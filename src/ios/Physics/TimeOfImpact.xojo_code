#tag Class
Protected Class TimeOfImpact
	#tag Method, Flags = &h0
		Sub Constructor()
		  mCache = New Physics.SimplexCache
		  mDistanceInput = New Physics.DistanceInput
		  mxfA = Physics.Transform.Zero
		  mxfB = Physics.Transform.Zero
		  mDistanceOutput = New Physics.DistanceOutput
		  mFcn = New Physics.SeparationFunction
		  mSweepA = New Physics.Sweep
		  mSweepB = New Physics.Sweep
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TimeOfImpact_(output As Physics.TOIOutput, input As Physics.TOIInput)
		  /// Compute the upper bound on time before two shapes penetrate. Time is
		  /// represented as a fraction between [0,TMax]. 
		  ///
		  /// This uses a swept separating axis and may miss some intermediate, non-tunneling 
		  /// collisions.
		  /// If you change the time interval, you should call this function again.
		  /// Note: use Distance to compute the contact point and normal at the time of
		  /// impact.
		  
		  // CCD via the local separating axis method. This seeks progression
		  // by computing the largest time at which separation is maintained.
		  
		  ToiCalls = ToiCalls + 1
		  
		  output.State = Physics.TOIOutputState.Unknown
		  output.T = input.TMax
		  
		  Var proxyA As Physics.DistanceProxy = input.ProxyA
		  Var proxyB As Physics.DistanceProxy = input.ProxyB
		  
		  Call mSweepA.Set(input.SweepA)
		  Call mSweepB.Set(input.SweepB)
		  
		  // Large rotations can make the root finder fail, so we normalize the sweep angles.
		  mSweepA.Normalize
		  mSweepB.Normalize
		  
		  Var tMax As Double = input.TMax
		  
		  Var totalRadius As Double = proxyA.Radius + proxyB.Radius
		  Var target As Double = _
		  Max(Physics.Settings.LinearSlop, totalRadius - 3.0 * Physics.Settings.LinearSlop)
		  Var tolerance As Double = 0.25 * Physics.Settings.LinearSlop
		  
		  #If DebugBuild
		    Assert(target > tolerance)
		  #EndIf
		  
		  Var t1 As Double = 0.0
		  Var iteration As Integer = 0
		  
		  mCache.count = 0
		  mDistanceInput.ProxyA = input.ProxyA
		  mDistanceInput.ProxyB = input.ProxyB
		  mDistanceInput.UseRadii = False
		  
		  // The outer loop progressively attempts to compute new separating axes.
		  // This loop terminates when an axis is repeated (no progress is made).
		  Do
		    mSweepA.GetTransform(mxfA, t1)
		    mSweepB.getTransform(mxfB, t1)
		    // Get the distance between shapes. We can also use the results
		    // to get a separating axis
		    mDistanceInput.TransformA = mxfA
		    mDistanceInput.TransformB = mxfB
		    Physics.World.Distance.Compute(mDistanceOutput, mCache, mDistanceInput)
		    
		    // If the shapes are overlapped, we give up on continuous collision.
		    If mDistanceOutput.Distance <= 0.0 Then
		      // Failure!
		      output.State = Physics.TOIOutputState.Overlapped
		      output.T = 0.0
		      Exit
		    End If
		    
		    If mDistanceOutput.Distance < target + tolerance Then
		      // Victory!
		      output.State = Physics.TOIOutputState.Touching
		      output.T = t1
		      Exit
		    End If
		    
		    // Initialize the separating axis.
		    Call mFcn.Initialize(mCache, proxyA, mSweepA, proxyB, mSweepB, t1)
		    
		    // Compute the TOI on the separating axis. We do this by successively
		    // resolving the deepest point. This loop is bounded by the number of vertices.
		    Var done As Boolean = False
		    Var t2 As Double = tMax
		    Var pushBackIteration As Integer = 0
		    Do
		      // Find the deepest point at t2. Store the witness point indices.
		      Var s2 As Double = mFcn.FindMinSeparation(mIndexes, t2)
		      // Is the final configuration separated?
		      If s2 > target + tolerance Then
		        // Victory!
		        output.State = Physics.TOIOutputState.Separated
		        output.T = tMax
		        done = True
		        Exit
		      End If
		      
		      // Has the separation reached tolerance?
		      If s2 > target - tolerance Then
		        // Advance the sweeps.
		        t1 = t2
		        Exit
		      End If
		      
		      // Compute the initial separation of the witness points.
		      Var s1 As Double = mFcn.Evaluate(mIndexes(0), mIndexes(1), t1)
		      // Check for initial overlap. This might happen if the root finder
		      // runs out of iterations.
		      If s1 < target - tolerance Then
		        output.State = Physics.TOIOutputState.Failed
		        output.T = t1
		        done = True
		        Exit
		      End If
		      
		      // Check for touching.
		      If s1 <= target + tolerance Then
		        // Victory! t1 should hold the TOI (could be 0.0).
		        output.State = Physics.TOIOutputState.Touching
		        output.T = t1
		        done = True
		        Exit
		      End If
		      
		      // Compute 1D root of: f(x) - target = 0
		      Var rootIterationCount As Integer = 0
		      Var a1 As Double = t1
		      Var a2 As Double = t2
		      Do
		        // Use a mix of the secant rule and bisection.
		        Var t As Double
		        If (rootIterationCount And 1) = 1 Then
		          // Secant rule to improve convergence.
		          t = a1 + (target - s1) * (a2 - a1) / (s2 - s1)
		        Else
		          // Bisection to guarantee progress.
		          t = 0.5 * (a1 + a2)
		        End If
		        
		        rootIterationCount = rootIterationCount + 1
		        ToiRootIterations = ToiRootIterations + 1
		        
		        Var s As Double = mFcn.Evaluate(mIndexes(0), mIndexes(1), t)
		        
		        If Abs(s - target) < tolerance Then
		          // t2 holds a tentative value for t1.
		          t2 = t
		          Exit
		        End If
		        
		        // Ensure we continue to bracket the root.
		        If s > target Then
		          a1 = t
		          s1 = s
		        Else
		          a2 = t
		          s2 = s
		        End If
		        
		        If rootIterationCount = MaxRootIterations Then
		          Exit
		        End If
		      Loop
		      
		      ToiMaxRootIterations = Max(ToiMaxRootIterations, rootIterationCount)
		      
		      pushBackIteration = pushBackIteration + 1
		      
		      If pushBackIteration = Physics.Settings.MaxPolygonVertices Or _
		        rootIterationCount = MaxRootIterations Then
		        Exit
		      End If
		    Loop
		    
		    iteration = iteration + 1
		    ToiIterations = ToiIterations + 1
		    
		    If done Then
		      Exit
		    End If
		    
		    If iteration = MaxIterations Then
		      // Root finder got stuck. Semi-victory.
		      output.State = Physics.TOIOutputState.Failed
		      output.T = t1
		      Exit
		    End If
		  Loop
		  
		  ToiMaxIterations = Max(ToiMaxIterations, iteration)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Class used for computing the time of impact. This class should not be
		constructed usually, just retrieve from the `SingletonPool#getTOI()`.
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mCache As Physics.SimplexCache
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDistanceInput As Physics.DistanceInput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDistanceOutput As Physics.DistanceOutput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFcn As Physics.SeparationFunction
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexes(1) As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSweepA As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSweepB As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mxfA As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mxfB As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared ToiCalls As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared ToiIterations As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared ToiMaxIterations As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared ToiMaxRootIterations As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared ToiRootIterations As Integer = 0
	#tag EndProperty


	#tag Constant, Name = MaxIterations, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MaxRootIterations, Type = Double, Dynamic = False, Default = \"50", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

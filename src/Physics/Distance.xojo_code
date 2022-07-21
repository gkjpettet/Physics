#tag Class
Protected Class Distance
	#tag Method, Flags = &h0, Description = 436F6D707574652074686520636C6F7365737420706F696E7473206265747765656E2074776F207368617065732E20537570706F72747320616E7920636F6D62696E6174696F6E206F663A20436972636C65536861706520616E6420506F6C79676F6E53686170652E205468652073696D706C657820636163686520697320696E7075742F6F75747075742E204F6E207468652066697273742063616C6C20736574206053696D706C657843616368652E436F756E7420746F207A65726F2E
		Sub Compute(output As Physics.DistanceOutput, cache As Physics.SimplexCache, input As Physics.DistanceInput)
		  /// Compute the closest points between two shapes. Supports any combination
		  /// of: CircleShape and PolygonShape. The simplex cache is input/output.
		  /// On the first call set `SimplexCache.Count to zero.
		  
		  GjkCalls = GjkCalls
		  
		  Var proxyA As Physics.DistanceProxy = input.ProxyA
		  Var proxyB As Physics.DistanceProxy = input.ProxyB
		  
		  Var transformA As Physics.Transform = input.TransformA
		  Var transformB As Physics.Transform = input.TransformB
		  
		  // Initialise the simplex.
		  mSimplex.ReadCache(cache, proxyA, transformA, proxyB, transformB)
		  
		  // Get simplex vertices as an array.
		  Var vertices(2) As Physics.mSimplexVertex = mSimplex.Vertices
		  
		  // These store the vertices of the last simplex so that we
		  // can check for duplicates and prevent cycling (pooled above).
		  Var saveCount As Integer = 0
		  
		  mSimplex.GetClosestPoint(mClosestPoint)
		  Var distanceSqr1 As Double = mClosestPoint.Length2
		  Var distanceSqr2 As Double = distanceSqr1
		  
		  // Main iteration loop.
		  Var iter As Integer = 0
		  While iter < maxIterations
		    // Copy simplex so we can identify duplicates.
		    saveCount = mSimplex.Count
		    Var iLimit As Integer = saveCount - 1
		    For i As Integer = 0 To iLimit
		      mSaveA(i) = vertices(i).IndexA
		      mSaveB(i) = vertices(i).IndexB
		    Next i
		    
		    Select Case mSimplex.Count
		    Case 1
		      // Ignore.
		    Case 2
		      mSimplex.Solve2
		    Case 3
		      mSimplex.Solve3
		    Else
		      #If DebugBuild
		        Assert(False)
		      #EndIf
		    End Select
		    
		    // If we have 3 points, then the origin is in the corresponding triangle.
		    If mSimplex.Count = 3 Then Exit
		    
		    // Compute closest point.
		    mSimplex.GetClosestPoint(mClosestPoint)
		    distanceSqr2 = mClosestPoint.Length2
		    
		    // Ensure progress.
		    If distanceSqr2 >= distanceSqr1 Then
		      // Exit
		    End If
		    
		    distanceSqr1 = distanceSqr2
		    
		    // Get search direction
		    mSimplex.GetSearchDirection(mD)
		    
		    // Ensure the search direction is numerically fit.
		    If mD.Length2 < Physics.Settings.Epsilon * Physics.Settings.Epsilon Then
		      // The origin is probably contained by a line segment
		      // or triangle. Thus the shapes are overlapped.
		      
		      // We can't return zero here even though there may be overlap.
		      // In case the simplex is a point, segment, or triangle it is difficult
		      // to determine if the origin is contained in the CSO or very close to it.
		      Exit
		    End If
		    
		    // Compute a tentative new simplex vertex using support points.
		    Var vertex As Physics.mSimplexVertex = vertices(mSimplex.count)
		    
		    mTemp.SetFrom(Physics.Rot.MulTransVec2(transformA.Q, mD.Negate))
		    vertex.IndexA = proxyA.GetSupport(mTemp)
		    vertex.WA.SetFrom(Physics.Transform.MulVec2(transformA, proxyA.GetVertex(vertex.IndexA)))
		    mTemp.SetFrom(Physics.Rot.MulTransVec2(transformB.Q, mD.Negate))
		    vertex.IndexB = proxyB.GetSupport(mTemp)
		    vertex.WB.SetFrom(Physics.Transform.MulVec2(transformB, proxyB.GetVertex(vertex.IndexB)))
		    
		    vertex.W.SetFrom(vertex.WB)
		    vertex.W.Subtract(vertex.WA)
		    
		    // Iteration count is equated to the number of support point calls.
		    iter = iter + 1
		    GjkIterations = GjkIterations + 1
		    
		    // Check for duplicate support points. This is the main termination criteria.
		    Var duplicate as Boolean = False
		    Var jLimit As Integer = saveCount - 1
		    For j As Integer = 0 To jLimit
		      If vertex.IndexA = mSaveA(j) And vertex.IndexB = mSaveB(j) Then
		        duplicate = True
		        Exit
		      End If
		    Next j
		    
		    // If we found a duplicate support point we must exit to avoid cycling.
		    If duplicate Then Exit
		    
		    // New vertex is ok and needed.
		    mSimplex.Count = mSimplex.Count + 1
		  Wend
		  
		  GjkMaxIterations = Max(GjkMaxIterations, iter)
		  
		  // Prepare output.
		  mSimplex.GetWitnessPoints(output.PointA, output.PointB)
		  output.Distance = output.PointA.DistanceTo(output.PointB)
		  output.Iterations = iter
		  
		  // Cache the simplex.
		  mSimplex.WriteCache(cache)
		  
		  // Apply radii if requested.
		  If input.useRadii Then
		    Var rA As Double = proxyA.Radius
		    Var rB As Double = proxyB.Radius
		    
		    If output.Distance > rA + rB And output.Distance > Physics.Settings.Epsilon Then
		      // Shapes are still not overlapped.
		      // Move the witness points to the outer surface.
		      output.Distance = output.Distance - (rA + rB)
		      mNormal.SetFrom(output.PointB)
		      mNormal.Subtract(output.PointA)
		      
		      mNormal.Normalize
		      
		      mTemp.SetFrom(mNormal)
		      mTemp.Scale(rA)
		      output.PointA.Add(mTemp)
		      mTemp.SetFrom(mNormal)
		      mTemp.Scale(rB)
		      output.PointB.Subtract(mTemp)
		    Else
		      // Shapes are overlapped when radii are considered.
		      // Move the witness points to the middle.
		      output.PointA.Add(output.PointB)
		      output.PointA.Scale(0.5)
		      output.PointB.SetFrom(output.PointA)
		      output.Distance = 0.0
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mSimplex = New Physics.mSimplex
		  mClosestPoint = VMaths.Vector2.Zero
		  mD = VMaths.Vector2.Zero
		  mTemp = VMaths.Vector2.Zero
		  mNormal = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Shared GjkCalls As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared GjkIterations As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared GjkMaxIterations As Integer = 20
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClosestPoint As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mD As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNormal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveA(2) As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSaveB(2) As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSimplex As Physics.mSimplex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As VMaths.Vector2
	#tag EndProperty


	#tag Constant, Name = MaxIterations, Type = Double, Dynamic = False, Default = \"20", Scope = Public
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

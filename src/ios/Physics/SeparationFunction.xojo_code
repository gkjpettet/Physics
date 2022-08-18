#tag Class
Protected Class SeparationFunction
	#tag Method, Flags = &h0
		Sub Constructor()
		  LocalPoint = VMaths.Vector2.Zero
		  Axis = VMaths.Vector2.Zero
		  
		  mLocalPointA = VMaths.Vector2.Zero
		  mLocalPointB = VMaths.Vector2.Zero
		  mPointA = VMaths.Vector2.Zero
		  mPointB = VMaths.Vector2.Zero
		  mLocalPointA1 = VMaths.Vector2.Zero
		  mLocalPointA2 = VMaths.Vector2.Zero
		  mNormal = VMaths.Vector2.Zero
		  mLocalPointB1 = VMaths.Vector2.Zero
		  mLocalPointB2 = VMaths.Vector2.Zero
		  mTemp = VMaths.Vector2.Zero
		  mxfa = Physics.Transform.Zero
		  mxfb = Physics.Transform.Zero
		  mAxisA = VMaths.Vector2.Zero
		  mAxisB = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(indexA As Integer, indexB As Integer, t As Double) As Double
		  SweepA.GetTransform(mxfa, t)
		  SweepB.GetTransform(mxfb, t)
		  
		  Select Case type
		  Case Physics.SeparationFunctionType.Points
		    mLocalPointA.SetFrom(ProxyA.GetVertex(indexA))
		    mLocalPointB.SetFrom(ProxyB.GetVertex(indexB))
		    
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, mLocalPointA))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, mLocalPointB))
		    
		    Var tmp As VMaths.Vector2 = mPointB.Subtract(mPointA)
		    Return tmp.Dot(axis)
		    
		  Case Physics.SeparationFunctionType.FaceA
		    mNormal.SetFrom(Physics.Rot.MulVec2(mxfa.Q, axis))
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, localPoint))
		    
		    mLocalPointB.SetFrom(ProxyB.GetVertex(indexB))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, mLocalPointB))
		    Var tmp As VMaths.Vector2 = mPointB.Subtract(mPointA)
		    Return tmp.Dot(mNormal)
		    
		  Case Physics.SeparationFunctionType.FaceB
		    mNormal.SetFrom(Physics.Rot.MulVec2(mxfb.Q, axis))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, localPoint))
		    
		    mLocalPointA.SetFrom(ProxyA.GetVertex(indexA))
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, mLocalPointA))
		    
		    Var tmp As VMaths.Vector2 = mPointA.Subtract(mPointB)
		    Return tmp.Dot(mNormal)
		    
		  Else
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    Return 0.0
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindMinSeparation(indexes() As Integer, t As Double) As Double
		  SweepA.GetTransform(mxfa, t)
		  SweepB.GetTransform(mxfb, t)
		  
		  Select Case type
		  Case Physics.SeparationFunctionType.Points
		    mAxisA.SetFrom(Physics.Rot.MulTransVec2(mxfa.Q, axis))
		    mAxisB.SetFrom(Physics.Rot.MulTransVec2(mxfb.Q, axis.Negate))
		    axis.Negate
		    
		    indexes(0) = ProxyA.GetSupport(mAxisA)
		    indexes(1) = ProxyB.GetSupport(mAxisB)
		    
		    mLocalPointA.SetFrom(ProxyA.GetVertex(indexes(0)))
		    mLocalPointB.SetFrom(ProxyB.GetVertex(indexes(1)))
		    
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, mLocalPointA))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, mLocalPointB))
		    
		    Var tmp As VMaths.Vector2 = mPointB.Subtract(mPointA)
		    Return tmp.Dot(axis)
		    
		  Case Physics.SeparationFunctionType.FaceA
		    mNormal.SetFrom(Physics.Rot.MulVec2(mxfa.Q, axis))
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, localPoint))
		    
		    mAxisB.SetFrom(Physics.Rot.MulTransVec2(mxfb.Q, mNormal.Negate))
		    mNormal.Negate
		    
		    indexes(0) = -1
		    indexes(1) = ProxyB.GetSupport(mAxisB)
		    
		    mLocalPointB.SetFrom(ProxyB.GetVertex(indexes(1)))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, mLocalPointB))
		    
		    Var tmp As VMaths.Vector2 = mPointB.Subtract(mPointA)
		    Return tmp.Dot(mNormal)
		    
		  Case Physics.SeparationFunctionType.FaceB
		    mNormal.SetFrom(Physics.Rot.MulVec2(mxfb.Q, axis))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, localPoint))
		    
		    mAxisA.SetFrom(Physics.Rot.MulTransVec2(mxfa.Q, mNormal.Negate))
		    mNormal.Negate
		    
		    indexes(1) = -1
		    indexes(0) = ProxyA.GetSupport(mAxisA)
		    
		    mLocalPointA.SetFrom(ProxyA.GetVertex(indexes(0)))
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, mLocalPointA))
		    
		    Var tmp As VMaths.Vector2 = mPointA.Subtract(mPointB)
		    Return tmp.Dot(mNormal)
		    
		  Else
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    indexes(0) = -1
		    indexes(1) = -1
		    Return 0.0
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Initialize(cache As Physics.SimplexCache, proxyA As Physics.DistanceProxy, sweepA As Physics.Sweep, proxyB As Physics.DistanceProxy, sweepB As Physics.Sweep, t1 As Double) As Double
		  Self.ProxyA = proxyA
		  Self.ProxyB = proxyB
		  Var count As Integer = cache.Count
		  
		  #If DebugBuild
		    Assert(0 < count And count < 3)
		  #EndIf
		  
		  Self.SweepA = sweepA
		  Self.SweepB = sweepB
		  
		  sweepA.GetTransform(mxfa, t1)
		  sweepB.GetTransform(mxfb, t1)
		  
		  If count = 1 Then
		    type = Physics.SeparationFunctionType.Points
		    mLocalPointA.SetFrom(proxyA.GetVertex(cache.IndexA(0)))
		    mLocalPointB.SetFrom(proxyB.GetVertex(cache.IndexB(0)))
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, mLocalPointA))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, mLocalPointB))
		    axis.SetFrom(mPointB)
		    axis.Subtract(mPointA)
		    Return axis.Normalize
		    
		  Elseif cache.IndexA(0) = cache.IndexA(1) Then
		    // Two points on B and one on A.
		    type = Physics.SeparationFunctionType.FaceB
		    
		    mLocalPointB1.SetFrom(proxyB.GetVertex(cache.IndexB(0)))
		    mLocalPointB2.SetFrom(proxyB.GetVertex(cache.IndexB(1)))
		    
		    mTemp.SetFrom(mLocalPointB2)
		    mTemp.Subtract(mLocalPointB1)
		    mTemp.ScaleOrthogonalInto(-1.0, axis)
		    axis.Normalize
		    
		    mNormal.SetFrom(Physics.Rot.MulVec2(mxfb.Q, axis))
		    
		    localPoint.SetFrom(mLocalPointB1)
		    localPoint.Add(mLocalPointB2)
		    localPoint.Scale(0.5)
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, localPoint))
		    
		    mLocalPointA.SetFrom(proxyA.GetVertex(cache.IndexA(0)))
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, mLocalPointA))
		    
		    mTemp.SetFrom(mPointA)
		    mTemp.Subtract(mPointB)
		    Var s As Double = mTemp.Dot(mNormal)
		    If s < 0.0 then
		      axis.Negate
		      s = -s
		    End If
		    Return s
		  Else
		    // Two points on A and one or two points on B.
		    type = Physics.SeparationFunctionType.FaceA
		    
		    mLocalPointA1.SetFrom(proxyA.GetVertex(cache.IndexA(0)))
		    mLocalPointA2.SetFrom(proxyA.GetVertex(cache.IndexA(1)))
		    
		    mTemp.SetFrom(mLocalPointA2)
		    mTemp.Subtract(mLocalPointA1)
		    mTemp.ScaleOrthogonalInto(-1.0, axis)
		    axis.Normalize
		    
		    mNormal.SetFrom(Physics.Rot.MulVec2(mxfa.Q, axis))
		    
		    localPoint.SetFrom(mLocalPointA1)
		    localPoint.Add(mLocalPointA2)
		    localPoint.Scale(0.5)
		    mPointA.SetFrom(Physics.Transform.MulVec2(mxfa, localPoint))
		    
		    mLocalPointB.SetFrom(proxyB.GetVertex(cache.IndexB(0)))
		    mPointB.SetFrom(Physics.Transform.MulVec2(mxfb, mLocalPointB))
		    
		    mTemp.SetFrom(mPointB)
		    mTemp.Subtract(mPointA)
		    Var s As Double = mTemp.Dot(mNormal)
		    If s < 0.0 Then
		      axis.Negate
		      s = -s
		    End If
		    Return s
		  End If
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Axis As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalPoint As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAxisA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAxisB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalPointA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalPointA1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalPointA2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalPointB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalPointB1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalPointB2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNormal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPointA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPointB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mxfa As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mxfb As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyA As Physics.DistanceProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyB As Physics.DistanceProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		SweepA As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h0
		SweepB As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As Physics.SeparationFunctionType
	#tag EndProperty


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

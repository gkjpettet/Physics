#tag Class
Private Class mSimplex
	#tag Method, Flags = &h0
		Sub Constructor()
		  For i As Integer = 0 To Vertices.LastIndex
		    Vertices(i) = New Physics.mSimplexVertex
		  Next i
		  
		  mE12 = VMaths.Vector2.Zero
		  mCase2 = VMaths.Vector2.Zero
		  mCase22 = VMaths.Vector2.Zero
		  mCase3 = VMaths.Vector2.Zero
		  mCase33 = VMaths.Vector2.Zero
		  mE13 = VMaths.Vector2.Zero
		  mE23 = VMaths.Vector2.Zero
		  mW1 = VMaths.Vector2.Zero
		  mW2 = VMaths.Vector2.Zero
		  mW3 = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732072657475726E7320706F6F6C6564206F626A656374732E20646F6E2774206B656570206F72206D6F64696679207468656D2E
		Sub GetClosestPoint(ByRef out As VMaths.Vector2)
		  /// This returns pooled objects. don't keep or modify them.
		  
		  Select Case Count
		  Case 0
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    out.SetZero
		    Return
		    
		  Case 1
		    out.SetFrom(Vertex1.W)
		    Return
		    
		  Case 2
		    mCase22.SetFrom(Vertex2.W)
		    mCase22.scale(Vertex2.A)
		    
		    mCase2.SetFrom(Vertex1.W)
		    mCase2.Scale(Vertex1.A)
		    mCase2.Add(mCase22)
		    
		    out.SetFrom(mCase2)
		    Return
		    
		  Case 3
		    out.SetZero
		    Return
		    
		  Else
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    out.SetZero
		    Return
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMetric() As Double
		  Select Case Count
		  Case 0
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    Return 0.0
		    
		  Case 1
		    Return 0.0
		    
		  Case 2
		    Return Vertex1.W.DistanceTo(Vertex2.W)
		    
		  Case 3
		    mCase3.SetFrom(Vertex2.W)
		    mCase3.Subtract(Vertex1.W)
		    
		    mCase33.SetFrom(Vertex3.W)
		    mCase33.Subtract(Vertex1.W)
		    
		    Return mCase3.Cross(mCase33)
		    
		  Else
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    Return 0.0
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetSearchDirection(ByRef out As VMaths.Vector2)
		  Select Case Count
		  Case 1
		    out.SetFrom(Vertex1.W)
		    out.Negate
		    Return
		    
		  Case 2
		    mE12.SetFrom(Vertex2.W)
		    mE12.Subtract(Vertex1.W)
		    // Use out for a temp variable real quick.
		    out.SetFrom(Vertex1.W)
		    out.Negate
		    Var sgn As Double = mE12.Cross(out)
		    
		    If sgn > 0.0 Then
		      // Origin is left of e12.
		      mE12.ScaleOrthogonalInto(1.0, out)
		    Else
		      // Origin is right of e12.
		      mE12.ScaleOrthogonalInto(-1.0, out)
		    End If
		    Return
		    
		  Else
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    out.SetZero
		    Return
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetWitnessPoints(pA As VMaths.Vector2, pB As VMaths.Vector2)
		  Select Case Count
		  Case 0
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		    
		  Case 1
		    pA.SetFrom(Vertex1.WA)
		    pB.SetFrom(Vertex1.WB)
		    
		  Case 2
		    mCase2.SetFrom(Vertex1.WA)
		    mCase2.Scale(Vertex1.A)
		    
		    pA.SetFrom(Vertex2.WA)
		    pA.Scale(Vertex2.A)
		    pA.Add(mCase2)
		    
		    mCase2.SetFrom(Vertex1.WB)
		    mCase2.Scale(Vertex1.A)
		    
		    pB.SetFrom(Vertex2.WB)
		    pB.Scale(Vertex2.A)
		    pB.Add(mCase2)
		    
		  Case 3
		    pA.SetFrom(Vertex1.WA)
		    pA.Scale(Vertex1.A)
		    
		    mCase3.SetFrom(Vertex2.WA)
		    mCase3.Scale(Vertex2.A)
		    
		    mCase33.SetFrom(Vertex3.WA)
		    mCase33.Scale(Vertex3.A)
		    
		    pA.Add(mCase3)
		    pA.Add(mCase33)
		    
		    pB.SetFrom(pA)
		    
		  Else
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReadCache(cache As Physics.SimplexCache, proxyA As Physics.DistanceProxy, transformA As Physics.Transform, proxyB As Physics.DistanceProxy, transformB As Physics.Transform)
		  #If DebugBuild
		    Assert(cache.Count <= 3)
		  #EndIf
		  
		  // Copy data from cache.
		  Count = cache.Count
		  
		  Var iLimit As Integer = Count - 1
		  For i As Integer = 0 To iLimit
		    Var v As Physics.mSimplexVertex = Vertices(i)
		    v.IndexA = cache.IndexA(i)
		    v.IndexB = cache.IndexB(i)
		    Var wALocal As VMaths.Vector2 = proxyA.GetVertex(v.IndexA)
		    Var wBLocal As VMaths.Vector2 = proxyB.GetVertex(v.IndexB)
		    v.WA.SetFrom(Physics.Transform.MulVec2(transformA, wALocal))
		    v.WB.SetFrom(Physics.Transform.MulVec2(transformB, wBLocal))
		    
		    v.W.SetFrom(v.WB)
		    v.W.Subtract(v.WA)
		    v.A = 0.0
		  Next i
		  
		  // Compute the new simplex metric, if it is substantially different than the
		  // old metric then flush the simplex.
		  If Count > 1 Then
		    Var metric1 As Double = cache.Metric
		    Var metric2 As Double = GetMetric
		    If (metric2 < 0.5 * metric1 Or _
		      2.0 * metric1 < metric2 Or _
		      metric2 < Physics.Settings.Epsilon) Then // Reset the simplex.
		      Count = 0
		    End If
		  End If
		  
		  // If the cache is empty or invalid ...
		  If count = 0 Then
		    Var v As Physics.mSimplexVertex = Vertices(0)
		    v.IndexA = 0
		    v.IndexB = 0
		    Var wALocal As VMaths.Vector2 = proxyA.GetVertex(0)
		    Var wBLocal As VMaths.Vector2 = proxyB.GetVertex(0)
		    v.WA.SetFrom(Physics.Transform.MulVec2(transformA, wALocal))
		    v.WB.SetFrom(Physics.Transform.MulVec2(transformB, wBLocal))
		    
		    v.W.SetFrom(v.WB)
		    v.W.Subtract(v.WA)
		    Count = 1
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536F6C76652061206C696E65207365676D656E74207573696E67206261727963656E7472696320636F6F7264696E617465732E
		Sub Solve2()
		  /// Solve a line segment using barycentric coordinates.
		  
		  Var w1 As VMaths.Vector2 = Vertex1.W
		  Var w2 As VMaths.Vector2 = Vertex2.W
		  mE12.SetFrom(w2)
		  mE12.Subtract(w1)
		  
		  // w1 region.
		  Var d12n2 As Double= -w1.Dot(mE12)
		  If d12n2 <= 0.0 Then
		    // a2 <= 0, so we clamp it to 0.
		    Vertex1.A = 1.0
		    Count = 1
		    Return
		  End If
		  
		  // w2 region.
		  Var d12n1 As Double = w2.Dot(mE12)
		  If d12n1 <= 0.0 Then
		    // a1 <= 0, so we clamp it to 0.
		    Vertex2.A = 1.0
		    Count = 1
		    Vertex1.Set(Vertex2)
		    Return
		  End If
		  
		  // Must be in e12 region.
		  Var invD12 As Double = 1.0 / (d12n1 + d12n2)
		  Vertex1.A = d12n1 * invD12
		  Vertex2.A = d12n2 * invD12
		  Count = 2
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536F6C76652061206C696E65207365676D656E74207573696E67206261727963656E7472696320636F6F7264696E617465732E
		Sub Solve3()
		  /// Solve a line segment using barycentric coordinates.
		  ///
		  /// Possible regions:
		  /// - points(2)
		  /// - edge points(0)-points(2)
		  /// - edge points(1)-points(2)
		  /// - inside the triangle
		  
		  mW1.SetFrom(Vertex1.W)
		  mW2.SetFrom(Vertex2.W)
		  mW3.SetFrom(Vertex3.W)
		  
		  // Edge12
		  // [1 1 ][a1] = [1]
		  // [w1.e12 w2.e12][a2] = [0]
		  // a3 = 0
		  mE12.SetFrom(mW2)
		  mE12.Subtract(mW1)
		  Var w1e12 As Double = mW1.Dot(mE12)
		  Var w2e12 As Double = mW2.Dot(mE12)
		  Var d12n1 As Double = w2e12
		  Var d12n2 As Double = -w1e12
		  
		  // Edge13
		  // [1 1 ][a1] = [1]
		  // [w1.e13 w3.e13][a3] = [0]
		  // a2 = 0
		  mE13.SetFrom(mW3)
		  mE13.Subtract(mW1)
		  Var w1e13 As Double = mW1.Dot(mE13)
		  Var w3e13 As Double = mW3.Dot(mE13)
		  Var d13n1 As Double = w3e13
		  Var d13n2 As Double = -w1e13
		  
		  // Edge23
		  // [1 1 ][a2] = [1]
		  // [w2.e23 w3.e23][a3] = [0]
		  // a1 = 0
		  mE23.SetFrom(mW3)
		  mE23.Subtract(mW2)
		  Var w2e23 As Double = mW2.Dot(mE23)
		  Var w3e23 As Double = mW3.Dot(mE23)
		  Var d23n1 As Double = w3e23
		  Var d23n2 As Double = -w2e23
		  
		  // Triangle123
		  Var n123 As Double = mE12.Cross(mE13)
		  
		  Var d123n1 As Double = n123 * mW2.Cross(mW3)
		  Var d123n2 As Double = n123 * mW3.Cross(mW1)
		  Var d123n3 As Double = n123 * mW1.Cross(mW2)
		  
		  // w1 region
		  If d12n2 <= 0.0 And d13n2 <= 0.0 Then
		    Vertex1.A = 1.0
		    Count = 1
		    Return
		  End If
		  
		  // e12
		  If d12n1 > 0.0 And d12n2 > 0.0 And d123n3 <= 0.0 Then
		    Var invD12 As Double = 1.0 / (d12n1 + d12n2)
		    Vertex1.A = d12n1 * invD12
		    Vertex2.A = d12n2 * invD12
		    Count = 2
		    Return
		  End If
		  
		  // e13
		  If d13n1 > 0.0 And d13n2 > 0.0 And d123n2 <= 0.0 Then
		    Var invD13 As Double = 1.0 / (d13n1 + d13n2)
		    Vertex1.A = d13n1 * invD13
		    Vertex3.A = d13n2 * invD13
		    Count = 2
		    Vertex2.Set(Vertex3)
		    Return
		  End If
		  
		  // w2 region
		  If d12n1 <= 0.0 And d23n2 <= 0. Then
		    Vertex2.A = 1.0
		    Count = 1
		    Vertex1.Set(Vertex2)
		    Return
		  End If
		  
		  // w3 region
		  If d13n1 <= 0.0 And d23n1 <= 0.0 Then
		    Vertex3.A = 1.0
		    Count = 1
		    Vertex1.Set(Vertex3)
		    Return
		  End If
		  
		  // e23
		  If d23n1 > 0.0 And d23n2 > 0.0 And d123n1 <= 0.0 Then
		    Var invD23 As Double = 1.0 / (d23n1 + d23n2)
		    Vertex2.A = d23n1 * invD23
		    Vertex3.A = d23n2 * invD23
		    Count = 2
		    Vertex1.Set(Vertex3)
		    Return
		  End If
		  
		  // Must be in triangle123
		  Var invD123 As Double = 1.0 / (d123n1 + d123n2 + d123n3)
		  Vertex1.A = d123n1 * invD123
		  Vertex2.A = d123n2 * invD123
		  Vertex3.A = d123n3 * invD123
		  Count = 3
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteCache(cache As Physics.SimplexCache)
		  cache.Metric = GetMetric
		  cache.Count = Count
		  
		  Var iLimit As Integer = Count - 1
		  For i As Integer = 0 To iLimit
		    cache.IndexA(i) = Vertices(i).IndexA
		    cache.IndexB(i) = Vertices(i).IndexB
		  Next i
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Count As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCase2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCase22 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCase3 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCase33 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mE12 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mE13 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mE23 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mW1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mW2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mW3 As VMaths.Vector2
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Vertices(0)
			End Get
		#tag EndGetter
		Vertex1 As Physics.mSimplexVertex
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Vertices(1)
			End Get
		#tag EndGetter
		Vertex2 As Physics.mSimplexVertex
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Vertices(2)
			End Get
		#tag EndGetter
		Vertex3 As Physics.mSimplexVertex
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Vertices(2) As Physics.mSimplexVertex
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
		#tag ViewProperty
			Name="Vertices(2)"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

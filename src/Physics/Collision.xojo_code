#tag Class
Protected Class Collision
	#tag Method, Flags = &h0, Description = 436C697070696E6720666F7220636F6E74616374206D616E69666F6C64732E205375746865726C616E642D486F64676D616E20636C697070696E672E
		Shared Function ClipSegmentToLine(vOut() As Physics.ClipVertex, vIn() As Physics.ClipVertex, normal As VMaths.Vector2, offset As Double, vertexIndexA As Integer) As Integer
		  /// Clipping for contact manifolds. Sutherland-Hodgman clipping.
		  
		  // Start with no output points.
		  Var numOut As Integer = 0
		  Var vIn0 As Physics.ClipVertex = vIn(0)
		  Var vIn1 As Physics.ClipVertex = vIn(1)
		  Var vIn0v As VMaths.Vector2 = vIn0.V
		  Var vIn1v As VMaths.Vector2 = vIn1.V
		  
		  // Calculate the distance of end points to the line.
		  Var distance0 As Double = normal.Dot(vIn0v) - offset
		  Var distance1 As Double = normal.Dot(vIn1v) - offset
		  
		  // If the points are behind the plane.
		  If distance0 <= 0.0 Then
		    vOut(numOut).Set(vIn0)
		    numOut = numOut + 1
		  End If
		  
		  If distance1 <= 0.0 Then
		    vOut(numOut).Set(vIn1)
		    numOut = numOut + 1
		  End If
		  
		  // If the points are on different sides of the plane.
		  If distance0 * distance1 < 0.0 Then
		    // Find intersection point of edge and plane.
		    Var interp As Double = distance0 / (distance0 - distance1)
		    
		    Var vOutNO As Physics.ClipVertex = vOut(numOut)
		    vOutNO.V.X = vIn0v.X + interp * (vIn1v.X - vIn0v.X)
		    vOutNO.V.Y = vIn0v.Y + interp * (vIn1v.Y - vIn0v.Y)
		    
		    // VertexA is hitting edgeB..
		    vOutNO.ID.IndexA = vertexIndexA And &hFF
		    vOutNO.ID.IndexB = vIn0.ID.IndexB
		    vOutNO.ID.TypeA = Integer(Physics.ContactIDType.Vertex) And &hFF
		    vOutNO.ID.TypeB = Integer(Physics.ContactIDType.Face) And &hFF
		    numOut = numOut + 1
		  End If
		  
		  Return numOut
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D707574652074686520636F6C6C6973696F6E206D616E69666F6C64206265747765656E2074776F20636972636C65732E
		Sub CollideCircles(manifold As Physics.Manifold, circle1 As Physics.CircleShape, xfA As Physics.Transform, circle2 As Physics.CircleShape, xfB As Physics.Transform)
		  /// Compute the collision manifold between two circles.
		  
		  manifold.PointCount = 0
		  
		  Var circle1p As VMaths.Vector2 = circle1.Position
		  Var circle2p As VMaths.Vector2= circle2.Position
		  Var pAx As Double = (xfA.Q.Cos * circle1p.X - xfA.Q.Sin * circle1p.Y) + xfA.P.X
		  Var pAy As Double = (xfA.Q.Sin * circle1p.X + xfA.Q.Cos * circle1p.Y) + xfA.p.Y
		  Var pBx As Double = (xfB.Q.Cos * circle2p.X - xfB.Q.Sin * circle2p.Y) + xfB.p.X
		  Var pBy As Double = (xfB.Q.Sin * circle2p.X + xfB.Q.Cos * circle2p.Y) + xfB.p.Y
		  Var dx As Double = pBx - pAx
		  Var dy As Double = pBy - pAy
		  Var distSqr As Double = dx * dx + dy * dy
		  
		  Var radius As Double = circle1.Radius + circle2.Radius
		  If distSqr > radius * radius Then
		    Return
		  End If
		  
		  manifold.Type = ManifoldType.circles
		  manifold.LocalPoint.SetFrom(circle1p)
		  manifold.LocalNormal.SetZero
		  manifold.PointCount = 1
		  
		  manifold.Points(0).LocalPoint.SetFrom(circle2p)
		  manifold.Points(0).ID.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D707574652074686520636F6C6C6973696F6E206D616E69666F6C64206265747765656E206120706F6C79676F6E20616E64206120636972636C652E
		Sub CollidePolygonAndCircle(manifold AS Physics.Manifold, polygon AS Physics.PolygonShape, xfA AS Physics.Transform, circle AS Physics.CircleShape, xfB AS Physics.Transform)
		  /// Compute the collision manifold between a polygon and a circle.
		  
		  manifold.PointCount = 0
		  
		  Var circlep As VMaths.Vector2 = circle.Position
		  Var xfBq As Physics.Rot = xfB.Q
		  Var xfAq As Physics.Rot = xfA.Q
		  Var cx As Double = (xfBq.Cos * circlep.X - xfBq.Sin * circlep.Y) + xfB.P.X
		  Var cy As Double = (xfBq.Sin * circlep.X + xfBq.Cos * circlep.Y) + xfB.P.Y
		  Var px As Double = cx - xfA.P.X
		  Var py As Double = cy - xfA.P.Y
		  Var cLocalX As Double = xfAq.Cos * px + xfAq.Sin * py
		  Var cLocalY As Double = -xfAq.Sin * px + xfAq.Cos * py
		  
		  // Find the min separating edge.
		  Var normalIndex As Integer = 0
		  Var separation As Double = -Maths.DoubleMaxFinite
		  Var radius As Double = polygon.Radius + circle.Radius
		  Var s As Double
		  Var vertices() As VMaths.Vector2 = polygon.Vertices
		  Var normals() As VMaths.Vector2 = polygon.Normals
		  
		  For i As Integer = 0 To vertices.LastIndex
		    Var vertex As VMaths.Vector2 = vertices(i)
		    Var tempX As Double = cLocalX - vertex.X
		    Var tempY As Double = cLocalY - vertex.Y
		    s = normals(i).X * tempX + normals(i).Y * tempY
		    
		    If s > radius Then
		      // Early out.
		      Return
		    End If
		    
		    If s > separation Then
		      separation = s
		      normalIndex = i
		    End If
		  Next i
		  
		  // Vertices that subtend the incident face.
		  Var vertIndex1 As Integer = normalIndex
		  Var vertIndex2 As Integer = If(vertIndex1 + 1 < vertices.Count, vertIndex1 + 1, 0)
		  Var v1 As VMaths.Vector2 = vertices(vertIndex1)
		  Var v2 As VMaths.Vector2 = vertices(vertIndex2)
		  
		  // If the centre is inside the polygon...
		  If separation < Physics.Settings.Epsilon Then
		    manifold.PointCount = 1
		    manifold.Type = Physics.ManifoldType.FaceA
		    
		    Var normal As VMaths.Vector2 = normals(normalIndex)
		    manifold.LocalNormal.X = normal.X
		    manifold.LocalNormal.Y = normal.Y
		    manifold.LocalPoint.X = (v1.X + v2.X) * 0.5
		    manifold.LocalPoint.Y = (v1.Y + v2.Y) * 0.5
		    Var mpoint As Physics.ManifoldPoint = manifold.Points(0)
		    mpoint.LocalPoint.X = circlep.X
		    mpoint.LocalPoint.Y = circlep.Y
		    mpoint.ID.Zero
		    
		    Return
		  End If
		  
		  // Compute barycentric coordinates.
		  Var tempX As Double = cLocalX - v1.X
		  Var tempY As Double = cLocalY - v1.Y
		  Var temp2X As Double = v2.X - v1.X
		  Var temp2Y As Double = v2.Y - v1.Y
		  Var u1 As Double = tempX * temp2X + tempY * temp2Y
		  
		  Var temp3X As Double = cLocalX - v2.X
		  Var temp3Y As Double = cLocalY - v2.Y
		  Var temp4X As Double = v1.X - v2.X
		  Var temp4Y As Double = v1.Y - v2.Y
		  Var u2 As Double = temp3X * temp4X + temp3Y * temp4Y
		  
		  If u1 <= 0.0 Then
		    Var dx As Double  = cLocalX - v1.X
		    Var dy As Double = cLocalY - v1.Y
		    If dx * dx + dy * dy > radius * radius Then
		      Return
		    End If
		    
		    manifold.PointCount = 1
		    manifold.Type = Physics.ManifoldType.FaceA
		    manifold.LocalNormal.X = cLocalX - v1.X
		    manifold.LocalNormal.Y = cLocalY - v1.Y
		    manifold.LocalNormal.Normalize
		    manifold.LocalPoint.SetFrom(v1)
		    manifold.Points(0).LocalPoint.SetFrom(circlep)
		    manifold.Points(0).ID.Zero
		  ElseIf u2 <= 0.0 Then
		    Var dx As Double = cLocalX - v2.X
		    Var dy As Double = cLocalY - v2.Y
		    If dx * dx + dy * dy > radius * radius Then
		      Return
		    End If
		    
		    manifold.PointCount = 1
		    manifold.Type = Physics.ManifoldType.FaceA
		    manifold.LocalNormal.X = cLocalX - v2.X
		    manifold.LocalNormal.Y = cLocalY - v2.Y
		    manifold.LocalNormal.Normalize
		    manifold.LocalPoint.SetFrom(v2)
		    manifold.Points(0).LocalPoint.SetFrom(circlep)
		    manifold.Points(0).ID.Zero
		  Else
		    Var fcx As Double = (v1.X + v2.X) * 0.5
		    Var fcy As Double = (v1.Y + v2.Y) * 0.5
		    
		    Var tx As Double = cLocalX - fcx
		    Var ty As Double = cLocalY - fcy
		    Var normal As VMaths.Vector2 = normals(vertIndex1)
		    separation = tx * normal.X + ty * normal.Y
		    If separation > radius Then
		      Return
		    End If
		    
		    manifold.PointCount = 1
		    manifold.Type = Physics.ManifoldType.FaceA
		    manifold.LocalNormal.SetFrom(normals(vertIndex1))
		    manifold.LocalPoint.X = fcx
		    manifold.LocalPoint.Y = fcy
		    manifold.Points(0).LocalPoint.SetFrom(circlep)
		    manifold.Points(0).ID.Zero
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D707574652074686520706F696E742073746174657320676976656E2074776F206D616E69666F6C64732E
		Shared Sub ComputePointStates(state1() As Physics.PointState, state2() As Physics.PointState, manifold1 As Physics.Manifold, manifold2 As Physics.Manifold)
		  /// Compute the point states given two manifolds. 
		  ///
		  /// The states pertain to the
		  /// transition from `manifold1` to `manifold2`. So `state1` is either persist or
		  /// remove while `state2` is either add or persist.
		  
		  Var iLimit As Integer = Physics.Settings.MaxManifoldPoints - 1
		  For i As Integer = 0 To iLimit
		    state1(i) = Physics.PointState.NullState
		    state2(i) = Physics.PointState.NullState
		  Next i
		  
		  // Detect persists and removes.
		  iLimit = Manifold1.PointCount - 1
		  For i As Integer = 0 To iLimit
		    Var id As Physics.ContactID = manifold1.Points(i).ID
		    
		    state1(i) = Physics.PointState.RemoveState
		    
		    Var jLimit As Integer = manifold2.PointCount - 1
		    For j As Integer = 0 To jLimit
		      If manifold2.Points(j).ID.IsEqual(id) Then
		        state1(i) = PointState.persistState
		        Exit
		      End If
		    Next j
		  Next i
		  
		  // Detect persists and adds
		  iLimit = Manifold2.PointCount - 1
		  For i As Integer = 0 To iLimit
		    Var id As Physics.ContactID = manifold2.Points(i).ID
		    
		    state2(i) = Physics.PointState.AddState
		    
		    Var jLimit As Integer = manifold1.PointCount - 1
		    For j As Integer = 0 To jLimit
		      If manifold1.Points(j).ID.IsEqual(id) Then
		        state2(i) = Physics.PointState.PersistState
		        Exit
		      End If
		    Next j
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mInput = New Physics.DistanceInput
		  mCache = New Physics.SimplexCache
		  mOutput = New Physics.DistanceOutput
		  mD = VMaths.Vector2.Zero
		  mTemp = VMaths.Vector2.Zero
		  mXf = Physics.Transform.Zero
		  mN = VMaths.Vector2.Zero
		  mV1 = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 46696E6420746865206D61782073657061726174696F6E206265747765656E20706F6C793120616E6420706F6C7932207573696E672065646765206E6F726D616C732066726F6D2060706F6C7931602E
		Sub FindMaxSeparation(results As Physics.mEdgeResults, poly1 As Physics.PolygonShape, xf1 As Physics.Transform, poly As Physics.PolygonShape, xf2 As Physics.Transform)
		  /// Find the max separation between poly1 and poly2 using edge normals from `poly1`.
		  
		  Var count1 As Double = poly1.Vertices.Count
		  Var count2 As Double = poly2.Vertices.Count
		  Var n1s() As VMaths.Vector2 = poly1.Normals
		  Var v1s() As VMaths.Vector2 = poly1.Vertices
		  Var v2s() As VMaths.Vector2 = poly2.Vertices
		  
		  mXf.Set(Physics.Transform.MulTrans(xf2, xf1))
		  Var xfq As Physics.Rot = mXf.Q
		  
		  Var bestIndex As Integer = 0
		  Var maxSeparation As Double = -Maths.DoubleMaxFinite
		  Var iLimit As Integer = count1 - 1
		  For i As Integer = 0 To iLimit
		    // Get poly1 normal in frame2.
		    mN.SetFrom(Physics.Rot.MulVec2(xfq, n1s(i)))
		    mV1.SetFrom(Physics.Transform.MulVec2(mXf, v1s(i)))
		    
		    // Find deepest point for normal i.
		    Var si As Double = Maths.DoubleMaxFinite
		    Var jLimit As Integer = count2 - 1
		    For j As Integer = 0 To jLimit
		      Var v2sj As VMaths.Vector2 = v2s(j)
		      Var sij As Double = mN.X * (v2sj.X - mV1.X) + mN.Y * (v2sj.Y - mV1.Y)
		      If sij < si Then
		        si = sij
		      End If
		    Next j
		    
		    If si > maxSeparation Then
		      maxSeparation = si
		      bestIndex = i
		    End If
		  Next i
		  
		  results.EdgeIndex = bestIndex
		  results.Separation = maxSeparation
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657465726D696E652069662074776F2067656E6572696320736861706573206F7665726C61702E
		Function TestOverlap(shapeA As Physics.Shape, indexA As Integer, shapeB As Physics.Shape, indexB As Integer, xfA As Physics.Transform, xfB As Physics.Transform) As Boolean
		  /// Determine if two generic shapes overlap.
		  
		  mInput.ProxyA.Set(shapeA, indexA)
		  mInput.ProxyB.Set(shapeB, indexB)
		  mInput.TransformA.Set(xfA)
		  mInput.TransformB.Set(xfB)
		  mInput.UseRadii = True
		  
		  mCache.Count = 0
		  
		  World.Distance.Compute(mOutput, mCache, mInput)
		  
		  Return mOutput.Distance < 10.0 * Physics.Settings.Epsilon
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Functions used for computing contact points, distance queries, and TOI
		queries. 
		
		Collision methods are non-static for pooling speed, retrieve a
		collision object from the SingletonPool.
		
		
	#tag EndNote

	#tag Note, Name = Progress
		Ported upto but not including `()`
		
		findIncidentEdge
	#tag EndNote


	#tag Property, Flags = &h0
		mCache As Physics.SimplexCache
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mD As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		mInput As Physics.DistanceInput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mN As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		mOutput As Physics.DistanceOutput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mV1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mXf As Physics.Transform
	#tag EndProperty


	#tag Constant, Name = NullFeature, Type = Double, Dynamic = False, Default = \"&h3FFFFFFF", Scope = Public
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
		#tag ViewProperty
			Name="mInput"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

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

	#tag Method, Flags = &h0, Description = 436F6D7075746520636F6E7461637420706F696E747320666F7220656467652076657273757320636972636C652E2054686973206163636F756E747320666F72206564676520636F6E6E65637469766974792E
		Sub CollideEdgeAndCircle(manifold As Physics.Manifold, edgeA As Physics.EdgeShape, xfA As Physics.Transform, circleB As Physics.CircleShape, xfB As Physics.Transform)
		  /// Compute contact points for edge versus circle.
		  /// This accounts for edge connectivity.
		  
		  manifold.PointCount = 0
		  
		  // Compute circle in frame of edge.
		  mTemp.SetFrom(Physics.Transform.MulVec2(xfB, circleB.Position))
		  mQ.SetFrom(Physics.Transform.MulTransVec2(xfA, mTemp))
		  
		  Var a As VMaths.Vector2 = edgeA.Vertex1
		  Var b As VMaths.Vector2 = edgeA.Vertex2
		  m_E.SetFrom(b)
		  m_E.Subtract(a)
		  
		  // Barycentric coordinates.
		  mTemp.SetFrom(b)
		  mTemp.Subtract(mQ)
		  Var u As Double = m_E.Dot(mTemp)
		  mTemp.SetFrom(mQ)
		  mTemp.Subtract(a)
		  Var v As Double = m_E.Dot(mTemp)
		  
		  Var radius As Double = edgeA.Radius + circleB.Radius
		  
		  mCf.IndexB = 0
		  mCf.TypeB = Integer(Physics.ContactIDType.Vertex) And &hFF
		  
		  // Region A.
		  If v <= 0.0 Then
		    Var P As VMaths.Vector2 = a
		    mD.SetFrom(mQ)
		    mD.Subtract(P)
		    Var dd As Double = mD.Dot(mD)
		    If dd > radius * radius Then
		      Return
		    End If
		    
		    // Is there an edge connected to A?
		    If edgeA.HasVertex0 Then
		      Var a1 As VMaths.Vector2 = edgeA.Vertex0
		      Var b1 As VMaths.Vector2 = a
		      mE1.SetFrom(b1)
		      mE1.Subtract(a1)
		      mTemp.SetFrom(b1)
		      mTemp.Subtract(mQ)
		      Var u1 As Double = mE1.Dot(mTemp)
		      
		      // Is the circle in Region AB of the previous edge?
		      If u1 > 0.0 Then
		        Return
		      End If
		    End If
		    
		    mCf.IndexA = 0
		    mCf.TypeA = Integer(Physics.ContactIDType.Vertex) And &hFF
		    manifold.PointCount = 1
		    manifold.Type = Physics.ManifoldType.Circles
		    manifold.LocalNormal.SetZero
		    manifold.LocalPoint.SetFrom(P)
		    manifold.Points(0).ID.Set(mCf)
		    manifold.Points(0).LocalPoint.SetFrom(circleB.Position)
		    Return
		  End If
		  
		  // Region B.
		  If u <= 0.0 Then
		    Var p As VMaths.Vector2 = b
		    mD.SetFrom(mQ)
		    mD.Subtract(p)
		    Var dd As Double = mD.Dot(mD)
		    If dd > radius * radius Then
		      Return
		    End If
		    
		    // Is there an edge connected to B?
		    If edgeA.HasVertex3 Then
		      Var b2 As VMaths.Vector2  = edgeA.Vertex3
		      Var a2 As VMaths.Vector2 = b
		      Var e2 As VMaths.Vector2 = mE1
		      e2.SetFrom(b2)
		      e2.Subtract(a2)
		      mTemp.SetFrom(mQ)
		      mTemp.Subtract(a2)
		      Var v2 As Double = e2.Dot(mTemp)
		      
		      // Is the circle in Region AB of the next edge?
		      If v2 > 0.0 Then
		        Return
		      End If
		    End If
		    
		    mCf.IndexA = 1
		    mCf.typeA = Integer(Physics.ContactIDType.Vertex) And &hFF
		    manifold.PointCount = 1
		    manifold.Type = Physics.ManifoldType.Circles
		    manifold.LocalNormal.SetZero
		    manifold.LocalPoint.SetFrom(p)
		    manifold.Points(0).ID.Set(mCf)
		    manifold.Points(0).LocalPoint.SetFrom(circleB.Position)
		    Return
		  End If
		  
		  // Region AB.
		  Var den As Double = m_E.Dot(m_E)
		  #If DebugBuild
		    Assert(den > 0.0)
		  #EndIf
		  
		  mP.SetFrom(a)
		  mP.Scale(u)
		  mTemp.SetFrom(b)
		  mTemp.Scale(v)
		  mP.Add(mTemp)
		  mP.Scale(1.0 / den)
		  mD.SetFrom(mQ)
		  mD.Subtract(mP)
		  Var dd As Double = mD.Dot(mD)
		  If dd > radius * radius Then
		    Return
		  End If
		  
		  mN.X = -m_E.Y
		  mN.Y = m_E.X
		  
		  mTemp.SetFrom(mQ)
		  mTemp.Subtract(a)
		  If (mN.Dot(mTemp) < 0.0) Then
		    mN.SetValues(-mN.X, -mN.Y)
		  End If
		  mN.Normalize
		  
		  mCf.IndexA = 0
		  mCf.TypeA = Integer(Physics.ContactIDType.Face) And &hFF
		  manifold.PointCount = 1
		  manifold.Type = Physics.ManifoldType.FaceA
		  manifold.LocalNormal.SetFrom(mN)
		  manifold.LocalPoint.SetFrom(a)
		  manifold.Points(0).ID.Set(mCf)
		  manifold.Points(0).LocalPoint.SetFrom(circleB.Position)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CollideEdgeAndPolygon(manifold As Physics.Manifold, edgeA As Physics.EdgeShape, xfA As Physics.Transform, polygonB As Physics.PolygonShape, xfB As Physics.Transform)
		  mCollider.Collide(manifold, edgeA, xfA, polygonB, xfB)
		  
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

	#tag Method, Flags = &h0, Description = 436F6D707574652074686520636F6C6C6973696F6E206D616E69666F6C64206265747765656E2074776F20706F6C79676F6E732E
		Sub CollidePolygons(manifold As Physics.Manifold, polyA As Physics.PolygonShape, xfA As Physics.Transform, polyB As Physics.PolygonShape, xfB As Physics.Transform)
		  /// Compute the collision manifold between two polygons.
		  
		  // - Find edge normal of max separation on A - return if separating axis is found.
		  // - Find edge normal of max separation on B - return if separation axis is found.
		  // - Choose reference edge as min(minA, minB)
		  // - Find incident edge
		  // - Clip
		  
		  // The normal points from 1 to 2.
		  
		  manifold.PointCount = 0
		  Var totalRadius As Double = polyA.Radius + polyB.Radius
		  
		  FindMaxSeparation(mResults1, polyA, xfA, polyB, xfB)
		  If mResults1.Separation > totalRadius Then
		    Return
		  End If
		  
		  FindMaxSeparation(results2, polyB, xfB, polyA, xfA)
		  If Results2.Separation > totalRadius Then
		    Return
		  End If
		  
		  Var poly1 As Physics.PolygonShape // Reference polygon.
		  Var poly2 As Physics.PolygonShape // Incident polygon.
		  Var xf1, xf2 As Physics.Transform
		  Var edge1 As Integer // Reference edge.
		  Var flip As Boolean
		  Var kTol As Double = 0.1 * Physics.Settings.LinearSlop
		  
		  If Results2.Separation > mResults1.Separation + kTol Then
		    poly1 = polyB
		    poly2 = polyA
		    xf1 = xfB
		    xf2 = xfA
		    edge1 = Results2.EdgeIndex
		    manifold.Type = Physics.ManifoldType.FaceB
		    flip = True
		  Else
		    poly1 = polyA
		    poly2 = polyB
		    xf1 = xfA
		    xf2 = xfB
		    edge1 = mResults1.EdgeIndex
		    manifold.Type = Physics.ManifoldType.FaceA
		    flip = False
		  End If
		  
		  Var xf1q As Physics.Rot = xf1.Q
		  
		  FindIncidentEdge(mIncidentEdge, poly1, xf1, edge1, poly2, xf2)
		  
		  Var count1 As Integer = poly1.Vertices.Count
		  Var vertices1() As VMaths.Vector2 = poly1.Vertices
		  
		  Var iv1 As Integer = edge1
		  Var iv2 As Integer = If(edge1 + 1 < count1, edge1 + 1, 0)
		  mV11.SetFrom(vertices1(iv1))
		  mV12.SetFrom(vertices1(iv2))
		  mLocalTangent.X = mV12.X - mV11.X
		  mLocalTangent.Y = mV12.Y - mV11.Y
		  mLocalTangent.Normalize
		  
		  mLocalNormal.X = 1.0 * mLocalTangent.Y
		  mLocalNormal.Y = -1.0 * mLocalTangent.X
		  
		  mPlanePoint.X = (mV11.X + mV12.X) * 0.5
		  mPlanePoint.Y = (mV11.Y + mV12.Y) * 0.5
		  
		  mTangent.X = xf1q.Cos * mLocalTangent.X - xf1q.Sin * mLocalTangent.Y
		  mTangent.Y = xf1q.Sin * mLocalTangent.X + xf1q.Cos * mLocalTangent.Y
		  
		  Var normalx As Double = 1.0 * mTangent.Y
		  Var normaly As Double = -1.0 * mTangent.X
		  
		  mV11.SetFrom(Physics.Transform.MulVec2(xf1, mV11))
		  mV12.SetFrom(Physics.Transform.MulVec2(xf1, mV12))
		  
		  // Face offset.
		  Var frontOffset As Double = normalx * mV11.X + normaly * mV11.Y
		  
		  // Side offsets, extended by polytope skin thickness.
		  Var sideOffset1 As Double = _
		  -(mTangent.X * mV11.X + mTangent.Y * mv11.Y) + totalRadius
		  Var sideOffset2 As Double = mTangent.X * mV12.X + mTangent.Y * mV12.Y + totalRadius
		  
		  mTangent.Negate
		  // Clip to box side 1.
		  If ClipSegmentToLine(mClipPoints1, mIncidentEdge, mTangent, sideOffset1, iv1) < 2 Then
		    Return
		  End If
		  
		  mTangent.Negate
		  // Clip to negative box side 1.
		  If ClipSegmentToLine(mClipPoints2, mClipPoints1, mTangent, sideOffset2, iv2) < 2 Then
		    Return
		  End If
		  
		  // Now _clipPoints2 contains the clipped points.
		  manifold.LocalNormal.SetFrom(mLocalNormal)
		  manifold.LocalPoint.SetFrom(mPlanePoint)
		  
		  Var pointCount As Integer = 0
		  
		  Var iLimit As Integer = Physics.Settings.MaxManifoldPoints - 1
		  For i As Integer = 0 To iLimit
		    Var separation As Double = normalx * mClipPoints2(i).V.X + _
		    normaly * mClipPoints2(i).V.Y - frontOffset
		    
		    If separation <= totalRadius Then
		      Var cp As Physics.ManifoldPoint = manifold.Points(pointCount)
		      Var out As VMaths.Vector2 = cp.LocalPoint
		      Var px As Double = mClipPoints2(i).V.X - xf2.P.X
		      Var py As Double = mClipPoints2(i).V.Y - xf2.P.Y
		      out.X = xf2.Q.Cos * px + xf2.Q.Sin * py
		      out.Y = -xf2.Q.Sin * px + xf2.Q.Cos * py
		      cp.ID.Set(mClipPoints2(i).ID)
		      If flip Then
		        // Swap features.
		        cp.ID.Flip
		      End If
		      pointCount = pointCount + 1
		    End If
		  Next i
		  
		  manifold.PointCount = pointCount
		  
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
		  mResults1 = New Physics.mEdgeResults
		  Results2 = New Physics.mEdgeResults
		  mLocalTangent = VMaths.Vector2.Zero
		  mPlanePoint = VMaths.Vector2.Zero
		  mTangent = VMaths.Vector2.Zero
		  mv11 = VMaths.Vector2.Zero
		  mv12 = VMaths.Vector2.Zero
		  
		  mIncidentEdge.Add(New Physics.ClipVertex)
		  mIncidentEdge.Add(New Physics.ClipVertex)
		  
		  mClipPoints1.Add(New Physics.ClipVertex)
		  mClipPoints1.Add(New Physics.ClipVertex)
		  
		  mClipPoints2.Add(New Physics.ClipVertex)
		  mClipPoints2.Add(New Physics.ClipVertex)
		  
		  mQ = VMaths.Vector2.Zero
		  m_E = VMaths.Vector2.Zero
		  mCF = New Physics.ContactID
		  mE1 = VMaths.Vector2.Zero
		  mP = VMaths.Vector2.Zero
		  
		  mCollider = New Physics.EdgePolygonCollider
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FindIncidentEdge(c() As Physics.ClipVertex, poly1 As Physics.PolygonShape, xf1 As Physics.Transform, edge1 As Integer, poly2 As Physics.PolygonShape, xf2 As Physics.Transform)
		  Var count1 As Integer = poly1.Vertices.Count
		  Var normals1() As VMaths.Vector2 = poly1.Normals
		  
		  Var count2 As Integer = poly2.Vertices.Count
		  Var vertices2() As VMaths.Vector2 = poly2.Vertices
		  Var normals2() As VMaths.Vector2 = poly2.Normals
		  
		  #If DebugBuild
		    Assert(0 <= edge1 And edge1 < count1)
		  #EndIf
		  
		  Var c0 As Physics.ClipVertex = c(0)
		  Var c1 As Physics.ClipVertex = c(1)
		  Var xf1q As Physics.Rot = xf1.Q
		  Var xf2q As Physics.Rot = xf2.Q
		  
		  // Get the normal of the reference edge in poly2's frame.
		  Var v As VMaths.Vector2 = normals1(edge1)
		  Var tempx As Double = xf1q.Cos * v.X - xf1q.Sin * v.Y
		  Var tempy As Double = xf1q.Sin * v.X + xf1q.Cos * v.Y
		  Var normal1x As Double = xf2q.Cos * tempx + xf2q.Sin * tempy
		  Var normal1y As Double = -xf2q.Sin * tempx + xf2q.Cos * tempy
		  
		  // Find the incident edge on poly2.
		  Var index As Integer = 0 
		  Var minDot As Double = Maths.DoubleMaxFinite
		  Var iLimit As Integer = count2 - 1
		  For i As Integer = 0 To iLimit
		    Var b As VMaths.Vector2 = normals2(i)
		    Var dot As Double = normal1x * b.X + normal1y * b.Y
		    If dot < minDot Then
		      minDot = dot
		      index = i
		    End If
		  Next i
		  
		  // Build the clip vertices for the incident edge.
		  Var i1 As Integer = index
		  Var i2 As Integer = If(i1 + 1 < count2, i1 + 1, 0)
		  
		  Var v1 As VMaths.Vector2 = vertices2(i1)
		  Var out As VMaths.Vector2 = c0.V
		  out.X = (xf2q.Cos * v1.X - xf2q.Sin * v1.Y) + xf2.p.X
		  out.Y = (xf2q.Sin * v1.X + xf2q.Cos * v1.Y) + xf2.p.Y
		  c0.ID.IndexA = edge1 And &hFF
		  c0.ID.IndexB = i1 And &hFF
		  c0.ID.TypeA = Integer(Physics.ContactIDType.Face) And &hFF
		  c0.ID.TypeB = Integer(Physics.ContactIDType.Vertex) And &hFF
		  
		  Var v2 As VMaths.Vector2 = vertices2(i2) 
		  Var out1 As VMaths.Vector2 = c1.V
		  out1.X = (xf2q.Cos * v2.X - xf2q.Sin * v2.Y) + xf2.P.X
		  out1.Y = (xf2q.Sin * v2.X + xf2q.Cos * v2.Y) + xf2.P.Y
		  c1.ID.IndexA = edge1 And &hFF
		  c1.ID.IndexB = i2 And &hFF
		  c1.ID.TypeA = Integer(Physics.ContactIDType.Face) And &hFF
		  c1.ID.TypeB = Integer(Physics.ContactIDType.Vertex) And &hFF
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 46696E6420746865206D61782073657061726174696F6E206265747765656E20706F6C793120616E6420706F6C7932207573696E672065646765206E6F726D616C732066726F6D2060706F6C7931602E
		Sub FindMaxSeparation(results As Physics.mEdgeResults, poly1 As Physics.PolygonShape, xf1 As Physics.Transform, poly2 As Physics.PolygonShape, xf2 As Physics.Transform)
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


	#tag Property, Flags = &h21
		Private mCache As Physics.SimplexCache
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCF As Physics.ContactID
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClipPoints1() As Physics.ClipVertex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClipPoints2() As Physics.ClipVertex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCollider As Physics.EdgePolygonCollider
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mD As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mE1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIncidentEdge() As Physics.ClipVertex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInput As Physics.DistanceInput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalNormal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalTangent As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mN As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutput As Physics.DistanceOutput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mP As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlanePoint As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQ As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResults1 As Physics.mEdgeResults
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTangent As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mV1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mV11 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mV12 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mXf As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private m_E As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Results2 As Physics.mEdgeResults
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

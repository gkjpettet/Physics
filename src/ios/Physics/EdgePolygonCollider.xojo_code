#tag Class
Protected Class EdgePolygonCollider
	#tag Method, Flags = &h0
		Sub Collide(manifold As Physics.Manifold, edgeA As Physics.EdgeShape, xfA As Physics.Transform, polygonB2 As Physics.PolygonShape, xfB As Physics.Transform)
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Xf.Set(Physics.Transform.MulTrans(xfA, xfB))
		  CentroidB.SetFrom(Physics.Transform.MulVec2(xf, polygonB2.Centroid))
		  
		  V0 = edgeA.Vertex0
		  V1 = edgeA.Vertex1
		  V2 = edgeA.Vertex2
		  V3 = edgeA.Vertex3
		  
		  Var hasVertex0 As Boolean = edgeA.HasVertex0
		  Var hasVertex3 As Boolean = edgeA.HasVertex3
		  
		  mEdge1.SetFrom(V2)
		  mEdge1.Subtract(V1)
		  mEdge1.Normalize
		  Normal1.SetValues(mEdge1.Y, -mEdge1.X)
		  
		  mTemp.SetFrom(CentroidB)
		  mTemp.Subtract(V1)
		  Var offset1 As Double = Normal1.Dot(mTemp)
		  Var offset0 As Double = 0.0
		  Var offset2 As Double = 0.0
		  Var convex1 As Boolean = False
		  Var convex2 As Boolean = False
		  
		  // Is there a preceding edge?
		  if hasVertex0 Then
		    mEdge0.SetFrom(V1)
		    mEdge0.Subtract(V0)
		    mEdge0.Normalize
		    Normal0.SetValues(mEdge0.Y, -mEdge0.X)
		    convex1 = mEdge0.Cross(mEdge1) >= 0.0
		    mTemp.SetFrom(CentroidB)
		    mTemp.Subtract(V0)
		    offset0 = Normal0.Dot(mTemp)
		  End If
		  
		  // Is there a following edge?
		  If hasVertex3 Then
		    mEdge2.SetFrom(V3)
		    mEdge2.Subtract(V2)
		    mEdge2.Normalize
		    Normal2.SetValues(mEdge2.Y, -mEdge2.X)
		    convex2 = mEdge1.Cross(mEdge2) > 0.0
		    mTemp.SetFrom(CentroidB)
		    mTemp.Subtract(V2)
		    offset2 = Normal2.Dot(mTemp)
		  End If
		  
		  // Determine front or back collision. Determine collision normal limits.
		  If hasVertex0 And hasVertex3 Then
		    If convex1 And convex2 Then
		      front = (offset0 >= 0.0 Or offset1 >= 0.0 Or offset2 >= 0.0)
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = Normal0.X
		        LowerLimit.Y = Normal0.Y
		        UpperLimit.X = Normal2.X
		        UpperLimit.Y = Normal2.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = -Normal1.X
		        LowerLimit.Y = -Normal1.Y
		        UpperLimit.X = -Normal1.X
		        UpperLimit.Y = -Normal1.Y
		      End If
		    ElseIf convex1 Then
		      front = (offset0 >= 0.0 Or (offset1 >= 0.0 And offset2 >= 0.0))
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = Normal0.X
		        LowerLimit.Y = Normal0.Y
		        UpperLimit.X = Normal1.X
		        upperLimit.Y = Normal1.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = -Normal2.X
		        LowerLimit.Y = -Normal2.Y
		        UpperLimit.X = -Normal1.X
		        UpperLimit.Y = -Normal1.Y
		      End If
		    ElseIf convex2 Then
		      front = (offset2 >= 0.0 Or (offset0 >= 0.0 And offset1 >= 0.0))
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = Normal1.X
		        LowerLimit.Y = Normal1.Y
		        UpperLimit.X = Normal2.X
		        UpperLimit.Y = Normal2.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = -Normal1.X
		        LowerLimit.Y = -Normal1.Y
		        UpperLimit.X = -Normal0.X
		        UpperLimit.Y = -Normal0.Y
		      End If
		    Else
		      front = (offset0 >= 0.0 And offset1 >= 0.0 And offset2 >= 0.0)
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = Normal1.X
		        LowerLimit.Y = Normal1.Y
		        UpperLimit.X = Normal1.X
		        UpperLimit.Y = Normal1.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = -Normal2.X
		        LowerLimit.Y = -Normal2.Y
		        UpperLimit.X = -Normal0.X
		        UpperLimit.Y = -Normal0.Y
		      End If
		    End If
		  ElseIf hasVertex0 Then
		    If convex1 Then
		      front = (offset0 >= 0.0 Or offset1 >= 0.0)
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = Normal0.X
		        LowerLimit.Y = Normal0.Y
		        UpperLimit.X = -Normal1.X
		        UpperLimit.Y = -Normal1.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = Normal1.X
		        LowerLimit.Y = Normal1.Y
		        UpperLimit.X = -Normal1.X
		        UpperLimit.Y = -Normal1.Y
		      End If
		    Else
		      front = (offset0 >= 0.0 And offset1 >= 0.0)
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = Normal1.X
		        LowerLimit.Y = Normal1.Y
		        UpperLimit.X = -Normal1.X
		        UpperLimit.Y = -Normal1.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = Normal1.X
		        LowerLimit.Y = Normal1.Y
		        UpperLimit.X = -Normal0.X
		        UpperLimit.Y = -Normal0.Y
		      End If
		    End If
		  ElseIf hasVertex3 Then
		    If convex2 Then
		      front = (offset1 >= 0.0 Or offset2 >= 0.0)
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = -Normal1.X
		        LowerLimit.Y = -Normal1.Y
		        UpperLimit.X = Normal2.X
		        UpperLimit.Y = Normal2.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = -Normal1.X
		        LowerLimit.Y = -Normal1.Y
		        UpperLimit.X = Normal1.X
		        UpperLimit.Y = Normal1.Y
		      End If
		    Else
		      front = (offset1 >= 0.0 And offset2 >= 0.0)
		      If front Then
		        Normal.X = Normal1.X
		        Normal.Y = Normal1.Y
		        LowerLimit.X = -Normal1.X
		        LowerLimit.Y = -Normal1.Y
		        UpperLimit.X = Normal1.X
		        UpperLimit.Y = Normal1.Y
		      Else
		        Normal.X = -Normal1.X
		        Normal.Y = -Normal1.Y
		        LowerLimit.X = -Normal2.X
		        LowerLimit.Y = -Normal2.Y
		        UpperLimit.X = Normal1.X
		        UpperLimit.Y = Normal1.Y
		      End If
		    End If
		  Else
		    front = (offset1 >= 0.0)
		    If front Then
		      Normal.X = Normal1.X
		      Normal.Y = Normal1.Y
		      LowerLimit.X = -Normal1.X
		      LowerLimit.Y = -Normal1.Y
		      UpperLimit.X = -Normal1.X
		      UpperLimit.Y = -Normal1.Y
		    Else
		      Normal.X = -Normal1.X
		      Normal.Y = -Normal1.Y
		      LowerLimit.X = Normal1.X
		      LowerLimit.Y = Normal1.Y
		      UpperLimit.X = Normal1.X
		      UpperLimit.Y = Normal1.Y
		    End If
		  End If
		  
		  // Get polygonB in frameA.
		  polygonB.Count = polygonB2.Vertices.Count
		  Var iLimit As Integer = polygonB2.Vertices.Count - 1
		  For i As Integer = 0 To iLimit
		    PolygonB.Vertices(i).SetFrom(Physics.Transform.MulVec2(Xf, polygonB2.Vertices(i)))
		    PolygonB.Normals(i).SetFrom(Physics.Rot.MulVec2(Xf.Q, polygonB2.Normals(i)))
		  Next i
		  
		  radius = 2.0 * Physics.Settings.PolygonRadius
		  
		  manifold.PointCount = 0
		  
		  ComputeEdgeSeparation(mEdgeAxis)
		  
		  // If no valid normal can be found than this edge should not collide.
		  If mEdgeAxis.Type = Physics.EPAxisType.Unknown Then
		    Return
		  End If
		  
		  If mEdgeAxis.Separation > radius Then
		    Return
		  End If
		  
		  ComputePolygonSeparation(mPolygonAxis)
		  If mPolygonAxis.Type <> Physics.EPAxisType.Unknown And _
		    mPolygonAxis.Separation > radius Then
		    Return
		  End If
		  
		  // Use hysteresis for jitter reduction.
		  Const relativeTol As Double = 0.98
		  Const kAbsoluteTol As Double = 0.001
		  
		  Var primaryAxis As Physics.EPAxis
		  If mPolygonAxis.Type = Physics.EPAxisType.Unknown Then
		    primaryAxis = mEdgeAxis
		  Elseif mPolygonAxis.Separation > relativeTol * mEdgeAxis.Separation + kAbsoluteTol Then
		    primaryAxis = mPolygonAxis
		  Else
		    primaryAxis = mEdgeAxis
		  End If
		  
		  Var ie0 As Physics.ClipVertex = mIncidentEdge(0)
		  Var ie1 As Physics.ClipVertex = mIncidentEdge(1)
		  
		  If primaryAxis.Type = Physics.EPAxisType.EdgeA Then
		    manifold.Type = Physics.ManifoldType.FaceA
		    
		    // Search for the polygon normal that is most anti-parallel to the edge normal.
		    Var bestIndex As Integer = 0
		    Var bestValue As Double = Normal.Dot(PolygonB.Normals(0))
		    iLimit = PolygonB.Count - 1
		    For i As Integer = 1 To iLimit
		      Var value As Double = Normal.Dot(PolygonB.Normals(i))
		      If value < bestValue Then
		        bestValue = value
		        bestIndex = i
		      End If
		    Next i
		    
		    Var i1 As Integer = bestIndex
		    Var i2 As Integer = If(i1 + 1 < PolygonB.Count, i1 + 1, 0)
		    
		    ie0.V.SetFrom(PolygonB.Vertices(i1))
		    ie0.ID.IndexA = 0
		    ie0.ID.IndexB = i1 And &hFF
		    ie0.ID.TypeA = Integer(Physics.ContactIDType.Face) And &hFF
		    ie0.ID.TypeB = Integer(Physics.ContactIDType.Vertex) And &hFF
		    
		    ie1.V.SetFrom(PolygonB.Vertices(i2))
		    ie1.ID.IndexA = 0
		    ie1.ID.IndexB = i2 And &hFF
		    ie1.ID.TypeA = Integer(Physics.ContactIDType.Face) And &hFF
		    ie1.ID.TypeB = Integer(Physics.ContactIDType.Vertex) And &hFF
		    
		    If front Then
		      mRf.i1 = 0
		      mRf.i2 = 1
		      mRf.V1.SetFrom(V1)
		      mRf.V2.SetFrom(V2)
		      mRf.Normal.SetFrom(Normal1)
		    Else
		      mRf.i1 = 1
		      mRf.i2 = 0
		      mRf.V1.SetFrom(V2)
		      mRf.V2.SetFrom(V1)
		      mRf.Normal.SetFrom(Normal1)
		      mRf.Normal.Negate
		    End If
		  Else
		    manifold.Type = Physics.ManifoldType.FaceB
		    
		    ie0.V.SetFrom(V1)
		    ie0.ID.IndexA = 0
		    ie0.ID.IndexB = primaryAxis.Index And &hFF
		    ie0.ID.TypeA = Integer(Physics.ContactIDType.Vertex) And &hFF
		    ie0.ID.TypeB = Integer(Physics.ContactIDType.Face) And &hFF
		    
		    ie1.V.SetFrom(V2)
		    ie1.ID.IndexA = 0
		    ie1.ID.IndexB = primaryAxis.Index And &hFF
		    ie1.ID.TypeA = Integer(Physics.ContactIDType.Vertex) And &hFF
		    ie1.ID.TypeB = Integer(Physics.ContactIDType.Face) And &hFF
		    
		    mRf.i1 = primaryAxis.Index
		    mRf.i2 = If(mRf.i1 + 1 < PolygonB.Count, mRf.i1 + 1, 0)
		    mRf.V1.SetFrom(PolygonB.Vertices(mRf.i1))
		    mRf.V2.SetFrom(PolygonB.Vertices(mRf.i2))
		    mRf.Normal.SetFrom(PolygonB.Normals(mRf.i1))
		  End If
		  
		  mRf.SideNormal1.SetValues(mRf.Normal.Y, -mRf.Normal.X)
		  mRf.SideNormal2.SetFrom(mRf.SideNormal1)
		  mRf.SideNormal2.Negate
		  mRf.SideOffset1 = mRf.SideNormal1.Dot(mRf.V1)
		  mRf.SideOffset2 = mRf.SideNormal2.Dot(mRf.V2)
		  
		  // Clip to box side 1.
		  If Collision.ClipSegmentToLine(mClipPoints1, mIncidentEdge, mRf.SideNormal1, _
		    mRf.SideOffset1, mRf.i1) < Physics.Settings.MaxManifoldPoints Then
		    Return
		  End If
		  
		  // Clip to negative box side 1.
		  If Collision.ClipSegmentToLine(mClipPoints2, mClipPoints1, mRf.SideNormal2, _
		    mRf.SideOffset2, mRf.i2) < Physics.Settings.MaxManifoldPoints Then
		    Return
		  End If
		  
		  // Now mClipPoints2 contains the clipped points.
		  If primaryAxis.Type = Physics.EPAxisType.EdgeA Then
		    manifold.LocalNormal.SetFrom(mRf.Normal)
		    manifold.LocalPoint.SetFrom(mRf.V1)
		  Else
		    manifold.LocalNormal.SetFrom(polygonB2.Normals(mRf.i1))
		    manifold.LocalPoint.SetFrom(polygonB2.Vertices(mRf.i1))
		  End If
		  
		  Var pointCount As Integer = 0
		  iLimit = Physics.Settings.MaxManifoldPoints - 1
		  For i As Integer = 0 To iLimit
		    Var separation As Double
		    
		    mTemp.SetFrom(mClipPoints2(i).V)
		    mTemp.Subtract(mRf.V1)
		    separation = mRf.Normal.Dot(mTemp)
		    
		    If separation <= radius Then
		      Var cp As Physics.ManifoldPoint = manifold.Points(pointCount)
		      
		      If primaryAxis.Type = Physics.EPAxisType.EdgeA Then
		        cp.LocalPoint.SetFrom(Physics.Transform.MulTransVec2(Xf, mClipPoints2(i).V))
		        cp.ID.Set(mClipPoints2(i).ID)
		      Else
		        cp.LocalPoint.SetFrom(mClipPoints2(i).V)
		        cp.ID.TypeA = mClipPoints2(i).ID.TypeB
		        cp.ID.TypeB = mClipPoints2(i).ID.TypeA
		        cp.ID.IndexA = mClipPoints2(i).ID.IndexB
		        cp.ID.IndexB = mClipPoints2(i).ID.IndexA
		      End If
		      
		      pointCount = pointCount + 1
		    End If
		  Next i
		  
		  manifold.PointCount = pointCount
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeEdgeSeparation(axis As Physics.EPAxis)
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  axis.Type = Physics.EPAxisType.EdgeA
		  axis.Index = If(front, 0, 1)
		  axis.Separation = Maths.DoubleMaxFinite
		  Var nx As Double = Normal.X
		  Var ny As Double = Normal.Y
		  
		  Var iLimit As Integer = PolygonB.Count - 1
		  For i As Integer = 0 To iLimit
		    Var v As VMaths.Vector2 = PolygonB.Vertices(i)
		    Var tempX As Double = v.X - V1.X
		    Var tempY As Double = v.Y - V1.Y
		    Var s As Double = nx * tempX + ny * tempY
		    If s < axis.Separation Then
		      axis.Separation = s
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputePolygonSeparation(axis As Physics.EPAxis)
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  axis.Type = Physics.EPAxisType.Unknown
		  axis.Index = -1
		  axis.Separation = -Maths.DoubleMaxFinite
		  
		  mPerp.X = -Normal.Y
		  mPerp.Y = Normal.X
		  
		  Var iLimit As Integer = PolygonB.Count - 1
		  For i As Integer = 0 To iLimit
		    Var normalB As VMaths.Vector2 = PolygonB.Normals(i)
		    Var vB As VMaths.Vector2 = PolygonB.Vertices(i)
		    mN.X = -normalB.X
		    mN.Y = -normalB.Y
		    
		    Var tempX As Double = vB.X - v1.X
		    Var tempY As Double = vB.Y - v1.Y
		    Var s1 As Double = mN.X * tempX + mN.Y * tempY
		    tempX = vB.X - V2.X
		    tempY = vB.Y - V2.Y
		    Var s2 As Double = mN.X * tempX + mN.Y * tempY
		    Var s As Double = Min(s1, s2)
		    
		    If s > radius Then
		      // No collision.
		      axis.Type = Physics.EPAxisType.EdgeB
		      axis.Index = i
		      axis.Separation = s
		      Return
		    End If
		    
		    // Adjacency.
		    If mN.X * mPerp.X + mN.Y * mPerp.Y >= 0.0 Then
		      mTemp.SetFrom(mN)
		      mTemp.Subtract(UpperLimit)
		      If mTemp.Dot(normal) < -Physics.Settings.AngularSlop Then
		        Continue
		      End If
		    Else
		      mTemp.SetFrom(mN)
		      mTemp.Subtract(LowerLimit)
		      If mTemp.Dot(Normal) < -Physics.Settings.AngularSlop Then
		        Continue
		      End If
		    End If
		    
		    If s > axis.Separation Then
		      axis.Type = Physics.EPAxisType.EdgeB
		      axis.Index = i
		      axis.Separation = s
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  PolygonB = New Physics.TempPolygon
		  Xf = New Physics.Transform
		  CentroidB = VMaths.Vector2.Zero
		  V0 = VMaths.Vector2.Zero
		  V1 = VMaths.Vector2.Zero
		  V2 = VMaths.Vector2.Zero
		  V3 = VMaths.Vector2.Zero
		  Normal = VMaths.Vector2.Zero
		  Normal0 = VMaths.Vector2.Zero
		  Normal1 = VMaths.Vector2.Zero
		  Normal2 = VMaths.Vector2.Zero
		  LowerLimit = VMaths.Vector2.Zero
		  UpperLimit = VMaths.Vector2.Zero
		  mEdge0 = VMaths.Vector2.Zero
		  mEdge1 = VMaths.Vector2.Zero
		  mEdge2 = VMaths.Vector2.Zero
		  mTemp = VMaths.Vector2.Zero
		  
		  mIncidentEdge.Add(New Physics.ClipVertex)
		  mIncidentEdge.Add(New Physics.ClipVertex)
		  
		  mClipPoints1.Add(New Physics.ClipVertex)
		  mClipPoints1.Add(New Physics.ClipVertex)
		  
		  mClipPoints2.Add(New Physics.ClipVertex)
		  mClipPoints2.Add(New Physics.ClipVertex)
		  
		  mRf = New Physics.mReferenceFace
		  mEdgeAxis = New Physics.EPAxis
		  mPolygonAxis = New Physics.EPAxis
		  
		  mPerp = VMaths.Vector2.Zero
		  mN = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This class collides an edge and a polygon, taking into account edge adjacency.
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		CentroidB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Front As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		LowerLimit As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClipPoints1() As Physics.ClipVertex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClipPoints2() As Physics.ClipVertex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEdge0 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEdge1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEdge2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEdgeAxis As Physics.EPAxis
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIncidentEdge() As Physics.ClipVertex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mN As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPerp As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPolygonAxis As Physics.EPAxis
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRf As Physics.mReferenceFace
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal0 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		PolygonB As Physics.TempPolygon
	#tag EndProperty

	#tag Property, Flags = &h0
		Radius As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Type1 As Physics.VertexType = Physics.VertexType.Isolated
	#tag EndProperty

	#tag Property, Flags = &h0
		Type2 As Physics.VertexType = Physics.VertexType.Isolated
	#tag EndProperty

	#tag Property, Flags = &h0
		UpperLimit As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		V0 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		V1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		V2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		V3 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Xf As Physics.Transform
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
			Name="Front"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Radius"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

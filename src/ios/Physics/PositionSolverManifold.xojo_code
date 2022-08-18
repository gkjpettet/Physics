#tag Class
Protected Class PositionSolverManifold
	#tag Method, Flags = &h0
		Sub Constructor()
		  Normal = VMaths.Vector2.Zero
		  Point = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize(pc As Physics.ContactPositionConstraint, xfA As Physics.Transform, xfB As Physics.Transform, index As Integer)
		  #If DebugBuild
		    Assert(pc.PointCount > 0)
		  #EndIf
		  
		  Var xfAq As Physics.Rot = xfA.Q
		  Var xfBq As Physics.Rot = xfB.Q
		  Var pcLocalPointsI As VMaths.Vector2 = pc.LocalPoints(index)
		  
		  Select Case pc.Type
		  Case Physics.ManifoldType.Circles
		    Var pLocalPoint As VMaths.Vector2 = pc.LocalPoint
		    Var pLocalPoints0 As VMaths.Vector2 = pc.LocalPoints(0)
		    Var pointAx As Double = _
		    (xfAq.Cos * pLocalPoint.X - xfAq.Sin * pLocalPoint.Y) + xfA.P.X
		    Var pointAy As Double = _
		    (xfAq.Sin * pLocalPoint.X + xfAq.Cos * pLocalPoint.Y) + xfA.P.Y
		    Var pointBx As Double = _
		    (xfBq.Cos * pLocalPoints0.X - xfBq.Sin * pLocalPoints0.Y) + xfB.P.X
		    Var pointBy As Double = _
		    (xfBq.Sin * pLocalPoints0.X + xfBq.Cos * pLocalPoints0.Y) + xfB.P.Y
		    Normal.X = pointBx - pointAx
		    Normal.Y = pointBy - pointAy
		    Normal.Normalize
		    
		    Point.X = (pointAx + pointBx) * 0.5
		    Point.Y = (pointAy + pointBy) * 0.5
		    Var tempX As Double = pointBx - pointAx
		    Var tempY As Double = pointBy - pointAy
		    Separation = _
		    tempX * normal.X + tempY * normal.Y - pc.RadiusA - pc.RadiusB
		    
		  Case Physics.ManifoldType.FaceA
		    Var pcLocalNormal As VMaths.Vector2 = pc.LocalNormal
		    Var pcLocalPoint As VMaths.Vector2 = pc.LocalPoint
		    Normal.X = xfAq.Cos * pcLocalNormal.X - xfAq.Sin * pcLocalNormal.Y
		    Normal.Y = xfAq.Sin * pcLocalNormal.X + xfAq.Cos * pcLocalNormal.Y
		    Var planePointX As Double = _
		    (xfAq.Cos * pcLocalPoint.X - xfAq.Sin * pcLocalPoint.Y) + xfA.P.X
		    Var planePointY As Double = _
		    (xfAq.Sin * pcLocalPoint.X + xfAq.Cos * pcLocalPoint.Y) + xfA.P.Y
		    
		    Var clipPointX As Double = _
		    (xfBq.Cos * pcLocalPointsI.X - xfBq.Sin * pcLocalPointsI.Y) + _ 
		    xfB.P.X
		    Var clipPointY As Double = _
		    (xfBq.Sin * pcLocalPointsI.X + xfBq.Cos * pcLocalPointsI.Y) + _
		    xfB.p.Y
		    Var tempX As Double = clipPointX - planePointX
		    Var tempY As Double = clipPointY - planePointY
		    Separation = _
		    tempX * normal.X + tempY * normal.Y - pc.RadiusA - pc.RadiusB
		    Point.X = clipPointX
		    Point.Y = clipPointY
		    
		  Case Physics.ManifoldType.FaceB
		    Var pcLocalNormal As VMaths.Vector2 = pc.LocalNormal
		    Var pcLocalPoint As VMaths.Vector2  = pc.LocalPoint
		    Normal.X = xfBq.Cos * pcLocalNormal.X - xfBq.Sin * pcLocalNormal.Y
		    Normal.Y = xfBq.Sin * pcLocalNormal.X + xfBq.Cos * pcLocalNormal.Y
		    Var planePointX As Double = _
		    (xfBq.Cos * pcLocalPoint.X - xfBq.Sin * pcLocalPoint.Y) + xfB.P.X
		    Var planePointY As Double = _
		    (xfBq.Sin * pcLocalPoint.X + xfBq.Cos * pcLocalPoint.Y) + xfB.P.Y
		    
		    Var clipPointX As Double = _
		    (xfAq.Cos * pcLocalPointsI.X - xfAq.Sin * pcLocalPointsI.Y) + _
		    xfA.P.X
		    Var clipPointY As Double = _
		    (xfAq.Sin * pcLocalPointsI.X + xfAq.Cos * pcLocalPointsI.Y) + _
		    xfA.P.Y
		    Var tempX As Double = clipPointX - planePointX
		    Var tempY As Double = clipPointY - planePointY
		    Separation = _
		    tempX * normal.X + tempY * normal.Y - pc.RadiusA - pc.RadiusB
		    point.X = clipPointX
		    point.Y = clipPointY
		    normal.X = normal.X * -1
		    normal.Y = normal.Y * -1
		  End Select
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Normal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Point As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Separation As Double = 0
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
			Name="Separation"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

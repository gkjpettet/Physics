#tag Class
Protected Class WorldManifold
	#tag Method, Flags = &h0
		Sub Constructor()
		  Normal = VMaths.Vector2.Zero
		  
		  Points.ResizeTo(Physics.Settings.MaxManifoldPoints - 1)
		  For i As Integer = 0 To Points.LastIndex
		    Points(i) = VMaths.Vector2.Zero
		  Next i
		  
		  Separations.ResizeTo(Physics.Settings.MaxManifoldPoints - 1)
		  
		  mPool3 = VMaths.Vector2.Zero
		  mPool4 = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize(manifold As Physics.Manifold, xfA As Physics.Transform, radiusA As Double, xfB As Physics.Transform, radiusB As Double)
		  If manifold.PointCount = 0 Then Return
		  
		  Select Case manifold.Type
		  Case Physics.ManifoldType.Circles
		    Var pointA As VMaths.Vector2 = mPool3
		    Var pointB As VMAths.Vector2 = mPool4
		    
		    Normal.X = 1.0
		    Normal.Y = 0.0
		    Var v As VMaths.Vector2 = manifold.LocalPoint
		    pointA.X = (xfA.Q.Cos * v.X - xfA.Q.Sin * v.Y) + xfA.P.X
		    pointA.Y = (xfA.Q.Sin * v.X + xfA.Q.Cos * v.Y) + xfA.P.Y
		    Var mp0p As VMaths.Vector2 = manifold.Points(0).LocalPoint
		    pointB.X = (xfB.Q.Cos * mp0p.X - xfB.Q.Sin * mp0p.Y) + xfB.P.X
		    pointB.Y = (xfB.Q.Sin * mp0p.X + xfB.Q.Cos * mp0p.Y) + xfB.P.Y
		    
		    If pointA.DistanceToSquared(pointB) > _
		      Physics.Settings.Epsilon * Physics.Settings.Epsilon Then
		      Normal.X = pointB.X - pointA.X
		      Normal.Y = pointB.Y - pointA.Y
		      Normal.Normalize
		    End If
		    
		    Var cAx As Double = Normal.X * radiusA + pointA.X
		    Var cAy As Double = Normal.Y * radiusA + pointA.Y
		    
		    Var cBx As Double = -Normal.X * radiusB + pointB.X
		    Var cBy As Double = -Normal.Y * radiusB + pointB.Y
		    
		    Points(0).X = (cAx + cBx) * 0.5
		    points(0).Y = (cAy + cBy) * 0.5
		    Separations(0) = (cBx - cAx) * Normal.X + (cBy - cAy) * Normal.Y
		    
		  Case Physics.ManifoldType.FaceA
		    Var planePoint As VMaths.Vector2 = mPool3
		    
		    Normal.SetFrom(Physics.Rot.MulVec2(xfA.Q, manifold.LocalNormal))
		    planePoint.SetFrom(Physics.Transform.MulVec2(xfA, manifold.LocalPoint))
		    
		    Var clipPoint As VMaths.Vector2 = mPool4
		    
		    Var iLimit As Integer = manifold.PointCount - 1
		    For i As Integer = 0 To iLimit
		      clipPoint.SetFrom(Physics.Transform.MulVec2(xfB, manifold.Points(i).LocalPoint))
		      
		      Var scalar As Double = radiusA - _
		      ((clipPoint.X - planePoint.X) * Normal.X + _
		      (clipPoint.Y - planePoint.Y) * Normal.Y)
		      
		      Var cAx As Double = Normal.X * scalar + clipPoint.X
		      Var cAy As Double = Normal.Y * scalar + clipPoint.Y
		      
		      Var cBx As Double = -Normal.X * radiusB + clipPoint.X
		      Var cBy As Double = -Normal.Y * radiusB + clipPoint.Y
		      
		      Points(i).X = (cAx + cBx) * 0.5
		      Points(i).Y = (cAy + cBy) * 0.5
		      Separations(i) = (cBx - cAx) * Normal.X + (cBy - cAy) * Normal.Y
		    Next i
		    
		  Case Physics.ManifoldType.FaceB
		    Var planePoint As VMaths.Vector2 = mPool3
		    Normal.SetFrom(Physics.Rot.MulVec2(xfB.Q, manifold.LocalNormal))
		    planePoint.setFrom(Physics.Transform.MulVec2(xfB, manifold.LocalPoint))
		    
		    Var clipPoint As VMaths.Vector2 = mPool4
		    
		    Var iLimit As Integer = manifold.PointCount - 1
		    For i As Integer = 0 To iLimit
		      clipPoint.SetFrom(Physics.Transform.MulVec2(xfA, manifold.Points(i).LocalPoint))
		      
		      Var scalar As Double = radiusB - _
		      ((clipPoint.X - planePoint.X) * Normal.X + _
		      (clipPoint.Y - planePoint.Y) * Normal.Y)
		      
		      Var cBx As Double = Normal.X * scalar + clipPoint.X
		      Var cBy As Double = Normal.Y * scalar + clipPoint.Y
		      
		      Var cAx As Double = -Normal.X * radiusA + clipPoint.X
		      Var cAy As Double = -Normal.Y * radiusA + clipPoint.Y
		      
		      Points(i).X = (cAx + cBx) * 0.5
		      Points(i).Y = (cAy + cBy) * 0.5
		      Separations(i) = (cAx - cBx) * Normal.X + (cAy - cBy) * Normal.Y
		    Next i
		    
		    // Ensure normal points from A to B.
		    Normal.X = -Normal.X
		    Normal.Y = -Normal.Y
		  End Select
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This is used to compute the current state of a contact manifold.
		
	#tag EndNote


	#tag Property, Flags = &h0
		mPool3 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		mPool4 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 576F726C6420766563746F7220706F696E74696E672066726F6D204120746F20422E
		Normal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 576F726C6420636F6E7461637420706F696E742028706F696E74206F6620696E74657273656374696F6E292E
		Points() As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41206E656761746976652076616C756520696E64696361746573206F7665726C61702C20696E206D65747265732E
		Separations() As Double
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
			Name="Normal"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

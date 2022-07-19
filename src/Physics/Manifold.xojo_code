#tag Class
Protected Class Manifold
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Initialises a manifold with 0 points, with its Points array full of instantiated
		  /// ManifoldPoints.
		  
		  Points.ResizeTo(Physics.Settings.MaxManifoldPoints - 1)
		  For i As Integer = 0 To Points.LastIndex
		    Points(i) = New Physics.ManifoldPoint
		  Next i
		  
		  LocalNormal = VMaths.Vector2.Zero
		  LocalPoint = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465732074686973206D616E69666F6C64206173206120636F7079206F6620606F74686572602E
		Shared Function Copy(other As Physics.Manifold) As Physics.Manifold
		  /// Creates this manifold as a copy of `other`.
		  
		  Var result As New Physics.Manifold
		  
		  result.LocalNormal.SetFrom(other.LocalNormal)
		  result.LocalPoint.SetFrom(other.LocalPoint)
		  result.Type = other.Type
		  result.PointCount = other.PointCount
		  
		  Var iLimit As Integer = Physics.Settings.MaxManifoldPoints - 1
		  For i As Integer = 0 To iLimit
		    result.Points(i) = Physics.ManifoldPoint.Copy(other.Points(i))
		  Next i
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742074686973206D616E69666F6C642066726F6D2074686520676976656E206F6E652E
		Sub Set(manifold As Physics.Manifold)
		  /// Set this manifold from the given one.
		  
		  Var iLimit As Integer = manifold.PointCount - 1
		  For i As Integer = 0 To iLimit
		    Points(i).Set(manifold.Points(i))
		  Next i
		  
		  Type = manifold.Type
		  LocalNormal.SetFrom(manifold.LocalNormal)
		  LocalPoint.SetFrom(manifold.LocalPoint)
		  PointCount = manifold.PointCount
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		 A manifold for two touching convex shapes. The engine supports multiple types
		 of contact:
		
		 - clip point versus plane with radius
		 - point versus point with radius (circles)
		
		 The local point usage depends on the manifold type:
		
		 - e_circles: the local centre of circleA
		 - e_faceA: the centre of faceA
		 - e_faceB: the centre of faceB
		
		 Similarly the local normal usage:
		
		 - e_circles: not used
		 - e_faceA: the normal on polygonA
		 - e_faceB: the normal on polygonB
		
		 We store contacts in this way so that position correction can account for
		 movement, which is critical for continuous physics. All contact scenarios
		 must be expressed in one of these types.
		 This structure is stored across time steps, so we keep it small.
		
	#tag EndNote


	#tag Property, Flags = &h0
		LocalNormal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557361676520646570656E6473206F6E206D616E69666F6C6420747970652E
		LocalPoint As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F66206D616E69666F6C6420706F696E74732E
		PointCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Points() As Physics.ManifoldPoint
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As Physics.ManifoldType = Physics.ManifoldType.Circles
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

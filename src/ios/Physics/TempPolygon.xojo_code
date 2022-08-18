#tag Class
Protected Class TempPolygon
	#tag Method, Flags = &h0
		Sub Constructor()
		  Vertices.ResizeTo(Physics.Settings.MaxPolygonVertices - 1)
		  For i As Integer = 0 To Vertices.LastIndex
		    Vertices(i) = VMaths.Vector2.Zero
		  Next i
		  
		  Normals.ResizeTo(Physics.Settings.MaxPolygonVertices - 1)
		  For i As Integer = 0 To Vertices.LastIndex
		    Normals(i) = VMaths.Vector2.Zero
		  Next i
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This holds polygon B expressed in frame A. 
		Used internally within `Physics.Collision`.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Count As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Normals() As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Vertices() As VMaths.Vector2
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
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

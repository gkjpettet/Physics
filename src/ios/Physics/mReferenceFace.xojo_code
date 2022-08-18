#tag Class
Private Class mReferenceFace
	#tag Method, Flags = &h0
		Sub Constructor()
		  V1 = VMaths.Vector2.Zero
		  V2 = VMaths.Vector2.Zero
		  Normal = VMaths.Vector2.Zero
		  SideNormal1 = VMaths.Vector2.Zero
		  SideNormal2 = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Reference face used for clipping.
		
		Used internally within `Physics.Collision`.
		
	#tag EndNote


	#tag Property, Flags = &h0
		i1 As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		i2 As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		SideNormal1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		SideNormal2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		SideOffset1 As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0
		SideOffset2 As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0
		V1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		V2 As VMaths.Vector2
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
			Name="i1"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="i2"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SideOffset1"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SideOffset2"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

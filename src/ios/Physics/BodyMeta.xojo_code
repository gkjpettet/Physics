#tag Class
Protected Class BodyMeta
	#tag Method, Flags = &h0
		Sub Constructor(body As Physics.Body)
		  Self.Velocity = New Physics.Velocity
		  Self.Position = New Physics.Position
		  
		  Self.Body = body
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Body As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		Position As Physics.Position
	#tag EndProperty

	#tag Property, Flags = &h0
		Velocity As Physics.Velocity
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

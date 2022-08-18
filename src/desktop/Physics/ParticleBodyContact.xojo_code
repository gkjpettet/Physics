#tag Class
Protected Class ParticleBodyContact
	#tag Method, Flags = &h0
		Sub Constructor(particle As Physics.Particle, body As Physics.Body)
		  Self.Particle = particle
		  Self.Body = body
		  
		  Normal = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520626F6479206D616B696E6720636F6E746163742E
		Body As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520656666656374697665206D617373207573656420696E2063616C63756C6174696E6720666F7263652E
		Mass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E6F726D616C6973656420646972656374696F6E2066726F6D20746865207061727469636C6520746F2074686520626F64792E
		Normal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520696E646578206F6620746865207061727469636C65206D616B696E6720636F6E746163742E
		Particle As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 576569676874206F662074686520636F6E746163742E20412076616C7565206265747765656E203020616E6420312E
		Weight As Double = 0
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
			Name="Particle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

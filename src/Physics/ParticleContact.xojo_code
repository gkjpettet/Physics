#tag Class
Protected Class ParticleContact
	#tag Method, Flags = &h0
		Sub Constructor(particleA As Physics.Particle, particleB As Physics.Particle)
		  Self.ParticleA = particleA
		  Self.ParticleB = particleB
		  
		  Normal = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206C6F676963616C2073756D206F6620746865207061727469636C65206265686176696F727320746861742068617665206265656E207365742E
		Flags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E6F726D616C6973656420646972656374696F6E2066726F6D204120746F20422E
		Normal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleA As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleB As Physics.Particle
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
			Name="ParticleA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

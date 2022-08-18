#tag Class
Protected Class PsPair
	#tag Method, Flags = &h0
		Sub Constructor(particleA As Physics.Particle, particleB As Physics.Particle)
		  Self.ParticleA = particleA
		  Self.ParticleB = particleB
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Connection between two particles.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Distance As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Flags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleA As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleB As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0
		Strength As Double = 0
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

#tag Class
Protected Class PsTriad
	#tag Method, Flags = &h0
		Sub Constructor(particleA As Physics.Particle, particleB As Physics.Particle, particleC As Physics.Particle)
		  Self.ParticleA = particleA
		  Self.ParticleB = particleB
		  Self.ParticleC = particleC
		  
		  Pa = VMaths.Vector2.Zero
		  Pb = VMaths.Vector2.Zero
		  Pc = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Connection between three particles.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Flags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Ka As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Kb As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Kc As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Pa As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleA As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleB As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleC As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0
		Pb As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Pc As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		S As Double = 0
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
			Name="Flags"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Ka"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Kb"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Kc"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Strength"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

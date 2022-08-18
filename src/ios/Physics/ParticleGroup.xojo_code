#tag Class
Protected Class ParticleGroup
	#tag Method, Flags = &h0
		Sub Add(particle As Physics.Particle)
		  Particles.Add(particle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(system As Physics.ParticleSystem)
		  mCenter = VMaths.Vector2.Zero
		  mLinearVelocity = VMaths.Vector2.Zero
		  Self.Transform = Physics.Transform.Zero
		  Self.Transform.SetIdentity
		  
		  mSystem = system
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(particle As Physics.Particle) As Boolean
		  Var index As Integer = Particles.IndexOf(particle)
		  
		  If index = -1 Then
		    Return False
		  Else
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateStatistics()
		  If mTimestamp <> mSystem.Timestamp Then
		    Var m As Double = mSystem.ParticleMass
		    Var mMass As Double = m * Particles.Count
		    mCenter.SetZero
		    mLinearVelocity.SetZero
		    For Each particle As Physics.Particle In Particles
		      mCenter.SetFrom(mCenter + (particle.Position * m))
		      mLinearVelocity.SetFrom(mLinearVelocity + (particle.Velocity * m))
		    Next particle
		    if mMass > 0 Then
		      mCenter.X = mCenter.X * (1 / mMass)
		      mCenter.Y = mCenter.Y * (1 / mMass)
		      mLinearVelocity.X = mLinearVelocity.X * (1 / mMass)
		      mLinearVelocity.Y = mLinearVelocity.Y * (1 / mMass)
		    End If
		    mInertia = 0.0
		    mAngularVelocity = 0.0
		    For Each particle As Physics.Particle In Particles
		      Var position As VMaths.Vector2 = particle.Position
		      Var velocity As VMaths.Vector2 = particle.Velocity
		      Var px As Double = position.X - mCenter.X
		      Var py As Double = position.Y - mCenter.Y
		      Var vx As Double = velocity.X - mLinearVelocity.X
		      Var vy As Double = velocity.Y - mLinearVelocity.Y
		      mInertia = mInertia + (m * (px * px + py * py))
		      mAngularVelocity = mAngularVelocity + (m * (px * vy - py * vx))
		    Next particle
		    
		    If mInertia > 0 Then
		      mAngularVelocity = mAngularVelocity * (1 / mInertia)
		    End If
		    mTimestamp = mSystem.Timestamp
		  End If
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Transform.Q.GetAngle
			End Get
		#tag EndGetter
		Angle As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  UpdateStatistics
			  Return mAngularVelocity
			  
			End Get
		#tag EndGetter
		AngularVelocity As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  UpdateStatistics
			  Return mCenter
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCenter.SetFrom(value)
			  
			End Set
		#tag EndSetter
		Center As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		DestroyAutomatically As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		GroupFlags As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  UpdateStatistics
			  Return mInertia
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mInertia = value
			  
			End Set
		#tag EndSetter
		Inertia As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  UpdateStatistics
			  Return mLinearVelocity
			  
			End Get
		#tag EndGetter
		LinearVelocity As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAngularVelocity As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  UpdateStatistics
			  Return mMass
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mMass = value
			End Set
		#tag EndSetter
		Mass As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCenter As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInertia As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLinearVelocity As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSystem As Physics.ParticleSystem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimestamp As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		Particles() As Physics.Particle
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Transform.P
			End Get
		#tag EndGetter
		Position As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Strength As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		ToBeDestroyed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		ToBeSplit As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Transform As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		UserData As Variant
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
			Name="GroupFlags"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
		#tag ViewProperty
			Name="DestroyAutomatically"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToBeDestroyed"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToBeSplit"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Angle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AngularVelocity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Inertia"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

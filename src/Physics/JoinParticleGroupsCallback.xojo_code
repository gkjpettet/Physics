#tag Class
Protected Class JoinParticleGroupsCallback
Implements Physics.VoronoiDiagramCallback
	#tag Method, Flags = &h0
		Sub Call_(particleA As Physics.Particle, particleB As Physics.Particle, particleC As Physics.Particle)
		  // Part of the Physics.VoronoiDiagramCallback interface.
		  
		  Var callParticles() As Physics.Particle = Array(particleA, particleB, particleC)
		  
		  // Create a triad if it will contain particles from both groups.
		  If HasCallParticle(groupA, callParticles) And _
		    HasCallParticle(groupB, callParticles) Then
		    Var af As Integer = particleA.Flags
		    Var bf As Integer = particleB.Flags
		    Var cf As Integer = particleC.Flags
		    If (af And bf And cf And Physics.ParticleSystem.TriadFlags) <> 0 Then
		      Var pa As VMaths.Vector2 = particleA.Position
		      Var pb As VMaths.Vector2 = particleB.Position
		      Var pc As VMaths.Vector2 = particleC.Position
		      Var dabx As Double = pa.X - pb.X
		      Var daby As Double = pa.Y - pb.Y
		      Var dbcx As Double = pb.X - pc.X
		      Var dbcy As Double = pb.Y - pc.Y
		      Var dcax As Double = pc.X - pa.X
		      Var dcay As Double = pc.Y - pa.Y
		      Var maxDistanceSquared As Double = _
		      Physics.Settings.MaxTriadDistanceSquared * system.SquaredDiameter
		      If dabx * dabx + daby * daby < maxDistanceSquared And _
		        dbcx * dbcx + dbcy * dbcy < maxDistanceSquared And _
		        dcax * dcax + dcay * dcay < maxDistanceSquared Then
		        Var midPointX As Double = 1.0 / 3.0 * (pa.X + pb.X + pc.X)
		        Var midPointY As Double = 1.0 / 3.0 * (pa.Y + pb.Y + pc.Y)
		        Var triad As New Physics.PsTriad(particleA, particleB, particleC)
		        triad.Flags = af Or bf Or cf
		        triad.Strength = min(groupA.strength, groupB.strength)
		        triad.Pa.x = pa.X - midPointX
		        triad.Pa.y = pa.Y - midPointY
		        triad.Pb.x = pb.X - midPointX
		        triad.Pb.y = pb.Y - midPointY
		        triad.Pc.x = pc.X - midPointX
		        triad.Pc.y = pc.Y - midPointY
		        triad.Ka = -(dcax * dabx + dcay * daby)
		        triad.Kb = -(dabx * dbcx + daby * dbcy)
		        triad.Kc = -(dbcx * dcax + dbcy * dcay)
		        triad.S = pa.Cross(pb) + pb.Cross(pc) + pc.Cross(pa)
		        system.TriadBuffer.Add(triad)
		      End If
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(system As Physics.ParticleSystem, groupA As Physics.ParticleGroup, groupB As Physics.ParticleGroup)
		  Self.System = system
		  Self.GroupA = groupA
		  Self.GroupB = groupB
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasCallParticle(group As Physics.ParticleGroup, callParticles() As Physics.Particle) As Boolean
		  For Each cp As Physics.Particle In callParticles
		    If group.Particles.IndexOf(cp) <> -1 Then Return True
		  Next cp
		  
		  Return False
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		GroupA As Physics.ParticleGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		GroupB As Physics.ParticleGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		System As Physics.ParticleSystem
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
			Name="System"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

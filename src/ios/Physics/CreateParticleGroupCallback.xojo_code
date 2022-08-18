#tag Class
Protected Class CreateParticleGroupCallback
Implements Physics.VoronoiDiagramCallback
	#tag Method, Flags = &h0
		Sub Call_(particleA As Physics.Particle, particleB As Physics.Particle, particleC As Physics.Particle)
		  // Part of the Physics.VoronoiDiagramCallback interface.
		  
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
		    triad.Flags = particleA.Flags Or particleB.Flags Or particleC.Flags
		    triad.Strength = def.Strength
		    triad.Pa.X = pa.X - midPointX
		    triad.Pa.Y = pa.Y - midPointY
		    triad.Pb.X = pb.X - midPointX
		    triad.Pb.Y = pb.Y - midPointY
		    triad.Pc.X = pc.X - midPointX
		    triad.Pc.Y = pc.Y - midPointY
		    triad.Ka = -(dcax * dabx + dcay * daby)
		    triad.Kb = -(dabx * dbcx + daby * dbcy)
		    triad.Kc = -(dbcx * dcax + dbcy * dcay)
		    triad.S = pa.Cross(pb) + pb.Cross(pc) + pc.Cross(pa)
		    system.TriadBuffer.Add(triad)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(system As Physics.ParticleSystem, def As Physics.ParticleGroupDef)
		  Self.System = system
		  Self.Def = def
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Def As Physics.ParticleGroupDef
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
	#tag EndViewBehavior
End Class
#tag EndClass

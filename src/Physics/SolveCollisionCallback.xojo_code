#tag Class
Protected Class SolveCollisionCallback
Implements Physics.QueryCallback
	#tag Method, Flags = &h0
		Sub Constructor()
		  Input = New Physics.RaycastInput
		  Output = New Physics.RaycastOutput
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReportFixture(fixture As Physics.Fixture) As Boolean
		  // Part of the Physics.QueryCallback interface.
		  
		  If fixture.IsSensor Then
		    Return True
		  End If
		  
		  Var shape As Physics.Shape = fixture.Shape
		  Var body As Physics.Body = fixture.Body
		  Var childCount As Integer = shape.ChildCount
		  Var childIndexLimit As Integer = childCount - 1
		  For childIndex As Integer = 0 To childIndexLimit
		    Var aabb As Physics.AABB = fixture.GetAABB(childIndex)
		    Var particleDiameter As Double = system.particleDiameter
		    Var aabbLowerBoundx As Double = aabb.LowerBound.X - particleDiameter
		    Var aabbLowerBoundy As Double = aabb.LowerBound.Y - particleDiameter
		    Var aabbUpperBoundx As Double = aabb.UpperBound.X + particleDiameter
		    Var aabbUpperBoundy As Double = aabb.UpperBound.Y + particleDiameter
		    Var firstProxy As Integer = Physics.ParticleSystem.LowerBound( _
		    system.ProxyBuffer, _
		    Physics.ParticleSystem.ComputeTag( _
		    system.InverseDiameter * aabbLowerBoundx, _
		    system.InverseDiameter * aabbLowerBoundy))
		    
		    Var lastProxy As Integer = Physics.ParticleSystem.UpperBound( _
		    system.ProxyBuffer, _
		    Physics.ParticleSystem.ComputeTag( _
		    system.InverseDiameter * aabbUpperBoundx, _
		    system.InverseDiameter * aabbUpperBoundy))
		    
		    Var iLimit As Integer = lastProxy - 1
		    For i As Integer = firstProxy To iLimit
		      Var particle as Physics.Particle = system.ProxyBuffer(i).Particle
		      Var ap As VMaths.Vector2 = particle.Position
		      If aabbLowerBoundx <= ap.X And ap.X <= aabbUpperBoundx And  _
		        aabbLowerBoundy <= ap.Y And ap.Y <= aabbUpperBoundy Then
		        Var av As VMaths.Vector2 = particle.Velocity
		        Var temp As VMaths.Vector2 = Physics.Transform.MulTransVec2( _
		        body.PreviousTransform, ap)
		        Input.P1.SetFrom(Physics.Transform.MulVec2(body.Transform, temp))
		        Input.P2.X = ap.X + Step_.Dt * av.X
		        Input.P2.Y = ap.Y + Step_.Dt * av.Y
		        Input.MaxFraction = 1.0
		        If fixture.Raycast(output, input, childIndex) Then
		          Var p As New VMaths.Vector2( _
		          (1 - Output.Fraction) * Input.P1.X + _
		          Output.Fraction * Input.P2.X + _
		          Physics.Settings.LinearSlop * Output.Normal.X, _
		          (1 - Output.Fraction) * Input.P1.Y + _
		          Output.Fraction * Input.P2.Y + _
		          Physics.Settings.LinearSlop * Output.Normal.Y)
		          
		          Var vx As Double = Step_.InvDt * (p.X - ap.X)
		          Var vy As Double = Step_.InvDt * (p.Y - ap.Y)
		          av.X = vx
		          av.Y = vy
		          Var particleMass As Double = system.ParticleMass
		          Var ax As Double = particleMass * (av.X - vx)
		          Var ay As Double = particleMass * (av.Y - vy)
		          Var b As VMaths.Vector2 = Output.Normal
		          Var fdn As Double = ax * b.X + ay * b.Y
		          Var f As New VMaths.Vector2(fdn * b.X, fdn * b.Y)
		          body.ApplyLinearImpulse(f, p)
		        End If
		      End If
		    Next i
		  Next childIndex
		  
		  Return True
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Input As Physics.RaycastInput
	#tag EndProperty

	#tag Property, Flags = &h0
		Output As Physics.RaycastOutput
	#tag EndProperty

	#tag Property, Flags = &h0
		Step_ As Physics.TimeStep
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

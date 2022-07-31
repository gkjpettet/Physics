#tag Class
Protected Class UpdateBodyContactsCallback
Implements Physics.QueryCallback
	#tag Method, Flags = &h0
		Sub Constructor(system As Physics.ParticleSystem)
		  Self.System = system
		  
		  mTempNormal = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReportFixture(fixture As Physics.Fixture) As Boolean
		  If fixture.IsSensor Then Return True
		  
		  Var shape As Physics.Shape = fixture.Shape
		  Var b As Physics.Body = fixture.Body
		  Var bp As VMaths.Vector2 = b.WorldCenter
		  Var bm As Double = b.Mass
		  Var bI As Double = b.GetInertia - bm * b.GetLocalCenter.Length2
		  Var invBm As Double = If(bm > 0, 1 / bm, 0.0)
		  Var invBI As Double = If(bI > 0, 1 / bI , 0.0)
		  Var childCount As Integer = shape.ChildCount
		  
		  Var childIndexLimit As Integer = childCount - 1
		  For childIndex As Integer = 0 To childIndexLimit
		    Var aabb As Physics.AABB = fixture.GetAABB(childIndex)
		    Var aabbLowerBoundX As Double = aabb.LowerBound.X - System.ParticleDiameter
		    Var aabbLowerBoundY As Double = aabb.LowerBound.Y - System.ParticleDiameter
		    Var aabbUpperBoundX As Double = aabb.UpperBound.X + System.ParticleDiameter
		    Var aabbUpperBoundY As Double = aabb.UpperBound.Y + System.ParticleDiameter
		    Var firstProxy As Integer = _
		    Physics.ParticleSystem.LowerBound(system.proxyBuffer, _
		    Physics.ParticleSystem.ComputeTag( _
		    System.InverseDiameter * aabbLowerBoundX, _
		    System.InverseDiameter * aabbLowerBoundY))
		    Var lastProxy As Integer = _
		    Physics.ParticleSystem.UpperBound(System.ProxyBuffer, _
		    Physics.ParticleSystem.ComputeTag( _
		    System.InverseDiameter * aabbUpperBoundX, _
		    System.InverseDiameter * aabbUpperBoundY))
		    
		    Var iLimit As Integer = lastProxy - 1
		    For i As Integer = firstProxy To iLimit
		      Var particle As Physics.Particle = System.ProxyBuffer(i).Particle
		      Var ap As VMaths.Vector2 = particle.Position
		      If aabbLowerBoundX <= ap.X And _
		        ap.X <= aabbUpperBoundX And _
		        aabbLowerBoundY <= ap.Y And _
		        ap.Y <= aabbUpperBoundY Then
		        // mTempNormal gets manipulated here.
		        Var distance As Double = fixture.ComputeDistance(ap, childIndex, mTempNormal)
		        If distance < Self.System.ParticleDiameter Then
		          Var invAm As Double = _
		          If((particle.Flags And Physics.ParticleType.WallParticle) <> 0, _
		          0.0, Self.System.ParticleInverseMass)
		          Var rpx as Double = ap.X - bp.X
		          Var rpy As Double = ap.Y - bp.Y
		          Var rpn As Double = rpx * mTempNormal.Y - rpy * mTempNormal.X
		          Var contact As New Physics.ParticleBodyContact(particle, b)
		          contact.Weight = 1 - distance * Self.System.InverseDiameter
		          contact.Normal.X = -mTempNormal.X
		          contact.Normal.Y = -mTempNormal.Y
		          contact.Mass = 1 / (invAm + invBm + invBI * rpn * rpn)
		          Self.System.bodyContactBuffer.Add(contact)
		        End If
		      End If
		    Next i
		  Next childIndex
		  
		  Return True
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		mTempNormal As VMaths.Vector2
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

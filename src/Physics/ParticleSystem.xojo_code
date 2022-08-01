#tag Class
Protected Class ParticleSystem
	#tag Method, Flags = &h0
		Shared Function ComputeRelativeTag(tag As Integer, x As Integer, y As Integer) As Integer
		  Return _
		  tag + Bitwise.ShiftLeft(y, YShift) + Bitwise.ShiftLeft(x, XShift)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ComputeTag(x As Double, y As Double) As Integer
		  Return (Bitwise.ShiftLeft(y + yOffset, yShift) + _
		  (xScale * x) + xOffset)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(world As Physics.World, pressureStrength As Double = 0.05, dampingStrength As Double = 1, elasticStrength As Double = 0.25, springStrength As Double = 0.25, viscousStrength As Double = 0.25, surfaceTensionStrengthAs As Double = 0.1, surfaceTensionStrengthB As Double = 0.2, powderStrength As Double = 0.5, ejectionStrength As Double = 0.5, colorMixingStrength As Double = 0.5)
		  Self.World = world
		  Self.PressureStrength = pressureStrength
		  Self.DampingStrength = dampingStrength
		  Self.ElasticStrength = elasticStrength
		  Self.SpringStrength = springStrength
		  Self.ViscousStrength = viscousStrength
		  Self.SurfaceTensionStrengthA = SurfaceTensionStrengthA
		  Self.SurfaceTensionStrengthB = SurfaceTensionStrengthB
		  Self.PowderStrength = powderStrength
		  Self.EjectionStrength = ejectionStrength
		  Self.ColorMixingStrength = colorMixingStrength
		  
		  mTemp = New Physics.AABB
		  mTemp2 = New Physics.AABB
		  mTempVec = VMaths.Vector2.Zero
		  mTempTransform = Physics.Transform.Zero
		  mTempTransform2 = Physics.Transform.Zero
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateParticle(particle As Physics.Particle)
		  particle.Group.Add(particle)
		  GroupBuffer.Add(particle.Group)
		  ProxyBuffer.Add(New Physics.PsProxy(particle))
		  mParticles.Add(particle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateParticleGroup(groupDef As Physics.ParticleGroupDef)
		  Var stride As Double = ParticleStride
		  mTempTransform.SetIdentity
		  Var identity As Physics.Transform = mTempTransform
		  mTempTransform2.SetIdentity
		  Var transform As Physics.Transform = mTempTransform2
		  
		  Var group As New Physics.ParticleGroup(Self)
		  group.GroupFlags = groupDef.GroupFlags
		  group.Strength = groupDef.Strength
		  group.UserData = groupDef.UserData
		  group.Transform.Set(transform)
		  group.DestroyAutomatically = groupDef.DestroyAutomatically
		  
		  If groupDef.Shape <> Nil Then
		    Var seedParticle As New Physics.Particle(Self, group)
		    seedParticle.Flags = groupDef.Flags
		    seedParticle.Colour = groupDef.Colour
		    seedParticle.UserData = groupDef.UserData
		    Var shape As Physics.Shape = groupDef.Shape
		    transform.SetVec2Angle(groupDef.Position, groupDef.Angle)
		    Var aabb As Physics.AABB = mTemp
		    Var childCount As Integer = shape.ChildCount
		    Var childIndexLimit As Integer = childCount - 1
		    For childIndex As Integer = 0 To childIndexLimit
		      If childIndex = 0 Then
		        shape.ComputeAABB(aabb, identity, childIndex)
		      Else
		        Var childAABB As Physics.AABB = mTemp2
		        shape.ComputeAABB(childAABB, identity, childIndex)
		        aabb.Combine(childAABB)
		      End If
		    Next childIndex
		    Var upperBoundY As Double = aabb.UpperBound.Y
		    Var upperBoundX As Double = aabb.UpperBound.X
		    Var yLimit As Integer = upperBoundY - 1
		    For y As Integer = Floor(aabb.LowerBound.Y / stride) * stride To yLimit Step stride
		      Var xLimit As Integer = upperBoundX - 1
		      For x As Integer = Floor(aabb.lowerBound.x / stride) * stride To xLimit Step stride
		        mTempVec.SetValues(x, y)
		        Var p As VMaths.Vector2 = mTempVec
		        If shape.TestPoint(identity, p) Then
		          p.SetFrom(Physics.Transform.MulVec2(transform, p))
		          Var particle As Physics.Particle = seedParticle.Clone
		          p.Subtract(groupDef.Position)
		          particle.Position.SetFrom(p)
		          p.ScaleOrthogonalInto(groupDef.AngularVelocity, particle.Velocity)
		          particle.Velocity.Add(groupDef.LinearVelocity)
		          CreateParticle(particle)
		        End If
		      Next x
		    Next y
		    groupBuffer.Add(group)
		  End If
		  
		  UpdateContacts(True)
		  If (groupDef.Flags And pairFlags) <> 0 Then
		    For Each contact As Physics.ParticleContact In ContactBuffer
		      Var particleA As Physics.Particle = contact.ParticleA
		      Var particleB As Physics.Particle = contact.ParticleB
		      If group.Particles.Contains(particleA) And _
		        group.Particles.Contains(particleB) Then
		        Var pair_ As New Physics.PsPair(particleA, particleB)
		        pair_.Flags = contact.Flags
		        pair_.Strength = groupDef.Strength
		        pair_.Distance = particleA.Position.DistanceTo(particleB.Position)
		        pairBuffer.Add(pair_)
		      End If
		    Next contact
		  End If
		  If (groupDef.Flags And triadFlags) <> 0 Then
		    Var diagram As New Physics.VoronoiDiagram
		    For Each particle As Physics.Particle In group.Particles
		      diagram.AddGenerator(particle.Position, particle)
		    Next particle
		    diagram.Generate(stride / 2)
		    Var cpgCallback As New Physics.CreateParticleGroupCallback(Self, groupDef)
		    diagram.Nodes(cpgCallback)
		  End If
		  If (groupDef.GroupFlags And Physics.ParticleGroupType.SolidParticleGroup) <> 0 Then
		    ComputeDepthForGroup(group)
		  End If
		  
		  Return group
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DestroyParticle(particle As Physics.Particle, callDestructionListener As Boolean)
		  Var flags As Integer = Physics.ParticleType.ZombieParticle
		  
		  If callDestructionListener Then
		    flags = flags Or Physics.ParticleType.DestroyListener
		  End If
		  
		  particle.Flags = particle.Flags Or flags
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DestroyParticlesInGroup(group As Physics.ParticleGroup, callDestructionListener As Boolean = False)
		  For Each p As Physics.Particle In group.Particles
		    DestroyParticle(p, callDestructionListener)
		  Next p
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657374726F79207061727469636C657320696E7369646520612073686170652E
		Sub DestroyParticlesInShape(shape As Physics.Shape, xf As Physics.Transform, callDestructionListener As Boolean = False)
		  /// Destroy particles inside a shape. 
		  ///
		  /// In addition, this function immediately
		  /// destroys particles in the shape in contrast to `DestroyParticle()` which
		  /// defers the destruction until the next simulation step.
		  
		  Var callback As New Physics.DestroyParticlesInShapeCallback( _
		  Self, shape, xf, callDestructionListener)
		  shape.ComputeAABB(mTemp, xf, 0)
		  Self.World.QueryAABBParticle(callback, mTemp)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub JoinParticleGroups(groupA As Physics.ParticleGroup, groupB As Physics.ParticleGroup)
		  #Pragma Error "TODO"
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AllGroupFlags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		AllParticleFlags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		BodyContactBuffer() As Physics.ParticleBodyContact
	#tag EndProperty

	#tag Property, Flags = &h0
		ColorMixingStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ContactBuffer() As Physics.ParticleContact
	#tag EndProperty

	#tag Property, Flags = &h0
		DampingStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		EjectionStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ElasticStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		GravityScale As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		GroupBuffer As Physics.ParticleGroupSet
	#tag EndProperty

	#tag Property, Flags = &h0
		InverseDiameter As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInverseDensity As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParticleDensity As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParticles() As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp2 As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempTransform As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempTransform2 As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempVec As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		PairBuffer() As Physics.PsPair
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Particles.Count
			End Get
		#tag EndGetter
		ParticleCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ParticleDiameter As Double = 1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return GroupBuffer.Count
			End Get
		#tag EndGetter
		ParticleGroupCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New UnmodifiableParticleArrayView(mParticles)
			  
			End Get
		#tag EndGetter
		Particles As Physics.UnmodifiableParticleArrayView
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		PowderStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		PressureStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyBuffer() As Physics.PsProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		SpringStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		SquaredDiameter As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		SurfaceTensionStrengthA As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		SurfaceTensionStrengthB As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		TimeStamp As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		TriadBuffer() As Physics.PsTriad
	#tag EndProperty

	#tag Property, Flags = &h0
		ViscousStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


	#tag Constant, Name = NoPressureFlags, Type = Double, Dynamic = False, Default = \"Physics.ParticleType.PowderParticle", Scope = Public, Description = 416C6C207061727469636C652074797065732074686174207265717569726520636F6D707574696E672064657074682E
	#tag EndConstant

	#tag Constant, Name = PairFlag, Type = Double, Dynamic = False, Default = \"Physics.ParticleType.SpringParticle", Scope = Public, Description = 416C6C207061727469636C6520747970657320746861742072657175697265206372656174696E672070616972732E
	#tag EndConstant

	#tag Constant, Name = TagBits, Type = Double, Dynamic = False, Default = \"31", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TriadFlags, Type = Double, Dynamic = False, Default = \"Physics.ParticleType.ElasticParticle", Scope = Public, Description = 416C6C207061727469636C6520747970657320746861742072657175697265206372656174696E67207472696164732E
	#tag EndConstant

	#tag Constant, Name = XMask, Type = Double, Dynamic = False, Default = \"4095", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XOffset, Type = Double, Dynamic = False, Default = \"262144", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XScale, Type = Double, Dynamic = False, Default = \"128", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XShift, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XTruncBits, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YMask, Type = Double, Dynamic = False, Default = \"4095", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YOffset, Type = Double, Dynamic = False, Default = \"2048", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YShift, Type = Double, Dynamic = False, Default = \"19", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YTruncBits, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant


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

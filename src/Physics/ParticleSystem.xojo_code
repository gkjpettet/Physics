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
		Sub DestroyParticle(particle As Physics.Particle, callDestructionListener As Boolean)
		  Var flags As Integer = Physics.ParticleType.ZombieParticle
		  
		  If callDestructionListener Then
		    flags = flags Or Physics.ParticleType.DestroyListener
		  End If
		  
		  particle.Flags = particle.Flags Or flags
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44657374726F79207061727469636C657320696E7369646520612073686170652E
		Private Sub DestroyParticlesInShape(shape As Physics.Shape, xf As Physics.Transform, callDestructionListener As Boolean = False)
		  /// Destroy particles inside a shape. 
		  ///
		  /// In addition, this function immediately
		  /// destroys particles in the shape in contrast to `DestroyParticle()` which
		  /// defers the destruction until the next simulation step.
		  
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

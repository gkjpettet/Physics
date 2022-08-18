#tag Class
Protected Class BodyDef
	#tag Method, Flags = &h0
		Sub Constructor(type As Physics.BodyType = Physics.BodyType.Static_, userData As Variant = Nil, position As VMaths.Vector2 = Nil, angle As Double = 0, linearVelocity As VMaths.Vector2 = Nil, angularVelocity As Double = 0, linearDamping As Double = 0, angularDamping As Double = 0, allowSleep As Boolean = True, isAwake As Boolean = True, fixedRotation As Boolean = False, bullet As Boolean = False, active As Boolean = True, gravityOverride As VMaths.Vector2 = Nil, gravityScale As VMaths.Vector2 = Nil)
		  Self.Type = type
		  Self.UserData = userData
		  Self.Angle = angle
		  Self.AngularVelocity = angularVelocity
		  Self.LinearDamping = linearDamping
		  Self.AngularDamping = angularDamping
		  Self.AllowSleep = allowSleep
		  Self.IsAwake = isAwake
		  Self.FixedRotation = fixedRotation
		  Self.Bullet = bullet
		  Self.Active = active
		  Self.GravityOverride = gravityOverride
		  Self.GravityScale = gravityScale
		  Self.Position = If(position = Nil, VMaths.Vector2.Zero, position)
		  Self.LinearVelocity = If(linearVelocity = Nil, VMaths.Vector2.Zero, linearVelocity)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		 data needed to construct a body.
		
		You can safely re-use body definitions.
		
		Shapes are added through Fixtures to a Body after construction via `Body.CreateFixture()`.
		Holds all the
	#tag EndNote


	#tag Property, Flags = &h0, Description = 446F6573207468697320626F6479207374617274206F7574206163746976653F
		Active As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 536574207468697320666C616720746F2066616C7365206966207468697320626F64792073686F756C64206E657665722066616C6C2061736C6565702E204E6F74653A204E6F7420616C6C6C6F77696E67206120626F647920746F20736C65657020696E63726561736573204350552075736167652E
		AllowSleep As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520776F726C6420616E676C65206F662074686520626F647920696E2072616469616E732E
		Angle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 416E67756C61722064616D70696E672069732075736520746F207265647563652074686520616E67756C61722076656C6F636974792E205468652064616D70696E6720706172616D657465722063616E206265203E203120627574207468652064616D70696E6720656666656374206265636F6D65732073656E73697469766520746F207468652074696D652073746570207768656E207468652064616D70696E6720706172616D65746572206973206C617267652E
		AngularDamping As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520616E67756C61722076656C6F63697479206F662074686520626F64792E
		AngularVelocity As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4973207468697320612066617374206D6F76696E6720626F647920746861742073686F756C642062652070726576656E7465642066726F6D2074756E6E656C696E67207468726F756768206F74686572206D6F76696E6720626F646965733F205761726E696E673A20596F752073686F756C6420757365207468697320666C61672073706172696E676C792073696E636520697420696E637265617365732070726F63657373696E672074696D652E
		#tag Note
			Is this a fast moving body that should be prevented from tunneling through
			other moving bodies?
			
			Note: All bodies are prevented from tunneling through `BodyType.kinematic`
			and `BodyType.static` bodies. This setting is only considered on
			`BodyType.dynamic` bodies.
			
			Warning: You should use this flag sparingly since it increases processing time.
		#tag EndNote
		Bullet As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 53686F756C64207468697320626F64792062652070726576656E7465642066726F6D20726F746174696E673F2055736566756C20666F7220636861726163746572732E
		FixedRotation As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4368616E67657320686F772074686520776F726C642074726561747320746865206772617669747920666F72207468697320626F64792E
		#tag Note
			Changes how the world treats the gravity for this body.
			
			Specifying a `GravityOverride overrides the world's gravity. For example,
			if `World.Gravity` is (0, -10), and a body has a `GravityOverride of
			(0, 0) the body will behave as if the world does not have a gravity.
			
			If you wish to modify the gravity relative to the world, use
			`World.Gravity` as part of the calculation. However, if you only wish to
			scale it, use `GravityScale` instead.
		#tag EndNote
		GravityOverride As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D756C7469706C69657220666F722074686520626F6479277320677261766974792E2049662060477261766974794F7665727269646560206973207370656369666965642C20746869732076616C756520616C736F20616666656374732069742E
		GravityScale As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4973207468697320626F647920696E697469616C6C7920736C656570696E673F
		IsAwake As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4C696E6561722064616D70696E672069732075736520746F2072656475636520746865206C696E6561722076656C6F636974792E205468652064616D70696E6720706172616D657465722063616E206265203E203120627574207468652064616D70696E6720656666656374206265636F6D65732073656E73697469766520746F207468652074696D652073746570207768656E207468652064616D70696E6720706172616D65746572206973206C617267652E
		LinearDamping As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E6561722076656C6F63697479206F662074686520626F647920696E20776F726C6420636F6F7264696E617465732E
		LinearVelocity As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520776F726C6420706F736974696F6E206F662074686520626F64792E2041766F6964206372656174696E6720626F6469657320617420746865206F726967696E2073696E636520746869732063616E206C65616420746F206D616E79206F7665726C617070696E67207368617065732E
		Position As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5374617469632C206B696E656D617469632C206F722064796E616D69632E204E6F74653A20412060426F6479547970652E44796E616D69636020626F64792077697468207A65726F206D6173732C2077696C6C20686176652061206D617373206F66206F6E652E
		Type As Physics.BodyType = Physics.BodyType.Static_
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557365207468697320746F2073746F7265206170706C69636174696F6E20737065636966696320626F647920646174612E
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
			Name="Active"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSleep"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Angle"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AngularDamping"
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
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bullet"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FixedRotation"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsAwake"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LinearDamping"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

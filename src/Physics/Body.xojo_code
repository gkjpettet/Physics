#tag Class
Protected Class Body
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Transform = Physics.Transform.Zero
		  Self.PreviousTransform = Physics.Transform.Zero
		  Self.Sweep = New Physics.Sweep
		  Self.LinearVelocity = VMaths.Vector2.Zero
		  Self.Force = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(bd As Physics.BodyDef, world As Physics.World)
		  #If DebugBuild
		    Assert(Not bd.Position.IsInfinite And Not bd.Position.IsNotANumber)
		    Assert(Not bd.LinearVelocity.IsInfinite And Not bd.LinearVelocity.IsNotANumber)
		    Assert(bd.AngularDamping >= 0.0)
		    Assert(bd.LinearDamping >= 0.0)
		  #EndIf
		  
		  Constructor
		  
		  Self.World = world
		  
		  flags = 0
		  
		  If bd.Bullet Then flags = flags Or BulletFlag
		  If bd.FixedRotation Then flags = flags Or FixedRotationFlag
		  If bd.AllowSleep Then flags = flags Or AutoSleepFlag
		  If bd.IsAwake Then flags = flags Or AwakeFlag
		  If bd.Active Then flags = flags Or ActiveFlag
		  
		  Self.Transform.P.SetFrom(bd.Position)
		  Self.Transform.Q.SetAngle(bd.Angle)
		  
		  Self.Sweep.LocalCenter.SetZero
		  Self.Sweep.C0.SetFrom(Self.Transform.P)
		  Self.Sweep.C.SetFrom(Self.Transform.P)
		  Self.Sweep.A0 = bd.Angle
		  Self.Sweep.A = bd.Angle
		  Self.Sweep.Alpha0 = 0.0
		  
		  LinearVelocity.SetFrom(bd.LinearVelocity)
		  mAngularVelocity = bd.AngularVelocity
		  
		  LinearDamping = bd.LinearDamping
		  AngularDamping = bd.AngularDamping
		  GravityOverride = bd.GravityOverride
		  GravityScale = bd.GravityScale
		  
		  Force.SetZero
		  
		  SleepTime = 0.0
		  
		  mBodyType = bd.Type
		  
		  If mBodyType = Physics.BodyType.Dynamic Then
		    mMass = 1.0
		    mInverseMass = 1.0
		  Else
		    mMass = 0.0
		    mInverseMass = 0.0
		  End If
		  
		  Inertia = 0.0
		  InverseInertia = 0.0
		  
		  UserData = bd.UserData
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A rigid body. These are created via `World.CreateBody()`.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 416E67756C61722064616D70696E672069732075736520746F207265647563652074686520616E67756C61722076656C6F636974792E205468652064616D70696E6720706172616D657465722063616E206265203E203120627574207468652064616D70696E6720656666656374206265636F6D65732073656E73697469766520746F207468652074696D652073746570207768656E207468652064616D70696E6720706172616D65746572206973206C617267652E
		AngularDamping As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520616E67756C61722076656C6F6369747920696E2072616469616E732F7365636F6E642E
		#tag Getter
			Get
			  Return mAngularVelocity
			  
			End Get
		#tag EndGetter
		AngularVelocity As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5374617469632C206B696E656D617469632C206F722064796E616D69632E204E6F74653A20412060426F6479547970652E44796E616D69636020626F64792077697468207A65726F206D6173732C2077696C6C20686176652061206D617373206F66206F6E652E
		#tag Getter
			Get
			  Return mBodyType
			  
			End Get
		#tag EndGetter
		BodyType As Physics.BodyType
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Contacts() As Physics.Contact
	#tag EndProperty

	#tag Property, Flags = &h0
		Fixtures() As Physics.Fixture
	#tag EndProperty

	#tag Property, Flags = &h0
		Flags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 446F206E6F74206D6F64696679206469726563746C792E
		Force As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4368616E67657320686F772074686520776F726C642074726561747320746865206772617669747920666F72207468697320626F64792E
		GravityOverride As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D756C7469706C69657220666F722074686520626F6479277320677261766974792E2049662060477261766974794F7665727269646560206973207370656369666965642C20746869732076616C756520616C736F20616666656374732069742E
		GravityScale As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526F746174696F6E616C20696E65727469612061626F7574207468652063656E747265206F66206D6173732E
		Inertia As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526F746174696F6E616C20696E65727469612061626F7574207468652063656E747265206F66206D6173732E
		InverseInertia As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mInverseMass
			  
			End Get
		#tag EndGetter
		InverseMass As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		IslandIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Joints() As Physics.Joint
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4C696E6561722064616D70696E672069732075736520746F2072656475636520746865206C696E6561722076656C6F636974792E205468652064616D70696E6720706172616D657465722063616E206265203E203120627574207468652064616D70696E6720656666656374206265636F6D65732073656E73697469766520746F207468652074696D652073746570207768656E207468652064616D70696E6720706172616D65746572206973206C617267652E
		LinearDamping As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E6561722076656C6F63697479206F66207468652063656E747265206F66206D6173732E20446F206E6F74206D6F64696679206469726563746C792C20696E73746561642075736520604170706C794C696E656172496D70756C736560206F7220604170706C79466F726365602E
		LinearVelocity As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520616E67756C61722076656C6F6369747920696E2072616469616E732F7365636F6E642E
		mAngularVelocity As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBodyType As Physics.BodyType = Physics.BodyType.Static_
	#tag EndProperty

	#tag Property, Flags = &h0
		mInverseMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		mMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 446F206E6F74206D6F64696679206469726563746C792E
		mTorque As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652070726576696F7573207472616E73666F726D20666F72207061727469636C652073696D756C6174696F6E2E
		PreviousTransform As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		SleepTime As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207377657074206D6F74696F6E20666F72204343442E
		Sweep As Physics.Sweep
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mTorque
			  
			End Get
		#tag EndGetter
		Torque As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520626F6479206F726967696E207472616E73666F726D2E
		Transform As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557365207468697320746F2073746F726520796F7572206170706C69636174696F6E20737065636966696320646174612E
		UserData As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


	#tag Constant, Name = ActiveFlag, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AutoSleepFlag, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AwakeFlag, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BulletFlag, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FixedRotationFlag, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IslandFlag, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TOIFlag, Type = Double, Dynamic = False, Default = \"&h0040", Scope = Public
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

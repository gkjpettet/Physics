#tag Class
Protected Class PrismaticJointDef
Inherits Physics.JointDef
	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  LocalAxisA = New VMaths.Vector2(1.0, 0.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E697469616C697365732074686520626F646965732C20616E63686F72732C20617869732C20616E64207265666572656E636520616E676C65207573696E672074686520776F726C6420616E63686F7220616E6420776F726C6420617869732E
		Sub Initialize(b1 As Physics.Body, b2 As Physics.Body, anchor As VMaths.Vector2, axis As VMaths.Vector2)
		  /// Initialises the bodies, anchors, axis, and reference angle using the world
		  /// anchor and world axis.
		  
		  BodyA = b1
		  BodyB = b2
		  LocalAnchorA.SetFrom(BodyA.LocalPoint(anchor))
		  LocalAnchorB.SetFrom(BodyB.LocalPoint(anchor))
		  LocalAxisA.SetFrom(BodyA.LocalVector(axis))
		  ReferenceAngle = BodyB.Angle - BodyA.Angle
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Prismatic joint definition.
		
		This requires defining a line of motion using an
		axis and an anchor point. The definition uses local anchor points and a
		local axis so that the initial configuration can violate the constraint
		slightly. The joint translation is zero when the local anchor points
		coincide in world space. Using local anchors and a local axis helps when
		saving and loading a game.
		
		Warning: at least one body should by dynamic with a non-fixed rotation.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 456E61626C652F64697361626C6520746865206A6F696E74206C696D69742E
		EnableLimit As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 456E61626C652F64697361626C6520746865206A6F696E74206D6F746F722E
		EnableMotor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F63616C207472616E736C6174696F6E206178697320696E2060426F647941602E
		LocalAxisA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F776572207472616E736C6174696F6E206C696D69742C20757375616C6C7920696E206D65747265732E
		LowerTranslation As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D6178696D756D206D6F746F7220746F727175652C20757375616C6C7920696E204E2D6D2E
		MaxMotorForce As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652064657369726564206D6F746F7220737065656420696E2072616469616E7320706572207365636F6E642E
		MotorSpeed As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6E73747261696E656420616E676C65206265747765656E2074686520626F646965733A2060426F6479322E416E676C65202D20426F6479312E416E676C65602E
		ReferenceAngle As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207570706572207472616E736C6174696F6E206C696D69742C20757375616C6C7920696E206D65747265732E
		UpperTranslation As Double = 0.0
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
			Name="CollideConnected"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReferenceAngle"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableLimit"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LowerTranslation"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UpperTranslation"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableMotor"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxMotorForce"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MotorSpeed"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

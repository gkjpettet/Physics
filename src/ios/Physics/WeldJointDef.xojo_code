#tag Class
Protected Class WeldJointDef
Inherits Physics.JointDef
	#tag Method, Flags = &h0, Description = 496E697469616C6973652074686520626F646965732C20616E63686F72732C20616E64207265666572656E636520616E676C65207573696E67206120776F726C6420616E63686F7220706F696E742E
		Sub Initialize(bodyA As Physics.Body, bodyB As Physics.Body, anchor As VMaths.Vector2)
		  /// Initialise the bodies, anchors, and reference angle using a world anchor point.
		  
		  Self.BodyA = bodyA
		  Self.BodyB = bodyB
		  LocalAnchorA.SetFrom(bodyA.LocalPoint(anchor))
		  LocalAnchorB.SetFrom(bodyB.LocalPoint(anchor))
		  Self.ReferenceAngle = bodyB.Angle - bodyA.Angle
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652064616D70696E6720726174696F2E2030203D206E6F2064616D70696E672C2031203D20637269746963616C2064616D70696E672E
		DampingRatio As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D6173732D737072696E672D64616D706572206672657175656E637920696E20486572747A2E20526F746174696F6E206F6E6C792E2044697361626C6520736F66746E657373207769746820612076616C7565206F6620302E
		FrequencyHz As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652060626F6479326020616E676C65206D696E75732060626F6479316020616E676C6520696E20746865207265666572656E6365207374617465202872616469616E73292E
		ReferenceAngle As Double = 0.0
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
			Name="ReferenceAngle"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FrequencyHz"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DampingRatio"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

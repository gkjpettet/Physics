#tag Class
Protected Class RevoluteJointDef
Inherits Physics.JointDef
	#tag Method, Flags = &h0
		Sub Initialize(body1 As Physics.Body, body2 As Physics.Body, anchor As VMaths.Vector2)
		  BodyA = body1
		  BodyB = body2
		  LocalAnchorA.SetFrom(BodyA.LocalPoint(anchor))
		  LocalAnchorB.SetFrom(BodyB.LocalPoint(anchor))
		  ReferenceAngle = BodyB.Angle - BodyA.Angle
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This requires defining an anchor point where the
		bodies are joined. The definition uses local anchor points so that the
		initial configuration can violate the constraint slightly.
		
		You also need to specify the initial relative angle for joint limits. This
		helps when saving and loading a game. 
		
		The local anchor points are measured from the body's origin rather than 
		the centre of mass because:
		 - You might not know where the center of mass will be.
		 - If you add/remove shapes from a body and recompute the mass, the joints will be broken.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 4120666C616720746F20656E61626C65206A6F696E74206C696D6974732E
		EnableLimit As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4120666C616720746F20656E61626C6520746865206A6F696E74206D6F746F722E
		EnableMotor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F77657220616E676C6520666F7220746865206A6F696E74206C696D6974202872616469616E73292E
		LowerAngle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D6178696D756D206D6F746F7220746F72717565207573656420746F2061636869657665207468652064657369726564206D6F746F722073706565642E20557375616C6C7920696E204E2D6D2E
		MaxMotorTorque As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652064657369726564206D6F746F722073706565642E20557375616C6C7920696E2072616469616E7320706572207365636F6E642E
		MotorSpeed As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F64793220616E676C65206D696E757320626F64793120616E676C6520696E20746865207265666572656E6365207374617465202872616469616E73292E
		ReferenceAngle As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520757070657220616E676C6520666F7220746865206A6F696E74206C696D6974202872616469616E73292E
		UpperAngle As Double = 0
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

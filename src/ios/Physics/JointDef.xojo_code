#tag Class
 Attributes ( Abstract ) Protected Class JointDef
	#tag Method, Flags = &h0
		Sub Constructor(collideConnected As Boolean = False)
		  Self.CollideConnected = collideConnected
		  
		  LocalAnchorA = VMaths.Vector2.Zero
		  LocalAnchorB = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		`JointDef`s are used to construct `Joint`s.
		
		All `Joint`s are connected between two different `Body`ies.
		One `Body` may be `BodyType.Static_`.
		
		`Joint`s between `BodyType.Static_` and/or BodyType.Kinematic` are allowed,
		but have no effect and use some processing time.
		
		Don't subclass `JointDef`. Instead, extend from an already defined `JointDef` subclass.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520666972737420617474616368656420626F64792E
		BodyA As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207365636F6E6420617474616368656420626F64792E
		BodyB As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 536574207468697320666C616720746F20547275652069662074686520617474616368656420626F646965732073686F756C6420636F6C6C6964652E
		CollideConnected As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F63616C20616E63686F7220706F696E742072656C617469766520746F20626F6479412773206F726967696E2E
		LocalAnchorA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F63616C20616E63686F7220706F696E742072656C617469766520746F20626F6479422773206F726967696E2E
		LocalAnchorB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557365207468697320746F20617474616368206170706C69636174696F6E207370656369666963206461746120746F20796F7572206A6F696E74732E
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
			Name="CollideConnected"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

#tag Class
Protected Class RopeJointDef
Inherits Physics.JointDef
	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  LocalAnchorA.SetValues(-1.0, 0.0)
		  LocalAnchorB.SetValues(1.0, 0.0)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Rope joint definition. This requires two body anchor points and a maximum lengths.
		
		Note: by default the connected objects will not collide. See `JointDef.CollideConnected`.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546865206D6178696D756D206C656E677468206F662074686520726F70652E205761726E696E673A2074686973206D757374206265206C6172676572207468616E20604C696E656172536C6F7060206F7220746865206A6F696E742077696C6C2068617665206E6F206566666563742E
		maxLength As Double = 0
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

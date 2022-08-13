#tag Class
Protected Class DistanceJointDef
Inherits Physics.JointDef
	#tag Method, Flags = &h0
		Sub Initialize(body1 As Physics.Body, body2 As Physics.Body, anchor1 As VMaths.Vector2, anchor2 As VMaths.Vector2)
		  BodyA = body1
		  BodyB = body2
		  LocalAnchorA.SetFrom(BodyA.LocalPoint(anchor1))
		  LocalAnchorB.SetFrom(BodyB.LocalPoint(anchor2))
		  Var d As VMaths.Vector2 = anchor2 - anchor1
		  length = d.Length
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Distance joint definition.
		
		This requires defining an anchor point on both
		bodies and the non-zero length of the distance joint. The definition uses
		local anchor points so that the initial configuration can violate the
		constraint slightly. This helps when saving and loading a game.
		
		Warning: Do not use a zero or short length.
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5468652064616D70696E6720726174696F2E2030203D206E6F2064616D70696E672C2031203D20637269746963616C2064616D70696E672E
		DampingRatio As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D6173732D737072696E672D64616D706572206672657175656E637920696E20486572747A2E
		FrequencyHz As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520657175696C69627269756D206C656E677468206265747765656E2074686520616E63686F7220706F696E74732E
		Length As Double = 1.0
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
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

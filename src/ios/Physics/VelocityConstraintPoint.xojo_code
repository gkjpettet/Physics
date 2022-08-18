#tag Class
Protected Class VelocityConstraintPoint
	#tag Method, Flags = &h0
		Sub Constructor()
		  RA = VMaths.Vector2.Zero
		  RB = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		NormalImpulse As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		NormalMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		RA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		RB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		TangentImpulse As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		TangentMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		VelocityBias As Double = 0
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
			Name="NormalImpulse"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NormalMass"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TangentImpulse"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TangentMass"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="VelocityBias"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

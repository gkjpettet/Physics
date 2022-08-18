#tag Class
Protected Class TimeStep
	#tag Note, Name = About
		This is an internal structure.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54696D6520737465702E
		Dt As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4474202A204976447430
		DtRatio As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520696E76657273652074696D652073746570202830206966204474203D2030292E
		InvDt As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0
		PositionIterations As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		VelocityIterations As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		WarmStarting As Boolean = False
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
			Name="Dt"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

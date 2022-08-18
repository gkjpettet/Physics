#tag Class
Protected Class DistanceInput
	#tag Method, Flags = &h0
		Sub Constructor()
		  ProxyA = New Physics.DistanceProxy
		  ProxyB = New Physics.DistanceProxy
		  TransformA = Physics.Transform.Zero
		  TransformB = Physics.Transform.Zero
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Input for Distance.
		You have to option to use the shape radii in the computation.
		
	#tag EndNote


	#tag Property, Flags = &h0
		ProxyA As Physics.DistanceProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyB As Physics.DistanceProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		TransformA As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		TransformB As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		UseRadii As Boolean = False
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
			Name="UseRadii"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

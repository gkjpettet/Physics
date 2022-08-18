#tag Class
Protected Class RaycastInput
	#tag Method, Flags = &h0
		Sub Constructor()
		  P1 = VMaths.Vector2.Zero
		  P2 = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(rci As Physics.RaycastInput)
		  P1.SetFrom(rci.P1)
		  P2.SetFrom(rci.P2)
		  MaxFraction = rci.MaxFraction
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		MaxFraction As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0
		P1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		P2 As VMaths.Vector2
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
			Name="MaxFraction"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

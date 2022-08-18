#tag Class
Protected Class RaycastResult
	#tag Method, Flags = &h0
		Sub Constructor()
		  mNormal = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Set(argOther As Physics.RaycastResult) As Physics.RaycastResult
		  Lambda = argOther.Lambda
		  mNormal.SetFrom(argOther.Normal)
		  Return Self
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Lambda As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNormal As VMaths.Vector2
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mNormal
			End Get
		#tag EndGetter
		Normal As VMaths.Vector2
	#tag EndComputedProperty


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
			Name="Lambda"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

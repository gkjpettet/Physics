#tag Class
Protected Class DynamicTreeNode
	#tag Method, Flags = &h0
		Sub Constructor(id As Integer)
		  Self.ID = id
		  AABB = New Physics.AABB
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AABB As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h0
		Child1 As Physics.DynamicTreeNode
	#tag EndProperty

	#tag Property, Flags = &h0
		Child2 As Physics.DynamicTreeNode
	#tag EndProperty

	#tag Property, Flags = &h0
		Height As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Parent As Physics.DynamicTreeNode
	#tag EndProperty

	#tag Property, Flags = &h0
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
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

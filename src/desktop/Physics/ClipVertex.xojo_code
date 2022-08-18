#tag Class
Protected Class ClipVertex
	#tag Method, Flags = &h0
		Sub Constructor()
		  V = VMaths.Vector2.Zero
		  ID = New Physics.ContactID
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(cv As Physics.ClipVertex)
		  Var v1 As VMaths.Vector2 = cv.V
		  v.X = v1.X
		  v.Y = v1.Y
		  Var c As Physics.ContactID = cv.ID
		  id.IndexA = c.IndexA
		  id.IndexB = c.IndexB
		  id.TypeA = c.TypeA
		  id.TypeB = c.TypeB
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ID As Physics.ContactID
	#tag EndProperty

	#tag Property, Flags = &h0
		V As VMaths.Vector2
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
			Name="V"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

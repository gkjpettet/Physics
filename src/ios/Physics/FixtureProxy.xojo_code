#tag Class
Protected Class FixtureProxy
	#tag Method, Flags = &h0
		Sub Constructor(fixture As Physics.Fixture)
		  Self.AABB = New Physics.AABB
		  Self.Fixture = fixture
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		
		d-phase.
	#tag EndNote


	#tag Property, Flags = &h0
		AABB As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h0
		ChildIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Fixture As Physics.Fixture
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyId As Integer = 0
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
			Name="ChildIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProxyId"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

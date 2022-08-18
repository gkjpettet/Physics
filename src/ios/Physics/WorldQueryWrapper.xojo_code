#tag Class
Protected Class WorldQueryWrapper
Implements Physics.TreeCallback
	#tag Method, Flags = &h0
		Function TreeCallback(nodeID As Integer) As Boolean
		  // Part of the Physics.TreeCallback interface.
		  
		  Var userData As Variant = Broadphase.GetUserData(nodeID)
		  If userData = Nil Then
		    Return False
		  End If
		  
		  Var proxy As Physics.FixtureProxy = Physics.FixtureProxy(userData)
		  
		  If callback <> Nil Then
		    Return Callback.ReportFixture(proxy.Fixture)
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Broadphase As Physics.Broadphase
	#tag EndProperty

	#tag Property, Flags = &h0
		Callback As Physics.QueryCallback
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
	#tag EndViewBehavior
End Class
#tag EndClass

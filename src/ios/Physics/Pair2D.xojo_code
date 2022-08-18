#tag Class
Protected Class Pair2D
	#tag Method, Flags = &h0
		Function CompareTo(pair2 As Physics.Pair2D) As Integer
		  If proxyIdA < pair2.proxyIdA Then
		    Return -1
		  End If
		  
		  If proxyIdA = pair2.ProxyIdA Then
		    
		    If ProxyIdB > pair2.ProxyIdB Then
		      Return 1
		    ElseIf ProxyIdB < pair2.ProxyIdB Then
		      Return -1
		    Else
		      Return 0
		    End If
		  End If
		  
		  Return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(proxyIdA As Integer, proxyIdB As Integer)
		  Self.ProxyIdA = proxyIdA
		  Self.ProxyIdB = proxyIdB
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Notes
		Renamed from Pair to Pair2D to avoid name conflict with Xojo's native Pair type.
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		ProxyIdA As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyIdB As Integer
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
			Name="ProxyIdA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ProxyIdB"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

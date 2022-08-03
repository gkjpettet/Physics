#tag Class
Protected Class Pair2DSet
	#tag Method, Flags = &h0, Description = 4164647320607032646020746F20746865207365742E2052657475726E732060547275656020696620607032646020776173206E6F742079657420696E20746865207365742E204F74686572776973652072657475726E73206046616C73656020616E642074686520736574206973206E6F74206368616E6765642E
		Function Add(p2d As Physics.Pair2D) As Boolean
		  /// Adds `p2d` to the set. Returns `True` if `p2d` was not yet in the set. 
		  /// Otherwise returns `False` and the set is not changed.
		  
		  If mPairs.IndexOf(p2d) = -1 Then
		    // Not in the set
		    mPairs.Add(p2d)
		    Return True
		  Else
		    // Already in the set.
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  mPairs.ResizeTo(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520656C656D656E742061742060696E646578602E
		Function ElementAt(index As Integer) As Physics.Pair2D
		  /// Returns the element at `index`.
		  
		  Return mPairs(index)
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPairs.LastIndex
			  
			End Get
		#tag EndGetter
		LastIndex As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mPairs() As Physics.Pair2D
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
			Name="mPairs()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

#tag Class
Protected Class ContactID
	#tag Method, Flags = &h0
		Function CompareTo(o As Physics.ContactID) As Integer
		  Return GetKey - o.GetKey
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Copy(c As Physics.ContactID) As Physics.ContactID
		  Var result As New Physics.ContactID
		  result.Set(c)
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flip()
		  Var tempA As Integer = IndexA
		  IndexA = IndexB
		  IndexB = tempA
		  tempA = TypeA
		  TypeA = TypeB
		  TypeB = tempA
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetKey() As Integer
		  Return Bitwise.ShiftLeft(IndexA, 24) Or _
		  Bitwise.ShiftLeft(IndexB, 16) Or _
		  Bitwise.ShiftLeft(typeA, 8) Or typeB
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEqual(cid As Physics.ContactID) As Boolean
		  Return GetKey = cid.GetKey
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(c As Physics.ContactID)
		  IndexA = c.IndexA
		  IndexB = c.IndexB
		  TypeA = c.TypeA
		  TypeB = c.TypeB
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5A65726F6573206F75742074686520646174612E
		Sub Zero()
		  /// Zeroes out the data.
		  
		  IndexA = 0
		  IndexB = 0
		  TypeA = 0
		  TypeB = 0
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mData(0)
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mData(0) = value
			  
			End Set
		#tag EndSetter
		IndexA As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mData(1)
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mData(1) = value
			  
			End Set
		#tag EndSetter
		IndexB As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		mData(3) As Int8
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mData(2)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mData(2) = value
			End Set
		#tag EndSetter
		TypeA As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mData(3)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mData(3) = value
			End Set
		#tag EndSetter
		TypeB As Integer
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
			Name="IndexA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IndexB"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TypeA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TypeB"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

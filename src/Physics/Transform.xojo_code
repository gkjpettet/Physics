#tag Class
Protected Class Transform
	#tag Method, Flags = &h0, Description = 5468652064656661756C7420636F6E7374727563746F722E
		Shared Function Zero() As Physics.Transform
		  /// The default constructor.
		  
		  Var t As New Physics.Transform
		  t.mP = VMaths.Vector2.Zero
		  t.mQ = New Physics.Rot
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A transform contains translation and rotation. It is used to represent the
		position and orientation of rigid frames.
		
	#tag EndNote


	#tag Property, Flags = &h1, Description = 546865207472616E736C6174696F6E2063617573656420627920746865207472616E73666F726D
		Protected mP As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 41206D617472697820726570726573656E74696E67206120726F746174696F6E2E
		Protected mQ As Physics.Rot
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207472616E736C6174696F6E2063617573656420627920746865207472616E73666F726D
		#tag Getter
			Get
			  Return mP
			End Get
		#tag EndGetter
		P As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 41206D617472697820726570726573656E74696E67206120726F746174696F6E2E
		#tag Getter
			Get
			  Return mQ
			End Get
		#tag EndGetter
		Q As Physics.Rot
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
			Name="mP"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

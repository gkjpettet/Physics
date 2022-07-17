#tag Class
Protected Class FixtureDef
	#tag Method, Flags = &h0
		Sub Constructor(shape As Physics.Shape, userData As Variant = Nil, friction As Double = 0, restitution As Double = 0, density As Double = 0, isSensor As Boolean = False, filter As Physics.Filter = Nil)
		  Self.Shape = shape
		  Self.UserData = userData
		  Self.Friction = friction
		  Self.Restitution = restitution
		  Self.Density = density
		  Self.IsSensor = isSensor
		  Self.Filter = If(filter = Nil, New Physics.Filter, filter)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Fixture definitions are used to create a fixture.
		
		You can reuse them safely.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5468652064656E736974792C20757375616C6C7920696E206B672F6D5E322E
		Density As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436F6E746163742066696C746572696E6720646174612E
		Filter As Physics.Filter
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206672696374696F6E20636F656666696369656E742C20757375616C6C7920696E207468652072616E6765205B302C315D2E
		Friction As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 412073656E736F7220736861706520636F6C6C6563747320636F6E7461637420696E666F726D6174696F6E20627574206E657665722067656E657261746573206120636F6C6C6973696F6E20726573706F6E73652E
		IsSensor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207265737469747574696F6E2028656C61737469636974792920757375616C6C7920696E207468652072616E6765205B302C315D2E
		Restitution As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520605368617065602E2054686973206D757374206265207365742E
		Shape As Physics.Shape
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557365207468697320746F2073746F7265206170706C69636174696F6E207370656369666963206669787475726520646174612E
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
			Name="Shape"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

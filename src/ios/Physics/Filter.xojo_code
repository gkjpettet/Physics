#tag Class
Protected Class Filter
	#tag Method, Flags = &h0
		Sub Set(argOther As Physics.Filter)
		  CategoryBits = argOther.CategoryBits
		  MaskBits = argOther.MaskBits
		  GroupIndex = argOther.GroupIndex
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Holds contact filtering data.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520636F6C6C6973696F6E2063617465676F727920626974732E204E6F726D616C6C7920796F7520776F756C64206A75737420736574206F6E65206269742E
		CategoryBits As Integer = &h0001
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436F6C6C6973696F6E2067726F75707320616C6C6F772061206365727461696E2067726F7570206F66206F626A6563747320746F206E6576657220636F6C6C69646520286E6567617469766529206F7220616C7761797320636F6C6C6964652028706F736974697665292E205A65726F206D65616E73206E6F20636F6C6C6973696F6E2067726F75702E204E6F6E2D7A65726F2067726F75702066696C746572696E6720616C776179732077696E7320616761696E737420746865206D61736B20626974732E
		GroupIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6C6973696F6E206D61736B20626974732E205468697320737461746573207468652063617465676F726965732074686174207468697320736861706520776F756C642061636365707420666F7220636F6C6C6973696F6E2E
		MaskBits As Integer = &hFFFF
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
			Name="CategoryBits"
			Visible=false
			Group="Behavior"
			InitialValue="&h0001"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GroupIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaskBits"
			Visible=false
			Group="Behavior"
			InitialValue="&hFFFF"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

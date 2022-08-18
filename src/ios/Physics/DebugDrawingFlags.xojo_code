#tag Class
Protected Class DebugDrawingFlags
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // This class should not be instantiated.
		End Sub
	#tag EndMethod


	#tag Constant, Name = AABBBit, Type = Double, Dynamic = False, Default = \"8", Scope = Public, Description = 44726177206178697320616C69676E656420626F756E64696E6720626F7865732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = CenterOfMassBit, Type = Double, Dynamic = False, Default = \"32", Scope = Public, Description = 44726177207468652063656E747265206F66206D617373206F6620626F646965732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DynamicTreeBit, Type = Double, Dynamic = False, Default = \"64", Scope = Public, Description = 447261772064796E616D696320747265652E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = JointBit, Type = Double, Dynamic = False, Default = \"4", Scope = Public, Description = 44726177206A6F696E7420636F6E6E656374696F6E732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = PairBit, Type = Double, Dynamic = False, Default = \"16", Scope = Public, Description = 44726177207061697273206F6620636F6E6E6563746564206F626A656374732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = ShapeBit, Type = Double, Dynamic = False, Default = \"2", Scope = Public, Description = 44726177207368617065732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = WireFrameDrawingBit, Type = Double, Dynamic = False, Default = \"128", Scope = Public, Description = 44726177206F6E6C792074686520776972656672616D6520666F722064726177696E6720706572666F726D616E63652E20466F722064656275672064726177696E672E
	#tag EndConstant


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

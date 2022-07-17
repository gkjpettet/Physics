#tag Module
Protected Module VMaths
	#tag Method, Flags = &h1, Description = 52657475726E732060646567726565736020696E2072616469616E732E
		Protected Function Radians(degrees As Double) As Double
		  /// Returns `degrees` in radians.
		  
		  Return degrees * DEGREES_TO_RADIANS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206072616469616E736020696E20646567726565732E
		Protected Function ToDegrees(radians As Double) As Double
		  /// Returns `radians` in degrees.
		  
		  Return radians * RADIANS_TO_DEGREES
		  
		End Function
	#tag EndMethod


	#tag Note, Name = TODO
		- Port Vector3
		- Port Matrix3
		
		
	#tag EndNote


	#tag Constant, Name = DEGREES_TO_RADIANS, Type = Double, Dynamic = False, Default = \"0.017453292519943295", Scope = Protected, Description = 54686520636F6E7374616E7420627920776869636820746F206D756C7469706C7920616E20616E67756C61722076616C756520696E206465677265657320746F206F627461696E20616E20616E67756C61722076616C756520696E2072616469616E732E
	#tag EndConstant

	#tag Constant, Name = RADIANS_TO_DEGREES, Type = Double, Dynamic = False, Default = \"57.29577951308232", Scope = Protected, Description = 54686520636F6E7374616E7420627920776869636820746F206D756C7469706C7920616E20616E67756C61722076616C756520696E2072616469616E7320746F206F627461696E20616E20616E67756C61722076616C756520696E20646567726565732E
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
End Module
#tag EndModule

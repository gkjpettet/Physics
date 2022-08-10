#tag Module
Protected Module Maths
	#tag Method, Flags = &h1
		Protected Function Clamp(value As Double, minimum As Double, maximum As Double) As Double
		  /// Clamps `value` between `minimum` and `maximum`.
		  
		  If value > maximum Then Return maximum
		  If value < minimum Then Return minimum
		  Return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C616D707320606460206265747765656E20606D696E696D756D6020616E6420606D6178696D756D602E
		Function Clamp(Extends value As Double, minimum As Double, maximum As Double) As Double
		  /// Clamps `value` between `minimum` and `maximum`.
		  
		  If value > maximum Then Return maximum
		  If value < minimum Then Return minimum
		  Return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C616D707320606460206265747765656E20606D696E696D756D6020616E6420606D6178696D756D602E
		Function Clamp(Extends value As Integer, minimum As Integer, maximum As Integer) As Integer
		  /// Clamps `value` between `minimum` and `maximum`.
		  
		  If value > maximum Then Return maximum
		  If value < minimum Then Return minimum
		  Return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732054727565206966207468697320646F75626C6520616E64206076602061726520636F6E73696465726564207468652073616D652077697468696E2060646563696D616C506F696E7473602E
		Function Compare(Extends d As Double, v As Double, decimalPoints As Integer = 5) As Boolean
		  /// Returns True if this double and `v` are considered the same within `decimalPoints`.
		  ///
		  /// Credit: https://forum.xojo.com/t/double-equals-help/56862/6?u=garrypettet
		  
		  Return Round(d * Pow(10, decimalPoints)) = Round(v * Pow(10, decimalPoints))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520737065636966696564206465677265657320696E2072616469616E732E
		Protected Function DegreesToRadians(degrees As Double) As Double
		  /// Returns the specified degrees in radians.
		  
		  Return degrees * DEGREES_TO_RADIANS_RATIO
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732054727565206966206076616C756560206973206F757473696465207468652072616E676520605B6D696E2C206D6178605D2E
		Protected Function OutsideRange(value As Double, min As Double, max As Double) As Boolean
		  /// Returns True if `value` is outside the range `[min, max`].
		  
		  If value < min Or value > max Then
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865207370656369666965642072616469616E7320696E20646567726565732E
		Protected Function RadiansToDegrees(radians As Double) As Double
		  /// Returns the specified radians in degrees.
		  
		  Return radians * RADIANS_TO_DEGREES_RATIO
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = DEGREES_TO_RADIANS_RATIO, Type = Double, Dynamic = False, Default = \"0.017453292", Scope = Private, Description = 313830202F20CF802E205573656420666F7220636F6E76657274696E67206465677265657320746F2072616469616E732E
	#tag EndConstant

	#tag Constant, Name = DoubleMaxFinite, Type = Double, Dynamic = False, Default = \"1.7976931348623157e+308", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HALF_PI, Type = Double, Dynamic = False, Default = \"1.570796326795", Scope = Protected, Description = 416E20617070726F78696D6174696F6E206F662068616C662050692E
	#tag EndConstant

	#tag Constant, Name = PI, Type = Double, Dynamic = False, Default = \"3.14159265359", Scope = Protected, Description = 5468652076616C7565206F6620506920746F20313120646563696D616C20706C616365732E
	#tag EndConstant

	#tag Constant, Name = RADIANS_TO_DEGREES_RATIO, Type = Double, Dynamic = False, Default = \"57.29577951", Scope = Private, Description = 313830202F20CF802E205573656420666F7220636F6E76657274696E67206465677265657320746F2072616469616E732E
	#tag EndConstant

	#tag Constant, Name = TWO_PI, Type = Double, Dynamic = False, Default = \"6.28318530718", Scope = Protected, Description = 416E20617070726F78696D6174696F6E206F66205069202A20322E
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

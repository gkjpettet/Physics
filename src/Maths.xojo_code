#tag Module
Protected Module Maths
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


	#tag Constant, Name = PI, Type = Double, Dynamic = False, Default = \"3.14159265359", Scope = Protected, Description = 5468652076616C7565206F6620506920746F20313120646563696D616C20706C616365732E
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

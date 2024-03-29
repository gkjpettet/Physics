#tag Class
Protected Class ProfileEntry
	#tag Method, Flags = &h0
		Sub Accum(value As Double)
		  mAccum = mAccum + value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndAccum()
		  Record(mAccum)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Record(value As Double)
		  LongAvg = LongAvg * (1 - LongFraction) + value * LongFraction
		  ShortAvg = ShortAvg * (1 - ShortFraction) + value * ShortFraction
		  Minimum = Min(value, Minimum)
		  Maximum = Max(value, Maximum)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartAccum()
		  mAccum = 0.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520617665726167652C206D696E20616E64206D6178207265636F726465642074696D6573206173206120737472696E6720696E2074686520666F726D61743A20226176673A20232E23206D732C206D696E3A20232E23206D732C206D61783A20232E23206D73222E
		Function ToString() As String
		  /// Returns the average, min and max recorded times as a string 
		  /// in the format: "avg: #.# ms, min: #.# ms, max: #.# ms".
		  
		  Return "avg: " + LongAvg.ToString(Locale.Current, "#.0") + " ms, " + _
		  "min: " + Minimum.ToString(Locale.Current, "#.0") + " ms, " + _
		  "max: " + Maximum.ToString(Locale.Current, "#.0") + " ms"
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		LongAvg As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAccum As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Maximum As Double = -1.7976931348623157e+308
	#tag EndProperty

	#tag Property, Flags = &h0
		Minimum As Double = 1.7976931348623157e+308
	#tag EndProperty

	#tag Property, Flags = &h0
		ShortAvg As Double = 0
	#tag EndProperty


	#tag Constant, Name = LongAvgNums, Type = Double, Dynamic = False, Default = \"20", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LongFraction, Type = Double, Dynamic = False, Default = \"0.05", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ShortAvgNums, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ShortFraction, Type = Double, Dynamic = False, Default = \"0.2", Scope = Private
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
		#tag ViewProperty
			Name="LongAvg"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Maximum"
			Visible=false
			Group="Behavior"
			InitialValue="-1.7976931348623157e+308"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minimum"
			Visible=false
			Group="Behavior"
			InitialValue="1.7976931348623157e+308"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShortAvg"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

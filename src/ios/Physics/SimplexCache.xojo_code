#tag Class
Protected Class SimplexCache
	#tag Method, Flags = &h0
		Sub Constructor()
		  IndexA(0) = Physics.Settings.IntMaxValue
		  IndexA(1) = Physics.Settings.IntMaxValue
		  IndexA(2) = Physics.Settings.IntMaxValue
		  IndexB(0) = Physics.Settings.IntMaxValue
		  IndexB(1) = Physics.Settings.IntMaxValue
		  IndexB(2) = Physics.Settings.IntMaxValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(sc As Physics.SimplexCache)
		  IndexA.SetRange(0, sc.IndexA.Count, sc.IndexA)
		  IndexA.SetRange(0, sc.IndexB.Count, sc.IndexB)
		  Metric = sc.Metric
		  Count = sc.Count
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Count As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5665727469636573206F6E205368617065412E
		IndexA(2) As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5665727469636573206F6E205368617065422E
		IndexB(2) As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Metric As Double = 0.0
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
			Name="Metric"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

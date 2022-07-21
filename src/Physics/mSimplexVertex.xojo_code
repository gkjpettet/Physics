#tag Class
Private Class mSimplexVertex
	#tag Method, Flags = &h0
		Sub Constructor()
		  WA = VMaths.Vector2.Zero
		  WB = VMaths.Vector2.Zero
		  W = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(sv As Physics.mSimplexVertex)
		  WA.SetFrom(sv.WA)
		  WB.SetFrom(sv.WB)
		  W.SetFrom(sv.W)
		  a = sv.A
		  IndexA = sv.IndexA
		  IndexB = sv.IndexB
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		GJK using Voronoi regions (Christer Ericson) and Barycentric coordinates.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 4261727963656E7472696320636F6F7264696E61746520666F7220636C6F7365737420706F696E742E
		A As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 574120696E6465782E
		IndexA As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 574220696E6465782E
		IndexB As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5742202D205741
		W As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 537570706F727420706F696E7420696E205368617065412E
		WA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 537570706F727420706F696E7420696E205368617065422E
		WB As VMaths.Vector2
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
			Name="WA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

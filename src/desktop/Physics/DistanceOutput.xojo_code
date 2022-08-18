#tag Class
Protected Class DistanceOutput
	#tag Method, Flags = &h0
		Sub Constructor()
		  PointA = VMaths.Vector2.Zero
		  PointB = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Output for distance.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Distance As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4E756D626572206F6620676A6B20697465726174696F6E7320757365642E
		Iterations As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436C6F7365737420706F696E74206F6E205368617065412E
		PointA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436C6F7365737420706F696E74206F6E205368617065422E
		PointB As VMaths.Vector2
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
			Name="PointA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

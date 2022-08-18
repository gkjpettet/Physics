#tag Class
Protected Class ContactImpulse
	#tag Method, Flags = &h0
		Sub Constructor()
		  NormalImpulses.ResizeTo(Physics.Settings.MaxManifoldPoints - 1)
		  TangentImpulses.ResizeTo(Physics.Settings.MaxManifoldPoints - 1)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Contact impulses for reporting. Impulses are used instead of forces because
		sub-step forces may approach infinity for rigid body collisions. These match
		up one-to-one with the contact points in `Manifold`.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Count As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		NormalImpulses() As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		TangentImpulses() As Double
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
			Name="NormalImpulses()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

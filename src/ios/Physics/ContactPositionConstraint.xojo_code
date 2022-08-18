#tag Class
Protected Class ContactPositionConstraint
	#tag Method, Flags = &h0
		Sub Constructor()
		  LocalPoints.ResizeTo(Physics.Settings.MaxManifoldPoints - 1)
		  For i As Integer = 0 To LocalPoints.LastIndex
		    LocalPoints(i) = VMaths.Vector2.Zero
		  Next i
		  
		  LocalNormal = VMaths.Vector2.Zero
		  LocalPoint = VMaths.Vector2.Zero
		  LocalCenterA = VMaths.Vector2.Zero
		  LocalCenterB = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		IndexA As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		IndexB As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		InvIA As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		InvIB As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		InvMassA As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		InvMassB As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalCenterA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalCenterB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalNormal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalPoint As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalPoints() As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		PointCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		RadiusA As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		RadiusB As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As Physics.ManifoldType
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
			Name="IndexA"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IndexB"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvIA"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvIB"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvMassA"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvMassB"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PointCount"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RadiusA"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RadiusB"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

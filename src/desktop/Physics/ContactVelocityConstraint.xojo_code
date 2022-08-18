#tag Class
Protected Class ContactVelocityConstraint
	#tag Method, Flags = &h0
		Sub Constructor()
		  Points.ResizeTo(Physics.Settings.MaxManifoldPoints - 1)
		  For i As Integer = 0 To Points.LastIndex
		    Points(i) = New Physics.VelocityConstraintPoint
		  Next i
		  
		  Normal = VMaths.Vector2.Zero
		  NormalMass = VMaths.Matrix2.Zero
		  K = VMaths.Matrix2.Zero
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ContactIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Friction As Double = 0
	#tag EndProperty

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
		K As VMaths.Matrix2
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		NormalMass As VMaths.Matrix2
	#tag EndProperty

	#tag Property, Flags = &h0
		PointCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Points() As Physics.VelocityConstraintPoint
	#tag EndProperty

	#tag Property, Flags = &h0
		Restitution As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		TangentSpeed As Double = 0
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
			Name="Points()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

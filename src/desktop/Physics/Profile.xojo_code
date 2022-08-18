#tag Class
Protected Class Profile
	#tag Method, Flags = &h0
		Sub Constructor()
		  Step_ = New Physics.ProfileEntry
		  StepInit = New Physics.ProfileEntry
		  Collide = New Physics.ProfileEntry
		  SolveParticleSystem = New Physics.ProfileEntry
		  Solve = New Physics.ProfileEntry
		  SolveInit = New Physics.ProfileEntry
		  SolveVelocity = New Physics.ProfileEntry
		  SolvePosition = New Physics.ProfileEntry
		  Broadphase = New Physics.ProfileEntry
		  SolveTOI = New Physics.ProfileEntry
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ToDebugStrings(strings() As String)
		  Strings.Add("Profile:")
		  Strings.Add(" step: " + Step_.ToString)
		  Strings.Add("  init: " + StepInit.ToString)
		  Strings.Add("  collide: " + Collide.ToString)
		  Strings.Add("  particles: " + SolveParticleSystem.ToString)
		  Strings.Add("  solve: " + Solve.ToString)
		  Strings.Add("   solveInit: " + SolveInit.ToString)
		  Strings.Add("   solveVelocity: " + SolveVelocity.ToString)
		  Strings.Add("   solvePosition: " + SolvePosition.ToString)
		  Strings.Add("   broadphase: " + Broadphase.ToString)
		  Strings.Add("  solveTOI: " + SolveTOI.ToString)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Broadphase As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Collide As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Solve As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		SolveInit As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		SolveParticleSystem As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		SolvePosition As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		SolveTOI As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		SolveVelocity As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		StepInit As Physics.ProfileEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Step_ As Physics.ProfileEntry
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
			Name="Step_"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

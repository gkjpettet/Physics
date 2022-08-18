#tag Class
Protected Class WorldRayCastWrapper
Implements Physics.TreeRayCastCallback
	#tag Method, Flags = &h0
		Sub Constructor()
		  mOutput = New Physics.RaycastOutput
		  mTemp = VMaths.Vector2.Zero
		  mPoint = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RaycastCallback(input As Physics.RaycastInput, nodeID As Integer) As Double
		  // Part of the Physics.TreeRayCastCallback interface.
		  
		  Var userData As Variant = Broadphase.GetUserData(nodeID)
		  If userData = Nil Then
		    Return 0
		  End If
		  
		  Var proxy As Physics.FixtureProxy = Physics.FixtureProxy(userData)
		  Var fixture As Physics.Fixture = proxy.Fixture
		  Var index As Integer = proxy.ChildIndex
		  Var hit As Boolean = fixture.Raycast(mOutput, input, index)
		  
		  If hit Then
		    Var fraction As Double = mOutput.fraction
		    mTemp.SetFrom(input.P2)
		    mTemp.Scale(fraction)
		    
		    mPoint.SetFrom(input.P1)
		    mPoint.Scale(1 - fraction)
		    mPoint.Add(mTemp)
		    
		    If Callback <> Nil Then
		      Return Callback.ReportFixture( _
		      fixture, mPoint, mOutput.Normal, fraction)
		    Else
		      Return 0
		    End If
		  End If
		  
		  Return input.MaxFraction
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Broadphase As Physics.Broadphase
	#tag EndProperty

	#tag Property, Flags = &h0
		Callback As Physics.RaycastCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutput As Physics.RaycastOutput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPoint As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As VMaths.Vector2
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
	#tag EndViewBehavior
End Class
#tag EndClass

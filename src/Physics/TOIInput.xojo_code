#tag Class
Protected Class TOIInput
	#tag Method, Flags = &h0
		Sub Constructor()
		  ProxyA = New Physics.DistanceProxy
		  ProxyB = New Physics.DistanceProxy
		  SweepA = New Physics.Sweep
		  SweepB = New Physics.Sweep
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ProxyA As Physics.DistanceProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyB As Physics.DistanceProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		SweepA As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h0
		SweepB As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 446566696E657320737765657020696E74657276616C205B302C20544D61785D2E
		TMax As Double = 0
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
			Name="ProxyA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

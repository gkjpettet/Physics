#tag Interface
Protected Interface ParticleQueryCallback
	#tag Method, Flags = &h0, Description = 43616C6C656420666F722065616368207061727469636C6520666F756E6420696E2074686520717565727920414142422E2052657475726E2046616C736520746F207465726D696E617465207468652071756572792E
		Function ReportParticle(particle As Physics.Particle) As Boolean
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Callback class for AABB queries. See `World.QueryAABB()`.
		
	#tag EndNote


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
End Interface
#tag EndInterface

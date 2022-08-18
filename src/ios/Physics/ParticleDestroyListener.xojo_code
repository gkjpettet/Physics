#tag Interface
Protected Interface ParticleDestroyListener
	#tag Method, Flags = &h0, Description = 43616C6C6564207768656E2061207061727469636C652069732061626F757420746F2062652064657374726F7965642E
		Sub OnDestroyParticle(particle As Physics.Particle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C6564207768656E20616E79207061727469636C652067726F75702069732061626F757420746F2062652064657374726F7965642E
		Sub OnDestroyParticleGroup(group As Physics.ParticleGroup)
		  
		End Sub
	#tag EndMethod


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

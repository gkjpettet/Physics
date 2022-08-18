#tag Class
Protected Class ParticleType
	#tag Note, Name = About
		The particle type. Can be combined with the `Or` operator. Zero means liquid.
		
		
	#tag EndNote


	#tag Constant, Name = ColorMixingParticle, Type = Double, Dynamic = False, Default = \"256", Scope = Public, Description = 4D6978696E6720636F6C6F7572206265747765656E20636F6E74616374696E67207061727469636C65732E
	#tag EndConstant

	#tag Constant, Name = DestroyListener, Type = Double, Dynamic = False, Default = \"512", Scope = Public, Description = 43616C6C207468652064657374726F79206C697374656E6572206F6E206465737472756374696F6E2E
	#tag EndConstant

	#tag Constant, Name = ElasticParticle, Type = Double, Dynamic = False, Default = \"16", Scope = Public, Description = 57697468207265737469747574696F6E2066726F6D206465666F726D6174696F6E2E
	#tag EndConstant

	#tag Constant, Name = PowderParticle, Type = Double, Dynamic = False, Default = \"64", Scope = Public, Description = 576974682069736F74726F7069632070726573737572652E
	#tag EndConstant

	#tag Constant, Name = SpringParticle, Type = Double, Dynamic = False, Default = \"8", Scope = Public, Description = 57697468207265737469747574696F6E2066726F6D2073747265746368696E672E
	#tag EndConstant

	#tag Constant, Name = TensileParticle, Type = Double, Dynamic = False, Default = \"128", Scope = Public, Description = 5769746820737572666163652074656E73696F6E2E
	#tag EndConstant

	#tag Constant, Name = ViscousParticle, Type = Double, Dynamic = False, Default = \"32", Scope = Public, Description = 5769746820766973636F736974792E
	#tag EndConstant

	#tag Constant, Name = WallParticle, Type = Double, Dynamic = False, Default = \"4", Scope = Public, Description = 5A65726F2076656C6F636974792E
	#tag EndConstant

	#tag Constant, Name = WaterParticle, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ZombieParticle, Type = Double, Dynamic = False, Default = \"2", Scope = Public, Description = 52656D6F766564206166746572206E65787420737465702E
	#tag EndConstant


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

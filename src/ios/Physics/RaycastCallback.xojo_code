#tag Interface
Protected Interface RaycastCallback
	#tag Method, Flags = &h0, Description = 43616C6C656420666F722065616368206669787475726520666F756E6420696E207468652071756572792E20596F7520636F6E74726F6C20686F77207468652072617920636173742070726F63656564732062792072657475726E696E67206120666C6F61743A0A52657475726E202D313A2069676E6F72652074686973206669787475726520616E6420636F6E74696E75650A2052657475726E20303A207465726D696E617465207468652072617920636173740A2052657475726E206672616374696F6E3A20636C6970207468652072617920746F207468697320706F696E740A2052657475726E20313A20646F6E277420636C6970207468652072617920616E6420636F6E74696E75650A206066697874757265602069732074686520666978747572652068697420627920746865207261792E0A2060706F696E74602069732074686520706F696E74206F6620696E697469616C20696E74657273656374696F6E2E0A2020606E6F726D616C6020697320746865206E6F726D616C20766563746F722061742074686520706F696E74206F6620696E74657273656374696F6E2E
		Function ReportFixture(fixture As Physics.Fixture, point As VMaths.Vector2, normal As VMaths.Vector2, fraction As Double) As Double
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Callback class for ray casts.
		See `World.`Raycast`.
		
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

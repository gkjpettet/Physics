#tag Class
Protected Class ParticleGroupDef
	#tag Method, Flags = &h0
		Sub Constructor()
		  Position = VMaths.Vector2.Zero
		  LinearVelocity = VMaths.Vector2.Zero
		  Colour = Physics.Color3i.Black
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A particle group definition holds all the data needed to construct a
		particle group. You can safely re-use these definitions.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520776F726C6420616E676C65206F66207468652067726F757020696E2072616469616E732E20526F74617465732074686520736861706520627920616E20616E676C6520657175616C20746F207468652076616C7565206F6620616E676C652E
		Angle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520616E67756C61722076656C6F63697479206F66207468652067726F75702E
		AngularVelocity As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620616C6C207061727469636C657320696E207468652067726F75702E
		Colour As Physics.Color3i
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620547275652C2064657374726F79207468652067726F7570206175746F6D61746963616C6C7920616674657220697473206C617374207061727469636C6520686173206265656E2064657374726F7965642E
		DestroyAutomatically As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207061727469636C65206265686176696F757220666C6167732E
		Flags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652067726F757020636F6E737472756374696F6E20666C6167732E
		GroupFlags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E6561722076656C6F63697479206F66207468652067726F75702773206F726967696E20696E20776F726C6420636F6F7264696E617465732E
		LinearVelocity As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520776F726C6420706F736974696F6E206F66207468652067726F75702E204D6F766573207468652067726F7570277320736861706520612064697374616E636520657175616C20746F207468652076616C7565206F6620706F736974696F6E2E
		Position As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 536861706520636F6E7461696E696E6720746865207061727469636C652067726F75702E
		Shape As Physics.Shape
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520737472656E677468206F6620636F686573696F6E20616D6F6E6720746865207061727469636C657320696E20612067726F7570207769746820666C61672060456C61737469635061727469636C6560206F722060537072696E675061727469636C65602E
		Strength As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5573656420746F2073746F7265206170706C69636174696F6E2D73706563696669632067726F757020646174612E
		UserData As Variant
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
			Name="Flags"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

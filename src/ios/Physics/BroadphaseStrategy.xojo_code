#tag Interface
Protected Interface BroadphaseStrategy
	#tag Method, Flags = &h0, Description = 436F6D707574652074686520686569676874206F662074686520747265652E
		Function ComputeHeight() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43726561746520612070726F78792E2050726F7669646520612074696768742066697474696E67204141424220616E64206120557365724461746120706F696E7465722E
		Function CreateProxy(aabb As Physics.AABB, userData As Variant = Nil) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657374726F7920612070726F78792E
		Sub DestroyProxy(proxyId As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawTree(draw As Physics.DebugDraw)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FatAABB(proxyId As Integer) As Physics.AABB
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520726174696F206F66207468652073756D206F6620746865206E6F646520617265617320746F2074686520726F6F7420617265612E
		Function GetAreaRatio() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D707574652074686520686569676874206F66207468652062696E617279207472656520696E204F284E292074696D652E2053686F756C64206E6F742062652063616C6C6564206F6674656E2E
		Function GetHeight() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865206D6178696D756D2062616C616E6365206F6620616E206E6F646520696E2074686520747265652E205468652062616C616E63652069732074686520646966666572656E636520696E20686569676874206F66207468652074776F206368696C6472656E206F662061206E6F64652E
		Function GetMaxBalance() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F766520612070726F787920776974682061207377657074656420414142422E204966207468652070726F787920686173206D6F766564206F757473696465206F66206974730A66617474656E656420414142422C207468656E207468652070726F78792069732072656D6F7665642066726F6D20746865207472656520616E642072652D696E7365727465642E0A4F7468657277697365207468652066756E6374696F6E2072657475726E7320696D6D6564696174656C792E0A49742072657475726E732054727565206966207468652070726F7879207761732072652D696E7365727465642E
		Function MoveProxy(proxyId As Integer, aabb As Physics.AABB, displacement As VMaths.Vector2) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 517565727920616E204141424220666F72206F7665726C617070696E672070726F786965732E205468652063616C6C6261636B20636C6173732069732063616C6C656420666F7220656163682070726F78792074686174206F7665726C6170732074686520737570706C69656420414142422E
		Sub Query(callback As Physics.TreeCallback, aabb As Physics.AABB)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5261792D6361737420616761696E7374207468652070726F7869657320696E2074686520747265652E20546869732072656C696573206F6E207468652063616C6C6261636B20746F20706572666F726D2061206578616374207261792D6361737420696E2074686520636173652077657265207468652070726F787920636F6E7461696E7320612073686170652E0A5468652063616C6C6261636B20616C736F20706572666F726D732074686520616E7920636F6C6C6973696F6E2066696C746572696E672E0A0A546869732068617320706572666F726D616E636520726F7567686C7920657175616C20746F206B202A206C6F67286E292C207768657265206B20697320746865206E756D626572206F660A636F6C6C6973696F6E7320616E64206E20697320746865206E756D626572206F662070726F7869657320696E2074686520747265652E0A0A60696E7075746020697320746865207261792D6361737420696E70757420646174612E0A5468652072617920657874656E64732066726F6D20703120746F207031202B206D61784672616374696F6E202A20287032202D207031292E0A6063616C6C6261636B20697320612063616C6C6261636B20636C61737320746861742069732063616C6C656420666F7220656163682070726F787920746861742069732068697420627920746865207261792E
		Sub Raycast(callback As Physics.TreeRayCastCallback, input As Physics.RaycastInput)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserData(proxyId As Integer) As Variant
		  
		End Function
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
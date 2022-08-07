#tag Interface
Protected Interface Broadphase
	#tag Method, Flags = &h0, Description = 43726561746520612070726F7879207769746820616E20696E697469616C20414142422E20506169727320617265206E6F74207265706F7274656420756E74696C206055706461746550616972732829602069732063616C6C65642E
		Function CreateProxy(aabb As Physics.AABB, userData As Variant) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657374726F7920612070726F78792E20497420697320757020746F2074686520636C69656E7420746F2072656D6F766520616E792070616972732E
		Sub DestroyProxy(proxyID As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawTree(argDraw As Physics.DebugDraw)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FatAABB(proxyID As Integer) As Physics.AABB
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTreeBalance() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520686569676874206F662074686520656D62656464656420747265652E
		Function GetTreeHeight() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTreeQuality() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUserData(proxyID As Integer) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C20604D6F766550726F7879282960206173206D616E792074696D657320617320796F75206C696B652C207468656E207768656E20796F752061726520646F6E652063616C6C2060557064617465506169727328296020746F2066696E616C697365207468652070726F78792070616972732028666F7220796F75722074696D652073746570292E
		Sub MoveProxy(proxyID As Integer, AABB As Physics.AABB, displacement As VMaths.Vector2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765747320746865206E756D626572206F662070726F786965732E
		Function ProxyCount() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 517565727920616E204141424220666F72206F7665726C617070696E672070726F786965732E205468652063616C6C6261636B20636C6173732069732063616C6C656420666F7220656163682070726F78792074686174206F7665726C6170732074686520737570706C69656420414142422E
		Sub Query(callback As Physics.TreeCallback, aabb As Physics.AABB)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5261792D6361737420616761696E7374207468652070726F7869657320696E2074686520747265652E20546869732072656C696573206F6E207468652063616C6C6261636B20746F0A706572666F726D2061206578616374207261796361737420696E207468652063617365207768657265207468652070726F787920636F6E7461696E7320612073686170652E0A5468652063616C6C6261636B20616C736F20706572666F726D732074686520616E7920636F6C6C6973696F6E2066696C746572696E672E2054686973206861730A706572666F726D616E636520726F7567686C7920657175616C20746F20606B202A206C6F67286E29602C20776865726520606B6020697320746865206E756D626572206F660A636F6C6C6973696F6E7320616E6420606E6020697320746865206E756D626572206F662070726F7869657320696E2074686520747265652E0A0A60696E7075746020697320746865207261796361737420696E70757420646174612E0A5468652072617920657874656E64732066726F6D206070316020746F20607031202B204D61784672616374696F6E202A20287032202D20703129602E0A6063616C6C6261636B6020697320612063616C6C6261636B20636C61737320746861742069732063616C6C656420666F7220656163682070726F78792074686174206973206869740A20627920746865207261792E
		Sub Raycast(callback As Physics.TreeRayCastCallback, input As RaycastInput)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestOverlap(proxyIDA As Integer, proxyIDB As Integer) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TouchProxy(proxyID As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 557064617465207468652070616972732E205468697320726573756C747320696E20706169722063616C6C6261636B732E20546869732063616E206F6E6C79206164642070616972732E
		Sub UpdatePairs(callback As Physics.PairCallback)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface

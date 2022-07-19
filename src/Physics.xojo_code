#tag Module
Protected Module Physics
	#tag Method, Flags = &h0, Description = 496620606E6565646C65602069732077697468696E2060686179737461636B602069742069732072656D6F76656420616E6420547275652069732072657475726E65642E204F74686572776973652046616C73652069732072657475726E65642E
		Function Remove(Extends haystack() As Physics.Contact, needle As Physics.Contact) As Boolean
		  /// If `needle` is within `haystack` it is removed and True is returned. Otherwise
		  /// False is returned.
		  
		  Var index As Integer = haystack.IndexOf(needle)
		  
		  If index = -1 Then
		    Return False
		  Else
		    haystack.RemoveAt(index)
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496620606E6565646C65602069732077697468696E2060686179737461636B602069742069732072656D6F76656420616E6420547275652069732072657475726E65642E204F74686572776973652046616C73652069732072657475726E65642E
		Function Remove(Extends haystack() As Physics.Fixture, needle As Physics.Fixture) As Boolean
		  /// If `needle` is within `haystack` it is removed and True is returned. Otherwise
		  /// False is returned.
		  
		  Var index As Integer = haystack.IndexOf(needle)
		  
		  If index = -1 Then
		    Return False
		  Else
		    haystack.RemoveAt(index)
		    Return True
		  End If
		  
		End Function
	#tag EndMethod


	#tag Enum, Name = BodyType, Type = Integer, Flags = &h1, Description = 446566696E6573207468652074797065206F66206120626F64792E
		Static_
		  Kinematic
		Dynamic
	#tag EndEnum

	#tag Enum, Name = ManifoldType, Type = Integer, Flags = &h1
		Circles
		  FaceA
		FaceB
	#tag EndEnum

	#tag Enum, Name = ShapeType, Type = Integer, Flags = &h1, Description = 5479706573206F66207368617065732E
		Circle = 0
		  Edge = 1
		  Polygon = 2
		Chain = 3
	#tag EndEnum


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
End Module
#tag EndModule

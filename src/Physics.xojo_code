#tag Module
Protected Module Physics
	#tag Method, Flags = &h1
		Protected Sub Assert(condition As Boolean, message As String = "")
		  /// If `condition` is False then an `UnsupportedOperation` is raised. 
		  /// Only executes in debug mode.
		  
		  #If DebugBuild
		    If Not condition Then
		      Raise New UnsupportedOperationException("Failed assertion: " + message)
		    End If
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(Extends haystack() As Physics.Particle, needle As Physics.Particle) As Boolean
		  If haystack.IndexOf(needle) = -1 Then
		    Return False
		  Else
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496620606E6565646C65602069732077697468696E2060686179737461636B602069742069732072656D6F7665642E
		Sub Remove(Extends haystack() As Physics.Body, needle As Physics.Body)
		  /// If `needle` is within `haystack` it is removed.
		  
		  Var index As Integer = haystack.IndexOf(needle)
		  
		  If index <> -1 Then haystack.RemoveAt(index)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496620606E6565646C65602069732077697468696E2060686179737461636B602069742069732072656D6F7665642E
		Sub Remove(Extends haystack() As Physics.Contact, needle As Physics.Contact)
		  /// If `needle` is within `haystack` it is removed.
		  
		  Var index As Integer = haystack.IndexOf(needle)
		  
		  If index <> -1 Then haystack.RemoveAt(index)
		  
		End Sub
	#tag EndMethod

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

	#tag Method, Flags = &h0, Description = 496620606E6565646C65602069732077697468696E2060686179737461636B602069742069732072656D6F7665642E
		Sub Remove(Extends haystack() As Physics.Joint, needle As Physics.Joint)
		  /// If `needle` is within `haystack` it is removed.
		  
		  Var index As Integer = haystack.IndexOf(needle)
		  
		  If index <> -1 Then haystack.RemoveAt(index)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRange(Extends destination() As Integer, start As Integer, finish As Integer, source() As Integer, skipCount As Integer = 0)
		  /// Copies elements of `source` into `destination` skipping `skipCount` elements first 
		  /// from `start` (inclusive) to `finish` (exclusive).
		  
		  // Empty range?
		  If start = finish Then Return
		  
		  Var sourceFinish As Integer = skipCount + finish - start - 1
		  
		  If source = destination Then
		    Var tmp() As Integer
		    For i As Integer = skipCount To sourceFinish
		      tmp.Add(source(i))
		    Next i
		    Var j As Integer = start
		    For i As Integer = skipCount To sourceFinish
		      destination(j) = tmp(i)
		      j = j + 1
		    Next i
		    
		  Else
		    Var j As Integer = start
		    For i As Integer = skipCount To sourceFinish
		      destination(j) = source(i)
		      j = j + 1
		    Next i
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = BroadphaseNullProxy, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected, Description = 506F727465642066726F6D206042726F616470686173652E4E756C6C50726F7879602E
	#tag EndConstant

	#tag Constant, Name = DebugDrawAABBBit, Type = Double, Dynamic = False, Default = \"8", Scope = Protected, Description = 44726177206178697320616C69676E656420626F756E64696E6720626F7865732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DebugDrawCenterOfMassBit, Type = Double, Dynamic = False, Default = \"32", Scope = Protected, Description = 447261772063656E747265206F66206D617373206672616D652E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DebugDrawDynamicTreeBit, Type = Double, Dynamic = False, Default = \"64", Scope = Protected, Description = 447261772064796E616D696320747265652E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DebugDrawJointBit, Type = Double, Dynamic = False, Default = \"4", Scope = Protected, Description = 44726177206A6F696E7420636F6E6E656374696F6E732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DebugDrawPairBit, Type = Double, Dynamic = False, Default = \"16", Scope = Protected, Description = 44726177207061697273206F6620636F6E6E6563746564206F626A656374732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DebugDrawShapeBit, Type = Double, Dynamic = False, Default = \"2", Scope = Protected, Description = 44726177207368617065732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DebugDrawWireFrameDrawingBit, Type = Double, Dynamic = False, Default = \"128", Scope = Protected, Description = 44726177206F6E6C792074686520776972656672616D6520666F722064726177696E6720706572666F726D616E63652E20466F722064656275672064726177696E672E
	#tag EndConstant


	#tag Enum, Name = BodyType, Type = Integer, Flags = &h1, Description = 446566696E6573207468652074797065206F66206120626F64792E
		Static_
		  Kinematic
		Dynamic
	#tag EndEnum

	#tag Enum, Name = ContactIDType, Type = Integer, Flags = &h1
		Vertex
		Face
	#tag EndEnum

	#tag Enum, Name = EPAxisType, Type = Integer, Flags = &h1
		Unknown
		  EdgeA
		EdgeB
	#tag EndEnum

	#tag Enum, Name = ManifoldType, Type = Integer, Flags = &h1
		Circles
		  FaceA
		FaceB
	#tag EndEnum

	#tag Enum, Name = PointState, Type = Integer, Flags = &h1, Description = 5573656420696E7465726E616C6C7920666F722064657465726D696E696E6720746865207374617465206F6620636F6E7461637420706F696E74732E
		NullState
		  AddState
		  PersistState
		RemoveState
	#tag EndEnum

	#tag Enum, Name = SeparationFunctionType, Type = Integer, Flags = &h1
		Points
		  FaceA
		FaceB
	#tag EndEnum

	#tag Enum, Name = ShapeType, Type = Integer, Flags = &h1, Description = 5479706573206F66207368617065732E
		Circle = 0
		  Edge = 1
		  Polygon = 2
		Chain = 3
	#tag EndEnum

	#tag Enum, Name = TOIOutputState, Type = Integer, Flags = &h1
		Unknown
		  Failed
		  Overlapped
		  Touching
		Separated
	#tag EndEnum

	#tag Enum, Name = VertexType, Type = Integer, Flags = &h1
		Isolated
		  Concave
		Convex
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

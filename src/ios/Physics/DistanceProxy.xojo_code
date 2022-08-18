#tag Class
Protected Class DistanceProxy
	#tag Method, Flags = &h0
		Sub Constructor()
		  Vertices.ResizeTo(Physics.Settings.MaxPolygonVertices - 1)
		  For i As Integer = 0 To Vertices.LastIndex
		    Vertices(i) = VMaths.Vector2.Zero
		  Next i
		  
		  For i As Integer = 0 To Buffer.LastIndex
		    Buffer(i) = VMaths.Vector2.Zero
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520737570706F7274696E672076657274657820696E64657820696E2074686520676976656E20646972656374696F6E2E
		Function GetSupport(d As VMaths.Vector2) As Integer
		  /// Get the supporting vertex index in the given direction.
		  
		  Var bestIndex As Integer = 0
		  Var bestValue As Double = Vertices(0).Dot(d)
		  Var iLimit As Integer = mCount - 1
		  For i As Integer = 1 To iLimit
		    Var value As Double = Vertices(i).Dot(d)
		    If value > bestValue Then
		      bestIndex = i
		      bestValue = value
		    End If
		  Next i
		  
		  Return bestIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520737570706F7274696E672076657274657820696E2074686520676976656E20646972656374696F6E2E
		Function GetSupportVertex(d As VMaths.Vector2) As VMaths.Vector2
		  /// Get the supporting vertex in the given direction.
		  
		  Var bestIndex As Integer = 0
		  Var bestValue As Double = Vertices(0).Dot(d)
		  Var iLimit As Integer = mCount - 1
		  For i As Integer = 1 To iLimit
		    Var value As Double = Vertices(i).Dot(d)
		    If value > bestValue Then
		      bestIndex = i
		      bestValue = value
		    End If
		  Next i
		  
		  Return Vertices(bestIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420612076657274657820627920696E6465782E2055736564206279206044697374616E6365602E
		Function GetVertex(index As Integer) As VMaths.Vector2
		  /// Get a vertex by index. Used by `Distance`.
		  
		  #If DebugBuild
		    Assert(0 <= index And index < mCount)
		  #EndIf
		  
		  Return Vertices(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574207468652076657274657820636F756E742E
		Function GetVertexCount() As Integer
		  /// Get the vertex count.
		  
		  Return mCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E697469616C697365207468652070726F7879207573696E672074686520676976656E2073686170652E20546865207368617065206D7573742072656D61696E20696E2073636F7065207768696C65207468652070726F787920697320696E207573652E
		Sub Set(shape As Physics.Shape, index As Integer)
		  /// Initialise the proxy using the given shape. The shape must remain in scope
		  /// while the proxy is in use.
		  
		  Select Case shape.ShapeType
		  Case Physics.ShapeType.Circle
		    Var circle As Physics.CircleShape = Physics.CircleShape(shape)
		    Vertices(0).SetFrom(circle.Position)
		    mCount = 1
		    Radius = circle.Radius
		    
		  Case Physics.ShapeType.Polygon
		    Var poly As Physics.PolygonShape = Physics.PolygonShape(shape)
		    mCount = poly.Vertices.Count
		    Radius = poly.Radius
		    Var iLimit As Integer = mCount - 1
		    For i As Integer = 0 To iLimit
		      Vertices(i).SetFrom(poly.Vertices(i))
		    Next i
		    
		  Case Physics.ShapeType.Chain
		    Var chain As Physics.ChainShape = Physics.ChainShape(shape)
		    #If DebugBuild
		      Assert(0 <= index And index < chain.VertexCount)
		    #EndIf
		    buffer(0) = chain.Vertices(index)
		    If index + 1 < chain.VertexCount Then
		      buffer(1) = chain.Vertices(index + 1)
		    Else
		      buffer(1) = chain.vertices(0)
		    End If
		    
		    Vertices(0).SetFrom(buffer(0))
		    Vertices(1).SetFrom(buffer(1))
		    mCount = 2
		    Radius = chain.Radius
		    
		  Case Physics.ShapeType.Edge
		    Var edge As Physics.EdgeShape = Physics.EdgeShape(shape)
		    Vertices(0).SetFrom(edge.Vertex1)
		    Vertices(1).SetFrom(edge.Vertex2)
		    mCount = 2
		    Radius = edge.Radius
		    
		  Else
		    #If DebugBuild
		      Assert(False)
		    #EndIf
		  End Select
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Buffer(1) As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Radius As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Vertices() As VMaths.Vector2
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
			Name="Radius"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

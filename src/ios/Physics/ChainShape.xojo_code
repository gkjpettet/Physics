#tag Class
Protected Class ChainShape
Inherits Physics.Shape
	#tag Method, Flags = &h0
		Function ChildCount() As Integer
		  Return VertexCount - 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742061206368696C6420656467652E
		Function ChildEdge(index As Integer) As Physics.EdgeShape
		  /// Get a child edge.
		  
		  #If DebugBuild
		    Assert(0 <= index And index < VertexCount - 1)
		  #EndIf
		  
		  Var edge As New Physics.EdgeShape
		  
		  edge.Radius = Radius
		  Var v0 As VMaths.Vector2 = Vertices(index + 0)
		  Var v1 As VMaths.Vector2 = Vertices(index + 1)
		  edge.Vertex1.X = v0.X
		  edge.Vertex1.Y = v0.Y
		  edge.Vertex2.X = v1.X
		  edge.Vertex2.Y = v1.Y
		  
		  If index > 0 Then
		    Var v As VMaths.Vector2 = Vertices(index - 1)
		    edge.Vertex0.X = v.X
		    edge.Vertex0.Y = v.Y
		    edge.HasVertex0 = True
		  Else
		    edge.Vertex0.X = mPrevVertex.X
		    edge.Vertex0.Y = mPrevVertex.Y
		    edge.HasVertex0 = mHasPrevVertex
		  End If
		  
		  If index < VertexCount - 2 Then
		    Var v As VMaths.Vector2 = Vertices(index + 2)
		    edge.Vertex3.X = v.X
		    edge.Vertex3.Y = v.Y
		    edge.HasVertex3 = True
		  Else
		    edge.Vertex3.X = mNextVertex.X
		    edge.Vertex3.Y = mNextVertex.Y
		    edge.HasVertex3 = mHasNextVertex
		  End If
		  
		  Return edge
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  Vertices.ResizeTo(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Physics.Shape
		  Var clone As New Physics.ChainShape
		  clone.CreateChain(Vertices)
		  clone.mPrevVertex.SetFrom(mPrevVertex)
		  clone.mNextVertex.SetFrom(mNextVertex)
		  clone.mHasPrevVertex = mHasPrevVertex
		  clone.mHasNextVertex = mHasNextVertex
		  
		  Return clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeAABB(aabb As Physics.AABB, xf As Physics.Transform, childIndex As Integer)
		  #If DebugBuild
		    Assert(childIndex < VertexCount)
		  #EndIf
		  
		  Var lower As VMaths.Vector2 = aabb.LowerBound
		  Var upper As VMaths.Vector2 = aabb.UpperBound
		  
		  Var i1 As Integer = childIndex
		  var i2 As Integer = childIndex + 1
		  If i2 = VertexCount Then i2 = 0
		  
		  Var vi1 As VMaths.Vector2 = Vertices(i1)
		  Var vi2 As VMaths.Vector2 = Vertices(i2)
		  Var xfq As Physics.Rot = xf.Q
		  Var xfp As VMaths.Vector2 = xf.P
		  Var v1x As Double = (xfq.Cos * vi1.X - xfq.Sin * vi1.Y) + xfp.X
		  Var v1y As Double = (xfq.Sin * vi1.X + xfq.Cos * vi1.Y) + xfp.Y
		  Var v2x As Double = (xfq.Cos * vi2.X - xfq.Sin * vi2.Y) + xfp.X
		  Var v2y As Double = (xfq.Sin * vi2.X + xfq.Cos * vi2.Y) + xfp.Y
		  
		  lower.X = If(v1x < v2x, v1x, v2x)
		  lower.Y = If(v1y < v2y, v1y, v2y)
		  upper.X = If(v1x > v2x, v1x, v2x)
		  upper.Y = If(v1y > v2y, v1y, v2y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ComputeDistanceToOut(xf As Physics.Transform, p As VMaths.Vector2, childIndex As Integer, ByRef normalOut As VMaths.Vector2) As Double
		  Var edge As Physics.EdgeShape = ChildEdge(childIndex)
		  
		  Return edge.ComputeDistanceToOut(xf, p, 0, normalOut)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeMass(massData As Physics.MassData, density As Double)
		  #Pragma Unused density
		  
		  massData.Mass = 0.0
		  massData.Center.SetZero
		  massData.I = 0.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor(Physics.ShapeType.Chain)
		  
		  mPrevVertex = VMaths.Vector2.Zero
		  mNextVertex = VMaths.Vector2.Zero
		  
		  Radius = Physics.Settings.PolygonRadius
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465206120636861696E20776974682069736F6C6174656420656E642076657274696365732E
		Sub CreateChain(vertices() As VMaths.Vector2)
		  /// Create a chain with isolated end vertices.
		  ///
		  /// `vertices` are copied.
		  
		  #If DebugBuild
		    Assert(VertexCount = 0)
		    Assert(vertices.Count >= 2)
		  #EndIf
		  
		  For Each v As VMaths.Vector2 In vertices
		    Self.Vertices.Add(v.Clone)
		  Next v
		  
		  mValidateDistances(Self.Vertices)
		  mPrevVertex.SetZero
		  mNextVertex.SetZero
		  mHasPrevVertex = False
		  mHasNextVertex = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174652061206C6F6F702E2054686973206175746F6D61746963616C6C792061646A7573747320636F6E6E65637469766974792E
		Sub CreateLoop(vertices() As VMaths.Vector2)
		  /// Create a loop. This automatically adjusts connectivity.
		  ///
		  /// The `vertices` are copied.
		  
		  #If DebugBuild
		    Assert(VertexCount = 0)
		    Assert(vertices.Count >= 3, "A loop can't be created with less than 3 vertices.")
		  #EndIf
		  
		  For Each v As VMaths.Vector2 In vertices
		    Self.Vertices.Add(v.Clone)
		  Next v
		  
		  mValidateDistances(Self.Vertices)
		  Self.Vertices.Add(Self.Vertices(0).Clone)
		  PrevVertex = Self.Vertices(VertexCount - 2)
		  NextVertex = Self.Vertices(1)
		  mHasPrevVertex = True
		  mHasNextVertex = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mValidateDistances(vertices() As VMaths.Vector2)
		  Var iLimit As Integer = vertices.Count - 1
		  For i As Integer = 1 To iLimit
		    Var v1 As VMaths.Vector2 = vertices(i - 1)
		    Var v2 As VMaths.Vector2 = vertices(i)
		    // If the code crashes here, it means your vertices are too close together.
		    If v1.DistanceToSquared(v2) < _
		      Physics.Settings.LinearSlop * Physics.Settings.LinearSlop Then
		      Raise New InvalidArgumentException("Vertices of chain shape are too close together.")
		    End if
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Raycast(output As Physics.RaycastOutput, input As Physics.RaycastInput, xf As Physics.Transform, childIndex As Integer) As Boolean
		  #If DebugBuild
		    Assert(childIndex < VertexCount)
		  #EndIf
		  
		  Var edgeShape As New Physics.EdgeShape
		  
		  Var i1 As Integer = childIndex
		  Var i2 As Integer = childIndex + 1
		  If i2 = VertexCount Then i2 = 0
		  
		  Var v as VMaths.Vector2 = Vertices(i1)
		  edgeShape.Vertex1.X = v.X
		  edgeShape.Vertex1.Y = v.Y
		  
		  Var v1 As VMaths.Vector2 = Vertices(i2)
		  edgeShape.Vertex2.X = v1.X
		  edgeShape.Vertex2.Y = v1.Y
		  
		  Return edgeShape.Raycast(output, input, xf, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestPoint(xf As Physics.Transform, point As VMaths.Vector2) As Boolean
		  #Pragma Unused xf
		  #Pragma Unused point
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207665727465782061742074686520676976656E20706F736974696F6E2028696E646578292E
		Function Vertex(index As Integer) As VMaths.Vector2
		  /// Returns the vertex at the given position (index).
		  
		  #If DebugBuild
		    Assert(index >= 0 And index < Vertices.Count)
		  #EndIf
		  
		  Return Vertices(index).Clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VertexCount() As Integer
		  Return Vertices.Count
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A chain shape is a free form sequence of line segments. The chain has
		two-sided collision, so you can use inside and outside collision.
		Therefore, you may use any winding order. Connectivity information is used
		to create smooth collisions. WARNING: The chain will not collide properly if
		there are self-intersections.
		
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected mHasNextVertex As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHasPrevVertex As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mNextVertex As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPrevVertex As VMaths.Vector2
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Setter
			Set
			  /// Establish connectivity to a vertex that follows the last vertex.
			  /// Don't call this for loops.
			  
			  mNextVertex.SetFrom(value)
			  mHasNextVertex = True
			  
			End Set
		#tag EndSetter
		NextVertex As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Setter
			Set
			  /// Establish connectivity to a vertex that precedes the first vertex.
			  /// Don't call this for loops.
			  
			  mPrevVertex.SetFrom(value)
			  mHasPrevVertex = True
			  
			End Set
		#tag EndSetter
		PrevVertex As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 446F206E6F74206D6F64696679206469726563746C792E
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
	#tag EndViewBehavior
End Class
#tag EndClass

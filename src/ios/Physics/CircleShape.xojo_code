#tag Class
Protected Class CircleShape
Inherits Physics.Shape
	#tag Method, Flags = &h0
		Function ChildCount() As Integer
		  Return 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Physics.Shape
		  Var shape As Physics.CircleShape = New Physics.CircleShape
		  shape.Position.X = Position.X
		  shape.Position.Y = Position.Y
		  shape.Radius = Radius
		  
		  Return shape
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeAABB(aabb As Physics.AABB, transform As Physics.Transform, childIndex As Integer)
		  #Pragma Unused childIndex
		  
		  Var tq As Physics.Rot = transform.Q
		  Var tp As VMaths.Vector2 = transform.P
		  Var px As Double = tq.Cos * Position.X - tq.Sin * Position.Y + tp.X
		  Var py As Double = tq.Sin * Position.X + tq.Cos * Position.Y + tp.Y
		  
		  aabb.LowerBound.X = px - radius
		  aabb.LowerBound.Y = py - radius
		  aabb.UpperBound.X = px + radius
		  aabb.UpperBound.Y = py + radius
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ComputeDistanceToOut(xf As Physics.Transform, p As VMaths.Vector2, childIndex As Integer, ByRef normalOut As VMaths.Vector2) As Double
		  #Pragma Unused childIndex
		  
		  Var xfq As Physics.Rot = xf.Q
		  Var centerX As Double = xfq.Cos * p.X - xfq.Sin * p.Y + xf.P.X
		  Var centerY As Double = xfq.Sin * p.X + xfq.Cos * p.Y + xf.P.Y
		  Var dx As Double = p.X - centerX
		  Var dy As Double = p.Y - centerY
		  Var d1 As Double = Sqrt(dx * dx + dy * dy)
		  normalOut.X = dx * 1 / d1
		  normalOut.Y = dy * 1 / d1
		  
		  Return d1 - radius
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeMass(massData As Physics.MassData, density As Double)
		  massData.Mass = density * Maths.PI * radius * radius
		  massData.Center.X = position.X
		  massData.Center.Y = position.Y
		  
		  // Inertia about the local origin.
		  massData.I = massData.Mass * _
		  (0.5 * radius * radius + _
		  (Position.X * Position.X + Position.Y * Position.Y))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor(Physics.ShapeType.Circle)
		  
		  Position = VMaths.Vector2.Zero
		  Radius = 0.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520737570706F7274696E672076657274657820696E64657820696E2074686520676976656E20646972656374696F6E2E
		Function GetSupport(d As VMaths.Vector2) As Integer
		  /// Get the supporting vertex index in the given direction.
		  
		  #Pragma Unused d
		  
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520737570706F7274696E672076657274657820696E2074686520676976656E20646972656374696F6E2E
		Function GetSupportVertex(d As VMaths.Vector2) As VMaths.Vector2
		  /// Get the supporting vertex in the given direction.
		  
		  #Pragma Unused d
		  
		  Return Position
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420612076657274657820627920696E6465782E
		Function GetVertex(index As Integer) As VMaths.Vector2
		  /// Get a vertex by index.
		  
		  #If DebugBuild
		    Assert(index = 0)
		  #EndIf
		  
		  Return Position
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574207468652076657274657820636F756E742E
		Function GetVertexCount() As Integer
		  /// Get the vertex count.
		  
		  Return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Raycast(output As Physics.RaycastOutput, input As Physics.RaycastInput, transform As Physics.Transform, childIndex As Integer) As Boolean
		  // Collision Detection in Interactive 3D Environments by Gino van den Bergen
		  // From Section 3.1.2
		  // x = s + a * r
		  // norm(x) = radius
		  
		  #Pragma Unused childIndex
		  
		  Var inputP1 As VMaths.Vector2 = input.P1
		  Var inputP2 As VMaths.Vector2 = input.P2
		  Var tq As Physics.Rot = transform.Q
		  Var tp As VMaths.Vector2 = transform.P
		  
		  Var positionX As Double = tq.Cos * Position.X - tq.Sin * Position.Y + tp.X
		  Var positionY As Double = tq.Sin * Position.X + tq.Cos * position.Y + tp.Y
		  
		  Var sx As Double = inputP1.X - positionX
		  Var sy As Double = inputP1.Y - positionY
		  Var b As Double = sx * sx + sy * sy - radius * radius
		  
		  // Solve quadratic equation.
		  Var rx As Double = inputP2.X - inputP1.X
		  Var ry As Double = inputP2.Y - inputP1.Y
		  Var c As Double = sx * rx + sy * ry
		  Var rr As Double = rx * rx + ry * ry
		  Var sigma As Double = c * c - rr * b
		  
		  // Check for negative discriminant and short segment.
		  If sigma < 0.0 Or rr < Physics.Settings.Epsilon Then Return False
		  
		  // Find the point of intersection of the line with the circle.
		  Var a As Double = -(c + Sqrt(sigma))
		  
		  // Is the intersection point on the segment?
		  If 0.0 <= a And a <= input.MaxFraction * rr Then
		    a = a / rr
		    output.Fraction = a
		    output.Normal.X = rx * a + sx
		    output.Normal.Y = ry * a + sy
		    output.Normal.Normalize
		    Return True
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestPoint(transform As Physics.Transform, point As VMaths.Vector2) As Boolean
		  Var q As Physics.Rot = transform.Q
		  Var tp As VMaths.Vector2 = transform.P
		  Var centerX As Double = -(q.Cos * Position.X - q.Sin * Position.Y + tp.X - point.X)
		  Var centerY As Double = -(q.Sin * Position.X + q.Cos * Position.Y + tp.Y - point.Y)
		  
		  Return centerX * centerX + centerY * centerY <= radius * radius
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Position As VMaths.Vector2
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

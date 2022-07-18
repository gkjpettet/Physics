#tag Class
 Attributes ( Abstract ) Protected Class Shape
	#tag Method, Flags = &h0, Description = 47657420746865206E756D626572206F66206368696C64207072696D6974697665732E
		Function ChildCount() As Integer
		  /// Get the number of child primitives.
		  
		  Raise New UnsupportedOperationException("This method should be overriden by subclasses.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Physics.Shape
		  Raise New UnsupportedOperationException("This method should be overriden by subclasses.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476976656E2061207472616E73666F726D2C20636F6D7075746520746865206173736F636961746564206178697320616C69676E656420626F756E64696E6720626F7820666F722061206368696C642073686170652E
		Sub ComputeAABB(aabb As Physics.AABB, xf As Physics.Transform, childIndex As Integer)
		  /// Given a transform, compute the associated axis aligned bounding box for a
		  /// child shape.
		  
		  Raise New UnsupportedOperationException("This method should be overriden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70757465207468652064697374616E63652066726F6D207468652063757272656E7420736861706520746F207468652073706563696669656420706F696E742E2052657475726E73207468652064697374616E63652066726F6D207468652063757272656E742073686170652E
		Function ComputeDistanceToOut(xf As Physics.Transform, p As VMaths.Vector2, childIndex As Integer, ByRef normalOut As VMaths.Vector2) As Double
		  /// Compute the distance from the current shape to the specified point. 
		  /// Returns the distance from the current shape.
		  ///
		  /// This only works for convex shapes.
		  ///
		  /// `xf` is the shape world transform.
		  /// `p` is a point in world coordinates.
		  /// `normalOut` returns the direction in which the distance increases.
		  
		  Raise New UnsupportedOperationException("This method should be overriden by subclasses.")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D7075746520746865206D6173732070726F70657274696573206F662074686973207368617065207573696E67206974732064696D656E73696F6E7320616E642064656E736974792E2054686520696E65727469612074656E736F7220697320636F6D70757465642061626F757420746865206C6F63616C206F726967696E2E
		Sub ComputeMass(massData As Physics.MassData, density As Double)
		  /// Compute the mass properties of this shape using its dimensions and
		  /// density. The inertia tensor is computed about the local origin.
		  ///
		  /// `density` should be in kilograms per metre squared.
		  
		  Raise New UnsupportedOperationException("This method should be overriden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  /// Private to prevent instantiation with no parameters.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(type As Physics.ShapeType)
		  /// Protected to prevent instantiation. Should still be called by subclasses.
		  
		  ShapeType = type
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4361737420612072617920616761696E73742061206368696C642073686170652E2052657475726E73205472756520696620746865206368696C64207368617065206973206869742E
		Function Raycast(output As Physics.RaycastOutput, input As Physics.RaycastInput, transform As Physics.Transform, childIndex As Integer) As Boolean
		  /// Cast a ray against a child shape. Returns True if the child shape is hit.
		  ///
		  /// `output` is the ray-cast results.
		  /// `input` the ray-cast input parameters.
		  /// `transform` to be applied to the shape.
		  /// `childIndex` the child shape index
		  
		  Raise New UnsupportedOperationException("This method should be overriden by subclasses.")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54657374206120706F696E7420666F7220636F6E7461696E6D656E7420696E20746869732073686170652E2054686973206F6E6C7920776F726B7320666F7220636F6E766578207368617065732E
		Function TestPoint(xf As Physics.Transform, point As VMaths.Vector2) As Boolean
		  /// Test a point for containment in this shape. This only works for convex shapes.
		  ///
		  /// `xf` should be the shape world transform.
		  /// `point` should be in world coordinates.
		  
		  Raise New UnsupportedOperationException("This method should be overriden by subclasses.")
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This is an abstract class and is not intended to be instantiate directly.
		Subclasses should override it's methods.
		
		A shape is used for collision detection. You can create a shape however you
		like. Shapes used for simulation in a `World` are created automatically when a
		`Fixture` is created. Shapes may encapsulate a one or more child shapes.
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		Radius As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0
		ShapeType As Physics.ShapeType
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
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

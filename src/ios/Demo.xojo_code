#tag Module
Protected Module Demo
	#tag Method, Flags = &h1, Description = 4372656174657320616E64206164647320612022626C6F622220746F2060776F726C64602E
		Protected Sub CreateBlob(world As Physics.World, circleCount As Integer, blobRadius As VMaths.Vector2, blobCenter As VMaths.Vector2)
		  /// Creates and adds a "blob" to `world`.
		  ///
		  /// A blob is a collection of circle bodies that maintain a constant volume.
		  
		  Const bodyRadius = 0.5
		  
		  // Create a joint definition for the blob.
		  Var jointDef As New Physics.ConstantVolumeJointDef
		  jointDef.FrequencyHz = 20
		  jointDef.DampingRatio = 1
		  jointDef.CollideConnected = False
		  
		  For i As Integer = 0 To circleCount - 1
		    Var angle As Double = (i / circleCount) * Maths.PI * 2
		    Var x As Double = blobCenter.X + blobRadius.X * Sin(angle)
		    Var y As Double = blobCenter.Y + blobRadius.Y * Cos(angle)
		    
		    Var bodyDef As New Physics.BodyDef(Physics.BodyType.Dynamic)
		    bodyDef.FixedRotation = True
		    bodyDef.Position = New VMaths.Vector2(x, y)
		    
		    Var body As Physics.Body = world.CreateBody(bodyDef)
		    
		    Var shape As New Physics.CircleShape
		    shape.Radius = bodyRadius
		    
		    Var fixtureDef As New Physics.FixtureDef(shape)
		    fixtureDef.Density = 1
		    fixtureDef.Friction = 0.2
		    
		    body.CreateFixture(fixtureDef)
		    jointDef.AddBody(body)
		    
		  Next i
		  
		  world.CreateJoint(New Physics.ConstantVolumeJoint(world, jointDef))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4372656174657320616E642061646473206120626F7820706F6C79676F6E20746F2074686520776F726C642061742060706F736974696F6E602E2052657475726E732074686520626F64792E
		Protected Function CreateBox(world As Physics.World, position As VMaths.Vector2, width As Double, height As Double, isStatic As Boolean = False, restitution As Double = 0.3, friction As Double = 0.5, density As Double = 1) As Physics.Body
		  /// Creates and adds a box polygon to the world at `position`. Returns the body.
		  
		  // Create a body.
		  Var type As Physics.BodyType = If(isStatic, Physics.BodyType.Static_, Physics.BodyType.Dynamic)
		  Var bodyDef As New Physics.BodyDef(type)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = world.CreateBody(bodyDef)
		  
		  // Create a box shape.
		  Var box As New Physics.PolygonShape
		  box.SetAsBoxXY(width / 2, height / 2)
		  
		  // Create and add a fixture with custom properties for the box.
		  Var fixtureDef As New Physics.FixtureDef(box)
		  fixtureDef.Density = density
		  fixtureDef.Friction = friction
		  fixtureDef.Restitution = restitution
		  body.CreateFixture(fixtureDef)
		  
		  Return body
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4372656174657320616E642061646473206120636972636C6520626F647920746F2074686520776F726C642061742060706F736974696F6E60207265747575726E696E672074686520626F64792E
		Protected Function CreateCircle(world As Physics.World, position As VMaths.Vector2, radius As Double, isStatic As Boolean = False, restitution As Double = 0.3, friction As Double = 0.5, density As Double = 1) As Physics.Body
		  /// Creates and adds a circle body to the world at `position` returning the body.
		  
		  // Create a body.
		  Var type As Physics.BodyType = If(isStatic, Physics.BodyType.Static_, Physics.BodyType.Dynamic)
		  Var bodyDef As New Physics.BodyDef(type)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = world.CreateBody(bodyDef)
		  
		  // Create a circle shape.
		  Var circle As New Physics.CircleShape
		  circle.Radius = radius
		  
		  // Create and add a fixture with custom properties for the circle.
		  Var fixtureDef As New Physics.FixtureDef(circle)
		  fixtureDef.Restitution = restitution
		  fixtureDef.Friction = friction
		  fixtureDef.Density = density
		  
		  body.CreateFixture(fixtureDef)
		  
		  Return body
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateCircleShuffler(centre As VMaths.Vector2, world As Physics.World, sceneW As Double, sceneH As Double)
		  Var ground As Physics.Body = CreateGroundAndOptionalWalls(world, sceneW, sceneH, False)
		  
		  Var bodyDef As New Physics.BodyDef
		  bodyDef.Type = Physics.BodyType.Dynamic
		  bodyDef.Position = centre
		  
		  Var body As Physics.Body = world.CreateBody(bodyDef)
		  
		  Const numPieces As Integer = 5
		  Const radius As Double = 6.5
		  
		  For i As Integer = 0 To numPieces - 1
		    Var xPos As Double = radius * Cos(2 * Maths.PI * (i / numPieces))
		    Var yPos As Double = radius * Sin(2 * Maths.PI * (i / numPieces))
		    
		    Var shape As New Physics.CircleShape
		    shape.Radius = 2
		    shape.Position.SetValues(xPos, yPos)
		    
		    Var fixtureDef As New Physics.FixtureDef(shape, Nil, 0.1, 0.9, 50.0)
		    body.CreateFixture(fixtureDef)
		  Next i
		  
		  Var revoluteJointDef As New Physics.RevoluteJointDef
		  revoluteJointDef.Initialize(body, ground, body.Position)
		  revoluteJointDef.MotorSpeed = Maths.PI
		  revoluteJointDef.MaxMotorTorque = 1000000.0
		  revoluteJointDef.EnableMotor = True
		  
		  world.CreateJoint(New Physics.RevoluteJoint(revoluteJointDef))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 437265617465732067726F756E6420616E642077616C6C20626F6469657320616E642061646473207468656D20746F2074686520776F726C642E2052657475726E73207468652067726F756E6420626F64792E
		Protected Function CreateGroundAndOptionalWalls(world As Physics.World, sceneWidth As Double, sceneHeight As Double, createWalls As Boolean = True) As Physics.Body
		  /// Creates ground and wall bodies and adds them to the world. Returns the ground body.
		  
		  Const GROUND_HEIGHT = 1
		  Const WALL_WIDTH = 1
		  
		  Var scene As Physics.DebugDraw = world.DebugDraw
		  
		  // =======================
		  // GROUND
		  // =======================
		  // Compute the position of the ground (accounting for pixels -> world space coordinates).
		  Var pos As VMaths.Vector2 = _
		  scene.ScreenXYToWorld(sceneWidth/2, sceneHeight - (GROUND_HEIGHT/2 * scene.Viewport.Scale))
		  
		  // Create the ground body.
		  Var groundBodyDef As New Physics.BodyDef
		  groundBodyDef.Position.SetFrom(pos)
		  Var ground As Physics.Body = world.CreateBody(groundBodyDef)
		  
		  // Make the ground a rectangle.
		  Var groundShape As New Physics.PolygonShape
		  groundShape.SetAsBoxXY((sceneWidth / scene.Viewport.Scale) / 2, GROUND_HEIGHT / 2)
		  
		  // Create the fixture from the shape and a modest amount of friction.
		  Var groundFixtureDef As New Physics.FixtureDef(groundShape)
		  groundFixtureDef.Friction = 0.5
		  ground.CreateFixture(groundFixtureDef)
		  
		  // =======================
		  // WALLS
		  // =======================
		  If createWalls Then
		    // Compute the position of the walls. (accounting for pixels -> world space coordinates).
		    Var lPos As VMaths.Vector2 = _
		    scene.ScreenXYToWorld(0 + (WALL_WIDTH * scene.Viewport.Scale)/2, sceneHeight / 2)
		    Var rPos As VMaths.Vector2 = _
		    scene.ScreenXYToWorld(sceneWidth - (WALL_WIDTH * scene.Viewport.Scale)/2, sceneHeight / 2)
		    
		    // Create the wall bodyies.
		    Var wallBodyDef As New Physics.BodyDef
		    wallBodyDef.Position.SetFrom(lPos)
		    Var leftWall As Physics.Body = world.CreateBody(wallBodyDef)
		    
		    wallBodyDef.Position.SetFrom(rPos)
		    Var rightWall As Physics.Body = world.CreateBody(wallBodyDef)
		    
		    // Set their shape.
		    Var wallShape As New Physics.PolygonShape
		    wallShape.SetAsBoxXY(WALL_WIDTH / 2, (sceneHeight / scene.Viewport.Scale) / 2)
		    
		    // Create the fixture from the shape and a modest amount of friction.
		    Var wallFixtureDef As New Physics.FixtureDef(wallShape)
		    wallFixtureDef.Friction = 0.3
		    leftWall.CreateFixture(wallFixtureDef)
		    rightWall.CreateFixture(wallFixtureDef)
		  End If
		  
		  Return ground
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4372656174657320616E642061646473206120706F6C79676F6E20636F6D707269736564206F66206076657274696365736020746F2074686520776F726C642061742060706F736974696F6E602E2052657475726E732074686520626F64792E
		Protected Function CreatePolygon(world As Physics.World, position As VMaths.Vector2, vertices() As VMaths.Vector2, isStatic As Boolean = False, restitution As Double = 0.3, friction As Double = 0.5, density As Double = 1) As Physics.Body
		  /// Creates and adds a polygon comprised of `vertices` to the world at `position`.
		  /// Returns the body.
		  ///
		  /// `vertices` will be copied.
		  
		  // Create a body.
		  Var type As Physics.BodyType = If(isStatic, Physics.BodyType.Static_, Physics.BodyType.Dynamic)
		  Var bodyDef As New Physics.BodyDef(type)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = world.CreateBody(bodyDef)
		  
		  // Create the polygon shape.
		  Var poly As New Physics.PolygonShape
		  poly.Set(vertices)
		  
		  // Create and add a fixture with custom properties for the box.
		  Var fixtureDef As New Physics.FixtureDef(poly)
		  fixtureDef.Density = density
		  fixtureDef.Friction = friction
		  fixtureDef.Restitution = restitution
		  body.CreateFixture(fixtureDef)
		  
		  Return body
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateSwingingBoxPair(world As Physics.World, staticBoxX As Double, staticBoxY As Double, staticBoxSize As Double, swingingBoxX As Double, swingingBoxY As Double, swingingBoxSize As Double)
		  /// Creates and adds two box bodies (one static) linked via a distance joint.
		  
		  Var staticBox As Physics.Body = _
		  CreateBox(World, New VMaths.Vector2(staticBoxX, staticBoxY), _
		  staticBoxSize, staticBoxSize, True)
		  
		  Var swingingBox As Physics.Body = _
		  CreateBox(World, New VMaths.Vector2(swingingBoxX, swingingBoxY), _
		  swingingBoxSize, swingingBoxSize)
		  
		  Var jointDef As New Physics.DistanceJointDef
		  Var staticBoxAnchor As New VMaths.Vector2(staticBoxX - (staticBoxSize/2), staticBoxY - (staticBoxSize/2))
		  Var swingingBoxAnchor As New VMaths.Vector2(swingingBoxX - (swingingBoxSize/2), swingingBoxY - (swingingBoxSize/2))
		  jointDef.Initialize(staticBox, swingingBox, staticBoxAnchor, swingingBoxAnchor)
		  
		  world.CreateJoint(New Physics.DistanceJoint(jointdef))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(Extends type As Demo.Types) As String
		  Select Case type
		  Case Demo.Types.CirclesAndBoxes
		    Return "Circles and Boxes"
		    
		  Case Demo.Types.ClickToAddRandomBodies
		    Return "Click To Add"
		    
		  Case Demo.Types.ConstantVolumeJoint
		    Return "Constant Volume Joint"
		    
		  Case Demo.Types.DistanceJoints
		    Return "Distance Joints"
		    
		  Case Demo.Types.PrismaticJoint
		    Return "Prismatic Joint"
		    
		  Case Demo.Types.RevoluteJoint
		    Return "Revolute Joint"
		    
		  Case Demo.Types.VariousShapes
		    Return "Various Shapes"
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown demo type.")
		  End Select
		  
		End Function
	#tag EndMethod


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		DistanceJoints
		  RevoluteJoint
		  VariousShapes
		  CirclesAndBoxes
		  ConstantVolumeJoint
		  ClickToAddRandomBodies
		PrismaticJoint
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

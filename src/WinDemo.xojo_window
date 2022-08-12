#tag DesktopWindow
Begin DesktopWindow WinDemo
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   800
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Untitled"
   Type            =   0
   Visible         =   True
   Width           =   1400
   Begin Physics.DebugCanvas Scene
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   800
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      SceneBackgroundColor=   &cFFFFFF00
      Scope           =   1
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1400
   End
   Begin Timer WorldUpdateTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   33
      RunMode         =   2
      Scope           =   0
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  'DemoCirclesAndBoxes
		  DemoImpulseEngineReplica
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 4372656174657320616E642061646473206120626F7820706F6C79676F6E20746F2074686520776F726C642061742060706F736974696F6E602E
		Private Sub CreateBox(position As VMaths.Vector2, width As Double, height As Double, isStatic As Boolean = False)
		  /// Creates and adds a box polygon to the world at `position`.
		  
		  // Create a body.
		  Var type As Physics.BodyType = If(isStatic, Physics.BodyType.Static_, Physics.BodyType.Dynamic)
		  Var bodyDef As New Physics.BodyDef(type)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = World.CreateBody(bodyDef)
		  
		  // Create a box shape.
		  Var box As New Physics.PolygonShape
		  box.SetAsBoxXY(width / 2, height / 2)
		  
		  // Create and add a fixture with custom properties for the box.
		  Var fixtureDef As New Physics.FixtureDef(box)
		  fixtureDef.Density = 1
		  fixtureDef.Friction = 0.5
		  fixtureDef.Restitution = 0.3
		  body.CreateFixture(fixtureDef)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174657320616E642061646473206120636972636C6520626F647920746F2074686520776F726C642061742060706F736974696F6E602E
		Private Sub CreateCircle(position As VMaths.Vector2, radius As Double, isStatic As Boolean = False, restitution As Double = 0.4)
		  /// Creates and adds a circle body to the world at `position`.
		  
		  // Create a body.
		  Var type As Physics.BodyType = If(isStatic, Physics.BodyType.Static_, Physics.BodyType.Dynamic)
		  Var bodyDef As New Physics.BodyDef(type)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = World.CreateBody(bodyDef)
		  
		  // Create a circle shape.
		  Var circle As New Physics.CircleShape
		  circle.Radius = radius
		  
		  // Create and add a fixture with custom properties for the circle.
		  Var fixtureDef As New Physics.FixtureDef(circle)
		  fixtureDef.Density = 1
		  fixtureDef.Friction = 0.5
		  fixtureDef.Restitution = restitution
		  body.CreateFixture(fixtureDef)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 437265617465732067726F756E6420616E642077616C6C20626F6469657320616E642061646473207468656D20746F2074686520776F726C642E
		Private Sub CreateGroundAndWalls()
		  /// Creates ground and wall bodies and adds them to the world.
		  
		  Const GROUND_HEIGHT = 1
		  Const WALL_WIDTH = 1
		  
		  // =======================
		  // GROUND
		  // =======================
		  // Compute the position of the ground (accounting for pixels -> world space coordinates).
		  Var pos As VMaths.Vector2 = _
		  Scene.ScreenXYToWorld(Scene.Width/2, Scene.Height - (GROUND_HEIGHT * Scene.Viewport.Scale))
		  
		  // Create the ground body.
		  Var groundBodyDef As New Physics.BodyDef
		  groundBodyDef.Position.SetFrom(pos)
		  GroundBody = World.CreateBody(groundBodyDef)
		  
		  // Make the ground a rectangle.
		  Var groundShape As New Physics.PolygonShape
		  groundShape.SetAsBoxXY((Scene.Width / Scene.Viewport.Scale) / 2, GROUND_HEIGHT)
		  
		  // Create the fixture from the shape and a modest amount of friction.
		  Var groundFixtureDef As New Physics.FixtureDef(groundShape)
		  groundFixtureDef.Friction = 0.5
		  GroundBody.CreateFixture(groundFixtureDef)
		  
		  // =======================
		  // WALLS
		  // =======================
		  // Compute the position of the walls. (accounting for pixels -> world space coordinates).
		  Var lPos As VMaths.Vector2 = _
		  Scene.ScreenXYToWorld(0 + (WALL_WIDTH * Scene.Viewport.Scale)/2, Scene.Height / 2)
		  Var rPos As VMaths.Vector2 = _
		  Scene.ScreenXYToWorld(Scene.Width - (WALL_WIDTH * Scene.Viewport.Scale)/2, Scene.Height / 2)
		  
		  // Create the wall bodyies.
		  Var wallBodyDef As New Physics.BodyDef
		  wallBodyDef.Position.SetFrom(lPos)
		  Var leftWallBody As Physics.Body = World.CreateBody(wallBodyDef)
		  
		  wallBodyDef.Position.SetFrom(rPos)
		  Var rightWallBody As Physics.Body = World.CreateBody(wallBodyDef)
		  
		  // Set their shape.
		  Var wallShape As New Physics.PolygonShape
		  wallShape.SetAsBoxXY(WALL_WIDTH / 2, (Scene.Height / Scene.Viewport.Scale) / 2)
		  
		  // Create the fixture from the shape and a modest amount of friction.
		  Var wallFixtureDef As New Physics.FixtureDef(wallShape)
		  wallFixtureDef.Friction = 0.3
		  leftWallBody.CreateFixture(wallFixtureDef)
		  rightWallBody.CreateFixture(wallFixtureDef)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174657320616E642061646473206120706F6C79676F6E20636F6D707269736564206F662060706F696E74736020746F2074686520776F726C642061742060706F736974696F6E602E
		Private Sub CreatePolygon(position As VMaths.Vector2, vertices() As VMaths.Vector2, isStatic As Boolean = False)
		  /// Creates and adds a polygon comprised of `vertices` to the world at `position`.
		  /// `vertices` will be copied.
		  
		  // Create a body.
		  Var type As Physics.BodyType = If(isStatic, Physics.BodyType.Static_, Physics.BodyType.Dynamic)
		  Var bodyDef As New Physics.BodyDef(type)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = World.CreateBody(bodyDef)
		  
		  // Create the polygon shape.
		  Var poly As New Physics.PolygonShape
		  poly.Set(vertices)
		  ' For Each v As VMaths.Vector2 In vertices
		  ' poly.Vertices.Add(v.Clone)
		  ' Next v
		  
		  // Create and add a fixture with custom properties for the box.
		  Var fixtureDef As New Physics.FixtureDef(poly)
		  fixtureDef.Density = 1
		  fixtureDef.Friction = 0.5
		  fixtureDef.Restitution = 0.3
		  body.CreateFixture(fixtureDef)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DemoCirclesAndBoxes()
		  SetupWorldAndScene
		  
		  // Create the ground and two walls.
		  CreateGroundAndWalls
		  
		  // Figure out the limits of where to randomise the bodies in world space.
		  Var minX As Double = Scene.ScreenXYToWorld(0, 0).X
		  Var maxX As Double = Scene.ScreenXYToWorld(Scene.Width, 0).X
		  Var minY As Double = Scene.ScreenXYToWorld(0, 0).Y
		  Var maxY As Double = Scene.ScreenXYToWorld(0, Scene.Height).Y - 5 // Allow for ground height.
		  
		  // Create some circles in random locations and apply a random impulse to each one.
		  For i As Integer = 0 To 19
		    Var pos As VMaths.Vector2 = RandomVector2(minX, maxX, minY, maxY)
		    Var radius As Double = System.Random.InRange(5, 30)/10
		    CreateCircle(pos, radius)
		    World.Bodies(World.Bodies.LastIndex).ApplyLinearImpulse(RandomVector2(1, 10, 1, 10))
		  Next i
		  
		  // Create some boxes in random locations and apply a random impulse to each one.
		  For i As Integer = 0 To 19
		    Var pos As VMaths.Vector2 = RandomVector2(minX, maxX, minY, maxY)
		    Var w As Double = System.Random.InRange(5, 60)/10
		    Var h As Double = System.Random.InRange(5, 60)/10
		    CreateBox(pos, w, h)
		    World.Bodies(World.Bodies.LastIndex).ApplyLinearImpulse(RandomVector2(1, 10, 1, 10))
		  Next i
		  
		  // Start updating.
		  WorldUpdateTimer.Enabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DemoImpulseEngineReplica()
		  SetupWorldAndScene
		  
		  CreateGroundAndWalls
		  
		  // Static central circle.
		  CreateCircle(VMaths.Vector2.Zero, 5, True)
		  
		  // Triangle.
		  Var triangleVertices() As VMaths.Vector2 = Array( _
		  New VMaths.Vector2(0, 0), _
		  New VMaths.Vector2(27, 0), _
		  New VMaths.Vector2(27, 12))
		  CreatePolygon( _
		  New VMaths.Vector2(GroundBody.Position.X - 22, GroundBody.Position.Y + 1), _
		  triangleVertices, True)
		  
		  // Bouncy circle.
		  CreateCircle(New VMaths.Vector2(-1, 35), 1.7, False, 0.8)
		  
		  // Add some other circles.
		  CreateCircle(New VMaths.Vector2(1, 25), 2)
		  CreateCircle(New VMaths.Vector2(35, 20), 3.5)
		  CreateCircle(New VMaths.Vector2(50, 20), 2)
		  CreateCircle(New VMaths.Vector2(-6, 26), 2)
		  CreateCircle(New VMaths.Vector2(-8, 34), 3)
		  CreateCircle(New VMaths.Vector2(-60, 32), 2.6)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732061206E657720566563746F72322077686F736520605860206973205B6D696E582C206D6178585D20616E642077686F736520605960206973205B6D696E592C206D6178595D2E
		Private Function RandomVector2(minX As Integer, maxX As Integer, minY As Integer, maxY As Integer) As VMaths.Vector2
		  /// Returns a new Vector2 whose `X` is [minX, maxX] and whose `Y` is [minY, maxY].
		  
		  Return New VMaths.Vector2( _
		  System.Random.InRange(minX, maxX), System.Random.InRange(minY, maxY))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupWorldAndScene()
		  // Setup the viewport for the canvas.
		  Const VIEWPORT_SCALE = 10
		  Var extents As New VMaths.Vector2(Scene.Width / 2, Scene.Height / 2)
		  Scene.Viewport = New Physics.ViewportTransform(extents, extents, VIEWPORT_SCALE)
		  
		  // Draw the centre of mass for debugging.
		  Scene.DrawCenterOfMass = True
		  Scene.DrawWireframes = True
		  
		  // Create a world with normal gravity.
		  Var gravity As New VMaths.Vector2(0, -10)
		  World = New Physics.World(gravity)
		  
		  // Assign the debug drawing canvas to the world.
		  World.DebugDraw = Scene
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F207468652067726F756E6420626F64792028666F7220636F6E76656E69656E6365292E
		GroundBody As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


#tag EndWindowCode

#tag Events WorldUpdateTimer
	#tag Event
		Sub Action()
		  // fps = 1/dt
		  Var dt As Double = Me.Period / 1000
		  
		  // Step the physics simulation.
		  World.StepDt(dt)
		  
		  // Draw the world to its internal buffer and time how long it takes.
		  Var drawTimer As New Physics.Timer
		  World.DrawDebugData
		  drawTimer.Stop
		  
		  // Draw the timing stats in the top left corner.
		  World.DebugDraw.DrawStringXY(20, 20, _
		  "Step Time: " + World.Profile.Step_.ToString, Color.Black)
		  
		  World.DebugDraw.DrawStringXY(20, 35, _
		  "Draw Time: " + _
		  drawTimer.ElapsedMilliseconds.ToString(Locale.Current, "#.#") + " ms", _
		  Color.Black)
		  
		  World.DebugDraw.DrawStringXY(20, 50, _
		  "Bodies: " + World.Bodies.Count.ToString, Color.Black)
		  
		  Var frameTime As Double = World.Profile.Step_.LongAvg + drawTimer.ElapsedMilliseconds
		  Var fps As Integer = 1000 / frameTime
		  World.DebugDraw.DrawStringXY(20, 65, _
		  "Frame Time: " + _
		  frameTime.ToString(Locale.Current, "#.#") + " ms " + _
		  fps.ToString + " fps", _
		  Color.Black)
		  
		  // Tell the debug canvas to paint.
		  Scene.Refresh
		  
		End Sub
	#tag EndEvent
#tag EndEvents

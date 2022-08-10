#tag DesktopWindow
Begin DesktopWindow Window1
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
   Height          =   788
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1821124607
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Untitled"
   Type            =   0
   Visible         =   True
   Width           =   1038
   Begin Physics.DebugCanvas Scene
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   788
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
      Width           =   1038
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
		  // Setup the debug drawing canvas for the world.
		  Const viewportScale = 10
		  Var extents As New VMaths.Vector2(Scene.Width / 2, Scene.Height / 2)
		  Scene.Viewport = New Physics.ViewportTransform(extents, extents, viewportScale)
		  
		  'Scene.DrawWireframes = True
		  Scene.DrawCenterOfMass = True
		  
		  // Create a world.
		  Var gravity As New VMaths.Vector2(0, -10)
		  World = New Physics.World(gravity)
		  
		  // Assign the debug drawing canvas to the world.
		  World.DebugDraw = Scene
		  
		  // Create and add the ground.
		  CreateGround
		  
		  ' CreateCircle(New VMaths.Vector2(0, 0), 0.5)
		  ' CreateCircle(New VMaths.Vector2(2.5, 10), 0.5)
		  ' CreateCircle(New VMaths.Vector2(10, 0), 1)
		  
		  Var xMin As Double = Scene.ScreenXYToWorld(0, 0).X
		  Var xMax As Double = Scene.ScreenXYToWorld(Scene.Width, 0).X
		  Var yMin As Double = Scene.ScreenXYToWorld(0, 0).Y
		  Var yMax As Double = Scene.ScreenXYToWorld(0, Scene.Height).Y - 5 // Allow for ground height.
		  
		  // Create some circles.
		  For i As Integer = 0 To 9
		    Var pos As New VMaths.Vector2(System.Random.InRange(xMin, xMax), _
		    System.Random.InRange(yMin, yMax))
		    CreateCircle(pos, System.Random.InRange(5, 30)/10) ' /10 as InRange takes an integer.
		  Next i
		  
		  // Create some boxes.
		  For i As Integer = 0 To 9
		    Var pos As New VMaths.Vector2(System.Random.InRange(xMin, xMax), _
		    System.Random.InRange(yMin, yMax))
		    CreateBox(pos, System.Random.InRange(5, 60)/10, System.Random.InRange(5, 60)/10)
		  Next i
		  
		  WorldUpdateTimer.Enabled = True
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 4372656174657320616E642061646473206120636972636C6520626F647920746F2074686520776F726C642061742060706F736974696F6E602E
		Private Sub CreateBox(position As VMaths.Vector2, width As Double, height As Double)
		  /// Creates and adds a circle body to the world at `position`.
		  
		  // Create a dynamic body.
		  Var bodyDef As New Physics.BodyDef(Physics.BodyType.Dynamic)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = World.CreateBody(bodyDef)
		  
		  // Create a box shape.
		  Var box As New Physics.PolygonShape
		  box.SetAsBoxXY(width / 2, height / 2)
		  
		  // Create and add a fixture with custom properties for the box.
		  Var fixtureDef As New Physics.FixtureDef(box)
		  fixtureDef.Density = 1
		  fixtureDef.Friction = 0.7
		  fixtureDef.Restitution = 0.3
		  Call body.CreateFixture(fixtureDef)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174657320616E642061646473206120636972636C6520626F647920746F2074686520776F726C642061742060706F736974696F6E602E
		Private Sub CreateCircle(position As VMaths.Vector2, radius As Double)
		  /// Creates and adds a circle body to the world at `position`.
		  
		  // Create a dynamic body.
		  Var bodyDef As New Physics.BodyDef(Physics.BodyType.Dynamic)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = World.CreateBody(bodyDef)
		  
		  // Create a circle shape.
		  Var circle As New Physics.CircleShape
		  circle.Radius = radius
		  
		  // Create and add a fixture with custom properties for the circle.
		  Var fixtureDef As New Physics.FixtureDef(circle)
		  fixtureDef.Density = 1
		  fixtureDef.Friction = 0.7
		  fixtureDef.Restitution = 0.3
		  Call body.CreateFixture(fixtureDef)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174657320612067726F756E6420626F647920616E64206164647320697420746F2060776F726C64602E
		Private Sub CreateGround()
		  /// Creates a ground body and adds it to `world`.
		  
		  Var groundHeight As Double = 1
		  
		  Var pos As VMaths.Vector2 = _
		  Scene.ScreenXYToWorld(Scene.Width/2, Scene.Height - (groundHeight * Scene.Viewport.Scale))
		  
		  // Create the ground body.
		  Var groundBodyDef As New Physics.BodyDef
		  groundBodyDef.Position.SetFrom(pos)
		  Var groundBody As Physics.Body = World.CreateBody(groundBodyDef)
		  
		  // Set the ground's shape and attach it as a fixture.
		  Var groundBox As New Physics.PolygonShape
		  groundBox.SetAsBoxXY((Scene.Width / Scene.Viewport.Scale) / 2, groundHeight)
		  Call groundBody.CreateFixtureFromShape(groundBox, 0)
		  groundBody.Fixtures(0).Friction = 1
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


#tag EndWindowCode

#tag Events Scene
#tag EndEvents
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
		  
		  World.DebugDraw.DrawStringXY(20, 40, _
		  "Draw Time: " + _
		  drawTimer.ElapsedMilliseconds.ToString(Locale.Current, "#.#") + " ms", _
		  Color.Black)
		  
		  World.DebugDraw.DrawStringXY(20, 60, _
		  "Bodies: " + World.Bodies.Count.ToString, Color.Black)
		  
		  // Tell the debug canvas to paint.
		  Scene.Refresh
		  
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Windows Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior

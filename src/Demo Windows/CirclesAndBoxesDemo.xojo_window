#tag DesktopWindow
Begin DesktopWindow CirclesAndBoxesDemo
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
   Height          =   700
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Circle And Boxes Demo"
   Type            =   0
   Visible         =   True
   Width           =   1280
   Begin Physics.DebugCanvas Scene
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DrawAABB        =   False
      DrawCenterOfMass=   False
      DrawDynamicTree =   False
      DrawJoints      =   False
      DrawPairs       =   False
      DrawShapes      =   False
      DrawWireframes  =   False
      Enabled         =   True
      Height          =   648
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
      Width           =   1280
   End
   Begin DesktopButton ButtonStart
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Start"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   1180
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton ButtonReset
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Reset"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   1088
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel LabelTiming
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   11.0
      FontUnit        =   0
      Height          =   40
      Index           =   -2147483648
      Italic          =   False
      Left            =   10
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   655
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   370
   End
   Begin Timer WorldUpdateTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   33
      RunMode         =   0
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin DesktopCheckBox CheckBoxCentreOfMass
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Centre of Mass"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   950
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   126
   End
   Begin DesktopCheckBox CheckBoxWireframes
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Wireframes"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   834
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   104
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h1, Description = 4372656174657320616E642061646473206120626F7820706F6C79676F6E20746F2074686520776F726C642061742060706F736974696F6E602E2052657475726E732074686520626F64792E
		Protected Function CreateBox(position As VMaths.Vector2, width As Double, height As Double, isStatic As Boolean = False, restitution As Double = 0.3, friction As Double = 0.5, density As Double = 1) As Physics.Body
		  /// Creates and adds a box polygon to the world at `position`. Returns the body.
		  
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
		  fixtureDef.Density = density
		  fixtureDef.Friction = friction
		  fixtureDef.Restitution = restitution
		  body.CreateFixture(fixtureDef)
		  
		  Return body
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4372656174657320616E642061646473206120636972636C6520626F647920746F2074686520776F726C642061742060706F736974696F6E60207265747575726E696E672074686520626F64792E
		Protected Function CreateCircle(position As VMaths.Vector2, radius As Double, isStatic As Boolean = False, restitution As Double = 0.3, friction As Double = 0.5, density As Double = 1) As Physics.Body
		  /// Creates and adds a circle body to the world at `position` retuurning the body.
		  
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
		  fixtureDef.Restitution = restitution
		  fixtureDef.Friction = friction
		  fixtureDef.Density = density
		  
		  body.CreateFixture(fixtureDef)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 437265617465732067726F756E6420616E642077616C6C20626F6469657320616E642061646473207468656D20746F2074686520776F726C642E
		Protected Sub CreateGroundAndWalls()
		  /// Creates ground and wall bodies and adds them to the world.
		  
		  Const GROUND_HEIGHT = 1
		  Const WALL_WIDTH = 1
		  
		  // =======================
		  // GROUND
		  // =======================
		  // Compute the position of the ground (accounting for pixels -> world space coordinates).
		  Var pos As VMaths.Vector2 = _
		  Scene.ScreenXYToWorld(Scene.Width/2, Scene.Height - (GROUND_HEIGHT/2 * Scene.Viewport.Scale))
		  
		  // Create the ground body.
		  Var groundBodyDef As New Physics.BodyDef
		  groundBodyDef.Position.SetFrom(pos)
		  Ground = World.CreateBody(groundBodyDef)
		  
		  // Make the ground a rectangle.
		  Var groundShape As New Physics.PolygonShape
		  groundShape.SetAsBoxXY((Scene.Width / Scene.Viewport.Scale) / 2, GROUND_HEIGHT / 2)
		  
		  // Create the fixture from the shape and a modest amount of friction.
		  Var groundFixtureDef As New Physics.FixtureDef(groundShape)
		  groundFixtureDef.Friction = 0.5
		  Ground.CreateFixture(groundFixtureDef)
		  
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
		  LeftWall = World.CreateBody(wallBodyDef)
		  
		  wallBodyDef.Position.SetFrom(rPos)
		  RightWall = World.CreateBody(wallBodyDef)
		  
		  // Set their shape.
		  Var wallShape As New Physics.PolygonShape
		  wallShape.SetAsBoxXY(WALL_WIDTH / 2, (Scene.Height / Scene.Viewport.Scale) / 2)
		  
		  // Create the fixture from the shape and a modest amount of friction.
		  Var wallFixtureDef As New Physics.FixtureDef(wallShape)
		  wallFixtureDef.Friction = 0.3
		  LeftWall.CreateFixture(wallFixtureDef)
		  RightWall.CreateFixture(wallFixtureDef)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4372656174657320616E642061646473206120706F6C79676F6E20636F6D707269736564206F66206076657274696365736020746F2074686520776F726C642061742060706F736974696F6E602E2052657475726E732074686520626F64792E
		Protected Function CreatePolygon(position As VMaths.Vector2, vertices() As VMaths.Vector2, isStatic As Boolean = False, restitution As Double = 0.3, friction As Double = 0.5, density As Double = 1) As Physics.Body
		  /// Creates and adds a polygon comprised of `vertices` to the world at `position`.
		  /// Returns the body.
		  ///
		  /// `vertices` will be copied.
		  
		  // Create a body.
		  Var type As Physics.BodyType = If(isStatic, Physics.BodyType.Static_, Physics.BodyType.Dynamic)
		  Var bodyDef As New Physics.BodyDef(type)
		  bodyDef.Position.SetValues(position.X, position.Y)
		  Var body As Physics.Body = World.CreateBody(bodyDef)
		  
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
		Protected Sub CreateSimulation()
		  InitialiseWorldAndScene
		  
		  // Create the ground and two walls.
		  CreateGroundAndWalls
		  
		  // Figure out the limits of where to randomise the bodies in world space.
		  Var minX As Double = Scene.ScreenXYToWorld(0, 0).X
		  Var maxX As Double = Scene.ScreenXYToWorld(Scene.Width, 0).X
		  Var minY As Double = Scene.ScreenXYToWorld(0, 0).Y
		  Var maxY As Double = Scene.ScreenXYToWorld(0, Scene.Height).Y - 5 // Allow for ground height.
		  
		  // Create some circles in random locations and apply a random impulse to each one.
		  For i As Integer = 0 To 19
		    Var pos As VMaths.Vector2 = VMaths.Vector2.RandomInRange(minX, maxX, minY, maxY)
		    Var radius As Double = System.Random.InRange(5, 30)/10
		    Call CreateCircle(pos, radius)
		    World.Bodies(World.Bodies.LastIndex).ApplyLinearImpulse(VMaths.Vector2.RandomInRange(1, 10, 1, 10))
		  Next i
		  
		  // Create some boxes in random locations and apply a random impulse to each one.
		  For i As Integer = 0 To 19
		    Var pos As VMaths.Vector2 = VMaths.Vector2.RandomInRange(minX, maxX, minY, maxY)
		    Var w As Double = System.Random.InRange(5, 60)/10
		    Var h As Double = System.Random.InRange(5, 60)/10
		    Call CreateBox(pos, w, h)
		    World.Bodies(World.Bodies.LastIndex).ApplyLinearImpulse(VMaths.Vector2.RandomInRange(1, 10, 1, 10))
		  Next i
		  
		  // Start updating.
		  WorldUpdateTimer.Enabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InitialiseWorldAndScene()
		  // Setup the viewport for the canvas.
		  Var extents As New VMaths.Vector2(Scene.Width / 2, Scene.Height / 2)
		  Scene.Viewport = New Physics.ViewportTransform(extents, extents, VIEWPORT_SCALE)
		  
		  // Draw the centre of mass for debugging.
		  Scene.DrawShapes = True
		  Scene.DrawCenterOfMass = CheckBoxCentreOfMass.Value
		  Scene.DrawWireframes = CheckBoxWireframes.Value
		  
		  // Create a world with normal gravity.
		  Var gravity As New VMaths.Vector2(0, -10)
		  World = New Physics.World(gravity)
		  
		  // Reset any bodies from previous runs.
		  Ground = Nil
		  LeftWall = Nil
		  RightWall = Nil
		  
		  // Assign the debug drawing canvas to the world.
		  World.DebugDraw = Scene
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F207468652067726F756E6420626F64792028666F7220636F6E76656E69656E6365292E
		Ground As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F20746865206C6566742077616C6C20626F64792028666F7220636F6E76656E69656E6365292E
		LeftWall As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F207468652072696768742077616C6C20626F64792028666F7220636F6E76656E69656E6365292E
		RightWall As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


	#tag Constant, Name = VIEWPORT_SCALE, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events ButtonStart
	#tag Event
		Sub Pressed()
		  Select Case Me.Caption
		  Case "Start"
		    // Start the simulation.
		    CreateSimulation
		    WorldUpdateTimer.Enabled = True
		    WorldUpdateTimer.RunMode = Timer.RunModes.Multiple
		    Me.Caption = "Pause"
		    
		  Case "Resume"
		    // Resume a paused simulation.
		    WorldUpdateTimer.RunMode = Timer.RunModes.Multiple
		    WorldUpdateTimer.Enabled = True
		    Me.Caption = "Pause"
		    
		  Case "Pause"
		    // Pause a running simulation.
		    WorldUpdateTimer.Enabled = False
		    Me.Caption = "Resume"
		    
		  End Select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonReset
	#tag Event
		Sub Pressed()
		  WorldUpdateTimer.Enabled = False
		  
		  InitialiseWorldAndScene
		  Scene.Refresh
		  
		  ButtonStart.Caption = "Start"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LabelTiming
	#tag Event
		Sub Opening()
		  // Use a monospace font.
		  #If TargetMacOS
		    Me.FontName = "Menlo"
		    
		  #ElseIf TargetWindows
		    Me.FontName = "Consolas"
		    
		  #ElseIf TargetLinux
		    Me.FontName = "DejaVu Sans Mono"
		  #EndIf
		End Sub
	#tag EndEvent
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
		  
		  // Update the timing stats.
		  LabelTiming.Text = _
		  "Step Time: " + World.Profile.Step_.ToString + EndOfLine + _
		  "Draw Time: " + drawTimer.ElapsedMilliseconds.ToString(Locale.Current, "#.#") + " ms" + EndOfLine + _
		  "      FPS: ?"
		  
		  // Tell the scene to paint.
		  Scene.Refresh
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxCentreOfMass
	#tag Event
		Sub ValueChanged()
		  Scene.DrawCenterOfMass = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxWireframes
	#tag Event
		Sub ValueChanged()
		  Scene.DrawWireframes = Me.Value
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

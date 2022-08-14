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
   Title           =   "Xojo Physics Demo"
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
      LockRight       =   True
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
   Begin DesktopCheckBox CheckBoxJoints
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Joints"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   746
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   76
   End
   Begin DesktopCheckBox CheckBoxAABBs
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "AABBs"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   658
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   76
   End
   Begin DesktopPopupMenu PopupDemos
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   392
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   254
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  mAllowRunning = True
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub CreateSimulation()
		  InitialiseWorldAndScene
		  
		  Select Case PopupDemos.RowTagAt(PopupDemos.SelectedRowIndex)
		  Case Demo.Types.DistanceJoints
		    DemoDistanceJoints
		    
		  Case Demo.Types.RevoluteJoint
		    DemoRevoluteJoint
		    
		  Case Demo.Types.CirclesAndBoxes
		    DemoCirclesAndBoxes
		    
		  Case Demo.Types.VariousShapes
		    DemoVariousShapes
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown demo type.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20776974682072616E646F6D206D6F76696E6720626F78657320616E6420636972636C65732E
		Sub DemoCirclesAndBoxes()
		  /// Configure the simulation with random moving boxes and circles.
		  
		  // Create the ground and two walls.
		  Call Demo.CreateGroundAndOptionalWalls(world, Scene.Width, Scene.Height)
		  
		  // Figure out the limits of where to randomise the bodies in world space.
		  Var minX As Double = Scene.ScreenXYToWorld(0, 0).X
		  Var maxX As Double = Scene.ScreenXYToWorld(Scene.Width, 0).X
		  Var minY As Double = Scene.ScreenXYToWorld(0, 0).Y
		  Var maxY As Double = Scene.ScreenXYToWorld(0, Scene.Height).Y - 5 // Allow for ground height.
		  
		  // Create some circles in random locations and apply a random impulse to each one.
		  For i As Integer = 0 To 19
		    Var pos As VMaths.Vector2 = VMaths.Vector2.RandomInRange(minX, maxX, minY, maxY)
		    Var radius As Double = System.Random.InRange(5, 30)/10
		    Call Demo.CreateCircle(World, pos, radius)
		    World.Bodies(World.Bodies.LastIndex).ApplyLinearImpulse(VMaths.Vector2.RandomInRange(1, 10, 1, 10))
		  Next i
		  
		  // Create some boxes in random locations and apply a random impulse to each one.
		  For i As Integer = 0 To 19
		    Var pos As VMaths.Vector2 = VMaths.Vector2.RandomInRange(minX, maxX, minY, maxY)
		    Var w As Double = System.Random.InRange(5, 60)/10
		    Var h As Double = System.Random.InRange(5, 60)/10
		    Call Demo.CreateBox(World, pos, w, h)
		    World.Bodies(World.Bodies.LastIndex).ApplyLinearImpulse(VMaths.Vector2.RandomInRange(1, 10, 1, 10))
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20666F72207468652064697374616E6365206A6F696E742064656D6F2E
		Sub DemoDistanceJoints()
		  /// Configure the simulation for the distance joint demo.
		  
		  InitialiseWorldAndScene
		  
		  Const BOX_SIZE = 7.0
		  
		  // Create three swinging box pairs.
		  // Left.
		  Var leftStaticX As Double = -3 * BOX_SIZE
		  Demo.CreateSwingingBoxPair(World, leftStaticX, 0, BOX_SIZE, leftStaticX - 14, -5, BOX_SIZE)
		  
		  // Centre.
		  Demo.CreateSwingingBoxPair(World, 0, 0, BOX_SIZE, -10, -5, BOX_SIZE)
		  
		  // Right.
		  Var rightStaticX As Double = 3 * BOX_SIZE
		  Demo.CreateSwingingBoxPair(World, rightStaticX, 0, BOX_SIZE, rightStaticX + 8, -5, BOX_SIZE)
		  
		  // Ensure the joints are drawn by default.
		  CheckBoxJoints.Value = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20666F7220746865207265766F6C757465206A6F696E742064656D6F2E
		Sub DemoRevoluteJoint()
		  /// Configure the simulation for the revolute joint demo.
		  
		  InitialiseWorldAndScene
		  
		  Demo.CreateCircleShuffler(New VMaths.Vector2(0, -15), World, Scene.Width, Scene.Height)
		  
		  Const numBalls As Integer = 30
		  For i As Integer = 1 To numBalls
		    Call Demo.CreateCircle(world, VMaths.Vector2.RandomInRange(-7, 7, 20, 30), 1)
		  Next i
		  
		  // Don't draw the joints by default.
		  CheckBoxJoints.Value = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E207769746820766172696F757320626F64696573206F6620646966666572656E742073686170657320616E642073697A65732E
		Sub DemoVariousShapes()
		  /// Configure the simulation with various bodies of different shapes and sizes.
		  ///
		  /// Mimics my old ImpulseEngine demo.
		  
		  InitialiseWorldAndScene
		  
		  Var ground As Physics.Body = Demo.CreateGroundAndOptionalWalls(World, Scene.Width, Scene.Height)
		  
		  // Static central circle.
		  Call Demo.CreateCircle(World, VMaths.Vector2.Zero, 5, True)
		  
		  // Triangle.
		  Var triangleVertices() As VMaths.Vector2 = Array( _
		  New VMaths.Vector2(0, 0), _
		  New VMaths.Vector2(27, 0), _
		  New VMaths.Vector2(27, 12))
		  Call Demo.CreatePolygon(World, _
		  New VMaths.Vector2(ground.Position.X - 22, ground.Position.Y + 1), _
		  triangleVertices, True)
		  
		  // Bouncy circle.
		  Call Demo.CreateCircle(World, New VMaths.Vector2(-1, 35), 1.7, False, 0.8)
		  
		  // Add some other circles.
		  Call Demo.CreateCircle(World, New VMaths.Vector2(1, 25), 2)
		  Call Demo.CreateCircle(World, New VMaths.Vector2(35, 20), 3.5)
		  Call Demo.CreateCircle(World, New VMaths.Vector2(50, 20), 2)
		  Call Demo.CreateCircle(World, New VMaths.Vector2(-6, 26), 2)
		  Call Demo.CreateCircle(World, New VMaths.Vector2(-8, 34), 3)
		  Call Demo.CreateCircle(World, New VMaths.Vector2(-60, 32), 2.6)
		  
		  // Add 10 little boxes.
		  For i As Integer = 0 To 9
		    Call Demo.CreateBox(World, New VMaths.Vector2(-60 + (i * 2.3), 38), 2, 2)
		  Next i
		  
		  // Add a pentagon with some spin.
		  Var pentagonVertices() As VMaths.Vector2 = Array( _
		  New VMaths.Vector2(0, 0), _
		  New VMaths.Vector2(7, 1), _
		  New VMaths.Vector2(7, 3), _
		  New VMaths.Vector2(5, 7), _
		  New VMaths.Vector2(0, 5))
		  Call Demo.CreatePolygon(World, New VMaths.Vector2(45, 28), pentagonVertices)
		  World.Bodies(World.Bodies.LastIndex).AngularVelocity = 0.55
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitialiseWorldAndScene()
		  // Setup the viewport for the canvas.
		  Var extents As New VMaths.Vector2(Scene.Width / 2, Scene.Height / 2)
		  Scene.Viewport = New Physics.ViewportTransform(extents, extents, VIEWPORT_SCALE)
		  
		  Scene.ShouldDrawShapes = True
		  Scene.ShouldDrawCenterOfMass = CheckBoxCentreOfMass.Value
		  Scene.ShouldDrawWireframes = CheckBoxWireframes.Value
		  Scene.ShouldDrawJoints = CheckBoxJoints.Value
		  
		  // Create a world with normal gravity.
		  Var gravity As New VMaths.Vector2(0, -10)
		  World = New Physics.World(gravity)
		  
		  // Assign the debug drawing canvas to the world.
		  World.DebugDraw = Scene
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PauseSimulation()
		  // Pause a running simulation.
		  WorldUpdateTimer.Enabled = False
		  ButtonStart.Caption = "Resume"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetSimulation()
		  WorldUpdateTimer.Enabled = False
		  
		  InitialiseWorldAndScene
		  World.DrawDebugData
		  Scene.Refresh
		  
		  ButtonStart.Caption = "Start"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5374617274207468652073696D756C6174696F6E2E
		Sub StartSimulation()
		  /// Start the simulation.
		  
		  CreateSimulation
		  WorldUpdateTimer.Enabled = True
		  WorldUpdateTimer.RunMode = Timer.RunModes.Multiple
		  ButtonStart.Caption = "Pause"
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 547275652069662066697273742074696D65207365747570206F66207468652077696E646F772068617320636F6D706C657465642E
		Private mAllowRunning As Boolean = False
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
		    StartSimulation
		    
		  Case "Resume"
		    // Resume a paused simulation.
		    WorldUpdateTimer.RunMode = Timer.RunModes.Multiple
		    WorldUpdateTimer.Enabled = True
		    Me.Caption = "Pause"
		    
		  Case "Pause"
		    PauseSimulation
		    
		  End Select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonReset
	#tag Event
		Sub Pressed()
		  ResetSimulation
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
		  Scene.ShouldDrawCenterOfMass = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxWireframes
	#tag Event
		Sub ValueChanged()
		  Scene.ShouldDrawWireframes = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxJoints
	#tag Event
		Sub ValueChanged()
		  Scene.ShouldDrawJoints = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxAABBs
	#tag Event
		Sub ValueChanged()
		  Scene.ShouldDrawAABB = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupDemos
	#tag Event
		Sub Opening()
		  Me.AddRow(Demo.Types.CirclesAndBoxes.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.CirclesAndBoxes
		  
		  Me.AddRow(Demo.Types.DistanceJoints.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.DistanceJoints
		  
		  Me.AddRow(Demo.Types.RevoluteJoint.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.RevoluteJoint
		  
		  Me.AddRow(Demo.Types.VariousShapes.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.VariousShapes
		  
		  Me.SelectRowWithTag(Demo.Types.RevoluteJoint)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  ResetSimulation
		  
		  // Run the simulation so long as this is the first time the popup has changed (i.e. during initialisation).
		  If mAllowRunning Then StartSimulation
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

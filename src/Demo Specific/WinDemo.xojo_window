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
   Begin Timer WorldUpdateTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   33
      RunMode         =   0
      Scope           =   0
      TabPanelIndex   =   0
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
      Left            =   972
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
      Left            =   884
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
      Left            =   796
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
      Left            =   20
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
      Width           =   224
   End
   Begin DesktopLabel Label1
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   546
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Gravity"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   660
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   63
   End
   Begin DesktopSlider SliderGravity
      AllowAutoDeactivate=   True
      AllowLiveScrolling=   True
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   621
      LineStep        =   1
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MaximumValue    =   15
      MinimumValue    =   0
      PageStep        =   1
      Scope           =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TickMarkStyle   =   0
      Tooltip         =   ""
      Top             =   656
      Transparent     =   False
      Value           =   10
      Visible         =   True
      Width           =   163
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  mAllowRunning = True
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 41646A757374732074686520706572696F64206F6620746865207570646174652074696D657220646570656E64696E67206F6E207468652063756D756C6174697665207374657020616E6420647261772074696D652E
		Sub AdjustFPS()
		  /// Adjusts the period of the update timer depending on the cumulative step and draw time.
		  ///
		  /// We will clamp to a max of ~60 frames per second (16 ms per frame).
		  
		  Var totalTime As Double = World.Profile.Step_.LongAvg + Scene.Timing.LongAvg
		  
		  WorldUpdateTimer.Period = Maths.Clamp(totalTime, 16, 1000)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateSimulation()
		  // Clear out any existing custom update action.
		  MyUpdateAction = Nil
		  
		  Select Case PopupDemos.RowTagAt(PopupDemos.SelectedRowIndex)
		  Case Demo.Types.CirclesAndBoxes
		    DemoCirclesAndBoxes
		    
		  Case Demo.Types.ClickToAddRandomBodies
		    DemoClickToAddRandomBodies
		    
		  Case Demo.Types.ConstantVolumeJoint
		    DemoConstantVolumeJoint
		    
		  Case Demo.Types.DistanceJoints
		    DemoDistanceJoints
		    
		  Case Demo.Types.PrismaticJoint
		    DemoPrismaticJoint
		    
		  Case Demo.Types.RevoluteJoint
		    DemoRevoluteJoint
		    
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
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
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

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20726561647920746F20636F6E766572742063616E76617320636C69636B7320746F2072616E646F6D20626F646965732E
		Sub DemoClickToAddRandomBodies()
		  /// Configure the simulation ready to convert canvas clicks to random bodies.
		  ///
		  /// Clicking the canvas will place a circle, box, polygon or blob at the mouse click location.
		  /// If the option key is held down at the time of the click, the body will be static (except blobs).
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
		  Call Demo.CreateGroundAndOptionalWalls(World, Scene.Width, Scene.Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DemoClickToAddRandomBodiesClickHandler(worldPos As VMaths.Vector2, optionClick As Boolean)
		  /// Called whenever the scene is clicked and the Demo.Types.ClickToAddRandomBodies demo is running.
		  
		  Var type As Integer = System.Random.InRange(0, 3)
		  Select Case type
		  Case 0
		    // Circle.
		    Var radius As Double = System.Random.InRange(5, 60)/10
		    Call Demo.CreateCircle(World, worldPos, radius, optionClick)
		  Case 1
		    // Box.
		    Var boxW As Double = System.Random.InRange(10, 60)/10
		    Var boxH As Double = System.Random.InRange(10, 60)/10
		    Call Demo.CreateBox(World, worldPos, boxW, boxH, optionClick)
		  Case 2
		    // Polygon.
		    Var pointCount As Integer = System.Random.InRange(3, Physics.Settings.MaxPolygonVertices)
		    Var points() As VMaths.Vector2
		    points.ResizeTo(pointCount - 1)
		    For i As Integer = 0 To points.LastIndex
		      points(i) = New VMaths.Vector2(System.Random.InRange(3, 9), System.Random.InRange(3, 9))
		    Next i
		    #Pragma BreakOnExceptions False
		    Try
		      Call Demo.CreatePolygon(World, worldPos, points, optionClick)
		    Catch e As UnsupportedOperationException
		      // We must have randomised non-sensical vertices. Just return a box.
		      Call Demo.CreateBox(World, worldPos, System.Random.InRange(10, 60)/10, System.Random.InRange(10, 60)/10, optionClick)
		    End Try
		    #Pragma BreakOnExceptions True
		  Case 3
		    // Blob
		    Var circleCount As Integer = System.Random.InRange(10, 20)
		    Var blobRadius As VMaths.Vector2 = VMaths.Vector2.RandomInRange(4, 8, 4, 8)
		    Call Demo.CreateBlob(World, circleCount, blobRadius, worldPos)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DemoConstantVolumeJoint()
		  /// Configure the simulation to demo constant volume joints.
		  ///
		  /// We'll make two "blobs" composed of multiple circle bodies.
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
		  // We need a ground and some walls.
		  Call Demo.CreateGroundAndOptionalWalls(World, Scene.Width, Scene.Height)
		  
		  // ==============================
		  // BLOB 1
		  // ==============================
		  Var blob1Center As New VMaths.Vector2(5, 10)
		  Var blob1Radius As New VMaths.Vector2(6, 6)
		  Demo.CreateBlob(World, 20, blob1Radius, blob1Center)
		  
		  // ==============================
		  // BLOB 2
		  // ==============================
		  Var blob2Center As New VMaths.Vector2(-15, 20)
		  Var blob2Radius As New VMaths.Vector2(3, 3)
		  Demo.CreateBlob(World, 20, blob2Radius, blob2Center)
		  
		  // Draw the joints by default.
		  CheckBoxJoints.Value = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20666F72207468652064697374616E6365206A6F696E742064656D6F2E
		Sub DemoDistanceJoints()
		  /// Configure the simulation for the distance joint demo.
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
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

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20666F722074686520707269736D61746963206A6F696E742064656D6F2E
		Sub DemoPrismaticJoint()
		  /// Configure the simulation for the prismatic joint demo.
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
		  // Create the ground.
		  Var ground As Physics.Body = Demo.CreateGroundAndOptionalWalls(World, Scene.Width, Scene.Height, False)
		  
		  // Box for the prismatic joint.
		  Const PLATFORM_W = 25
		  Const PLATFORM_H = 2.5
		  Var platform As Physics.Body = Demo.CreateBox(World, New VMaths.Vector2(0, -12), PLATFORM_W, PLATFORM_H)
		  
		  // Assign some user data - we will use this to find the joint in our update action after every world step.
		  platform.UserData = "prismaticPlatform"
		  
		  // Create the prismatic joint.
		  Var jointDef As New Physics.PrismaticJointDef
		  jointDef.LowerTranslation = -25
		  jointDef.UpperTranslation = 20
		  jointDef.EnableLimit = True
		  jointDef.MaxMotorForce = 300
		  jointDef.MotorSpeed = 5.0
		  jointDef.EnableMotor = True
		  jointDef.Initialize(ground, platform, platform.Position, New VMaths.Vector2(1, 0))
		  World.CreateJoint(New Physics.PrismaticJoint(jointDef))
		  
		  // Set a custom method to be called upon each world update. 
		  // This method will reverse the direction of the platform when it slows to a stop.
		  MyUpdateAction = AddressOf DemoPrismaticJointUpdateDelegate
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206D6574686F6420636865636B7320746F207365652069662074686520706C6174666F726D206372656174656420696E20746865206044656D6F507269736D617469634A6F696E7460206D6574686F64206861732073746F70706564206D6F76696E672E20496620736F2C2069742072657665727365732069747320646972656374696F6E2E
		Sub DemoPrismaticJointUpdateDelegate()
		  /// This method checks to see if the platform created in the `DemoPrismaticJoint` method has stopped
		  /// moving. If so, it reverses its direction.
		  
		  // Find the platform's joint.
		  Var platformJoint As Physics.PrismaticJoint
		  For Each j As Physics.Joint In World.Joints
		    If j.BodyB.UserData = "prismaticPlatform" Then // Set in `DemoPrismaticJoint`.
		      platformJoint = Physics.PrismaticJoint(j)
		      Exit
		    End If
		  Next j
		  
		  If platformJoint <> Nil And platformJoint.MotorLimitStateDidChange Then
		    Select Case platformJoint.LimitState
		    Case Physics.LimitState.AtUpper, Physics.LimitState.AtLower
		      platformJoint.MotorSpeed = -platformJoint.MotorSpeed
		    End Select
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20666F7220746865207265766F6C757465206A6F696E742064656D6F2E
		Sub DemoRevoluteJoint()
		  /// Configure the simulation for the revolute joint demo.
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
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
		  
		  ResetGravity
		  
		  Var ground As Physics.Body = Demo.CreateGroundAndOptionalWalls(World, Scene.Width, Scene.Height)
		  
		  // Static central circle.
		  Call Demo.CreateCircle(World, VMaths.Vector2.Zero, 5, True)
		  
		  // Triangle.
		  Var triangleVertices() As VMaths.Vector2 = Array( _
		  New VMaths.Vector2(0, 0), _
		  New VMaths.Vector2(27, 0), _
		  New VMaths.Vector2(27, 12))
		  Call Demo.CreatePolygon(World, _
		  New VMaths.Vector2(ground.Position.X - 22, ground.Position.Y + 0.5), _
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
		Function GravitySliderValueToVector(sliderValue As Integer) As VMaths.Vector2
		  Var mapping(15) As Integer = Array(10, 8, 6, 4, 2, 0, -2, -4, -6, -8, -10, -12, -14, -16, -18, -20)
		  
		  Return New VMaths.Vector2(0, mapping(sliderValue))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitialiseWorldAndScene()
		  // Setup the viewport for the canvas.
		  Var extents As New VMaths.Vector2(Scene.Width / 2, Scene.Height / 2)
		  Scene.Viewport = New Physics.ViewportTransform(extents, extents, VIEWPORT_SCALE)
		  
		  Scene.ShouldDrawShapes = True
		  Scene.ShouldDrawWireframes = CheckBoxWireframes.Value
		  Scene.ShouldDrawJoints = CheckBoxJoints.Value
		  
		  // Create a world with gravity specified by the gravity slider.
		  World = New Physics.World(GravitySliderValueToVector(SliderGravity.Value))
		  
		  // Assign the debug drawing canvas to the world.
		  World.DebugDraw = Scene
		  
		  Scene.ResetTiming
		  
		  // Aim for 30 FPS.
		  WorldUpdateTimer.Period = 33
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
		Sub ResetGravity()
		  /// Resets the world's gravity vector to (0, -10).
		  
		  SliderGravity.Value = 10
		  
		  If World <> Nil Then
		    World.SetGravity(GravitySliderValueToVector(10))
		  End If
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

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub UpdateAction()
	#tag EndDelegateDeclaration


	#tag Property, Flags = &h21, Description = 547275652069662066697273742074696D65207365747570206F66207468652077696E646F772068617320636F6D706C657465642E
		Private mAllowRunning As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206D6574686F6420746861742077696C2062652063616C6C65642075706F6E206561636820776F726C64207570646174652E
		MyUpdateAction As UpdateAction
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


	#tag Constant, Name = VIEWPORT_SCALE, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events Scene
	#tag Event , Description = 54686520757365722068617320636C69636B6564207468652063616E7661732E20496620606F7074696F6E436C69636B602069732054727565207468656E2074686520606F7074696F6E6020636C69636B207761732068656C6420646F776E207768656E20746865206D6F7573652077617320636C69636B65642E
		Sub Clicked(worldPos As VMaths.Vector2, optionClick As Boolean)
		  If World = Nil Or Not WorldUpdateTimer.Enabled Then Return
		  
		  Select Case PopupDemos.RowTagAt(PopupDemos.SelectedRowIndex)
		  Case Demo.Types.ClickToAddRandomBodies
		    DemoClickToAddRandomBodiesClickHandler(worldPos, optionClick)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
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
#tag Events WorldUpdateTimer
	#tag Event
		Sub Action()
		  Var dt As Double = Me.Period / 1000
		  Var fps As Integer = 1000 / Me.Period
		  
		  // Step the physics simulation.
		  World.StepDt(dt)
		  
		  // Draw the world.
		  World.DrawDebugData
		  
		  // Update the timing stats.
		  Var stats As String = _
		  "Step Time: " + World.Profile.Step_.ToString + EndOfLine + _
		  "Draw Time: " + Scene.Timing.ToString + EndOfLine + _
		  "   Bodies: " + World.Bodies.Count.ToString + EndOfLine + _
		  "      FPS: " + fps.ToString
		  Scene.DrawStringXY(20, 20, stats, Color.Black)
		  
		  // Tell the scene to paint.
		  Scene.Refresh
		  
		  AdjustFPS
		  
		  // If a demo has set a custom action to occur within each update, call it.
		  If MyUpdateAction <> Nil Then
		    MyUpdateAction.Invoke
		  End If
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
		  
		  Me.AddRow(Demo.Types.ClickToAddRandomBodies.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.ClickToAddRandomBodies
		  
		  Me.AddRow(Demo.Types.ConstantVolumeJoint.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.ConstantVolumeJoint
		  
		  Me.AddRow(Demo.Types.DistanceJoints.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.DistanceJoints
		  
		  Me.AddRow(Demo.Types.PrismaticJoint.ToString)
		  Me.RowTagAt(Me.LastAddedRowIndex) = Demo.Types.PrismaticJoint
		  
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
#tag Events SliderGravity
	#tag Event
		Sub ValueChanged()
		  /// The slider goes from 0 to 15. 
		  /// We clamp the gravity Y component between 10 and -20 (-10 is normal).
		  
		  If World <> Nil Then
		    World.SetGravity(GravitySliderValueToVector(Me.Value))
		  End If
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

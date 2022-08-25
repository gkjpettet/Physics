#tag MobileScreen
Begin MobileScreen ScreenDemo
   BackButtonCaption=   ""
   Compatibility   =   ""
   ControlCount    =   0
   Device = 2
   HasNavigationBar=   False
   LargeTitleDisplayMode=   2
   Left            =   0
   Orientation = 1
   TabBarVisible   =   False
   TabIcon         =   0
   TintColor       =   &c00000000
   Title           =   "Demo"
   Top             =   0
   Begin DebugMobileCanvas Scene
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Scene, 1, <Parent>, 1, False, +1.00, 4, 1, 225, , True
      AutoLayout      =   Scene, 2, <Parent>, 2, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   Scene, 3, TopLayoutGuide, 4, False, +1.00, 4, 1, *kStdControlGapV, , True
      AutoLayout      =   Scene, 4, ButtonReset, 3, False, +1.00, 4, 1, -*kStdControlGapV, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   682
      Left            =   225
      LockedInPosition=   False
      SceneBackgroundColor=   &cFFFFFF00
      Scope           =   0
      TintColor       =   &c000000
      Top             =   28
      Visible         =   True
      Width           =   799
   End
   Begin MobileButton ButtonStart
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   ButtonStart, 2, <Parent>, 2, False, +1.00, 4, 1, -*kStdGapCtlToViewH, , True
      AutoLayout      =   ButtonStart, 7, , 0, False, +1.00, 4, 1, 59, , True
      AutoLayout      =   ButtonStart, 8, , 0, False, +1.00, 4, 1, 30, , True
      AutoLayout      =   ButtonStart, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      Caption         =   "Start"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   945
      LockedInPosition=   False
      Scope           =   0
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   718
      Visible         =   True
      Width           =   59
   End
   Begin MobileButton ButtonReset
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   ButtonReset, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      AutoLayout      =   ButtonReset, 8, , 0, False, +1.00, 4, 1, 30, , True
      AutoLayout      =   ButtonReset, 2, ButtonStart, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   ButtonReset, 7, , 0, False, +1.00, 4, 1, 69, , True
      Caption         =   "Reset"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   868
      LockedInPosition=   False
      Scope           =   0
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   718
      Visible         =   True
      Width           =   69
   End
   Begin iOSMobileTable TableDemos
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AllowRefresh    =   False
      AllowSearch     =   False
      AutoLayout      =   TableDemos, 1, <Parent>, 1, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   TableDemos, 7, , 0, False, +1.00, 4, 1, 225, , True
      AutoLayout      =   TableDemos, 3, Scene, 3, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   TableDemos, 4, ButtonReset, 3, False, +1.00, 4, 1, -*kStdControlGapV, , True
      ControlCount    =   0
      EditingEnabled  =   False
      EditingEnabled  =   False
      Enabled         =   True
      EstimatedRowHeight=   -1
      Format          =   0
      Height          =   682
      Left            =   0
      LockedInPosition=   False
      Scope           =   2
      SectionCount    =   0
      TintColor       =   &c000000
      Top             =   28
      Visible         =   True
      Width           =   225
   End
   Begin Timer WorldUpdateTimer
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Period          =   33
      RunMode         =   0
      Scope           =   2
   End
   Begin MobileSwitch SwitchWireframes
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   SwitchWireframes, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      AutoLayout      =   SwitchWireframes, 8, , 0, True, +1.00, 4, 1, 31, , True
      AutoLayout      =   SwitchWireframes, 2, ButtonReset, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   SwitchWireframes, 7, , 0, True, +1.00, 4, 1, 51, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   31
      Left            =   809
      LockedInPosition=   False
      Scope           =   0
      TintColor       =   &c000000
      Top             =   717
      Value           =   True
      Visible         =   True
      Width           =   51
   End
   Begin MobileSwitch SwitchJoints
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   SwitchJoints, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      AutoLayout      =   SwitchJoints, 8, , 0, True, +1.00, 4, 1, 31, , True
      AutoLayout      =   SwitchJoints, 2, LabelWireframes, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   SwitchJoints, 7, , 0, True, +1.00, 4, 1, 51, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   31
      Left            =   660
      LockedInPosition=   False
      Scope           =   0
      TintColor       =   &c000000
      Top             =   717
      Value           =   False
      Visible         =   True
      Width           =   51
   End
   Begin MobileLabel LabelWireframes
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      Alignment       =   2
      AutoLayout      =   LabelWireframes, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      AutoLayout      =   LabelWireframes, 8, , 0, False, +1.00, 4, 1, 30, , True
      AutoLayout      =   LabelWireframes, 2, SwitchWireframes, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   LabelWireframes, 7, , 0, False, +1.00, 4, 1, 82, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   719
      LineBreakMode   =   0
      LockedInPosition=   False
      Scope           =   0
      Text            =   "Wireframes"
      TextColor       =   &c000000
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   718
      Visible         =   True
      Width           =   82
   End
   Begin MobileLabel LabelJoints
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      Alignment       =   2
      AutoLayout      =   LabelJoints, 11, LabelWireframes, 11, False, +1.00, 4, 1, , , True
      AutoLayout      =   LabelJoints, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      AutoLayout      =   LabelJoints, 8, , 0, False, +1.00, 4, 1, 30, , True
      AutoLayout      =   LabelJoints, 2, SwitchJoints, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   LabelJoints, 7, , 0, False, +1.00, 4, 1, 49, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   603
      LineBreakMode   =   0
      LockedInPosition=   False
      Scope           =   0
      Text            =   "Joints"
      TextColor       =   &c000000
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   718
      Visible         =   True
      Width           =   49
   End
   Begin MobileSlider SliderGravity
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   SliderGravity, 4, LabelJoints, 4, False, +1.00, 4, 1, -3, , True
      AutoLayout      =   SliderGravity, 8, , 0, False, +1.00, 4, 1, 23, , True
      AutoLayout      =   SliderGravity, 2, LabelJoints, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   SliderGravity, 7, , 0, False, +1.00, 4, 1, 200, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   23
      Left            =   395
      LockedInPosition=   False
      MaximumValue    =   15.0
      MinimumValue    =   0.0
      Scope           =   0
      TintColor       =   &c000000
      Top             =   722
      Value           =   10.0
      Visible         =   True
      Width           =   200
   End
   Begin MobileLabel LabelGravity
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      Alignment       =   2
      AutoLayout      =   LabelGravity, 2, SliderGravity, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   LabelGravity, 7, , 0, False, +1.00, 4, 1, 59, , True
      AutoLayout      =   LabelGravity, 8, , 0, False, +1.00, 4, 1, 30, , True
      AutoLayout      =   LabelGravity, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      AutoLayout      =   LabelGravity, 11, ButtonStart, 11, False, +1.00, 4, 1, , , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   328
      LineBreakMode   =   0
      LockedInPosition=   False
      Scope           =   0
      Text            =   "Gravity"
      TextColor       =   &c000000
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   718
      Visible         =   True
      Width           =   59
   End
End
#tag EndMobileScreen

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
		  
		  Select Case DemoToRun
		  Case Demo.Types.CirclesAndBoxes.ToString
		    DemoCirclesAndBoxes
		    
		  Case Demo.Types.ClickToAddRandomBodies.ToString
		    DemoClickToAddRandomBodies
		    
		  Case Demo.Types.ConstantVolumeJoint.ToString
		    DemoConstantVolumeJoint
		    
		  Case Demo.Types.DistanceJoints.ToString
		    DemoDistanceJoints
		    
		  Case Demo.Types.Particles.ToString
		    DemoParticles
		    
		  Case Demo.Types.PrismaticJoint.ToString
		    DemoPrismaticJoint
		    
		  Case Demo.Types.Raycasting.ToString
		    DemoRaycasting
		    
		  Case Demo.Types.RevoluteJoint.ToString
		    DemoRevoluteJoint
		    
		  Case Demo.Types.VariousShapes.ToString
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

	#tag Method, Flags = &h0, Description = 447261777320612063697263756C61722067726F7570206F66207061727469636C65732061742060776F726C64506F73602E
		Sub DemoClickToAddParticlesClickHandler(worldPos As VMaths.Vector2)
		  /// Draws a circular group of particles at `worldPos`.
		  
		  // Ensure the world has a particle system.
		  If World.ParticleSystem = Nil Then
		    World.ParticleSystem = New Physics.ParticleSystem(World)
		  End If
		  
		  // Set the size of the particles.
		  World.ParticleSystem.ParticleDiameter = 0.5
		  
		  // Create a circular particle group centred at `worldPos`.
		  Var groupDef As New Physics.ParticleGroupDef
		  groupDef.Colour = RandomColor
		  groupDef.Shape = New Physics.CircleShape(2.5)
		  groupDef.Position = worldPos
		  groupDef.Lifespan = 2
		  
		  Call World.ParticleSystem.CreateParticleGroup(groupDef)
		  
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
		Sub DemoClickToAddRandomBodiesClickHandler(worldPos As VMaths.Vector2)
		  /// Called whenever the scene is clicked and the Demo.Types.ClickToAddRandomBodies demo is running.
		  
		  Var type As Integer = System.Random.InRange(0, 3)
		  Select Case type
		  Case 0
		    // Circle.
		    Var radius As Double = System.Random.InRange(5, 60)/10
		    Call Demo.CreateCircle(World, worldPos, radius)
		  Case 1
		    // Box.
		    Var boxW As Double = System.Random.InRange(10, 60)/10
		    Var boxH As Double = System.Random.InRange(10, 60)/10
		    Call Demo.CreateBox(World, worldPos, boxW, boxH)
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
		      Call Demo.CreatePolygon(World, worldPos, points)
		    Catch e As UnsupportedOperationException
		      // We must have randomised non-sensical vertices. Just return a box.
		      Call Demo.CreateBox(World, worldPos, System.Random.InRange(10, 60)/10, System.Random.InRange(10, 60)/10)
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
		  Scene.ShouldDrawJoints = True
		  SwitchJoints.Value = True
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
		  Scene.ShouldDrawJoints = True
		  SwitchJoints.Value = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20666F7220746865207061727469636C65732064656D6F2E
		Sub DemoParticles()
		  /// Configure the simulation for the particles demo.
		  ///
		  /// Clicking anywhere in the scene will create a randomly coloured circular particle group.
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
		  // Create a ground.
		  Call Demo.CreateGroundAndOptionalWalls(World, Scene.Width, Scene.Height, False)
		  
		  // Default to drawing solid bodies and objects.
		  Scene.ShouldDrawWireframes = False
		  SwitchWireframes.Value = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E666967757265207468652073696D756C6174696F6E20666F722074686520707269736D61746963206A6F696E742064656D6F2E
		Sub DemoPrismaticJoint()
		  /// Configure the simulation for the prismatic joint demo.
		  ///
		  /// We will create a rectangle platform that moves backwards and forwards from left to right.
		  /// Clickling anywhere in the canvas will create random bodies at that location.
		  
		  InitialiseWorldAndScene
		  
		  ResetGravity
		  
		  // Create the ground and walls.
		  Var ground As Physics.Body = Demo.CreateGroundAndOptionalWalls(World, Scene.Width, Scene.Height)
		  
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
		  
		  // Don't draw the joints by default.
		  Scene.ShouldDrawJoints = False
		  SwitchJoints.Value = False
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

	#tag Method, Flags = &h0
		Sub DemoRaycasting()
		  /// Configure the simulation for the raycasting demo.
		  ///
		  /// We will construct a scene with a fenced area and some shapes floating in zero gravity.
		  /// We will then add a rotating ray in the centre of the scene.
		  
		  InitialiseWorldAndScene
		  
		  // Set gravity to (0, 0).
		  SliderGravity.Value = 5
		  World.SetGravity(VMaths.Vector2.Zero)
		  
		  Demo.CreateEnclosingBox(World, Scene.Width, Scene.Height)
		  
		  // Figure out the limits of where to randomise the bodies in world space.
		  Var minX As Double = Scene.ScreenXYToWorld(0, 0).X
		  Var maxX As Double = Scene.ScreenXYToWorld(Scene.Width, 0).X
		  Var minY As Double = Scene.ScreenXYToWorld(0, 0).Y
		  Var maxY As Double = Scene.ScreenXYToWorld(0, Scene.Height).Y - 5 // Allow for ground height.
		  
		  // Create some boxes and circles with some velocity and rotation.
		  For i As Integer = 1 To 10
		    Var box As Physics.Body = _
		    Demo.CreateBox(World, VMaths.Vector2.RandomInRange(minX, maxX, minY, maxY), 3, 3, False, 0.5, 1.0)
		    Var circle As Physics.Body = _
		    Demo.CreateCircle(World, VMaths.Vector2.RandomInRange(minX, maxX, minY, maxY), 3, False, 0.5, 1.0)
		    
		    // Apply some spin.
		    box.ApplyAngularImpulse(Maths.DegreesToRadians(System.Random.InRange(0, 360)))
		    circle.ApplyAngularImpulse(Maths.DegreesToRadians(System.Random.InRange(0, 360)))
		    
		    // Apply random linear motion.
		    box.ApplyLinearImpulse(VMaths.Vector2.RandomInRange(-100, 100, -100, 100))
		    circle.ApplyLinearImpulse(VMaths.Vector2.RandomInRange(-100, 100, -100, 100))
		  Next i
		  
		  // Reset the raycasting angle.
		  mCurrentRayAngle = 0
		  
		  // Set the method to be called each step.
		  MyUpdateAction = AddressOf DemoRaycastingUpdateDelegate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DemoRaycastingUpdateDelegate()
		  /// Increases the current ray angle.
		  
		  // One revolution every 20 seconds.
		  mCurrentRayAngle = mCurrentRayAngle + 360 / 15.0 / 60.0 * Maths.DEGREES_TO_RADIANS_RATIO
		  
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
		  Scene.ShouldDrawJoints = False
		  SwitchJoints.Value = False
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
		  New VMaths.Vector2(ground.Position.X - 15, ground.Position.Y + 0.5), _
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
		    Call Demo.CreateBox(World, New VMaths.Vector2(-40 + (i * 2.3), 38), 2, 2)
		  Next i
		  
		  // Add a pentagon with some spin.
		  Var pentagonVertices() As VMaths.Vector2 = Array( _
		  New VMaths.Vector2(0, 0), _
		  New VMaths.Vector2(7, 1), _
		  New VMaths.Vector2(7, 3), _
		  New VMaths.Vector2(5, 7), _
		  New VMaths.Vector2(0, 5))
		  Call Demo.CreatePolygon(World, New VMaths.Vector2(20, 28), pentagonVertices)
		  World.Bodies(World.Bodies.LastIndex).AngularVelocity = 0.55
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D707574657320616E6420647261772061207265666C65637461626C652072617920696E206120726563757273697665206D616E6E65722E
		Sub DrawReflectedRay(p1 As VMaths.Vector2, p2 As VMaths.Vector2, g As Graphics)
		  /// Computes and draw a reflectable ray in a recursive manner.
		  ///
		  /// Credit: https://www.iforce2d.net/b2dtut/raycasting
		  
		  // Draw the centre of the ray as a circle point.
		  g.DrawingColor = Color.Purple
		  g.FillOval((Scene.Width / 2) - 4, (Scene.Height / 2) - 4, 8, 8)
		  
		  // Set up the raycasting input.
		  Var input As New Physics.RaycastInput
		  input.P1 = p1
		  input.P2 = p2
		  input.MaxFraction = 1
		  
		  // Check every fixture of every body to find the closest.
		  // TODO: This is inefficient. Use a callbacks for better efficiency:
		  // https://www.iforce2d.net/b2dtut/world-querying
		  
		  Var closestFraction As Double = 1 // Start with end of line as p2.
		  Var intersectionNormal As New VMaths.Vector2 (0, 0)
		  
		  For Each b As Physics.Body In World.Bodies
		    For Each f As Physics.Fixture In b.Fixtures
		      Var output As New Physics.RaycastOutput
		      If Not f.RayCast(output, input) Then
		        Continue
		      End If
		      
		      If output.Fraction < closestFraction Then
		        closestFraction = output.Fraction
		        intersectionNormal = output.Normal
		      End If
		    Next f
		  Next b
		  
		  Var intersectionPoint As VMaths.Vector2 = p1 + (p2 - p1) * closestFraction
		  
		  // Get screen coordinates from world coordinates.
		  Var p1Screen As VMaths.Vector2 = Scene.Viewport.WorldToScreen(p1)
		  Var intersectScreen As VMaths.Vector2 = Scene.Viewport.WorldToScreen(intersectionPoint)
		  
		  // Draw this part of the ray.
		  g.DrawLine(p1Screen.X, p1Screen.Y, intersectScreen.X, intersectScreen.Y)
		  
		  If closestFraction = 1 Then
		    // The ray hit nothing so we can finish here.
		    Return
		  End If
		  
		  If closestFraction = 0 Then
		    // The ray has run out of steam.
		    Return
		  End If
		  
		  // We still some ray left to reflect.
		  Var remainingRay As VMaths.Vector2 = p2 - intersectionPoint
		  Var projectedOntoNormal As VMaths.Vector2 =  intersectionNormal * remainingRay.Dot(intersectionNormal)
		  Var nextP2 As VMaths.Vector2 = p2 - projectedOntoNormal * 2
		  
		  // Recurse.
		  DrawReflectedRay(intersectionPoint, nextP2, g)
		  
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
		  Scene.ShouldDrawJoints = SwitchJoints.Value
		  Scene.ShouldDrawWireframes = SwitchWireframes.Value
		  
		  // Create a world with gravity specified by the gravity slider.
		  World = New Physics.World(GravitySliderValueToVector(SliderGravity.Value))
		  
		  // Assign the debug drawing canvas to the world.
		  World.DebugDraw = Scene
		  
		  Scene.ResetTiming
		  
		  // Aim for 30 FPS.
		  WorldUpdateTimer.Period = 33
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5061696E7473206120726F746174696E672C207265666C65637461626C652C20726179207769746820697473206F726967696E20696E207468652063656E747265206F6620746865207363656E652E
		Sub PaintRaycastDemo(g As Graphics)
		  /// Paints a rotating, reflectable, ray with its origin in the centre of the scene.
		  
		  // Create the ray being cast.
		  Var rayLength As Double = 32 // Long enough to hit the walls.
		  Var p1 As New VMaths.Vector2(0, 0) // The centre of the scene.
		  Var p2 As VMaths.Vector2 = _
		  p1 + (New VMaths.Vector2(Sin(mCurrentRayAngle), Cos(mCurrentRayAngle)) * rayLength)
		  
		  // Recursively draw the ray and its reflections.
		  DrawReflectedRay(p1, p2, g)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PauseSimulation()
		  // Pause a running simulation.
		  WorldUpdateTimer.Enabled = False
		  ButtonStart.Caption = "Resume"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612072616E646F6D20636F6C6F75722E
		Function RandomColor() As Color
		  /// Returns a random colour.
		  
		  Return Color.RGB(System.Random.InRange(0, 255), System.Random.InRange(0, 255), System.Random.InRange(0, 255))
		  
		End Function
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


	#tag Property, Flags = &h21
		Private DemoToRun As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662066697273742074696D65207365747570206F66207468652077696E646F772068617320636F6D706C657465642E
		Private mAllowRunning As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 55736564206279207468652072617963617374696E672064656D6F2E20497427732074686520616E676C65206F66207468652072617920726F746174696E672061626F7574207468652063656E7472652E
		Private mCurrentRayAngle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206D6574686F6420746861742077696C2062652063616C6C65642075706F6E206561636820776F726C64207570646174652E
		MyUpdateAction As UpdateAction
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206D6574686F6420746861742077696C2062652063616C6C65642075706F6E206561636820776F726C64207570646174652E
		MyUpdateAction1 As UpdateAction
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


	#tag Constant, Name = VIEWPORT_SCALE, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events Scene
	#tag Event , Description = 54686520757365722068617320746170706564207468652063616E7661732E
		Sub Tapped(worldPos As VMaths.Vector2)
		  If World = Nil Or Not WorldUpdateTimer.Enabled Then Return
		  
		  Select Case DemoToRun
		  Case Demo.Types.ClickToAddRandomBodies.ToString
		    DemoClickToAddRandomBodiesClickHandler(worldPos)
		    
		  Case Demo.Types.PrismaticJoint.ToString
		    DemoClickToAddRandomBodiesClickHandler(worldPos)
		    
		  Case Demo.Types.Particles.ToString
		    DemoClickToAddParticlesClickHandler(worldPos)
		    
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Paint(g As Graphics)
		  Select Case DemoToRun
		  Case Demo.Types.Raycasting.ToString
		    PaintRaycastDemo(g)
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
#tag Events TableDemos
	#tag Event
		Sub Opening()
		  Me.AddRow(Demo.Types.CirclesAndBoxes.ToString)
		  Me.AddRow(Demo.Types.ClickToAddRandomBodies.ToString)
		  Me.AddRow(Demo.Types.ConstantVolumeJoint.ToString)
		  Me.AddRow(Demo.Types.DistanceJoints.ToString)
		  Me.AddRow(Demo.Types.Particles.ToString)
		  Me.AddRow(Demo.Types.PrismaticJoint.ToString)
		  Me.AddRow(Demo.Types.Raycasting.ToString)
		  Me.AddRow(Demo.Types.RevoluteJoint.ToString)
		  Me.AddRow(Demo.Types.VariousShapes.ToString)
		  
		  Me.SelectRow(0, 0)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(section As Integer, row As Integer)
		  ResetSimulation
		  
		  Var selectedCell As MobileTableCellData = Me.RowCellData(section, row)
		  DemoToRun = selectedCell.Text
		  
		  // Run the simulation so long as this is the first time the popup has changed (i.e. during initialisation).
		  If mAllowRunning Then StartSimulation
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WorldUpdateTimer
	#tag Event
		Sub Run()
		  Var dt As Double = Me.Period / 1000
		  Var fps As Integer = 1000 / Me.Period
		  
		  // Step the physics simulation.
		  World.StepDt(dt)
		  
		  // Draw the world.
		  World.DrawDebugData
		  
		  // Update the timing stats.
		  Scene.DrawStringXY(20, 20, "Step Time: " + World.Profile.Step_.ToString, Color.Black)
		  Scene.DrawStringXY(20, 40, "Draw Time: " + Scene.Timing.ToString, Color.Black)
		  Scene.DrawStringXY(20, 60, "   Bodies: " + World.Bodies.Count.ToString, Color.Black)
		  Scene.DrawStringXY(20, 80, "Particles: " + _
		  If(World.ParticleSystem <> Nil, World.ParticleSystem.ParticleCount.ToString, "0"), Color.Black)
		  Scene.DrawStringXY(20, 100, "      FPS: " + fps.ToString, Color.Black)
		  
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
#tag Events SwitchWireframes
	#tag Event
		Sub ValueChanged()
		  Scene.ShouldDrawWireframes = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwitchJoints
	#tag Event
		Sub ValueChanged()
		  Scene.ShouldDrawJoints = Me.Value
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
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
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
		Name="BackButtonCaption"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasNavigationBar"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIcon"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LargeTitleDisplayMode"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="MobileScreen.LargeTitleDisplayModes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Always"
			"2 - Never"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabBarVisible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TintColor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="ColorGroup"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior

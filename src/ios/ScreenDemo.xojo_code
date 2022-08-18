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
      AutoLayout      =   ButtonStart, 7, , 0, False, +1.00, 4, 1, 100, , True
      AutoLayout      =   ButtonStart, 4, <Parent>, 4, False, +1.00, 4, 1, -*kStdGapCtlToViewV, , True
      AutoLayout      =   ButtonStart, 8, , 0, False, +1.00, 4, 1, 30, , True
      Caption         =   "Start"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   904
      LockedInPosition=   False
      Scope           =   0
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   718
      Visible         =   True
      Width           =   100
   End
   Begin MobileButton ButtonReset
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   ButtonReset, 2, ButtonStart, 1, False, +1.00, 4, 1, -*kStdControlGapH, , True
      AutoLayout      =   ButtonReset, 7, , 0, False, +1.00, 4, 1, 100, , True
      AutoLayout      =   ButtonReset, 11, ButtonStart, 11, False, +1.00, 4, 1, , , True
      AutoLayout      =   ButtonReset, 8, , 0, False, +1.00, 4, 1, 30, , True
      Caption         =   "Reset"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   796
      LockedInPosition=   False
      Scope           =   0
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   718
      Visible         =   True
      Width           =   100
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
      Height          =   32
      Height          =   32
      Left            =   140
      Left            =   140
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Period          =   33
      RunMode         =   0
      Scope           =   2
      Top             =   140
      Top             =   140
      Width           =   32
      Width           =   32
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
		  Select Case DemoToRun
		  Case Demo.Types.CirclesAndBoxes.ToString
		    DemoCirclesAndBoxes
		    
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

	#tag Method, Flags = &h0
		Sub InitialiseWorldAndScene()
		  // Setup the viewport for the canvas.
		  Var extents As New VMaths.Vector2(Scene.Width / 2, Scene.Height / 2)
		  Scene.Viewport = New Physics.ViewportTransform(extents, extents, VIEWPORT_SCALE)
		  
		  Scene.ShouldDrawShapes = True
		  Scene.ShouldDrawWireframes = True
		  Scene.ShouldDrawJoints = False
		  
		  // Create a world with gravity specified by the gravity slider.
		  World = New Physics.World(New VMaths.Vector2(0, -10))
		  
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


	#tag Property, Flags = &h21
		Private DemoToRun As String
	#tag EndProperty

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
#tag Events TableDemos
	#tag Event
		Sub Opening()
		  Me.AddRow(Demo.Types.CirclesAndBoxes.ToString)
		  ' Me.AddRow(Demo.Types.ClickToAddRandomBodies.ToString)
		  ' Me.AddRow(Demo.Types.ConstantVolumeJoint.ToString)
		  ' Me.AddRow(Demo.Types.DistanceJoints.ToString)
		  ' Me.AddRow(Demo.Types.PrismaticJoint.ToString)
		  ' Me.AddRow(Demo.Types.RevoluteJoint.ToString)
		  ' Me.AddRow(Demo.Types.VariousShapes.ToString)
		  
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
		  Scene.DrawStringXY(20, 80, "      FPS: " + fps.ToString, Color.Black)
		  
		  // Tell the scene to paint.
		  Scene.Refresh
		  
		  AdjustFPS
		  
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

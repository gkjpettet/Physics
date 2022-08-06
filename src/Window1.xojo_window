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
   Height          =   400
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
   Width           =   600
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Var gravity As New VMaths.Vector2(0, -10)
		  Var world As New Physics.World(gravity)
		  
		  // Create the ground.
		  Var groundBodyDef As New Physics.BodyDef
		  groundBodyDef.Position.SetValues(0, -10)
		  Var groundBody As Physics.Body = world.CreateBody(groundBodyDef)
		  
		  Var groundBox As New Physics.PolygonShape
		  groundBox.SetAsBoxXY(50, 10)
		  Call groundBody.CreateFixtureFromShape(groundBox, 0)
		  
		  // Create a dynamic body.
		  Var bodyDef As New Physics.BodyDef(Physics.BodyType.Dynamic)
		  bodyDef.Position.SetValues(0, 4)
		  Var body As Physics.Body = world.CreateBody(bodyDef)
		  
		  // Create and attach a polygon shape to the dynamic body using a fixture definition.
		  // Create the boxy shape.
		  Var dynamicBox As New Physics.PolygonShape
		  dynamicBox.SetAsBoxXY(1, 1)
		  
		  // Create a fixture definition using the box.
		  Var fixtureDef As New Physics.FixtureDef(dynamicBox)
		  fixtureDef.Density = 1
		  fixtureDef.Friction = 0.3
		  
		  // Using the fixture definition we can now create the fixture. 
		  // Multiple fixtures per body are allowed.
		  Call body.CreateFixture(fixtureDef)
		  
		  // 60 FPS.
		  Var timeStep As Double = 1 / 60
		  
		  Var position As VMaths.Vector2
		  Var angle As Double
		  For i As Integer = 0 To 59
		    world.StepDt(timeStep)
		    position = body.Position
		    System.DebugLog(position.X.ToString + " " + position.Y.ToString + " " + body.Angle.ToString)
		  Next i
		  
		End Sub
	#tag EndEvent


#tag EndWindowCode


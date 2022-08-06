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
		  // Create a world.
		  Var gravity As New VMaths.Vector2(0, -10)
		  Var world As New Physics.World(gravity)
		  
		  // Create the ground body.
		  Var groundBodyDef As New Physics.BodyDef
		  groundBodyDef.Position.SetValues(0, -10)
		  Var groundBody As Physics.Body = world.CreateBody(groundBodyDef)
		  
		  // Set the ground's shape and attach it as a fixture.
		  Var groundBox As New Physics.PolygonShape
		  groundBox.SetAsBoxXY(50, 10)
		  Call groundBody.CreateFixtureFromShape(groundBox, 0)
		  
		  // Create two dynamic bodies
		  Var bodyDef As New Physics.BodyDef(Physics.BodyType.Dynamic)
		  bodyDef.Position.SetValues(0, 4)
		  Var body1 As Physics.Body = world.CreateBody(bodyDef)
		  
		  bodyDef.Position.SetValues(10, 4)
		  Var body2 As Physics.Body = world.CreateBody(bodyDef)
		  
		  // Create a 1 x 1 box shape.
		  Var dynamicBox As New Physics.PolygonShape
		  dynamicBox.SetAsBoxXY(1, 1)
		  
		  // Create a fixture definition.
		  Var fixtureDef As New Physics.FixtureDef(dynamicBox)
		  fixtureDef.Density = 1
		  fixtureDef.Friction = 0.3
		  
		  // Add the same fixture to both bodies.
		  Call body1.CreateFixture(fixtureDef)
		  Call body2.CreateFixture(fixtureDef)
		  
		  // 60 FPS.
		  Var timeStep As Double = 1 / 60
		  
		  Var pos1, pos2 As VMaths.Vector2
		  For i As Integer = 0 To 59
		    world.StepDt(timeStep)
		    pos1 = body1.Position
		    pos2 = body2.Position
		    System.DebugLog( _
		    "body1: " + pos1.X.ToString + " " + pos1.Y.ToString + " " + body1.Angle.ToString + _
		    ", body2: " + pos2.X.ToString + " " + pos2.Y.ToString + " " + body2.Angle.ToString)
		  Next i
		  
		End Sub
	#tag EndEvent


#tag EndWindowCode


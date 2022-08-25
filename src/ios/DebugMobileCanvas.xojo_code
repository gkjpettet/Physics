#tag Class
Protected Class DebugMobileCanvas
Inherits MobileCanvas
Implements Physics.DebugDraw
	#tag Event
		Sub Opening()
		  Timing = New Physics.ProfileEntry
		  mDrawTimer = New Physics.Timer(True)
		  
		  ScaleFactor = MainScreenScale
		  
		  RaiseEvent Opening
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics)
		  // We need a valid viewport. Ideally this should be set in the constructor but as 
		  // this is a canvas subclass we don't have access to the constructor.
		  If Self.Viewport = Nil Then Return
		  
		  CheckBuffer
		  
		  g.DrawPicture(mBuffer, 0, 0)
		  
		  RaiseEvent Paint(g)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PointerDown(position As Point, pointerInfo() As PointerEvent)
		  #Pragma Unused pointerInfo
		  
		  Tapped(ScreenXYToWorld(position.X, position.Y))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub BeginDrawing()
		  /// The world is about to begin drawing for this step.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  mDrawTimer.Reset
		  
		  CheckBuffer
		  
		  mBuffer.Graphics.DrawingColor = SceneBackgroundColor
		  mBuffer.Graphics.FillRectangle(0, 0, mBuffer.Graphics.Width, mBuffer.Graphics.Height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436865636B207468617420746865206261636B696E67206275666665722065786973747320616E642069732074686520636F72726563742073697A652E
		Private Sub CheckBuffer()
		  /// Check that the backing buffer exists and is the correct size.
		  
		  If mBuffer = Nil Then
		    CreateNewBuffer
		    Return
		  End If
		  
		  If mBuffer.Width <> Self.Width * ScaleFactor Or _
		    mBuffer.Height <> Self.Height * ScaleFactor Then
		    CreateNewBuffer
		    Return
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 437265617465732061206E6577206261636B69676E20627566666572206F662074686520636F727265637420776964746820616E64206865696768742E
		Private Sub CreateNewBuffer()
		  /// Creates a new backing buffer of the correct width and height.
		  
		  mBuffer = New Picture(Self.Width * ScaleFactor, Self.Height * ScaleFactor)
		  mBuffer.HorizontalResolution = 72 * ScaleFactor
		  mBuffer.VerticalResolution = 72 * ScaleFactor
		  
		  mBuffer.Graphics.ScaleX = ScaleFactor
		  mBuffer.Graphics.ScaleY = ScaleFactor
		  
		  // Use a monospace font.
		  #Pragma Warning "TODO"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawCircle(center As VMaths.Vector2, radius As Double, colour As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  Var screenRadius As Double = radius * Viewport.Scale
		  Var screenCenter As VMaths.Vector2 = WorldToScreen(center)
		  Var circumference As Double = screenRadius * 2
		  
		  mBuffer.Graphics.DrawingColor = colour
		  
		  mBuffer.Graphics.DrawOval(screenCenter.X - screenRadius, _
		  screenCenter.Y - screenRadius, _
		  circumference, circumference)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawCircleAxis(center As VMaths.Vector2, radius As Double, axis As VMaths.Vector2, colour As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  #Pragma Unused axis
		  
		  DrawCircle(center, radius, colour)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawParticles(particles() As Physics.Particle, radius As Double)
		  // Part of the Physics.DebugDraw interface.
		  
		  For Each p As Physics.Particle In particles
		    DrawSolidCircle(p.Position, radius, p.Colour)
		  Next p
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawParticlesWireframe(particles() As Physics.Particle, radius As Double)
		  // Part of the Physics.DebugDraw interface.
		  
		  For Each p As Physics.Particle In particles
		    DrawCircle(p.Position, radius, p.Colour)
		  Next p
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawPoint(point As VMaths.Vector2, radiusOnScreen As Double, colour As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  Var screenCenter As VMaths.Vector2 = WorldToScreen(point)
		  Var circumference As Double = radiusOnScreen * 2
		  
		  mBuffer.Graphics.DrawingColor = colour
		  
		  mBuffer.Graphics.FillOval(screenCenter.X - radiusOnScreen, _
		  screenCenter.Y - radiusOnScreen, _
		  circumference, circumference)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawPolygon(vertices() As VMaths.Vector2, colour As Color)
		  /// Draw the wireframe of a closed polygon provided in counter-clockwise order.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  mBuffer.Graphics.DrawingColor = colour
		  mBuffer.Graphics.DrawPath(PolygonPath(vertices))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawSegment(p1 As VMaths.Vector2, p2 As VMaths.Vector2, colour As Color)
		  /// Draw a line segment. 
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  mBuffer.Graphics.DrawingColor = colour
		  
		  Var screenP1 As VMaths.Vector2 = WorldToScreen(p1)
		  Var screenP2 As VMaths.Vector2 = WorldToScreen(p2)
		  
		  mBuffer.Graphics.DrawLine(screenP1.X, screenP1.Y, screenP2.X, screenP2.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawSolidCircle(center as VMaths.Vector2, radius as Double, colour as Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  Var screenRadius As Double = radius * Viewport.Scale
		  Var screenCenter As VMaths.Vector2 = WorldToScreen(center)
		  Var circumference As Double = screenRadius * 2
		  
		  mBuffer.Graphics.DrawingColor = colour
		  
		  mBuffer.Graphics.FillOval(screenCenter.X - screenRadius, _
		  screenCenter.Y - screenRadius, _
		  circumference, circumference)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawSolidPolygon(vertices() As VMaths.Vector2, colour As Color)
		  /// Draw a filled closed polygon provided in counter-clockwise order.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  mBuffer.Graphics.DrawingColor = colour
		  mBuffer.Graphics.FillPath(PolygonPath(vertices))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawString(pos As VMaths.Vector2, s As String, colour As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  mBuffer.Graphics.DrawingColor = colour
		  
		  mBuffer.Graphics.DrawText(s, pos.X, pos.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawStringXY(x As Double, y As Double, s As String, colour As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  mBuffer.Graphics.DrawingColor = colour
		  
		  mBuffer.Graphics.DrawText(s, x, y)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawTransform(xf As Physics.Transform, colour As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  DrawCircle(xf.P, 0.1, colour)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndDrawing()
		  /// The world has finished drawing for this step.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Timing.Record(mDrawTimer.ElapsedMilliseconds)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainScreenScale() As Double
		  //Jim McKay Retina detection.
		  
		  Static value As Double
		  
		  if value < 1.0 then
		    
		    declare function NSClassFromString lib "Foundation" (aClassName as CFStringRef) as Ptr
		    soft declare function scale lib "UIKit" selector "scale" (classRef as Ptr) as CGFloat
		    soft declare function mainScreen lib "UIKit" selector "mainScreen" (classRef as Ptr) as ptr
		    
		    value = scale(mainScreen(NSClassFromString("UIScreen")))
		    
		  End If
		  
		  Return value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E
		Private Function PolygonPath(vertices() As VMaths.Vector2) As GraphicsPath
		  /// Returns a closed polygon provided in counter-clockwise order.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Var screenVertices() As VMaths.Vector2
		  For Each vertex As VMaths.Vector2 In vertices
		    screenVertices.Add(WorldToScreen(vertex))
		  Next vertex
		  
		  Var path As New GraphicsPath
		  path.MoveToPoint(screenVertices(0).X, screenVertices(0).Y)
		  
		  // Draw lines to all of the remaining points.
		  For Each vertex As VMaths.Vector2 In screenVertices
		    path.AddLineToPoint(vertex.X, vertex.Y)
		  Next vertex
		  
		  // Draw a line back to the starting point.
		  path.AddLineToPoint(screenVertices(0).X, screenVertices(0).Y)
		  
		  Return path
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265736574207468652063616E7661732720647261772074696D65732E
		Sub ResetTiming()
		  /// Reset the canvas' draw times.
		  
		  Timing = New Physics.ProfileEntry
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScreenToWorld(argScreen As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the screen coordinates and returns the world coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.ScreenToWorld(argScreen)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScreenXYToWorld(screenX As Double, screenY As Double) As VMaths.Vector2
		  /// Takes the screen X, Y coordinates and returns the world coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.ScreenToWorld(New VMaths.Vector2(screenX, screenY))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldDrawAABB() As Boolean
		  Return mShouldDrawAABB
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldDrawAABB(Assigns value As Boolean)
		  mShouldDrawAABB = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldDrawCenterOfMass() As Boolean
		  Return mShouldDrawCenterOfMass
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldDrawCenterOfMass(Assigns value As Boolean)
		  mShouldDrawCenterOfMass = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldDrawDynamicTree() As Boolean
		  Return mShouldDrawDynamicTree
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldDrawDynamicTree(Assigns value As Boolean)
		  mShouldDrawDynamicTree = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldDrawJoints() As Boolean
		  Return mShouldDrawJoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldDrawJoints(Assigns value As Boolean)
		  mShouldDrawJoints = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldDrawPairs() As Boolean
		  Return mShouldDrawPairs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldDrawPairs(Assigns value As Boolean)
		  mShouldDrawPairs = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldDrawShapes() As Boolean
		  Return mShouldDrawShapes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldDrawShapes(Assigns value As Boolean)
		  mShouldDrawShapes = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldDrawWireframes() As Boolean
		  Return mShouldDrawWireframes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldDrawWireframes(Assigns value As Boolean)
		  mShouldDrawWireframes = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Viewport() As Physics.ViewportTransform
		  Return mViewport
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Viewport(Assigns v As Physics.ViewportTransform)
		  mViewport = v
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WorldToScreen(argWorld As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the world coordinates and returns the screen coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.WorldToScreen(argWorld)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WorldToScreenXY(worldX As Double, worldY As Double) As VMaths.Vector2
		  /// Takes the world coordinates and returns the screen coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.WorldToScreen(New VMaths.Vector2(worldX, worldY))
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Paint(g As Graphics)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520757365722068617320746170706564207468652063616E7661732E
		Event Tapped(worldPos As VMaths.Vector2)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDrawTimer As Physics.Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldDrawAABB As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldDrawCenterOfMass As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldDrawDynamicTree As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldDrawJoints As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldDrawPairs As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldDrawShapes As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldDrawWireframes As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViewport As Physics.ViewportTransform
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436F6D7075746564207768656E207468652063616E766173206F70656E732E
		Private ScaleFactor As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865207363656E652E
		SceneBackgroundColor As Color = &cffffff
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5573656420746F207265636F72642074686520617665726167652C206D696E20616E64206D61782074696D6520656C6170736564207768656E2064726177696E672E
		Timing As Physics.ProfileEntry
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="TintColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
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
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
		#tag ViewProperty
			Name="AccessibilityHint"
			Visible=false
			Group="UI Control"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AccessibilityLabel"
			Visible=false
			Group="UI Control"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="UI Control"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="UI Control"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SceneBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&cffffff"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

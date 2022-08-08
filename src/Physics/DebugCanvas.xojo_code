#tag Class
Protected Class DebugCanvas
Inherits DesktopCanvas
Implements Physics.DebugDraw
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  mCurrentScaleFactorX = g.ScaleX
		  mCurrentScaleFactorY = g.ScaleY
		  
		  // We need a valid viewport. Ideally this should be set in the constructor but as 
		  // this is a canvas csubclass we don't have access to the constructor.
		  If Self.Viewport = Nil Then Return
		  
		  CheckBuffer
		  
		  g.DrawPicture(mBuffer, 0, 0)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendFlags(flags As Integer)
		  // Part of the Physics.DebugDraw interface.
		  
		  mDrawFlags = mDrawFlags Or flags
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520776F726C642069732061626F757420746F20626567696E2064726177696E6720666F72207468697320737465702E
		Sub BeginDrawing()
		  /// The world is about to begin drawing for this step.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
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
		  
		  #Pragma Warning "CHECK: Is this correct or should it be multiplied by ScaleFactor?"
		  If mBuffer.Width <> Self.Width * mCurrentScaleFactorX Or _
		    mBuffer.Height <> Self.Height * mCurrentScaleFactorY Then
		    CreateNewBuffer
		    Return
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearFlags(flags As Integer)
		  // Part of the Physics.DebugDraw interface.
		  
		  mDrawFlags = mDrawFlags And Bitwise.OnesComplement(flags)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 437265617465732061206E6577206261636B69676E20627566666572206F662074686520636F727265637420776964746820616E64206865696768742E
		Private Sub CreateNewBuffer()
		  /// Creates a new backign buffer of the correct width and height.
		  
		  #Pragma Warning "CHECK: Is this width & height * ScaleFactor?"
		  mBuffer = Self.Window.BitmapForCaching(Self.Width, Self.Height)
		  
		  // Use a monospace font.
		  #If TargetMacOS
		    mBuffer.Graphics.FontName = "Menlo"
		    
		  #ElseIf TargetWindows
		    mBuffer.Graphics.FontName = "Consolas"
		    
		  #ElseIf TargetLinux
		    mBuffer.Graphics.FontName = "DejaVu Sans Mono"
		    
		  #ElseIf TargetIOS
		    mBuffer.Graphics.FontName = "Menlo"
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawCircle(center As VMaths.Vector2, radius As Double, colour As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  Var screenRadius As Double = radius * Viewport.Scale
		  Var screenCenter As VMaths.Vector2 = WorldToScreen(center)
		  Var circumference As Double = radius * 2
		  
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
		Function DrawFlags() As Integer
		  Return mDrawFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawParticles(particles() As Physics.Particle, radius As Double)
		  // Part of the Physics.DebugDraw interface.
		  
		  #Pragma Unused particles
		  #Pragma Unused radius
		  
		  #Pragma Warning  "Don't forget to implement this method!"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawParticlesWireframe(particles() As Physics.Particle, radius As Double)
		  // Part of the Physics.DebugDraw interface.
		  
		  #Pragma Unused particles
		  #Pragma Unused radius
		  
		  #Pragma Warning  "Don't forget to implement this method!"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawPoint(argPoint As VMaths.Vector2, argRadiusOnScreen As Double, argColor As Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  #Pragma Unused argPoint
		  #Pragma Unused  argRadiusOnScreen
		  #Pragma Unused argColor
		  
		  #Pragma Warning  "Don't forget to implement this method!"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772074686520776972656672616D65206F66206120636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E
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
		  // Part of the Physics.DebugDraw interface.
		  
		  #Pragma Unused p1
		  #Pragma Unused p2
		  #Pragma Unused colour
		  
		  #Pragma Warning  "Don't forget to implement this method!"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawSolidCircle(center as VMaths.Vector2, radius as Double, colour as Color)
		  // Part of the Physics.DebugDraw interface.
		  
		  Var screenRadius As Double = radius * Viewport.Scale
		  Var screenCenter As VMaths.Vector2 = WorldToScreen(center)
		  Var circumference As Double = radius * 2
		  
		  mBuffer.Graphics.DrawingColor = colour
		  
		  mBuffer.Graphics.FillOval(screenCenter.X - screenRadius, _
		  screenCenter.Y - screenRadius, _
		  circumference, circumference)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4472617720612066696C6C656420636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E
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
		  
		  #Pragma Unused xf
		  #Pragma Unused colour
		  
		  #Pragma Warning  "Don't forget to implement this method!"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520776F726C64206861732066696E69736865642064726177696E6720666F72207468697320737465702E
		Sub EndDrawing()
		  /// The world has finished drawing for this step.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  
		End Sub
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

	#tag Method, Flags = &h0, Description = 54616B6573207468652073637265656E20636F6F7264696E6174657320616E642072657475726E732074686520776F726C6420636F6F7264696E617465732E
		Function ScreenToWorld(argScreen As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the screen coordinates and returns the world coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.ScreenToWorld(argScreen)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B65732074686520776F726C6420636F6F7264696E6174657320616E642072657475726E73207468652073637265656E20636F6F7264696E617465732E
		Function WorldToScreen(argWorld As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the world coordinates and returns the screen coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.WorldToScreen(argWorld)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B65732074686520776F726C6420636F6F7264696E6174657320616E642072657475726E73207468652073637265656E20636F6F7264696E617465732E
		Function WorldToScreenXY(worldX As Double, worldY As Double) As VMaths.Vector2
		  /// Takes the world coordinates and returns the screen coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.WorldToScreen(New VMaths.Vector2(worldX, worldY))
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentScaleFactorX As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentScaleFactorY As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDrawFlags As Integer = Physics.DebugDrawShapeBit
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865207363656E652E
		SceneBackgroundColor As Color = &cffffff
	#tag EndProperty

	#tag Property, Flags = &h0
		Viewport As Physics.ViewportTransform
	#tag EndProperty


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
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

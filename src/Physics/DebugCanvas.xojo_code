#tag Class
Protected Class DebugCanvas
Inherits DesktopCanvas
Implements Physics.DebugDraw
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  // We need a valid viewport. Ideally this should be set in the constructor but as 
		  // this is a canvas subclass we don't have access to the constructor.
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
		  
		  If mBuffer.Width <> Self.Width * ScaleFactor Or _
		    mBuffer.Height <> Self.Height * ScaleFactor Then
		    CreateNewBuffer
		    Return
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearFlag(flag As Integer)
		  // Part of the Physics.DebugDraw interface.
		  
		  mDrawFlags = mDrawFlags And OnesComplement(flag)
		  
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
		Function DrawFlags() As Integer
		  Return mDrawFlags
		End Function
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
		  
		  #Pragma Unused particles
		  #Pragma Unused radius
		  
		  Raise New UnsupportedOperationException("Not implemented.")
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

	#tag Method, Flags = &h0, Description = 447261772074686520776972656672616D65206F66206120636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E
		Sub DrawPolygon(vertices() As VMaths.Vector2, colour As Color)
		  /// Draw the wireframe of a closed polygon provided in counter-clockwise order.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  mBuffer.Graphics.DrawingColor = colour
		  mBuffer.Graphics.DrawPath(PolygonPath(vertices))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061206C696E65207365676D656E742E
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
		  
		  DrawCircle(xf.P, 0.1, colour)
		  
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

	#tag Method, Flags = &h0, Description = 54616B6573207468652073637265656E20582C205920636F6F7264696E6174657320616E642072657475726E732074686520776F726C6420636F6F7264696E617465732E
		Function ScreenXYToWorld(screenX As Double, screenY As Double) As VMaths.Vector2
		  /// Takes the screen X, Y coordinates and returns the world coordinates.
		  ///
		  /// Part of the Physics.DebugDraw interface.
		  
		  Return Viewport.ScreenToWorld(New VMaths.Vector2(screenX, screenY))
		  
		End Function
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


	#tag ComputedProperty, Flags = &h0, Description = 57686574686572206F72206E6F7420746F206472617720746865206178697320616C69676E656420626F756E64696E6720626F7865732061726F756E6420626F646965732E
		#tag Getter
			Get
			  Return (mDrawFlags And DrawAABBBit) <> 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    AppendFlags(DrawAABBBit)
			  Else
			    ClearFlag(DrawAABBBit)
			  End If
			End Set
		#tag EndSetter
		DrawAABB As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E207468652063656E747265206F66206D6173732077696C6C20626520647261776E20666F7220626F646965732E
		#tag Getter
			Get
			  Return (mDrawFlags And DrawCenterOfMassBit) <> 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    AppendFlags(DrawCenterOfMassBit)
			  Else
			    ClearFlag(DrawCenterOfMassBit)
			  End If
			End Set
		#tag EndSetter
		DrawCenterOfMass As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E207468652064796E616D696320747265652077696C6C20626520647261776E2E
		#tag Getter
			Get
			  Return (mDrawFlags And DrawDynamicTreeBit) <> 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    AppendFlags(DrawDynamicTreeBit)
			  Else
			    ClearFlag(DrawDynamicTreeBit)
			  End If
			End Set
		#tag EndSetter
		DrawDynamicTree As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E206A6F696E74732077696C6C20626520647261776E2E
		#tag Getter
			Get
			  Return (mDrawFlags And DrawJointBit) <> 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    AppendFlags(DrawJointBit)
			  Else
			    ClearFlag(DrawJointBit)
			  End If
			End Set
		#tag EndSetter
		DrawJoints As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2070616972732077696C6C20626520647261776E2E
		#tag Getter
			Get
			  Return (mDrawFlags And DrawPairBit) <> 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    AppendFlags(DrawPairBit)
			  Else
			    ClearFlag(DrawPairBit)
			  End If
			End Set
		#tag EndSetter
		DrawPairs As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E207368617065732077696C6C20626520647261776E2E
		#tag Getter
			Get
			  Return (mDrawFlags And DrawShapeBit) <> 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    AppendFlags(DrawShapeBit)
			  Else
			    ClearFlag(DrawShapeBit)
			  End If
			End Set
		#tag EndSetter
		DrawShapes As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E20776972656672616D657320726174686572207468616E20736F6C6964207368617065732077696C6C20626520647261776E2E
		#tag Getter
			Get
			  Return (mDrawFlags And DrawWireFrameDrawingBit) <> 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    AppendFlags(DrawWireFrameDrawingBit)
			  Else
			    ClearFlag(DrawWireFrameDrawingBit)
			  End If
			End Set
		#tag EndSetter
		DrawWireframes As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDrawFlags As Integer = Physics.DebugDrawShapeBit
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViewport As Physics.ViewportTransform
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865207363656E652E
		SceneBackgroundColor As Color = &cffffff
	#tag EndProperty


	#tag Constant, Name = DrawAABBBit, Type = Double, Dynamic = False, Default = \"8", Scope = Protected, Description = 44726177206178697320616C69676E656420626F756E64696E6720626F7865732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DrawCenterOfMassBit, Type = Double, Dynamic = False, Default = \"32", Scope = Protected, Description = 44726177207468652063656E747265206F66206D617373206F6620626F646965732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DrawDynamicTreeBit, Type = Double, Dynamic = False, Default = \"64", Scope = Protected, Description = 447261772064796E616D696320747265652E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DrawJointBit, Type = Double, Dynamic = False, Default = \"4", Scope = Protected, Description = 44726177206A6F696E7420636F6E6E656374696F6E732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DrawPairBit, Type = Double, Dynamic = False, Default = \"16", Scope = Protected, Description = 44726177207061697273206F6620636F6E6E6563746564206F626A656374732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DrawShapeBit, Type = Double, Dynamic = False, Default = \"2", Scope = Protected, Description = 44726177207368617065732E20466F722064656275672064726177696E672E
	#tag EndConstant

	#tag Constant, Name = DrawWireFrameDrawingBit, Type = Double, Dynamic = False, Default = \"128", Scope = Protected, Description = 44726177206F6E6C792074686520776972656672616D6520666F722064726177696E6720706572666F726D616E63652E20466F722064656275672064726177696E672E
	#tag EndConstant


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
		#tag ViewProperty
			Name="DrawCenterOfMass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawAABB"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawDynamicTree"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawJoints"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawPairs"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawShapes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawWireframes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

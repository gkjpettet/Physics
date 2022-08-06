#tag Class
 Attributes ( Abstract ) Protected Class DebugDraw
	#tag Method, Flags = &h0
		Sub AppendFlags(flags As Integer)
		  DrawFlags = DrawFlags Or flags
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearFlags(flags As Integer)
		  DrawFlags = DrawFlags And Bitwise.OnesComplement(flags)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(viewport As Physics.ViewportTransform)
		  Self.Viewport = viewport
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120636972636C652E204D75737420626520696D706C656D656E74656420627920737562636C61737365732E
		Sub DrawCircle(center As VMaths.Vector2, radius As Double, colour As Physics.Color3i)
		  /// Draw a circle.
		  /// Must be implemented by subclasses.
		  
		  #Pragma Unused center
		  #Pragma Unused radius
		  #Pragma Unused colour
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawCircleAxis(center As VMaths.Vector2, radius As Double, axis As VMaths.Vector2, colour As Physics.Color3i)
		  /// Draws a circle with an axis.
		  
		  #Pragma Unused axis
		  
		  DrawCircle(center, radius, colour)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061207061727469636C652061727261792E204D757374206265206F76657272696464656E20627920737562636C61737365732E
		Sub DrawParticles(particles() As Physics.Particle, radius As Double)
		  /// Draw a particle array.
		  /// Must be overridden by subclasses.
		  
		  #Pragma Unused particles
		  #Pragma Unused radius
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061207061727469636C652061727261792E204D757374206265206F76657272696464656E20627920737562636C61737365732E
		Sub DrawParticlesWireframe(particles() As Physics.Particle, radius As Double)
		  /// Draw a particle array.
		  /// Must be overridden by subclasses.
		  
		  #Pragma Unused particles
		  #Pragma Unused radius
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4472617773206120706F696E742E204D757374206265206F76657272696464656E20627920737562636C61737365732E
		Sub DrawPoint(argPoint As VMaths.Vector2, argRadiusOnScreen As Double, argColor As Physics.Color3i)
		  /// Draws a point. Must be overridden by subclasses.
		  
		  #Pragma Unused argPoint
		  #Pragma Unused argRadiusOnScreen
		  #Pragma Unused argColor
		  
		  Raise New UnsupportedOperationException("This method should be overridden by subclasses.")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E
		Sub DrawPolygon(vertices() As VMaths.Vector2, colour As Physics.Color3i)
		  /// Draw a closed polygon provided in counter-clockwise order.
		  ///
		  /// This implementation uses `DrawSegment()` to draw each side of the polygon.
		  
		  Var vertexCount As Integer = vertices.Count
		  
		  If vertexCount = 1 Then
		    DrawSegment(vertices(0), vertices(0), colour)
		    Return
		  End If
		  
		  Var iLimit As Integer = vertexCount - 2
		  For i As Integer = 0 To iLimit
		    DrawSegment(vertices(i), vertices(i + 1), colour)
		  Next i
		  
		  If vertexCount > 2 Then
		    DrawSegment(vertices(vertexCount - 1), vertices(0), colour)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061206C696E65207365676D656E742E204D75737420626520696D706C656D656E74656420627920737562636C61737365732E
		Sub DrawSegment(p1 As VMaths.Vector2, p2 As VMaths.Vector2, colour As Physics.Color3i)
		  /// Draw a line segment.
		  /// Must be implemented by subclasses.
		  
		  #Pragma Unused p1
		  #Pragma Unused p2
		  #Pragma Unused colour
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120736F6C696420636972636C652E204D75737420626520696D706C656D656E74656420627920737562636C61737365732E
		Sub DrawSolidCircle(center as VMaths.Vector2, radius as Double, colour as Physics.Color3i)
		  /// Draw a solid circle.
		  /// Must be implemented by subclasses.
		  
		  #Pragma Unused center
		  #Pragma Unused radius
		  #Pragma Unused colour
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120736F6C696420636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E204D75737420626520696D706C656D656E74656420627920737562636C61737365732E
		Sub DrawSolidPolygon(vertices() As VMaths.Vector2, colour As Physics.Color3i)
		  /// Draw a solid closed polygon provided in counter-clockwise order.
		  /// Must be implemented by subclasses.
		  
		  #Pragma Unused vertices
		  #Pragma Unused colour
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawString(pos As VMaths.Vector2, s As String, colour As Physics.Color3i)
		  DrawStringXY(pos.X, pos.Y, s, colour)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120737472696E672E204D757374206265206F76657272696464656E20627920737562636C61737365732E
		Sub DrawStringXY(x As Double, y As Double, s As String, colour As Physics.Color3i)
		  /// Draw a string.
		  /// Must be overridden by subclasses.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  #Pragma Unused s
		  #Pragma Unused colour
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061207472616E73666F726D2E204D757374206265206F76657272696464656E20627920737562636C61737365732E
		Sub DrawTransform(xf As Physics.Transform, colour As Physics.Color3i)
		  /// Draw a transform.
		  /// Must be overridden by subclasses.
		  ///
		  /// Choose your own length scale.
		  
		  #Pragma Unused xf
		  #Pragma Unused colour
		  
		  Raise New UnsupportedOperationException("This method must be overridden by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C65642061742074686520656E64206F662064726177696E67206120776F726C642E204D75737420626520696D706C656D656E74656420627920737562636C61737365732E
		Sub Flush()
		  /// Called at the end of drawing a world.
		  /// Must be implemented by subclasses.
		  
		  Raise New UnsupportedOperationException("Must be implemented by subclasses.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B6573207468652073637265656E20636F6F7264696E6174657320616E642072657475726E732074686520776F726C6420636F6F7264696E617465732E
		Function ScreenToWorld(argScreen As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the screen coordinates and returns the world coordinates.
		  
		  Return Viewport.ScreenToWorld(argScreen)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B65732074686520776F726C6420636F6F7264696E6174657320616E642072657475726E73207468652073637265656E20636F6F7264696E617465732E
		Function WorldToScreen(argWorld As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the world coordinates and returns the screen coordinates.
		  
		  Return Viewport.WorldToScreen(argWorld)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B65732074686520776F726C6420636F6F7264696E6174657320616E642072657475726E73207468652073637265656E20636F6F7264696E617465732E
		Function WorldToScreenXY(worldX As Double, worldY As Double) As VMaths.Vector2
		  /// Takes the world coordinates and returns the screen coordinates.
		  
		  Return Viewport.WorldToScreen(New VMaths.Vector2(worldX, worldY))
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Subclass this abstract class to allow `Xojo.Physics` to automatically draw your
		physics for debugging purposes.
		
		Not intended to replace your own custom rendering routines!
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		DrawFlags As Integer = Physics.DebugDraw.ShapeBit
	#tag EndProperty

	#tag Property, Flags = &h0
		Viewport As Physics.ViewportTransform
	#tag EndProperty


	#tag Constant, Name = AABBBit, Type = Double, Dynamic = False, Default = \"8", Scope = Public, Description = 44726177206178697320616C69676E656420626F756E64696E6720626F7865732E
	#tag EndConstant

	#tag Constant, Name = CenterOfMassBit, Type = Double, Dynamic = False, Default = \"32", Scope = Public, Description = 447261772063656E747265206F66206D617373206672616D652E
	#tag EndConstant

	#tag Constant, Name = DynamicTreeBit, Type = Double, Dynamic = False, Default = \"64", Scope = Public, Description = 447261772064796E616D696320747265652E
	#tag EndConstant

	#tag Constant, Name = JointBit, Type = Double, Dynamic = False, Default = \"4", Scope = Public, Description = 44726177206A6F696E7420636F6E6E656374696F6E732E
	#tag EndConstant

	#tag Constant, Name = PairBit, Type = Double, Dynamic = False, Default = \"16", Scope = Public, Description = 44726177207061697273206F6620636F6E6E6563746564206F626A656374732E
	#tag EndConstant

	#tag Constant, Name = ShapeBit, Type = Double, Dynamic = False, Default = \"2", Scope = Public, Description = 44726177207368617065732E
	#tag EndConstant

	#tag Constant, Name = WireFrameDrawingBit, Type = Double, Dynamic = False, Default = \"128", Scope = Public, Description = 44726177206F6E6C792074686520776972656672616D6520666F722064726177696E6720706572666F726D616E63652E
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
			Name="DrawFlags"
			Visible=false
			Group="Behavior"
			InitialValue="Physics.DebugDraw.ShapeBit"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

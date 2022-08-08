#tag Interface
Protected Interface DebugDraw
	#tag Method, Flags = &h0
		Sub AppendFlags(flags As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520776F726C642069732061626F757420746F20626567696E2064726177696E6720666F72207468697320737465702E
		Sub BeginDrawing()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearFlags(flags As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120636972636C652E
		Sub DrawCircle(center As VMaths.Vector2, radius As Double, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawCircleAxis(center As VMaths.Vector2, radius As Double, axis As VMaths.Vector2, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DrawFlags() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061207061727469636C652061727261792E
		Sub DrawParticles(particles() As Physics.Particle, radius As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061207061727469636C652061727261792E
		Sub DrawParticlesWireframe(particles() As Physics.Particle, radius As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4472617773206120706F696E742E
		Sub DrawPoint(argPoint As VMaths.Vector2, argRadiusOnScreen As Double, argColor As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E
		Sub DrawPolygon(vertices() As VMaths.Vector2, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061206C696E65207365676D656E742E
		Sub DrawSegment(p1 As VMaths.Vector2, p2 As VMaths.Vector2, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120736F6C696420636972636C652E20
		Sub DrawSolidCircle(center as VMaths.Vector2, radius as Double, colour as Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120736F6C696420636C6F73656420706F6C79676F6E2070726F766964656420696E20636F756E7465722D636C6F636B77697365206F726465722E
		Sub DrawSolidPolygon(vertices() As VMaths.Vector2, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120737472696E672E
		Sub DrawString(pos As VMaths.Vector2, s As String, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177206120737472696E672E
		Sub DrawStringXY(x As Double, y As Double, s As String, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261772061207472616E73666F726D2E
		Sub DrawTransform(xf As Physics.Transform, colour As Color)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520776F726C64206861732066696E69736865642064726177696E6720666F72207468697320737465702E
		Sub EndDrawing()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B6573207468652073637265656E20636F6F7264696E6174657320616E642072657475726E732074686520776F726C6420636F6F7264696E617465732E
		Function ScreenToWorld(argScreen As VMaths.Vector2) As VMaths.Vector2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B65732074686520776F726C6420636F6F7264696E6174657320616E642072657475726E73207468652073637265656E20636F6F7264696E617465732E
		Function WorldToScreen(argWorld As VMaths.Vector2) As VMaths.Vector2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B65732074686520776F726C6420636F6F7264696E6174657320616E642072657475726E73207468652073637265656E20636F6F7264696E617465732E
		Function WorldToScreenXY(worldX As Double, worldY As Double) As VMaths.Vector2
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Implement this interface to allow `Xojo.Physics` to automatically draw your
		physics for debugging purposes.
		
		
		
	#tag EndNote


End Interface
#tag EndInterface

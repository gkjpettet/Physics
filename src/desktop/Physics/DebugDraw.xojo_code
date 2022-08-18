#tag Interface
Protected Interface DebugDraw
	#tag Method, Flags = &h0, Description = 54686520776F726C642069732061626F757420746F20626567696E2064726177696E6720666F72207468697320737465702E
		Sub BeginDrawing()
		  
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

	#tag Method, Flags = &h0, Description = 54616B6573207468652073637265656E20582C205920636F6F7264696E6174657320616E642072657475726E732074686520776F726C6420636F6F7264696E617465732E
		Function ScreenXYToWorld(screenX As Double, screenY As Double) As VMaths.Vector2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E20617869732D616C69676E656420626F756E64696E6720626F7865732077696C6C20626520647261776E2E
		Function ShouldDrawAABB() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E20617869732D616C69676E656420626F756E64696E6720626F7865732077696C6C20626520647261776E2E
		Sub ShouldDrawAABB(Assigns value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E207468652063656E747265206F66206D6173732077696C6C20626520647261776E2E
		Function ShouldDrawCenterOfMass() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E207468652063656E747265206F66206D6173732077696C6C20626520647261776E2E
		Sub ShouldDrawCenterOfMass(Assigns value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E207468652064796E616D696320747265652077696C6C20626520647261776E2E
		Function ShouldDrawDynamicTree() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E207468652064796E616D696320747265652077696C6C20626520647261776E2E
		Sub ShouldDrawDynamicTree(Assigns value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E206A6F696E74732077696C6C20626520647261776E2E
		Function ShouldDrawJoints() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E206A6F696E74732077696C6C20626520647261776E2E
		Sub ShouldDrawJoints(Assigns value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E2070616972732077696C6C20626520647261776E2E
		Function ShouldDrawPairs() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E2070616972732077696C6C20626520647261776E2E
		Sub ShouldDrawPairs(Assigns value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E207368617065732077696C6C20626520647261776E2E
		Function ShouldDrawShapes() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E207368617065732077696C6C20626520647261776E2E
		Sub ShouldDrawShapes(Assigns value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E20776972656672616D65732077696C6C20626520647261776E2E
		Function ShouldDrawWireframes() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662054727565207468656E20776972656672616D65732077696C6C20626520647261776E2E
		Sub ShouldDrawWireframes(Assigns value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Viewport() As Physics.ViewportTransform
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Viewport(Assigns v As Physics.ViewportTransform)
		  
		End Sub
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
	#tag EndViewBehavior
End Interface
#tag EndInterface

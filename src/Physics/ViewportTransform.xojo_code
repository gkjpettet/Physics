#tag Class
Protected Class ViewportTransform
	#tag Method, Flags = &h0
		Sub Constructor(extents As VMaths.Vector2, center As VMaths.Vector2, scale As Double)
		  Self.Extents = extents
		  Self.Center = center
		  Self.Scale = scale
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B6573207468652073637265656E20636F6F7264696E6174657320616E642072657475726E2074686520636F72726573706F6E64696E6720776F726C6420636F6F7264696E617465732E
		Function ScreenToWorld(argScreen As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the screen coordinates and return the corresponding world
		  /// coordinates.
		  
		  Var tmp As VMaths.Vector2 = Translation
		  tmp.Y = tmp.Y * If(yFlip, 1, -1)
		  
		  Var translatedCorrected As VMaths.Vector2 = argScreen - tmp
		  
		  tmp = translatedCorrected - extents
		  tmp.Y = tmp.Y * -1
		  
		  Return tmp / scale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320746865207472616E73666F726D27732063656E74657220746F2074686520676976656E207820616E64207920636F6F7264696E617465732C20616E64207573696E672074686520676976656E207363616C652E
		Sub SetCamera(x As Double, y As Double, s As Double)
		  /// Sets the transform's center to the given x and y coordinates,
		  /// and using the given scale.
		  
		  Center.SetValues(x, y)
		  scale = s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B65732074686520776F726C6420636F6F7264696E6174657320616E642072657475726E2074686520636F72726573706F6E64696E672073637265656E20636F6F7264696E617465732E
		Function WorldToScreen(argWorld As VMaths.Vector2) As VMaths.Vector2
		  /// Takes the world coordinates and return the corresponding screen
		  /// coordinates.
		  
		  // Correct for the canvas considering the upper-left corner, rather than the
		  // centre, to be the origin.
		  Var gridCorrected As New VMaths.Vector2( _
		  (argWorld.X * scale) + Extents.X, _
		  Extents.Y - (argWorld.Y * scale))
		  
		  Var tmp As VMaths.Vector2 = Translation
		  tmp.Y = tmp.Y * If(yFlip, 1, -1)
		  
		  Return gridCorrected + tmp
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652063656E747265206F66207468652076696577706F72742E
		Center As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206973207468652068616C662D776964746820616E642068616C662D6865696768742E20546869732073686F756C64206265207468652061637475616C2068616C662D776964746820616E642068616C662D6865696768742C206E6F7420616E797468696E67207472616E73666F726D6564206F72207363616C65642E
		Extents As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 52657475726E7320746865207363616C696E6720666163746F72207573656420696E20636F6E76657274696E672066726F6D20776F726C642073697A657320746F2072656E646572696E672073697A65732E
		Scale As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E74207472616E736C6174696F6E2069732074686520646966666572656E636520696E2063616E76617320756E697473206265747765656E207468652061637475616C2063656E747265206F66207468652063616E76617320616E64207468652063757272656E746C79207370656369666965642063656E7472652E
		#tag Note
			/// The current translation is the difference in canvas units between the
			/// actual centre of the canvas and the currently specified centre. For
			/// example, if the actual canvas centre is (5, 5) but the current centre is
			/// (6, 6), the translation is (1, 1).
			
		#tag EndNote
		#tag Getter
			Get
			  Return Extents - Center
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Center.SetFrom(Extents)
			  Center.Subtract(value)
			  
			End Set
		#tag EndSetter
		Translation As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 496620776520666C69702074686520792061786973207768656E207472616E73666F726D696E672E
		YFlip As Boolean = False
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
			Name="YFlip"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

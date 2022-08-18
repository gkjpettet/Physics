#tag Class
Protected Class MassData
	#tag Method, Flags = &h0
		Function Clone() As Physics.MassData
		  Return MassData.Copy(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Center = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F706965732066726F6D2074686520676976656E206D61737320646174612E
		Shared Function Copy(md As Physics.MassData) As Physics.MassData
		  /// Copies from the given mass data.
		  
		  Var newMD As New Physics.MassData
		  
		  newMD.Mass = md.Mass
		  newMD.Center = md.Center.Clone
		  newMD.I = md.I
		  
		  Return newMD
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(md As Physics.MassData)
		  Mass = md.Mass
		  I = md.I
		  Center.SetFrom(md.Center)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Holds the mass data computed for a shape.
		Contains the mass, inertia and centre of the body.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520706F736974696F6E206F662074686520736861706527732063656E74726F69642072656C617469766520746F207468652073686170652773206F726967696E2E
		Center As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520726F746174696F6E616C20696E6572746961206F66207468652073686170652061626F757420746865206C6F63616C206F726967696E2E
		I As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D617373206F66207468652073686170652C20757375616C6C7920696E206B696C6F6772616D732E
		Mass As Double = 0.0
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
			Name="Mass"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="I"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

#tag Class
Protected Class Color3i
	#tag Method, Flags = &h0
		Shared Function Black() As Physics.Color3i
		  Return New Physics.Color3i(0, 0, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Blue() As Physics.Color3i
		  Return New Physics.Color3i(0, 0, 255)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Physics.Color3i
		  Return New Physics.Color3i(R, G, B, A)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(r As Integer, g As Integer, b As Integer, a As Double = 1.0)
		  Self.R = r
		  Self.G = g
		  Self.B = b
		  Self.A = a
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromRGBd(red As Double, green As Double, blue As Double, alpha As Double = 1.0) As Physics.Color3i
		  Return New Physics.Color3i( _
		  Floor(red * 255), _
		  Floor(green * 255), _
		  Floor(blue * 255), _
		  alpha)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Green() As Physics.Color3i
		  Return New Physics.Color3i(0, 255, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Red() As Physics.Color3i
		  Return New Physics.Color3i(255, 0, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFromColor3i(argColor As Physics.Color3i)
		  Self.R = argColor.R
		  Self.G = argColor.G
		  Self.B = argColor.B
		  Self.A = argColor.A
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFromRGBd(red As Double, green As Double, blue As Double, alpha As Double = -1)
		  Self.R = Floor(red * 255)
		  Self.G = Floor(green * 255)
		  Self.B = Floor(blue * 255)
		  Self.A = If(alpha = -1, Self.A, alpha)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRGB(red As Integer, green As Integer, blue As Integer, alpha As Double = -1)
		  Self.R = red
		  Self.G = green
		  Self.B = blue
		  Self.A = If(alpha = -1, Self.A, alpha)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return "Color3i(" + R.ToString + ", " + G.ToString + ", " + _
		  B.ToString + ", " + A.ToString + ")"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function White() As Physics.Color3i
		  Return New Physics.Color3i(255, 255, 255)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Zero() As Physics.Color3i
		  Return New Physics.Color3i(0, 0, 0, 1.0)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		A As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h0
		B As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		G As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		R As Integer = 0
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
			Name="R"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

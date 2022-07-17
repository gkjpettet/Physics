#tag Class
Protected Class Sweep
	#tag Method, Flags = &h0, Description = 416476616E63652074686520737765657020666F72776172642C207969656C64696E672061206E657720696E697469616C2073746174652E
		Sub Advance(alpha As Double)
		  /// Advance the sweep forward, yielding a new initial state.
		  
		  Var beta As Double = (alpha - Alpha0) / (1.0 - Alpha0)
		  C0.X = C0.X + (beta * (C.X - C0.X))
		  C0.Y = C0.Y + (beta * (C.Y - C0.Y))
		  A0 = A0 + (beta * (a - a0))
		  Alpha0 = alpha
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mLocalCenter = VMaths.Vector2.Zero
		  mC = VMaths.Vector2.Zero
		  mC0 = VMaths.Vector2.Zero
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520696E746572706F6C61746564207472616E73666F726D20617420612073706563696669632074696D652E
		Sub GetTransform(ByRef xf As Physics.Transform, beta As Double)
		  /// Get the interpolated transform at a specific time.
		  ///
		  /// The result is placed in `xf`.
		  /// `beta` should be the normalized time in `0,1`.
		  
		  xf.P.X = (1.0 - beta) * C0.X + beta * c.X
		  xf.P.Y = (1.0 - beta) * C0.Y + beta * c.Y
		  Var angle As Double = (1.0 - beta) * A0 + beta * A
		  xf.Q.SetAngle(angle)
		  
		  // Shift to origin.
		  Var q As Physics.Rot = xf.Q
		  xf.P.X = xf.P.X - (q.Cos * LocalCenter.X - q.Sin * LocalCenter.Y)
		  xf.P.Y = xf.P.Y - (q.Sin * LocalCenter.X + q.Cos * LocalCenter.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Normalize()
		  Var d As Double = Maths.PI * 2 * Floor((A0 / Maths.PI * 2))
		  A0 = A0 - d
		  A = A - d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Set(other As Physics.Sweep) As Physics.Sweep
		  LocalCenter.SetFrom(other.LocalCenter)
		  C0.SetFrom(other.C0)
		  C.SetFrom(other.C)
		  A0 = other.A0
		  A = other.A
		  Alpha0 = other.Alpha0
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Var s() As String
		  
		  s.Add("Sweep:" + EndOfLine + "LocalCenter: " + LocalCenter.ToString + EndOfLine)
		  s.Add("C0: " + c0.ToString + ", C: " + C.ToString + EndOfLine)
		  s.Add("A0: " + A0.ToString + ", A: " + A.ToString + EndOfLine)
		  s.Add("Alpha0: " + Alpha0.ToString)
		  
		  Return String.FromArray(s, "")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 4F6E65206F662074776F2077726F6C6420616E676C65732E
		A As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F6E65206F662074776F2077726F6C6420616E676C65732E
		A0 As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4672616374696F6E206F66207468652063757272656E742074696D65207374657020696E207468652072616E6765205B302C315D206043306020616E642060413060206172652074686520706F736974696F6E732061742060416C70686130602E
		Alpha0 As Double = 0.0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 4F6E65206F662074776F2063656E74726520776F726C6420706F736974696F6E732E
		#tag Getter
			Get
			  Return mC
			End Get
		#tag EndGetter
		Private C As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 4F6E65206F662074776F2063656E74726520776F726C6420706F736974696F6E732E
		#tag Getter
			Get
			  Return mC0
			End Get
		#tag EndGetter
		Private C0 As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 4C6F63616C2063656E747265206F66206D61737320706F736974696F6E2E
		#tag Getter
			Get
			  Return mLocalCenter
			End Get
		#tag EndGetter
		LocalCenter As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4F6E65206F662074776F2063656E74726520776F726C6420706F736974696F6E732E
		Private mC As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4F6E65206F662074776F2063656E74726520776F726C6420706F736974696F6E732E
		Private mC0 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4C6F63616C2063656E747265206F66206D61737320706F736974696F6E2E
		Private mLocalCenter As VMaths.Vector2
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
	#tag EndViewBehavior
End Class
#tag EndClass

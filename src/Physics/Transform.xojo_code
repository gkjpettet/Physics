#tag Class
Protected Class Transform
	#tag Method, Flags = &h0, Description = 496E697469616C697365206173206120636F7079206F6620616E6F74686572207472616E73666F726D2E
		Shared Function Clone(xf As Physics.Transform) As Physics.Transform
		  /// Initialise as a copy of another transform.
		  
		  Var t As New Physics.Transform
		  t.mP = xf.P.Clone
		  t.mQ = xf.Q.Clone
		  
		  Return t
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E697469616C697365207573696E67206120706F736974696F6E20766563746F7220616E64206120726F746174696F6E206D61747269782E
		Shared Function From(position As VMaths.Vector2, r As Physics.Rot) As Physics.Transform
		  /// Initialise using a position vector and a rotation matrix.
		  
		  Var t As New Physics.Transform
		  
		  t.mP = position.Clone
		  t.mQ = r.Clone
		  
		  Return t
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Mul(a As Physics.Transform, b As Physics.Transform) As Physics.Transform
		  Var c As Physics.Transform = Physics.Transform.Zero
		  
		  c.Q.SetFrom(Rot.Mul(a.Q, b.Q))
		  c.P.SetFrom(Rot.MulVec2(a.Q, b.P))
		  c.P.Add(a.P)
		  
		  Return C
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MulTrans(A As Physics.Transform, b As Physics.Transform) As Physics.Transform
		  Var v As VMaths.Vector2 = b.P - a.P
		  
		  Return Physics.Transform.From(Rot.MulTransVec2(a.Q, v), Rot.MulTrans(a.Q, b.Q))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MulTransVec2(t As Physics.Transform, v As VMaths.Vector2) As VMaths.Vector2
		  Var pX As Double = v.X - t.P.X
		  Var pY As Double = v.Y - t.P.Y
		  
		  Return New VMaths.Vector2(t.Q.Cos * pX + t.Q.Sin * pY, _
		  -t.Q.Sin * pX + t.Q.Cos * pY)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MulVec2(t As Physics.Transform, v As VMaths.Vector2) As VMaths.Vector2
		  Return New VMaths.Vector2( _
		  (t.Q.Cos * v.X - t.Q.Sin * v.Y) + t.P.X, _
		  (t.Q.Sin * v.X + t.Q.Cos * v.Y) + t.P.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574207468697320746F20657175616C20616E6F74686572207472616E73666F726D2E
		Function Set(xf As Physics.Transform) As Physics.Transform
		  /// Set this to equal another transform.
		  
		  mP.SetFrom(xf.P)
		  mQ.SetFrom(xf.Q)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574207468697320746F20746865206964656E74697479207472616E73666F726D2E
		Sub SetIdentity()
		  /// Set this to the identity transform.
		  
		  mP.SetZero
		  mQ.SetIdentity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742074686973206261736564206F6E2074686520706F736974696F6E20616E6420616E676C652E
		Sub SetVec2Angle(position As VMaths.Vector2, angle As Double)
		  /// Set this based on the position and angle.
		  
		  mP.SetFrom(position)
		  mQ.SetAngle(angle)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Var s As String = "XForm:" + EndOfLine
		  s = s + "Position: " + P.ToString + EndOfLine
		  s = s + "R: " + &u0009 + Q.ToString + EndOfLine
		  
		  Return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652064656661756C7420636F6E7374727563746F722E
		Shared Function Zero() As Physics.Transform
		  /// The default constructor.
		  
		  Var t As New Physics.Transform
		  t.mP = VMaths.Vector2.Zero
		  t.mQ = New Physics.Rot
		  
		  Return t
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A transform contains translation and rotation. It is used to represent the
		position and orientation of rigid frames.
		
	#tag EndNote


	#tag Property, Flags = &h1, Description = 546865207472616E736C6174696F6E2063617573656420627920746865207472616E73666F726D
		Protected mP As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 41206D617472697820726570726573656E74696E67206120726F746174696F6E2E
		Protected mQ As Physics.Rot
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207472616E736C6174696F6E2063617573656420627920746865207472616E73666F726D
		#tag Getter
			Get
			  Return mP
			End Get
		#tag EndGetter
		P As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 41206D617472697820726570726573656E74696E67206120726F746174696F6E2E
		#tag Getter
			Get
			  Return mQ
			End Get
		#tag EndGetter
		Q As Physics.Rot
	#tag EndComputedProperty


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
			Name="mP"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

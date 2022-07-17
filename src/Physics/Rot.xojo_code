#tag Class
Protected Class Rot
	#tag Method, Flags = &h0
		Function Clone() As Physics.Rot
		  Return New Physics.Rot(Self.Sin, Self.Cos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sin As Double = 0.0, cos As Double = 1.0)
		  Self.Sin = sin
		  Self.Cos = cos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAngle() As Double
		  Return ATan2(Self.Sin, Self.Cos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCos() As Double
		  Return Self.Cos
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSin() As Double
		  Return Self.Sin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetXAxis(xAxis As VMaths.Vector2) As VMaths.Vector2
		  #Pragma Unused xAxis
		  
		  #Pragma Warning "BUG? I think there is a bug in Forge2D"
		  // https://github.com/flame-engine/forge2d/issues/60#issuecomment-1186529420
		  
		  Return New VMaths.Vector2(Self.Cos, Self.Sin)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetYAxis(yAxis As VMaths.Vector2) As VMaths.Vector2
		  #Pragma Unused yAxis
		  
		  #Pragma Warning "BUG? I think there is a bug in Forge2D"
		  // https://github.com/flame-engine/forge2d/issues/60#issuecomment-1186529420
		  
		  Return New VMaths.Vector2(-Self.Sin, Self.Cos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Mul(q As Physics.Rot, r As Physics.Rot) As Physics.Rot
		  Return New Physics.Rot(_
		  q.Sin * r.Cos + q.Cos * r.Sin, _
		  q.Cos * r.Cos - q.Sin * r.Sin)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MulTrans(q As Physics.Rot, r As Physics.Rot) As Physics.Rot
		  Return New Physics.Rot(_
		  q.Cos * r.Sin - q.Sin * r.Cos, _
		  q.Cos * r.Cos + q.Sin * r.Sin)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MulTransVec2(q As Physics.Rot, v As VMaths.Vector2) As VMaths.Vector2
		  Return New VMaths.Vector2(q.Cos * v.X + q.Sin * v.Y, -q.Sin * v.X + q.Cos * v.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MulVec2(q As Physics.Rot, v As VMaths.Vector2) As VMaths.Vector2
		  Return New VMaths.Vector2(q.Cos * v.X - q.Sin * v.Y, q.Sin * v.X + q.Cos * v.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetAngle(angle As Double)
		  Self.Sin = Sin(angle)
		  Self.Cos = Cos(angle)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFrom(other As Physics.Rot)
		  Self.Sin = other.Sin
		  Self.Cos = other.Cos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetIdentity()
		  Self.Sin = 0.0
		  Self.Cos = 1.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return "Rot(s:" + Self.Sin.ToString + ", c:" + Self.Cos.ToString + ")"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function WithAngle(angle As Double) As Physics.Rot
		  Return New Physics.Rot(Sin(angle), Cos(angle))
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Cos As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Sin As Double
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
			Name="Sin"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

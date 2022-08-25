#tag Class
Protected Class EdgeShape
Inherits Shape
	#tag Method, Flags = &h0
		Function ChildCount() As Integer
		  Return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Physics.Shape
		  Var edge As New Physics.EdgeShape
		  edge.Radius = Radius
		  edge.HasVertex0 = HasVertex0
		  edge.HasVertex3 = HasVertex3
		  edge.Vertex0.SetFrom(Vertex0)
		  edge.Vertex1.SetFrom(Vertex1)
		  edge.Vertex2.SetFrom(Vertex2)
		  edge.Vertex3.SetFrom(Vertex3)
		  
		  Return edge
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476976656E2061207472616E73666F726D2C20636F6D7075746520746865206173736F636961746564206178697320616C69676E656420626F756E64696E6720626F7820666F722061206368696C642073686170652E
		Sub ComputeAABB(aabb As Physics.AABB, xf As Physics.Transform, childIndex As Integer)
		  #Pragma Unused childIndex
		  
		  Var lowerBound As VMaths.Vector2 = aabb.LowerBound
		  Var upperBound As VMaths.Vector2 = aabb.UpperBound
		  Var xfq As Physics.Rot = xf.Q
		  
		  Var v1x As Double = (xfq.Cos * Vertex1.X - xfq.Sin * Vertex1.Y) + xf.P.X
		  Var v1y As Double = (xfq.Sin * Vertex1.X + xfq.Cos * Vertex1.Y) + xf.P.Y
		  Var v2x As Double = (xfq.Cos * Vertex2.X - xfq.Sin * Vertex2.Y) + xf.P.X
		  Var v2y As Double = (xfq.Sin * Vertex2.X + xfq.Cos * Vertex2.Y) + xf.P.Y
		  
		  lowerBound.X = If(v1x < v2x, v1x, v2x)
		  lowerBound.Y = If(v1y < v2y, v1y, v2y)
		  upperBound.X = If(v1x > v2x, v1x, v2x)
		  upperBound.Y = If(v1y > v2y, v1y, v2y)
		  
		  lowerBound.X = lowerBound.X - radius
		  lowerBound.Y = lowerBound.Y - radius
		  upperBound.X = upperBound.X + radius
		  upperBound.Y = upperBound.Y + radius
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70757465207468652064697374616E63652066726F6D207468652063757272656E7420736861706520746F207468652073706563696669656420706F696E742E2052657475726E73207468652064697374616E63652066726F6D207468652063757272656E742073686170652E
		Function ComputeDistanceToOut(xf As Physics.Transform, p As VMaths.Vector2, childIndex As Integer, ByRef normalOut As VMaths.Vector2) As Double
		  #Pragma Unused childIndex
		  
		  Var xfqc As Double = xf.Q.Cos
		  Var xfqs As Double = xf.Q.Sin
		  Var xfpx As Double = xf.P.X
		  Var xfpy As Double = xf.P.Y
		  Var v1x As Double = (xfqc * Vertex1.X - xfqs * Vertex1.Y) + xfpx
		  Var v1y As Double = (xfqs * Vertex1.X + xfqc * Vertex1.Y) + xfpy
		  Var v2x As Double = (xfqc * Vertex2.X - xfqs * Vertex2.Y) + xfpx
		  Var v2y As Double = (xfqs * Vertex2.X + xfqc * Vertex2.Y) + xfpy
		  
		  Var dx As Double = p.X - v1x
		  var dy As Double = p.Y - v1y
		  Var sx As Double = v2x - v1x
		  Var sy As Double = v2y - v1y
		  Var ds As Double = dx * sx + dy * sy
		  If ds > 0 Then
		    Var s2 As Double = sx * sx + sy * sy
		    If ds > s2 Then
		      dx = p.X - v2x
		      dy = p.Y - v2y
		    Else
		      dx = dx - (ds / s2 * sx)
		      dy = dy - (ds / s2 * sy)
		    End If
		  End If
		  
		  Var d1 As Double = Sqrt(dx * dx + dy * dy)
		  If d1 > 0 Then
		    normalOut.X = 1 / d1 * dx
		    normalOut.Y = 1 / d1 * dy
		  Else
		    normalOut.X = 0.0
		    normalOut.Y = 0.0
		  End If
		  
		  Return d1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D7075746520746865206D6173732070726F70657274696573206F662074686973207368617065207573696E67206974732064696D656E73696F6E7320616E642064656E736974792E2054686520696E65727469612074656E736F7220697320636F6D70757465642061626F757420746865206C6F63616C206F726967696E2E
		Sub ComputeMass(massData As Physics.MassData, density As Double)
		  #Pragma Unused density
		  
		  massData.Mass = 0.0
		  massData.Center.SetFrom(Vertex1)
		  massData.Center.Add(Vertex2)
		  massData.Center.Scale(0.5)
		  massData.I = 0.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor(Physics.ShapeType.Edge)
		  
		  Vertex0 = VMaths.Vector2.Zero
		  Vertex1 = VMaths.Vector2.Zero
		  Vertex2 = VMaths.Vector2.Zero
		  Vertex3 = VMaths.Vector2.Zero
		  
		  Radius = Physics.Settings.PolygonRadius
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4361737420612072617920616761696E73742061206368696C642073686170652E2052657475726E73205472756520696620746865206368696C64207368617065206973206869742E
		Function Raycast(output As Physics.RaycastOutput, input As Physics.RaycastInput, xf As Physics.Transform, childIndex As Integer = 0) As Boolean
		  #Pragma Unused childIndex
		  
		  Var v1 As VMaths.Vector2 = Vertex1
		  Var v2 As VMaths.Vector2 = Vertex2
		  Var xfq As Physics.Rot = xf.Q
		  Var xfp As VMaths.Vector2 = xf.P
		  
		  // Put the ray into the edge's frame of reference.
		  Var tempX As Double = input.P1.X - xfp.X
		  Var tempY As Double = input.P1.Y - xfp.Y
		  Var p1x As Double = xfq.Cos * tempX + xfq.Sin * tempY
		  Var p1y As Double = -xfq.Sin * tempX + xfq.Cos * tempY
		  
		  tempX = input.P2.X - xfp.X
		  tempY = input.P2.Y - xfp.Y
		  Var p2x As Double = xfq.Cos * tempX + xfq.Sin * tempY
		  Var p2y As Double = -xfq.Sin * tempX + xfq.Cos * tempY
		  
		  Var dx As Double = p2x - p1x
		  Var dy As Double = p2y - p1y
		  
		  Var normal As VMaths.Vector2 = New VMaths.Vector2(v2.Y - v1.Y, v1.X - v2.X)
		  normal.Normalize
		  
		  tempX = v1.X - p1x
		  tempY = v1.Y - p1y
		  Var numerator As Double = normal.X * tempX + normal.Y * tempY
		  Var denominator As Double = normal.X * dx + normal.Y * dy
		  
		  If denominator = 0.0 Then
		    Return False
		  End If
		  
		  Var t As Double = numerator / denominator
		  If t < 0.0 Or 1.0 < t Then
		    Return False
		  End If
		  
		  Var qx As Double = p1x + t * dx
		  Var qy As Double = p1y + t * dy
		  
		  Var rx As Double = v2.X - v1.X
		  Var ry As Double = v2.Y - v1.Y
		  Var rr As Double = rx * rx + ry * ry
		  If rr = 0.0 Then
		    Return False
		  End If
		  tempX = qx - v1.X
		  tempY = qy - v1.Y
		  Var s As Double = (tempX * rx + tempY * ry) / rr
		  If s < 0.0 Or 1.0 < s Then
		    Return False
		  End If
		  
		  output.Fraction = t
		  If numerator > 0.0 Then
		    output.Normal.X = -xfq.Cos * normal.X + xfq.Sin * normal.Y
		    output.Normal.Y = -xfq.Sin * normal.X - xfq.Cos * normal.Y
		  Else
		    output.Normal.X = xfq.Cos * normal.X - xfq.Sin * normal.Y
		    output.Normal.Y = xfq.Sin * normal.X + xfq.Cos * normal.Y
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(v1 As VMaths.Vector2, v2 As VMaths.Vector2)
		  Vertex1.SetFrom(v1)
		  Vertex2.SetFrom(v2)
		  hasVertex0 = (hasVertex3 = False)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54657374206120706F696E7420666F7220636F6E7461696E6D656E7420696E20746869732073686170652E2054686973206F6E6C7920776F726B7320666F7220636F6E766578207368617065732E
		Function TestPoint(xf As Physics.Transform, point As VMaths.Vector2) As Boolean
		  #Pragma Unused xf
		  #Pragma Unused point
		  
		  Return False
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A line segment (edge) shape. These can be connected in chains or loops to
		other edge shapes. The connectivity information is used to ensure correct
		contact normals.
	#tag EndNote


	#tag Property, Flags = &h0
		HasVertex0 As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		HasVertex3 As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2061646A6163656E742076657274657820312E205573656420666F7220736D6F6F746820636F6C6C6973696F6E2E
		Vertex0 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 456467652076657274657820312E
		Vertex1 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 456467652076657274657820322E
		Vertex2 As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2061646A6163656E742076657274657820322E205573656420666F7220736D6F6F746820636F6C6C6973696F6E2E
		Vertex3 As VMaths.Vector2
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
			Name="HasVertex0"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVertex3"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

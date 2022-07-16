#tag Class
Protected Class Vector2Tests
Inherits TestGroup
	#tag Method, Flags = &h0
		Sub AbsoluteErrorTest()
		  Var v1 As New VMaths.Vector2(1, 2)
		  Var v2 As New VMaths.Vector2(-3, 5)
		  Var v3 As New VMaths.Vector2(-3, 4)
		  Var v4 As New VMaths.Vector2(0, 0)
		  
		  Assert.AreEqual(5.0, v1.AbsoluteError(v2))
		  Assert.AreEqual(4.47213595499958, v1.AbsoluteError(v3))
		  Assert.AreEqual(2.23606797749979, v1.AbsoluteError(v4))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddScaledTest()
		  Var v1 As New VMaths.Vector2(1, 2)
		  Var v2 As New VMaths.Vector2(3, -4)
		  
		  Assert.AreEqual(New VMaths.Vector2(2, 4), VMaths.Vector2.Zero.AddScaled(v1, 2))
		  Assert.AreEqual(VMaths.Vector2.Zero, VMaths.Vector2.Zero.AddScaled(v2, 0))
		  Assert.AreEqual(New VMaths.Vector2(10.6, -10.8), v1.AddScaled(v2, 3.2))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFromArrayTest()
		  Var d() As Double = Array(0.0, 1.0, 2.0, 3.0)
		  Var v As New VMaths.Vector2(0, 0)
		  v.CopyFromArray(d, 2)
		  Assert.IsTrue(v.X = 2.0 And v.Y = 3.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyIntoArrayTest()
		  Var d() As Double = Array(0.0, 1.0, 2.0, 3.0)
		  Var v As New VMaths.Vector2(-7, -8)
		  v.CopyIntoArray(d)
		  Assert.IsTrue(d(0) = -7 And d(1) = -8)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NormalizeTest()
		  Var v1 As New VMaths.Vector2(1, 2)
		  Var v2 As New VMaths.Vector2(3, -4)
		  Var v3 As New VMaths.Vector2(5.5, 6.7)
		  
		  Assert.AreEqual(2.23606797749979, v1.Normalize)
		  Assert.AreEqual(0.4472135954999579, v1.X)
		  Assert.AreEqual(0.8944271909999159, v1.Y)
		  
		  Assert.AreEqual(5.0, v2.Normalize)
		  Assert.AreEqual(0.6, v2.X)
		  Assert.AreEqual(-0.8, v2.Y)
		  
		  Assert.AreEqual(8.668333173107735, v3.Normalize)
		  Assert.AreEqual(0.6344933783882424, v3.X)
		  Assert.AreEqual(0.7729282973093135, v3.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReflectTest()
		  Var v1 As New VMaths.Vector2(1, 2)
		  Var v2 As New VMaths.Vector2(3, -4)
		  Var v3 As New VMaths.Vector2(5.5, 6.7)
		  
		  v1.Reflect(New VMaths.Vector2(6, 7))
		  v2.Reflect(New VMaths.Vector2(6, 7))
		  v3.Reflect(New VMaths.Vector2(6, 7))
		  
		  Assert.AreEqual(New VMaths.Vector2(-239, -278), v1)
		  Assert.AreEqual(New VMaths.Vector2(123, 136), v2)
		  Assert.AreEqual(New VMaths.Vector2(-953.3, -1111.9), v3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RelativeErrorTest()
		  Var v1 As New VMaths.Vector2(1, 2)
		  Var v2 As New VMaths.Vector2(3, -4)
		  Var v3 As New VMaths.Vector2(5.5, 6.7)
		  Var correct As New VMaths.Vector2(2.5, 8)
		  
		  Assert.AreEqual(0.7378915813079348, v1.RelativeError(correct))
		  Assert.AreEqual(1.432962240576544, v2.RelativeError(correct))
		  Assert.AreEqual(0.39009078238961004, v3.RelativeError(correct))
		  
		  Assert.AreEqual(New VMaths.Vector2(1, 2), v1)
		  Assert.AreEqual(New VMaths.Vector2(3, -4), v2)
		  Assert.AreEqual(New VMaths.Vector2(5.5, 6.7), v3)
		  assert.AreEqual(New VMaths.Vector2(2.5, 8), correct)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RoundToZeroTest()
		  Var v1 As New VMaths.Vector2(1.1, 2.9)
		  Var v2 As New VMaths.Vector2(3, -4)
		  Var v3 As New VMaths.Vector2(5.5, 6.7)
		  
		  v1.RoundToZero
		  v2.RoundToZero
		  v3.RoundToZero
		  
		  Assert.AreEqual(New VMaths.Vector2(1, 2), v1)
		  Assert.AreEqual(New VMaths.Vector2(3, -4), v2)
		  Assert.AreEqual(New VMaths.Vector2(5, 6), v3)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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

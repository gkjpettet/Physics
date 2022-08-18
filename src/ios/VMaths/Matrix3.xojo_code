#tag Class
Protected Class Matrix3
	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6D706F6E656E742077697365206162736F6C7574652076616C7565206F662074686973206D61747269782E
		Function Absolute() As VMaths.Matrix3
		  /// Returns the component wise absolute value of this matrix.
		  
		  Var r As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  r.Storage(0) = Abs(Self.Storage(0))
		  r.Storage(1) = Abs(Self.Storage(1))
		  r.Storage(2) = Abs(Self.Storage(2))
		  r.Storage(3) = Abs(Self.Storage(3))
		  r.Storage(4) = Abs(Self.Storage(4))
		  r.Storage(5) = Abs(Self.Storage(5))
		  r.Storage(6) = Abs(Self.Storage(6))
		  r.Storage(7) = Abs(Self.Storage(7))
		  r.Storage(8) = Abs(Self.Storage(8))
		  
		  Return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206162736F6C757465206572726F72206265747765656E2074686973206D617472697820616E642060636F7272656374602E
		Function AbsoluteError(correct As VMaths.Matrix3) As Double
		  /// Returns the absolute error between this matrix and `correct`.
		  
		  Var this_norm As Double = InfinityNorm
		  Var correct_norm As Double = correct.InfinityNorm
		  Var diff_norm As Double = Abs(this_norm - correct_norm)
		  
		  Return diff_norm
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526F746174657320606172676020627920746865206162736F6C75746520726F746174696F6E206F662074686973206D61747269782E2052657475726E732060617267602E
		Function AbsoluteRotate(arg As VMaths.Vector3) As VMaths.Vector3
		  /// Rotates `arg` by the absolute rotation of this matrix.
		  /// Returns `arg`. 
		  ///
		  /// Primarily used by AABB transformation code.
		  
		  Var m00 As Double = Abs(Storage(0))
		  Var m01 As Double = Abs(Storage(3))
		  Var m02 As Double = Abs(Storage(6))
		  Var m10 As Double = Abs(Storage(1))
		  Var m11 As Double = Abs(Storage(4))
		  Var m12 As Double = Abs(Storage(7))
		  Var m20 As Double = Abs(Storage(2))
		  Var m21 As Double = Abs(Storage(5))
		  Var m22 As Double = Abs(Storage(8))
		  
		  Var x As Double = arg.X
		  Var y As Double = arg.Y
		  Var z As Double = arg.Z
		  
		  arg.X = x * m00 + y * m01 + z * m02
		  arg.Y = x * m10 + y * m11 + z * m12
		  arg.Z = x * m20 + y * m21 + z * m22
		  
		  Return arg
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526F746174657320606172676020627920746865206162736F6C75746520726F746174696F6E206F662074686973206D61747269782E
		Function AbsoluteRotate2(arg As VMaths.Vector2) As VMaths.Vector2
		  /// Rotates `arg` by the absolute rotation of this matrix.
		  // /Returns `arg`. 
		  ///
		  /// Primarily used by AABB transformation code.
		  
		  Var m00 As Double = Abs(Storage(0))
		  Var m01 As Double = Abs(Storage(3))
		  Var m10 As Double = Abs(Storage(1))
		  Var m11 As Double = Abs(Storage(4))
		  
		  Var x As Double = arg.X
		  Var y As Double = arg.Y
		  
		  arg.X = x * m00 + y * m01
		  arg.Y = x * m10 + y * m11
		  
		  Return arg
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320606F6020746F2074686973206D61747269782E
		Sub Add(o As VMaths.Matrix3)
		  /// Adds `o` to this matrix.
		  
		  Storage(0) = Storage(0) + o.Storage(0)
		  Storage(1) = Storage(1) + o.Storage(1)
		  Storage(2) = Storage(2) + o.Storage(2)
		  Storage(3) = Storage(3) + o.Storage(3)
		  Storage(4) = Storage(4) + o.Storage(4)
		  Storage(5) = Storage(5) + o.Storage(5)
		  Storage(6) = Storage(6) + o.Storage(6)
		  Storage(7) = Storage(7) + o.Storage(7)
		  Storage(8) = Storage(8) + o.Storage(8)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320606F6020746F2074686973206D617472697820616E642072657475726E7320697473656C662E
		Function Add(o As VMaths.Matrix3) As VMaths.Matrix3
		  /// Adds `o` to this matrix and returns itself.
		  
		  Storage(0) = Storage(0) + o.Storage(0)
		  Storage(1) = Storage(1) + o.Storage(1)
		  Storage(2) = Storage(2) + o.Storage(2)
		  Storage(3) = Storage(3) + o.Storage(3)
		  Storage(4) = Storage(4) + o.Storage(4)
		  Storage(5) = Storage(5) + o.Storage(5)
		  Storage(6) = Storage(6) + o.Storage(6)
		  Storage(7) = Storage(7) + o.Storage(7)
		  Storage(8) = Storage(8) + o.Storage(8)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C792074686973206D617472697820746F206561636820736574206F662078797A2076616C75657320696E206061727260207374617274696E6720617420606F6666736574602E2052657475726E732060617272602E
		Function ApplyToVector3Array(arr() As Double, offset As Integer = 0) As Double()
		  /// Multiply this matrix to each set of xyz values in `arr` starting at `offset`.
		  /// Returns `arr`.
		  
		  Var i As Integer = 0
		  Var j As Integer = offset
		  
		  While i < arr.Count
		    Var v As VMaths.Vector3 = VMaths.Vector3.FromArray(arr, j)
		    v.ApplyMatrix3(Self)
		    arr(j) = v.X
		    arr(j + 1) = v.Y
		    arr(j + 2) = v.Z
		    
		    i = i + 3
		    j = j + 3
		  Wend
		  
		  Return arr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120636C6F6E65206F662074686973206D61747269782E
		Function Clone() As VMaths.Matrix3
		  /// Returns a clone of this matrix.
		  
		  Return VMaths.Matrix3.Copy(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E657720604D617472697833602066726F6D2060636F6C756D6E73602E
		Shared Function Columns(arg0 As VMaths.Vector3, arg1 As VMaths.Vector3, arg2 As VMaths.Vector3) As VMaths.Matrix3
		  /// Constructs a new `Matrix3` from `columns`.
		  
		  Var m As VMaths.Matrix3 = Matrix3.Zero
		  
		  m.SetColumns(arg0, arg1, arg2)
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E20437265617465732061207A65726F206D61747269782E
		Sub Constructor()
		  /// Default constructor. Creates a zero matrix.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6577206D6174726978207769746820746865207370656369666965642076616C7565732E
		Sub Constructor(arg0 As Double, arg1 As Double, arg2 As Double, arg3 As Double, arg4 As Double, arg5 As Double, arg6 As Double, arg7 As Double, arg8 As Double)
		  /// New matrix with the specified values.
		  
		  SetValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720604D6174726978336020636F706965642066726F6D20606F74686572602E
		Shared Function Copy(other As VMaths.Matrix3) As VMaths.Matrix3
		  /// Returns a new `Matrix3` copied from `other`.
		  
		  Var m As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  m.SetFrom(other)
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F7069657320656C656D656E74732066726F6D20606172726020696E746F2074686973206D6174726978207374617274696E6720617420606F6666736574602E
		Sub CopyFromArray(arr() As Double, offset As Integer = 0)
		  /// Copies elements from `arr` into this matrix starting at `offset`.
		  
		  Storage(8) = arr(offset + 8)
		  Storage(7) = arr(offset + 7)
		  Storage(6) = arr(offset + 6)
		  Storage(5) = arr(offset + 5)
		  Storage(4) = arr(offset + 4)
		  Storage(3) = arr(offset + 3)
		  Storage(2) = arr(offset + 2)
		  Storage(1) = arr(offset + 1)
		  Storage(0) = arr(offset + 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F706965732074686973206D617472697820696E746F20606172676020616E642072657475726E732060617267602E
		Function CopyInto(arg As VMaths.Matrix3) As VMaths.Matrix3
		  /// Copies this matrix into `arg` and returns `arg`.
		  
		  arg.Storage(0) = Storage(0)
		  arg.Storage(1) = Storage(1)
		  arg.Storage(2) = Storage(2)
		  arg.Storage(3) = Storage(3)
		  arg.Storage(4) = Storage(4)
		  arg.Storage(5) = Storage(5)
		  arg.Storage(6) = Storage(6)
		  arg.Storage(7) = Storage(7)
		  arg.Storage(8) = Storage(8)
		  
		  Return arg
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F706965732074686973206D617472697820696E746F206061727260207374617274696E6720617420606F6666736574602E
		Sub CopyIntoArray(arr() As Double, offset As Integer = 0)
		  /// Copies this matrix into `arr` starting at `offset`.
		  
		  arr(offset + 8) = Storage(8)
		  arr(offset + 7) = Storage(7)
		  arr(offset + 6) = Storage(6)
		  arr(offset + 5) = Storage(5)
		  arr(offset + 4) = Storage(4)
		  arr(offset + 3) = Storage(3)
		  arr(offset + 2) = Storage(2)
		  arr(offset + 1) = Storage(1)
		  arr(offset + 0) = Storage(0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742074686973206D617472697820746F2062652074686520696E7665727365206F662060617267602E2052657475726E732074686520617267756D656E7427732064657465726D696E616E742E
		Function CopyInverse(arg As VMaths.Matrix3) As Double
		  /// Set this matrix to be the inverse of `arg`.
		  /// Returns the argument's determinant.
		  
		  Var det As Double = arg.Determinant
		  If det = 0 Then
		    SetFrom(arg)
		    Return 0
		  End If
		  
		  Var invDet As Double = 1.0 / det
		  Var ix As Double = invDet * (arg.Storage(4) * arg.Storage(8) - arg.Storage(5) * arg.Storage(7))
		  Var iy As Double = invDet * (arg.Storage(2) * arg.Storage(7) - arg.Storage(1) * arg.Storage(8))
		  Var iz As Double = invDet * (arg.Storage(1) * arg.Storage(5) - arg.Storage(2) * arg.Storage(4))
		  Var jx As Double = invDet * (arg.Storage(5) * arg.Storage(6) - arg.Storage(3) * arg.Storage(8))
		  Var jy As Double = invDet * (arg.Storage(0) * arg.Storage(8) - arg.Storage(2) * arg.Storage(6))
		  Var jz As Double = invDet * (arg.Storage(2) * arg.Storage(3) - arg.Storage(0) * arg.Storage(5))
		  Var kx As Double = invDet * (arg.Storage(3) * arg.Storage(7) - arg.Storage(4) * arg.Storage(6))
		  Var ky As Double = invDet * (arg.Storage(1) * arg.Storage(6) - arg.Storage(0) * arg.Storage(7))
		  Var kz As Double = invDet * (arg.Storage(0) * arg.Storage(4) - arg.Storage(1) * arg.Storage(3))
		  
		  Storage(0) = ix
		  Storage(1) = iy
		  Storage(2) = iz
		  Storage(3) = jx
		  Storage(4) = jy
		  Storage(5) = jz
		  Storage(6) = kx
		  Storage(7) = ky
		  Storage(8) = kz
		  
		  Return det
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652064657465726D696E616E74206F662074686973206D61747269782E
		Function Determinant() As Double
		  /// Returns the determinant of this matrix.
		  
		  Var x As Double = Storage(0) * ((Storage(4) * Storage(8)) - (Storage(5) * Storage(7)))
		  Var y As Double = Storage(1) * ((Storage(3) * Storage(8)) - (Storage(5) * Storage(6)))
		  Var z As Double = Storage(2) * ((Storage(3) * Storage(7)) - (Storage(4) * Storage(6)))
		  
		  Return x - y + z
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646F742070726F64756374206F6620636F6C756D6E20606A6020616E64206076602E
		Function DotColumn(j As Integer, v As VMaths.Vector3) As Double
		  /// Returns the dot product of column `j` and `v`.
		  
		  Return Storage(j * 3) * v.X + Storage(j * 3 + 1) * v.Y + Storage(j * 3 + 2) * v.Z
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646F742070726F64756374206F6620726F772060696020616E64206076602E
		Function DotRow(i As Integer, v As VMaths.Vector3) As Double
		  /// Returns the dot product of row `i` and `v`.
		  
		  Return Storage(i) * v.X + Storage(3 + i) * v.Y + Storage(6 + i) * v.Z
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C75652061742060726F772C20636F6C602E
		Function Entry(row As Integer, col As Integer) As Double
		  /// Returns the value at `row, col`.
		  
		  Return Storage(Index(row, col))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720604D617472697833602066726F6D206076616C756573602E
		Shared Function FromArray(values() As Double) As VMaths.Matrix3
		  /// Returns a new `Matrix3` from `values`.
		  
		  Var m As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  m.SetValues(values(0), values(1), values(2), values(3), values(4), _
		  values(5), values(6), values(7), values(8))
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657473207468652060636F6C756D6E60206F6620746865206D61747269782E
		Function GetColumn(column As Integer) As VMaths.Vector3
		  /// Gets the `column` of the matrix.
		  
		  Var r As New VMaths.Vector3
		  
		  Var entry As Double = column * 3
		  r.Z = Storage(entry + 2)
		  r.Y = Storage(entry + 1)
		  r.X = Storage(entry + 0)
		  
		  Return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657473207468652060726F7760206F6620746865206D61747269782E
		Function GetRow(row As Integer) As VMaths.Vector3
		  /// Gets the `row` of the matrix.
		  
		  Var r As New VMaths.Vector3
		  
		  r.X = Storage(Index(row, 0))
		  r.Y = Storage(Index(row, 1))
		  r.Z = Storage(Index(row, 2))
		  
		  Return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206964656E7469747920604D617472697833602E
		Shared Function Identity() As VMaths.Matrix3
		  /// Returns a new identity `Matrix3`.
		  
		  Var m As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  m.SetIdentity
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E20696E64657820696E206053746F726167656020666F722060726F772C20636F6C602076616C75652E
		Function Index(row As Integer, col As Integer) As Integer
		  /// Return index in `Storage` for `row, col` value.
		  
		  Return (col * 3) + row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320696E66696E697479206E6F726D206F6620746865206D61747269782E205573656420666F72206E756D65726963616C20616E616C797369732E
		Function InfinityNorm() As Double
		  /// Returns infinity norm of the matrix. Used for numerical analysis.
		  
		  Var norm As Double = 0
		  
		  Var row_norm1 As Double = 0
		  row_norm1 = row_norm1 + Abs(Storage(0))
		  row_norm1 = row_norm1 + Abs(Storage(1))
		  row_norm1 = row_norm1 + Abs(Storage(2))
		  norm = If(row_norm1 > norm, row_norm1, norm)
		  
		  Var row_norm2 As Double = 0
		  row_norm2 = row_norm2 + Abs(Storage(3))
		  row_norm2 = row_norm2 + Abs(Storage(4))
		  row_norm2 = row_norm2 + Abs(Storage(5))
		  norm = If(row_norm2 > norm, row_norm2, norm)
		  
		  Var row_norm3 As Double = 0
		  row_norm3 = row_norm3 + Abs(Storage(6))
		  row_norm3 = row_norm3 + Abs(Storage(7))
		  row_norm3 = row_norm3 + Abs(Storage(8))
		  norm = If(row_norm3 > norm, row_norm3, norm)
		  
		  Return norm
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E76657274732074686973206D61747269782E2052657475726E73207468652064657465726D696E616E742E
		Function Invert() As Double
		  /// Inverts this matrix. Returns the determinant.
		  
		  Return CopyInverse(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4973207468697320746865206964656E74697479206D61747269783F
		Function IsIdentity() As Boolean
		  /// Is this the identity matrix?
		  
		  Return Storage(0) = 1.0 And _
		  Storage(1) = 0.0 And _
		  Storage(2) = 0.0 And _
		  Storage(3) = 0.0 And _
		  Storage(4) = 1.0 And _
		  Storage(5) = 0.0 And _
		  Storage(6) = 0.0 And _
		  Storage(7) = 0.0 And _
		  Storage(8) = 1.0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4973207468697320746865207A65726F206D61747269783F
		Function IsZero() As Boolean
		  /// Is this the zero matrix?
		  
		  Return Storage(0) = 0.0 And _
		  Storage(1) = 0.0 And _
		  Storage(2) = 0.0 And _
		  Storage(3) = 0.0 And _
		  Storage(4) = 0.0 And _
		  Storage(5) = 0.0 And _
		  Storage(6) = 0.0 And _
		  Storage(7) = 0.0 And _
		  Storage(8) = 0.0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E7320636F7079206F662074686973206D6174726978206D756C7469706C6965642062792060617267602E
		Function Multiplied(arg As VMaths.Matrix3) As VMaths.Matrix3
		  /// Creates and returns copy of this matrix multiplied by `arg`.
		  
		  Return Clone.Multiply(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Multiply(arg As VMaths.Matrix3)
		  /// Multiplies this matrix by `arg`.
		  
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(3)
		  Var m02 As Double = Storage(6)
		  Var m10 As Double = Storage(1)
		  Var m11 As Double = Storage(4)
		  Var m12 As Double = Storage(7)
		  Var m20 As Double = Storage(2)
		  Var m21 As Double = Storage(5)
		  Var m22 As Double = Storage(8)
		  
		  Var n00 As Double = arg.Storage(0)
		  Var n01 As Double = arg.Storage(3)
		  Var n02 As Double = arg.Storage(6)
		  Var n10 As Double = arg.Storage(1)
		  Var n11 As Double = arg.Storage(4)
		  Var n12 As Double = arg.Storage(7)
		  Var n20 As Double = arg.Storage(2)
		  Var n21 As Double = arg.Storage(5)
		  Var n22 As Double = arg.Storage(8)
		  
		  Storage(0) = (m00 * n00) + (m01 * n10) + (m02 * n20)
		  Storage(3) = (m00 * n01) + (m01 * n11) + (m02 * n21)
		  Storage(6) = (m00 * n02) + (m01 * n12) + (m02 * n22)
		  Storage(1) = (m10 * n00) + (m11 * n10) + (m12 * n20)
		  Storage(4) = (m10 * n01) + (m11 * n11) + (m12 * n21)
		  Storage(7) = (m10 * n02) + (m11 * n12) + (m12 * n22)
		  Storage(2) = (m20 * n00) + (m21 * n10) + (m22 * n20)
		  Storage(5) = (m20 * n01) + (m21 * n11) + (m22 * n21)
		  Storage(8) = (m20 * n02) + (m21 * n12) + (m22 * n22)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C6965732074686973206D61747269782062792060617267602E2052657475726E7320697473656C662E
		Function Multiply(arg As VMaths.Matrix3) As VMaths.Matrix3
		  /// Multiplies this matrix by `arg`. Returns itself.
		  
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(3)
		  Var m02 As Double = Storage(6)
		  Var m10 As Double = Storage(1)
		  Var m11 As Double = Storage(4)
		  Var m12 As Double = Storage(7)
		  Var m20 As Double = Storage(2)
		  Var m21 As Double = Storage(5)
		  Var m22 As Double = Storage(8)
		  
		  Var n00 As Double = arg.Storage(0)
		  Var n01 As Double = arg.Storage(3)
		  Var n02 As Double = arg.Storage(6)
		  Var n10 As Double = arg.Storage(1)
		  Var n11 As Double = arg.Storage(4)
		  Var n12 As Double = arg.Storage(7)
		  Var n20 As Double = arg.Storage(2)
		  Var n21 As Double = arg.Storage(5)
		  Var n22 As Double = arg.Storage(8)
		  
		  Storage(0) = (m00 * n00) + (m01 * n10) + (m02 * n20)
		  Storage(3) = (m00 * n01) + (m01 * n11) + (m02 * n21)
		  Storage(6) = (m00 * n02) + (m01 * n12) + (m02 * n22)
		  Storage(1) = (m10 * n00) + (m11 * n10) + (m12 * n20)
		  Storage(4) = (m10 * n01) + (m11 * n11) + (m12 * n21)
		  Storage(7) = (m10 * n02) + (m11 * n12) + (m12 * n22)
		  Storage(2) = (m20 * n00) + (m21 * n10) + (m22 * n20)
		  Storage(5) = (m20 * n01) + (m21 * n11) + (m22 * n21)
		  Storage(8) = (m20 * n02) + (m21 * n12) + (m22 * n22)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultiplyTranspose(arg As VMaths.Matrix3)
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(3)
		  Var m02 As Double = Storage(6)
		  Var m10 As Double = Storage(1)
		  Var m11 As Double = Storage(4)
		  Var m12 As Double = Storage(7)
		  Var m20 As Double = Storage(2)
		  Var m21 As Double = Storage(5)
		  Var m22 As Double = Storage(8)
		  
		  Storage(0) = _
		  (m00 * arg.Storage(0)) + (m01 * arg.Storage(3)) + (m02 * arg.Storage(6))
		  
		  Storage(3) = _
		  (m00 * arg.Storage(1)) + (m01 * arg.Storage(4)) + (m02 * arg.Storage(7))
		  
		  Storage(6) = _
		  (m00 * arg.Storage(2)) + (m01 * arg.Storage(5)) + (m02 * arg.Storage(8))
		  
		  Storage(1) = _
		  (m10 * arg.Storage(0)) + (m11 * arg.Storage(3)) + (m12 * arg.Storage(6))
		  
		  Storage(4) = _
		  (m10 * arg.Storage(1)) + (m11 * arg.Storage(4)) + (m12 * arg.Storage(7))
		  
		  Storage(7) = _
		  (m10 * arg.Storage(2)) + (m11 * arg.Storage(5)) + (m12 * arg.Storage(8))
		  
		  Storage(2) = _
		  (m20 * arg.Storage(0)) + (m21 * arg.Storage(3)) + (m22 * arg.Storage(6))
		  
		  Storage(5) = _
		  (m20 * arg.Storage(1)) + (m21 * arg.Storage(4)) + (m22 * arg.Storage(7))
		  
		  Storage(8) = _
		  (m20 * arg.Storage(2)) + (m21 * arg.Storage(5)) + (m22 * arg.Storage(8))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6567617465732074686973206D61747269782E
		Sub Negate()
		  /// Negates this matrix.
		  
		  Storage(0) = -Storage(0)
		  Storage(1) = -Storage(1)
		  Storage(2) = -Storage(2)
		  Storage(3) = -Storage(3)
		  Storage(4) = -Storage(4)
		  Storage(5) = -Storage(5)
		  Storage(6) = -Storage(6)
		  Storage(7) = -Storage(7)
		  Storage(8) = -Storage(8)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6567617465732074686973206D61747269782E2052657475726E7320697473656C662E
		Function Negate() As VMaths.Matrix3
		  /// Negates this matrix. Returns itself.
		  
		  Storage(0) = -Storage(0)
		  Storage(1) = -Storage(1)
		  Storage(2) = -Storage(2)
		  Storage(3) = -Storage(3)
		  Storage(4) = -Storage(4)
		  Storage(5) = -Storage(5)
		  Storage(6) = -Storage(6)
		  Storage(7) = -Storage(7)
		  Storage(8) = -Storage(8)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206E6577206D617472697820616674657220636F6D706F6E656E742077697365206053656C66202B20617267602E
		Function Operator_Add(arg As VMaths.Matrix3) As VMaths.Matrix3
		  /// Returns new matrix after component wise `Self + arg`.
		  
		  Return Clone.Add(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436865636B732069662074776F206D6174726963657320617265207468652073616D652E
		Function Operator_Compare(other As VMaths.Matrix3) As Integer
		  /// Checks if two matrices are the same.
		  
		  If other = Nil Then
		    Return -1
		    
		  ElseIf Self Is other Then
		    Return 0
		    
		  Else
		    If Storage(0) = other.Storage(0) And _
		      Storage(1) = other.Storage(1) And _
		      Storage(2) = other.Storage(2) And _
		      Storage(3) = other.Storage(3) And _
		      Storage(4) = other.Storage(4) And _
		      Storage(5) = other.Storage(5) And _
		      Storage(6) = other.Storage(6) And _
		      Storage(7) = other.Storage(7) And _
		      Storage(8) = other.Storage(8) Then
		      Return 0
		    Else
		      Return -1
		    End If
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D6174726978206279206D756C7469706C79696E67207468697320776974682060617267602E
		Function Operator_Multiply(arg As Double) As VMaths.Matrix3
		  /// Returns a new matrix by multiplying this with `arg`.
		  
		  Return Scaled(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D6174726978206279206D756C7469706C79696E67207468697320776974682060617267602E
		Function Operator_Multiply(arg As VMaths.Matrix3) As VMaths.Matrix3
		  /// Returns a new matrix by multiplying this with `arg`.
		  
		  Return Multiplied(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E65772060566563746F723360206279206D756C7469706C79696E67207468697320776974682060617267602E
		Function Operator_Multiply(arg As VMaths.Vector3) As VMaths.Vector3
		  /// Returns a new `Vector3` by multiplying this with `arg`.
		  
		  Return Transformed(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D617472697820602D53656C66602E
		Function Operator_Negate() As VMaths.Matrix3
		  /// Returns a new matrix `-Self`.
		  
		  Return Clone.Negate
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520656C656D656E74206F662074686973206D617472697820617420696E646578206069602E
		Function Operator_Subscript(i As Integer) As Double
		  /// Returns the element of this matrix at index `i`.
		  
		  Return Storage(i)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520656C656D656E74206F662074686973206D617472697820617420696E646578206069602E
		Sub Operator_Subscript(i As Integer, v As Double)
		  /// Sets the element of this matrix at index `i`.
		  
		  Storage(i) = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206E6577206D617472697820616674657220636F6D706F6E656E742077697365206053656C66202D20617267602E
		Function Operator_Subtract(arg As VMaths.Matrix3) As VMaths.Matrix3
		  /// Returns new matrix after component wise `Self - arg`.
		  
		  Return Clone.Subtract(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720604D61747269783360207468617420697320746865206F757465722070726F64756374206F662060756020616E64206076602E
		Shared Function Outer(u As VMaths.Vector3, v As VMaths.Vector3) As VMaths.Matrix3
		  /// Returns a new `Matrix3` that is the outer product of `u` and `v`.
		  
		  Var m As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  m.SetOuter(u, v)
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732072656C6174697665206572726F72206265747765656E2074686973206D617472697820616E642060636F7272656374602E
		Function RelativeError(correct As VMaths.Matrix3) As Double
		  /// Returns relative error between this matrix and `correct`.
		  
		  Var diff As VMaths.Matrix3 = correct - Self
		  Var correct_norm As Double = correct.InfinityNorm
		  Var diff_norm As Double = diff.InfinityNorm
		  
		  Return diff_norm / correct_norm
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720604D617472697833602074686174206973206120726F746174696F6E206F66206072616469616E73602061726F756E6420746865205820617869732E
		Shared Function RotationX(radians As Double) As VMaths.Matrix3
		  /// Returns a new `Matrix3` that is a rotation of `radians` around the X axis.
		  
		  Var m As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  m.SetRotationX(radians)
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720604D617472697833602074686174206973206120726F746174696F6E206F66206072616469616E73602061726F756E6420746865205920617869732E
		Shared Function RotationY(radians As Double) As VMaths.Matrix3
		  /// Returns a new `Matrix3` that is a rotation of `radians` around the Y axis.
		  
		  Var m As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  m.SetRotationY(radians)
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720604D617472697833602074686174206973206120726F746174696F6E206F66206072616469616E73602061726F756E6420746865205A20617869732E
		Shared Function RotationZ(radians As Double) As VMaths.Matrix3
		  /// Returns a new `Matrix3` that is a rotation of `radians` around the Z axis.
		  
		  Var m As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  m.SetRotationZ(radians)
		  
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363616C65732074686973206D617472697820627920607363616C65602E
		Sub Scale(scale As Double)
		  /// Scales this matrix by `scale`.
		  
		  Storage(0) = Storage(0) * scale
		  Storage(1) = Storage(1) * scale
		  Storage(2) = Storage(2) * scale
		  Storage(3) = Storage(3) * scale
		  Storage(4) = Storage(4) * scale
		  Storage(5) = Storage(5) * scale
		  Storage(6) = Storage(6) * scale
		  Storage(7) = Storage(7) * scale
		  Storage(8) = Storage(8) * scale
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363616C65732074686973206D617472697820627920607363616C65602E2052657475726E7320697473656C662E
		Function Scale(scale As Double) As VMaths.Matrix3
		  /// Scales this matrix by `scale`. Returns itself.
		  
		  Storage(0) = Storage(0) * scale
		  Storage(1) = Storage(1) * scale
		  Storage(2) = Storage(2) * scale
		  Storage(3) = Storage(3) * scale
		  Storage(4) = Storage(4) * scale
		  Storage(5) = Storage(5) * scale
		  Storage(6) = Storage(6) * scale
		  Storage(7) = Storage(7) * scale
		  Storage(8) = Storage(8) * scale
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E766572747320696E746F2041646A7567617465206D617472697820616E64207363616C657320627920607363616C65602E
		Sub ScaleAdjoint(scale As Double)
		  /// Converts into Adjugate matrix and scales by `scale`.
		  
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(3)
		  Var m02 As Double = Storage(6)
		  Var m10 As Double = Storage(1)
		  Var m11 As Double = Storage(4)
		  Var m12 As Double = Storage(7)
		  Var m20 As Double = Storage(2)
		  Var m21 As Double = Storage(5)
		  Var m22 As Double = Storage(8)
		  
		  Storage(0) = (m11 * m22 - m12 * m21) * scale
		  Storage(1) = (m12 * m20 - m10 * m22) * scale
		  Storage(2) = (m10 * m21 - m11 * m20) * scale
		  Storage(3) = (m02 * m21 - m01 * m22) * scale
		  Storage(4) = (m00 * m22 - m02 * m20) * scale
		  Storage(5) = (m01 * m20 - m00 * m21) * scale
		  Storage(6) = (m01 * m12 - m02 * m11) * scale
		  Storage(7) = (m02 * m10 - m00 * m12) * scale
		  Storage(8) = (m00 * m11 - m01 * m10) * scale
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E7320636F7079206F662074686973206D617472697820616E64207363616C657320697420627920607363616C65602E
		Function Scaled(scale As Double) As VMaths.Matrix3
		  /// Creates and returns copy of this matrix and scales it by `scale`.
		  
		  Return Clone.Scale(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41737369676E73207468652060636F6C756D6E60206F6620746865206D61747269782060617267602E
		Sub SetColumn(column As Integer, arg As VMaths.Vector3)
		  /// Assigns the `column` of the matrix `arg`.
		  
		  Var entry As Integer = column * 3
		  Storage(entry + 2) = arg.Z
		  Storage(entry + 1) = arg.Y
		  Storage(entry + 0) = arg.X
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520656E74697265206D617472697820746F2074686520636F6C756D6E2076616C7565732E
		Sub SetColumns(arg0 As VMaths.Vector3, arg1 As VMaths.Vector3, arg2 As VMaths.Vector3)
		  /// Sets the entire matrix to the column values.
		  
		  Storage(0) = arg0.X
		  Storage(1) = arg0.Y
		  Storage(2) = arg0.Z
		  Storage(3) = arg1.X
		  Storage(4) = arg1.Y
		  Storage(5) = arg1.Z
		  Storage(6) = arg2.X
		  Storage(7) = arg2.Y
		  Storage(8) = arg2.Z
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742074686520646961676F6E616C206F6620746865206D61747269782E
		Sub SetDiagonal(arg As VMaths.Vector3)
		  /// Set the diagonal of the matrix.
		  
		  Storage(0) = arg.X
		  Storage(4) = arg.Y
		  Storage(8) = arg.X
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742076616C75652061742060726F772C20636F6C6020746F206265206076602E
		Sub SetEntry(row As Integer, col As Integer, v As Double)
		  /// Set value at `row, col` to be `v`.
		  
		  Storage(Index(row, col)) = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520656E74697265206D617472697820746F20746865206D617472697820696E2060617267602E
		Sub SetFrom(arg As VMaths.Matrix3)
		  /// Sets the entire matrix to the matrix in `arg`.
		  
		  Storage(8) = arg.Storage(8)
		  Storage(7) = arg.Storage(7)
		  Storage(6) = arg.Storage(6)
		  Storage(5) = arg.Storage(5)
		  Storage(4) = arg.Storage(4)
		  Storage(3) = arg.Storage(3)
		  Storage(2) = arg.Storage(2)
		  Storage(1) = arg.Storage(1)
		  Storage(0) = arg.Storage(0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B6573207468697320696E746F20746865206964656E74697479206D61747269782E
		Sub SetIdentity()
		  /// Makes this into the identity matrix.
		  
		  Storage(0) = 1.0
		  Storage(1) = 0.0
		  Storage(2) = 0.0
		  Storage(3) = 0.0
		  Storage(4) = 1.0
		  Storage(5) = 0.0
		  Storage(6) = 0.0
		  Storage(7) = 0.0
		  Storage(8) = 1.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320746F20746865206F757465722070726F64756374206F662060756020616E64206076602E
		Sub SetOuter(u As VMaths.Vector3, v As VMaths.Vector3)
		  /// Sets this to the outer product of `u` and `v`.
		  
		  Storage(0) = u.X * v.X
		  Storage(1) = u.X * v.Y
		  Storage(2) = u.X * v.Z
		  Storage(3) = u.Y * v.X
		  Storage(4) = u.Y * v.Y
		  Storage(5) = u.Y * v.Z
		  Storage(6) = u.Z * v.X
		  Storage(7) = u.Z * v.Y
		  Storage(8) = u.Z * v.Z
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5475726E7320746865206D617472697820696E746F206120726F746174696F6E206F662072616469616E732061726F756E6420582E
		Sub SetRotationX(radians As Double)
		  /// Turns the matrix into a rotation of radians around X.
		  
		  Var c As Double = Cos(radians)
		  Var s As Double = Sin(radians)
		  Storage(0) = 1.0
		  Storage(1) = 0.0
		  Storage(2) = 0.0
		  Storage(3) = 0.0
		  Storage(4) = c
		  Storage(5) = s
		  Storage(6) = 0.0
		  Storage(7) = -s
		  Storage(8) = c
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5475726E7320746865206D617472697820696E746F206120726F746174696F6E206F662072616469616E732061726F756E6420592E
		Sub SetRotationY(radians As Double)
		  /// Turns the matrix into a rotation of radians around Y.
		  
		  Var c As Double = Cos(radians)
		  Var s As Double = Sin(radians)
		  Storage(0) = c
		  Storage(1) = 0.0
		  Storage(2) = s
		  Storage(3) = 0.0
		  Storage(4) = 1.0
		  Storage(5) = 0.0
		  Storage(6) = -s
		  Storage(7) = 0.0
		  Storage(8) = c
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5475726E7320746865206D617472697820696E746F206120726F746174696F6E206F662072616469616E732061726F756E64205A2E
		Sub SetRotationZ(radians As Double)
		  /// Turns the matrix into a rotation of radians around Z.
		  
		  Var c As Double = Cos(radians)
		  Var s As Double = Sin(radians)
		  Storage(0) = c
		  Storage(1) = s
		  Storage(2) = 0.0
		  Storage(3) = -s
		  Storage(4) = c
		  Storage(5) = 0.0
		  Storage(6) = 0.0
		  Storage(7) = 0.0
		  Storage(8) = 1.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41737369676E73207468652060726F776020746F2060617267602E
		Sub SetRow(row As Integer, arg As VMaths.Vector3)
		  /// Assigns the `row` to `arg`.
		  
		  Storage(Index(row, 0)) = arg.X
		  Storage(Index(row, 1)) = arg.Y
		  Storage(Index(row, 2)) = arg.Z
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520757070657220327832206F6620746865206D617472697820746F2062652060617267602E
		Sub SetUpper2x2(arg As VMaths.Matrix3)
		  /// Sets the upper 2x2 of the matrix to be `arg`.
		  
		  Storage(0) = arg.Storage(0)
		  Storage(1) = arg.Storage(1)
		  Storage(3) = arg.Storage(2)
		  Storage(4) = arg.Storage(3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320746865206D61747269782077697468207370656369666965642076616C7565732E
		Sub SetValues(arg0 As Double, arg1 As Double, arg2 As Double, arg3 As Double, arg4 As Double, arg5 As Double, arg6 As Double, arg7 As Double, arg8 As Double)
		  /// Sets the matrix with specified values.
		  
		  Storage(8) = arg8
		  Storage(7) = arg7
		  Storage(6) = arg6
		  Storage(5) = arg5
		  Storage(4) = arg4
		  Storage(3) = arg3
		  Storage(2) = arg2
		  Storage(1) = arg1
		  Storage(0) = arg0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetZero()
		  /// Zeroes this matrix.
		  
		  Storage(0) = 0.0
		  Storage(1) = 0.0
		  Storage(2) = 0.0
		  Storage(3) = 0.0
		  Storage(4) = 0.0
		  Storage(5) = 0.0
		  Storage(6) = 0.0
		  Storage(7) = 0.0
		  Storage(8) = 0.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536F6C7665206041202A2078203D2062602E
		Shared Sub Solve(A As VMaths.Matrix3, x As VMaths.Vector3, b As VMaths.Vector3)
		  /// Solve `A * x = b`.
		  
		  Var A0x As Double = A.Entry(0, 0)
		  Var A0y As Double = A.Entry(1, 0)
		  Var A0z As Double = A.Entry(2, 0)
		  Var A1x As Double = A.Entry(0, 1)
		  Var A1y As Double = A.Entry(1, 1)
		  Var A1z As Double = A.Entry(2, 1)
		  Var A2x As Double = A.Entry(0, 2)
		  Var A2y As Double = A.Entry(1, 2)
		  Var A2z As Double = A.Entry(2, 2)
		  Var det, rx, ry, rz As Double 
		  
		  // Column1 cross Column 2.
		  rx = A1y * A2z - A1z * A2y
		  ry = A1z * A2x - A1x * A2z
		  rz = A1x * A2y - A1y * A2x
		  
		  // A.GetColumn(0).Dot(x)
		  det = A0x * rx + A0y * ry + A0z * rz
		  If det <> 0.0 Then
		    det = 1.0 / det
		  End If
		  
		  // b dot (Column1 cross Column 2).
		  Var x_ As Double = det * (b.X * rx + b.Y * ry + b.Z * rz)
		  
		  // Column2 cross b.
		  rx = -(A2y * b.Z - A2z * b.Y)
		  ry = -(A2z * b.X - A2x * b.Z)
		  rz = -(A2x * b.Y - A2y * b.X)
		  
		  // Column0 dot -(Column2 cross b (Column3))
		  Var y_ As Double = det * (A0x * rx + A0y * ry + A0z * rz)
		  
		  // b cross Column 1.
		  rx = -(b.Y * A1z - b.Z * A1y)
		  ry = -(b.Z * A1x - b.X * A1z)
		  rz = -(b.X * A1y - b.Y * A1x)
		  
		  // Column0 dot -(b cross Column 1).
		  Var z_ As Double = det * (A0x * rx + A0y * ry + A0z * rz)
		  
		  x.X = x_
		  x.Y = y_
		  x.Z = z_
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536F6C7665206041202A2078203D2062602E
		Shared Sub Solve2(A As VMaths.Matrix3, x As VMaths.Vector2, b As VMaths.Vector2)
		  /// Solve `A * x = b`.
		  
		  Var a11 As Double = A.Entry(0, 0)
		  Var a12 As Double = A.Entry(0, 1)
		  Var a21 As Double = A.Entry(1, 0)
		  Var a22 As Double = A.Entry(1, 1)
		  Var bx As Double = b.X - A.Storage(6)
		  Var by As Double = b.Y - A.Storage(7)
		  var det As Double = a11 * a22 - a12 * a21
		  
		  If det <> 0.0 Then
		    det = 1.0 / det
		  End If
		  
		  x.X = det * (a22 * bx - a12 * by)
		  x.Y = det * (a11 * by - a21 * bx)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520646961676F6E616C206F6620746865206D61747269782E
		Sub SplatDiagonal(arg As Double)
		  /// Sets the diagonal of the matrix.
		  
		  Storage(0) = arg
		  Storage(4) = arg
		  Storage(8) = arg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562747261637420606F602066726F6D2074686973206D61747269782E
		Sub Subtract(o As VMaths.Matrix3)
		  /// Subtract `o` from this matrix.
		  
		  Storage(0) = Storage(0) - o.Storage(0)
		  Storage(1) = Storage(1) - o.Storage(1)
		  Storage(2) = Storage(2) - o.Storage(2)
		  Storage(3) = Storage(3) - o.Storage(3)
		  Storage(4) = Storage(4) - o.Storage(4)
		  Storage(5) = Storage(5) - o.Storage(5)
		  Storage(6) = Storage(6) - o.Storage(6)
		  Storage(7) = Storage(7) - o.Storage(7)
		  Storage(8) = Storage(8) - o.Storage(8)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562747261637420606F602066726F6D2074686973206D61747269782E2052657475726E7320697473656C662E
		Function Subtract(o As VMaths.Matrix3) As VMaths.Matrix3
		  /// Subtract `o` from this matrix. Returns itself.
		  
		  Storage(0) = Storage(0) - o.Storage(0)
		  Storage(1) = Storage(1) - o.Storage(1)
		  Storage(2) = Storage(2) - o.Storage(2)
		  Storage(3) = Storage(3) - o.Storage(3)
		  Storage(4) = Storage(4) - o.Storage(4)
		  Storage(5) = Storage(5) - o.Storage(5)
		  Storage(6) = Storage(6) - o.Storage(6)
		  Storage(7) = Storage(7) - o.Storage(7)
		  Storage(8) = Storage(8) - o.Storage(8)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662074686973206D61747269782E
		Function ToString() As String
		  /// Returns a string representation of this matrix.
		  
		  Return "[0] " + GetRow(0).ToString + EndOfLine + _
		  "[1] " + GetRow(1).ToString + EndOfLine + _
		  "[2] " + GetRow(2).ToString + EndOfLine
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207472616365206F6620746865206D61747269782E20546865207472616365206F662061206D6174726978206973207468652073756D206F662074686520646961676F6E616C20656E74726965732E
		Function Trace() As Double
		  /// Returns the trace of the matrix. 
		  /// The trace of a matrix is the sum of the diagonal entries.
		  
		  Return Storage(0) + Storage(4) + Storage(8)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform(arg As VMaths.Vector3) As VMaths.Vector3
		  // Transforms `arg` using the transformation defined by this matrix.
		  
		  Var x_ As Double = (Storage(0) * arg.X) + (Storage(3) * arg.Y) + (Storage(6) * arg.Z)
		  Var y_ As Double = (Storage(1) * arg.X) + (Storage(4) * arg.Y) + (Storage(7) * arg.Z)
		  Var z_ As Double = (Storage(2) * arg.X) + (Storage(5) * arg.Y) + (Storage(8) * arg.Z)
		  
		  arg.X = x_
		  arg.Y = y_
		  arg.Z = z_
		  
		  Return arg
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73666F726D7320606172676020776974682074686973206D61747269782E
		Function Transform2(arg As VMaths.Vector2) As VMaths.Vector2
		  /// Transforms `arg` with this matrix.
		  
		  Var x_ As Double = (Storage(0) * arg.X) + (Storage(3) * arg.Y) + Storage(6)
		  Var y_ As Double = (Storage(1) * arg.X) + (Storage(4) * arg.Y) + Storage(7)
		  
		  arg.X = x_
		  arg.Y = y_
		  
		  Return arg
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73666F726D73206120636F7079206F66206061726760207573696E6720746865207472616E73666F726D6174696F6E20646566696E65642062792074686973206D61747269782E20496620606F75746020697320737570706C6965642C2074686520636F70792069732073746F72656420696E20606F7574602E20546865207472616E73666F726D656420766563746F722069732072657475726E65642E
		Function Transformed(arg As VMaths.Vector3, out As VMaths.Vector3 = Nil) As VMaths.Vector3
		  /// Transforms a copy of `arg` using the transformation defined by this matrix. 
		  /// If `out` is supplied, the copy is stored in `out`.
		  /// The transformed vector is returned.
		  
		  If out = Nil Then
		    out = VMaths.Vector3.Copy(arg)
		  Else
		    out.SetFrom(arg)
		  End If
		  
		  Return Transform(out)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73706F7365732074686973206D61747269782E
		Sub Transpose()
		  /// Transposes this matrix.
		  
		  Var temp As Double = Storage(3)
		  Storage(3) = Storage(1)
		  Storage(1) = temp
		  temp = Storage(6)
		  Storage(6) = Storage(2)
		  Storage(2) = temp
		  temp = Storage(7)
		  Storage(7) = Storage(5)
		  Storage(5) = temp
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73706F7365732074686973206D61747269782E2052657475726E7320697473656C662E
		Function Transpose() As VMaths.Matrix3
		  /// Transposes this matrix. Returns itself.
		  
		  Var temp As Double = Storage(3)
		  Storage(3) = Storage(1)
		  Storage(1) = temp
		  temp = Storage(6)
		  Storage(6) = Storage(2)
		  Storage(2) = temp
		  temp = Storage(7)
		  Storage(7) = Storage(5)
		  Storage(5) = temp
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207472616E73706F7365206F662074686973206D61747269782E
		Function Transposed() As VMaths.Matrix3
		  /// Returns the transpose of this matrix.
		  
		  Return Clone.Transpose
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TransposeMultiply(arg As VMaths.Matrix3)
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(1)
		  Var m02 As Double = Storage(2)
		  Var m10 As Double = Storage(3)
		  Var m11 As Double = Storage(4)
		  Var m12 As Double = Storage(5)
		  Var m20 As Double = Storage(6)
		  Var m21 As Double = Storage(7)
		  Var m22 As Double = Storage(8)
		  
		  Storage(0) = (m00 * arg.Storage(0)) + (m01 * arg.Storage(1)) + (m02 * arg.Storage(2))
		  Storage(3) = (m00 * arg.Storage(3)) + (m01 * arg.Storage(4)) + (m02 * arg.Storage(5))
		  Storage(6) = (m00 * arg.Storage(6)) + (m01 * arg.Storage(7)) + (m02 * arg.Storage(8))
		  Storage(1) = (m10 * arg.Storage(0)) + (m11 * arg.Storage(1)) + (m12 * arg.Storage(2))
		  Storage(4) = (m10 * arg.Storage(3)) + (m11 * arg.Storage(4)) + (m12 * arg.Storage(5))
		  Storage(7) = (m10 * arg.Storage(6)) + (m11 * arg.Storage(7)) + (m12 * arg.Storage(8))
		  Storage(2) = (m20 * arg.Storage(0)) + (m21 * arg.Storage(1)) + (m22 * arg.Storage(2))
		  Storage(5) = (m20 * arg.Storage(3)) + (m21 * arg.Storage(4)) + (m22 * arg.Storage(5))
		  Storage(8) = (m20 * arg.Storage(6)) + (m21 * arg.Storage(7)) + (m22 * arg.Storage(8))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720604D617472697833602066696C6C65642077697468207A65726F732E
		Shared Function Zero() As VMaths.Matrix3
		  /// Returns a new `Matrix3` filled with zeros.
		  
		  Return New VMaths.Matrix3
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 5468652064696D656E73696F6E206F6620746865206D61747269782E
		#tag Getter
			Get
			  Return 3
			  
			End Get
		#tag EndGetter
		Dimension As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New VMaths.Vector3(Storage(6), Storage(7), Storage(8))
			  
			End Get
		#tag EndGetter
		Forward As VMaths.Vector3
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New VMaths.Vector3(Storage(0), Storage(1), Storage(2))
			End Get
		#tag EndGetter
		Right As VMaths.Vector3
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return GetRow(0)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  SetRow(0, value)
			End Set
		#tag EndSetter
		Row0 As VMaths.Vector3
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return GetRow(1)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  SetRow(1, value)
			End Set
		#tag EndSetter
		Row1 As VMaths.Vector3
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return GetRow(2)
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  SetRow(2, value)
			End Set
		#tag EndSetter
		Row2 As VMaths.Vector3
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4120666978656420392D656C656D656E742061727261792073746F72696E672074686973206D6174726978277320726F772C20636F6C756D6E20646174612E
		Storage(8) As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New VMaths.Vector3(Storage(3), Storage(4), Storage(5))
			  
			End Get
		#tag EndGetter
		Up As VMaths.Vector3
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
			Name="Dimension"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

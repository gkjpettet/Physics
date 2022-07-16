#tag Class
Protected Class Matrix2
	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6D706F6E656E742D77697365206162736F6C7574652076616C7565206F662074686973206D61747269782E
		Function Absolute() As VMaths.Matrix2
		  /// Returns the component-wise absolute value of this matrix.
		  
		  Return New VMaths.Matrix2(Abs(Storage(0)), Abs(Storage(1)), Abs(Storage(2)), Abs(Storage(3)))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206162736F6C757465206572726F72206265747765656E2074686973206D617472697820616E642060636F7272656374602E
		Function AbsoluteError(correct As VMaths.Matrix2) As Double
		  /// Returns the absolute error between this matrix and `correct`.
		  
		  Var thisNorm As Double = InfinityNorm
		  Var correctNorm As Double = correct.InfinityNorm
		  Return Abs(thisNorm - correctNorm)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320606F6020746F2074686973206D61747269782E204F766572726964652072657475726E7320697473656C662E
		Sub Add(o As VMaths.Matrix2)
		  /// Adds `o` to this matrix. Override returns itself.
		  
		  Storage(0) = Storage(0) + o.Storage(0)
		  Storage(1) = Storage(1) + o.Storage(1)
		  Storage(2) = Storage(2) + o.Storage(2)
		  Storage(3) = Storage(3) + o.Storage(3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320606F6020746F2074686973206D617472697820616E642072657475726E7320697473656C662E
		Function Add(o As VMaths.Matrix2) As VMaths.Matrix2
		  /// Adds `o` to this matrix and returns itself.
		  
		  Storage(0) = Storage(0) + o.Storage(0)
		  Storage(1) = Storage(1) + o.Storage(1)
		  Storage(2) = Storage(2) + o.Storage(2)
		  Storage(3) = Storage(3) + o.Storage(3)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120636F7079206F662074686973206D61747269782E
		Function Clone() As VMaths.Matrix2
		  /// Returns a copy of this matrix.
		  
		  Return New VMaths.Matrix2(Storage(0), Storage(1), Storage(2), Storage(3))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D617472697820776974682076616C7565732066726F6D20636F6C756D6E20617267756D656E74732E
		Shared Function Columns(arg0 As VMaths.Vector2, arg1 As VMaths.Vector2) As VMaths.Matrix2
		  /// Returns a new matrix with values from column arguments.
		  
		  Var m As New VMaths.Matrix2
		  m.SetColumns(arg0, arg1)
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  /// Creates a zero matrix by default (all values = 0.0).
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(arg0 As Double, arg1 As Double, arg2 As Double, arg3 As Double)
		  SetValues(arg0, arg1, arg2, arg3)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D61747269782077686F73652076616C7565732061726520636F706965642066726F6D20606F74686572602E
		Shared Function Copy(other As VMaths.Matrix2) As VMaths.Matrix2
		  /// Returns a new matrix whose values are copied from `other`.
		  
		  Var m As New VMaths.Matrix2
		  m.SetFrom(other)
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F7069657320656C656D656E74732066726F6D2060646020696E746F2074686973206D6174726978207374617274696E6720617420606F6666736574602E
		Sub CopyFromArray(d() As Double, offset As Integer = 0)
		  /// Copies elements from `d` into this matrix starting at `offset`.
		  
		  Storage(0) = d(offset + 0)
		  Storage(1) = d(offset + 1)
		  Storage(2) = d(offset + 2)
		  Storage(3) = d(offset + 3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F706965732074686973206D617472697820696E746F20606172676020616E642072657475726E732060617267602E
		Function CopyInto(arg As VMaths.Matrix2) As VMaths.Matrix2
		  /// Copies this matrix into `arg` and returns `arg`.
		  
		  arg.Storage(0) = Storage(0)
		  arg.Storage(1) = Storage(1)
		  arg.Storage(2) = Storage(2)
		  arg.Storage(3) = Storage(3)
		  
		  Return arg
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F706965732074686973206D617472697820696E746F206074617267657460207374617274696E6720617420606F6666736574602E
		Sub CopyIntoArray(ByRef target() As Double, offset As Integer = 0)
		  /// Copies this matrix into `target` starting at `offset`.
		  
		  target(offset + 0) = Storage(0)
		  target(offset + 1) = Storage(1)
		  target(offset + 2) = Storage(2)
		  target(offset + 3) = Storage(3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206D617472697820746F2062652074686520696E7665727365206F662060617267602E2052657475726E732074686520617267756D656E7427732064657465726D696E616E742E
		Function CopyInverse(arg As VMaths.Matrix2) As Double
		  /// Sets this matrix to be the inverse of `arg`. Returns the argument's determinant.
		  
		  Var det As Double = arg.Determinant
		  
		  If det = 0.0 Then
		    SetFrom(arg)
		    Return 0.0
		  End If
		  
		  Var invDet As Double = 1.0 / det
		  Storage(0) = arg.Storage(3) * invDet
		  Storage(1) = -arg.Storage(1) * invDet
		  Storage(2) = -arg.Storage(2) * invDet
		  Storage(3) = arg.Storage(0) * invDet
		  
		  Return det
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652064657465726D696E616E74206F662074686973206D61747269782E
		Function Determinant() As Double
		  /// Returns the determinant of this matrix.
		  
		  Return (Storage(0) * Storage(3)) - (Storage(1) * Storage(2))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646F742070726F64756374206F6620636F6C756D6E20606A6020616E64206076602E
		Function DotColumn(j As Integer, v As VMaths.Vector2) As Double
		  /// Returns the dot product of column `j` and `v`.
		  
		  Return Storage(j * 2) * v.X + Storage((j * 2) + 1) * v.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646F742070726F64756374206F6620726F772060696020616E64206076602E
		Function DotRow(i As Integer, v As VMaths.Vector2) As Double
		  /// Returns the dot product of row `i` and `v`.
		  
		  Return Storage(i) * v.X + Storage(2 + i) * v.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C75652061742060726F772C20636F6C602E
		Function Entry(row As Integer, col As Integer) As Double
		  /// Returns the value at `row, col`.
		  
		  Return Storage(Index(row, col))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D617472697820637265617465642066726F6D206076616C756573602E
		Shared Function FromArray(values() As Double) As VMaths.Matrix2
		  /// Returns a new matrix created from `values`.
		  
		  Var m As New VMaths.Matrix2
		  m.SetValues(values(0), values(1), values(2), values(3))
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 67657473207468652060636F6C756D6E60206F6620746865206D61747269782E
		Function GetColumn(column As Integer) As VMaths.Vector2
		  /// gets the `column` of the matrix.
		  
		  Var entry As Integer = column * 2
		  
		  Return New VMaths.Vector2(Storage(entry + 0), Storage(entry + 1))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRow(row As Integer) As VMaths.Vector2
		  /// Gets the `row` of the matrix.
		  
		  Return New VMaths.Vector2(Storage(Index(row, 0)), Storage(Index(row, 1)))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206964656E74697479206D61747269782E
		Shared Function Identity() As VMaths.Matrix2
		  /// Returns a new identity matrix.
		  
		  Var m As New VMaths.Matrix2
		  m.SetIdentity
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E64657820696E206053746F726167656020666F722060726F77602C2060636F6C602E
		Function Index(row As Integer, col As Integer) As Integer
		  /// Returns the index in `Storage` for `row`, `col`.
		  
		  Return (col * 2) + row
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E6966696E7479206E6F726D206F662074686973206D61747269782E205573656420666F72206E756D65726963616C20616E616C797369732E
		Function InfinityNorm() As Double
		  /// Returns the inifinty norm of this matrix. Used for numerical analysis.
		  
		  Var norm As Double = 0.0
		  
		  Var rowNorm As Double = 0.0
		  rowNorm = rowNorm + Abs(Storage(0))
		  rowNorm = rowNorm + Abs(Storage(1))
		  norm = If(rowNorm > norm, rowNorm, norm)
		  
		  rowNorm = 0.0
		  rowNorm = rowNorm + Abs(Storage(2))
		  rowNorm = rowNorm + Abs(Storage(3))
		  norm = If(rowNorm > norm, rowNorm, norm)
		  
		  Return norm
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E76657274732074686973206D617472697820616E642072657475726E73207468652064657465726D696E616E742E
		Function Invert() As Double
		  /// Inverts this matrix and returns the determinant.
		  
		  Var det As Double = Determinant
		  
		  If det = 0.0 Then Return 0.0
		  
		  Var invDet As Double = 1.0 / det
		  
		  Var temp As Double = Storage(0)
		  Storage(0) = Storage(3) * invDet
		  Storage(1) = -Storage(1) * invDet
		  Storage(2) = -Storage(2) * invDet
		  Storage(3) = temp * invDet
		  
		  Return det
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C6573206120636C6F6E65206F662074686973206D6174726978207769746820606172676020616E642072657475726E73207468652070726F647563742061732061206E6577206D61747269782E
		Function Multiplied(arg As VMaths.Matrix2) As VMaths.Matrix2
		  /// Multiples a clone of this matrix with `arg` and returns the product as a new matrix.
		  
		  Return Clone.Multiply(arg)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C6965732074686973206D6174726978207769746820606172676020616E642073746F72657320697420696E2074686973206D61747269782E204F766572726964652072657475726E7320697473656C662E
		Sub Multiply(arg As VMaths.Matrix2)
		  /// Multiplies this matrix with `arg` and stores it in this matrix. Override returns itself.
		  
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(2)
		  Var m10 As Double = Storage(1)
		  Var m11 As Double = Storage(3)
		  
		  Var n00 As Double = arg.Storage(0)
		  Var n01 As Double = arg.Storage(2)
		  Var n10 As Double = arg.Storage(1)
		  Var n11 As Double = arg.Storage(3)
		  
		  Storage(0) = (m00 * n00) + (m01 * n10)
		  Storage(2) = (m00 * n01) + (m01 * n11)
		  Storage(1) = (m10 * n00) + (m11 * n10)
		  Storage(3) = (m10 * n01) + (m11 * n11)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C6965732074686973206D6174726978207769746820606172676020616E642073746F72657320697420696E2074686973206D617472697820616E642072657475726E7320697473656C662E
		Function Multiply(arg As VMaths.Matrix2) As VMaths.Matrix2
		  /// Multiplies this matrix with `arg` and stores it in this matrix and returns itself.
		  
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(2)
		  Var m10 As Double = Storage(1)
		  Var m11 As Double = Storage(3)
		  
		  Var n00 As Double = arg.Storage(0)
		  Var n01 As Double = arg.Storage(2)
		  Var n10 As Double = arg.Storage(1)
		  Var n11 As Double = arg.Storage(3)
		  
		  Storage(0) = (m00 * n00) + (m01 * n10)
		  Storage(2) = (m00 * n01) + (m01 * n11)
		  Storage(1) = (m10 * n00) + (m11 * n10)
		  Storage(3) = (m10 * n01) + (m11 * n11)
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C6965732074686973206D617472697820776974682061207472616E73706F7365642060617267602E
		Sub MultiplyTranspose(arg As VMaths.Matrix2)
		  /// Multiplies this matrix with a transposed `arg`.
		  
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(2)
		  Var m10 As Double = Storage(1)
		  Var m11 As Double = Storage(3)
		  
		  Storage(0) = (m00 * arg.Storage(0)) + (m01 * arg.Storage(2))
		  Storage(2) = (m00 * arg.Storage(1)) + (m01 * arg.Storage(3))
		  Storage(1) = (m10 * arg.Storage(0)) + (m11 * arg.Storage(2))
		  Storage(3) = (m10 * arg.Storage(1)) + (m11 * arg.Storage(3))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6567617465732074686973206D61747269782E204F766572726964652072657475726E7320697473656C662E
		Sub Negate()
		  /// Negates this matrix. Override returns itself.
		  
		  Storage(0) = -Storage(0)
		  Storage(1) = -Storage(1)
		  Storage(2) = -Storage(2)
		  Storage(3) = -Storage(3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6567617465732074686973206D617472697820616E64207468656E2072657475726E7320697473656C662E
		Function Negate() As VMaths.Matrix2
		  /// Negates this matrix and then returns itself.
		  
		  Storage(0) = -Storage(0)
		  Storage(1) = -Storage(1)
		  Storage(2) = -Storage(2)
		  Storage(3) = -Storage(3)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D617472697820616674657220636F6D706F6E656E742D77697365206053656C66202B20617267602E
		Function Operator_Add(arg As VMaths.Matrix2) As VMaths.Matrix2
		  /// Returns a new matrix after component-wise `Self + arg`.
		  
		  Return Clone.Add(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(other As VMaths.Matrix2) As Integer
		  If other = Nil Then
		    Return -1
		    
		  ElseIf Self Is other Then
		    Return 0
		    
		  Else
		    If Storage(0) = other.Storage(0) And Storage(1) = other.Storage(1) And _
		      Storage(2) = other.Storage(2) And Storage(3) = other.Storage(3) Then
		      Return 0
		    Else
		      Return -1
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D6174726978207363616C65642062792060617267602E
		Function Operator_Multiply(arg As Double) As VMaths.Matrix2
		  /// Returns a new matrix scaled by `arg`.
		  
		  Return Scaled(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F72207472616E73666F726D65642062792060617267602E
		Function Operator_Multiply(arg As VMaths.Matrix2) As VMaths.Matrix2
		  /// Returns a new matrix multiplied by `arg`.
		  
		  Return Multiplied(arg)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F72207468617420697320746865207472616E73666F726D206F662060617267602062792074686973206D61747269782E
		Function Operator_Multiply(arg As VMaths.Vector2) As VMaths.Vector2
		  /// Returns a new vector that is the transform of `arg` by this matrix.
		  
		  Return Transformed(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Negate() As VMaths.Matrix2
		  Return Clone.Negate
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4163636573732074686520656C656D656E74206F6620746865206D61747269782061732074686520696E646578206069602E
		Function Operator_Subscript(i As Integer) As Double
		  /// Access the element of the matrix as the index `i`.
		  
		  Return Storage(i)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520656C656D656E74206F6620746865206D61747269782061742074686520696E646578206069602E
		Sub Operator_Subscript(i As Integer, v As Double)
		  /// Sets the element of the matrix at the index `i`.
		  
		  Storage(i) = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D617472697820616674657220636F6D706F6E656E742D77697365206053656C66202D20617267602E
		Function Operator_Subtract(arg As VMaths.Matrix2) As VMaths.Matrix2
		  /// Returns a new matrix after component-wise `Self - arg`.
		  
		  Return Clone.Subtract(arg)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206F757465722070726F64756374206F662060756020616E64206076602E
		Shared Function Outer(u As VMaths.Vector2, v As VMaths.Vector2) As VMaths.Matrix2
		  /// Returns a new outer product of `u` and `v`.
		  
		  Var m As New VMaths.Matrix2
		  m.SetOuter(u, v)
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652072656C6174697665206572726F72206265747765656E2074686973206D617472697820616E642060636F7272656374602E
		Function RelativeError(correct As VMaths.Matrix2) As Double
		  /// Returns the relative error between this matrix and `correct`.
		  
		  Var diff As VMaths.Matrix2 = correct - Self
		  Var correctNorm As Double = correct.InfinityNorm
		  Var diffNorm As Double = diff.InfinityNorm
		  
		  Return diffNorm / correctNorm
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720726F746174696F6E206F66206072616469616E73602E
		Shared Function Rotation(radians As Double) As VMaths.Matrix2
		  /// Returns a new rotation of `radians`.
		  
		  Var m As New VMaths.Matrix2
		  m.SetRotation(radians)
		  Return m
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363616C65732074686973206D617472697820627920607363616C65602E204F766572726964652072657475726E7320697473656C662E
		Sub Scale(scale As Double)
		  /// Scales this matrix by `scale`. Override returns itself.
		  
		  Storage(0) = Storage(0) * scale
		  Storage(1) = Storage(1) * scale
		  Storage(2) = Storage(2) * scale
		  Storage(3) = Storage(3) * scale
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363616C65732074686973206D617472697820627920607363616C656020616E64207468656E2072657475726E7320697473656C662E
		Function Scale(scale As Double) As VMaths.Matrix2
		  /// Scales this matrix by `scale` and then returns itself.
		  
		  Storage(0) = Storage(0) * scale
		  Storage(1) = Storage(1) * scale
		  Storage(2) = Storage(2) * scale
		  Storage(3) = Storage(3) * scale
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E766572747320696E746F2061646A7567617465206D617472697820616E64207363616C657320627920607363616C65602E
		Sub ScaleAdjoint(scale As Double)
		  /// Converts into adjugate matrix and scales by `scale`.
		  
		  Var temp As Double = Storage(0)
		  Storage(0) = Storage(3) * scale
		  Storage(2) = -Storage(2) * scale
		  Storage(1) = -Storage(1) * scale
		  Storage(3) = temp * scale
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120636F7079206F662074686973206D6174726978207363616C656420627920607363616C65602E
		Function Scaled(scale As Double) As VMaths.Matrix2
		  /// Returns a copy of this matrix scaled by `scale`.
		  
		  Return Clone.Scale(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41737369676E73207468652060636F6C756D6E60206F6620746865206D61747269782060617267602E
		Sub SetColumn(column As Integer, arg As VMaths.Vector2)
		  /// Assigns the `column` of the matrix `arg`.
		  
		  Var entry As Integer = column * 2
		  Storage(entry + 1) = arg.Y
		  Storage(entry + 0) = arg.X
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520656E74697265206D617472697820746F2074686520636F6C756D6E2076616C7565732E
		Sub SetColumns(arg0 As VMaths.Vector2, arg1 As VMaths.Vector2)
		  /// Sets the entire matrix to the column values.
		  
		  Storage(0) = arg0.X
		  Storage(1) = arg0.Y
		  Storage(2) = arg1.X
		  Storage(3) = arg1.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520646961676F6E616C206F6620746865206D617472697820746F2062652060617267602E
		Sub SetDiagonal(arg As VMaths.Vector2)
		  /// Sets the diagonal of the matrix to be `arg`.
		  
		  Storage(0) = arg.X
		  Storage(3) = arg.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C75652061742060726F772C20636F6C6020746F206076602E
		Sub SetEntry(row As Integer, col As Integer, v As Double)
		  /// Sets the value at `row, col` to `v`.
		  
		  Storage(Index(row, col)) = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206D617472697827732076616C75657320746F207468652073616D652061732074686F736520696E20606D602E
		Sub SetFrom(m As VMaths.Matrix2)
		  /// Sets this matrix's values to the same as those in `m`.
		  
		  Storage(0) = m.Storage(0)
		  Storage(1) = m.Storage(1)
		  Storage(2) = m.Storage(2)
		  Storage(3) = m.Storage(3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B65732074686973206D617472697820696E746F20746865206964656E74697479206D61747269782E
		Sub SetIdentity()
		  /// Makes this matrix into the identity matrix.
		  
		  Storage(0) = 1.0
		  Storage(1) = 0.0
		  Storage(2) = 0.0
		  Storage(3) = 1.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206D617472697820746F20746865206F757465722070726F64756374206F662060756020616E64206076602E
		Sub SetOuter(u As VMaths.Vector2, v As VMaths.Vector2)
		  /// Sets this matrix to the outer product of `u` and `v`.
		  
		  Storage(0) = u.X * v.X
		  Storage(1) = u.X * v.Y
		  Storage(2) = u.Y * v.X
		  Storage(3) = u.Y * v.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5475726E732074686973206D617472697820696E746F206120726F746174696F6E206F66206072616469616E73602E
		Sub SetRotation(radians As Double)
		  /// Turns this matrix into a rotation of `radians`.
		  
		  Var c As Double = Cos(radians)
		  Var s As Double = Sin(radians)
		  
		  Storage(0) = c
		  Storage(1) = s
		  Storage(2) = -s
		  Storage(3) = c
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060726F7760206F662074686973206D617472697820746F207468652076616C75657320696E2060617267602E
		Sub SetRow(row As Integer, arg As VMaths.Vector2)
		  /// Sets `row` of this matrix to the values in `arg`.
		  
		  Storage(Index(row, 0)) = arg.X
		  Storage(Index(row, 1)) = arg.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 7365747320746865206D6174726978207769746820746865207370656369666965642076616C7565732E
		Sub SetValues(arg0 As Double, arg1 As Double, arg2 As Double, arg3 As Double)
		  /// sets the matrix with the specified values.
		  
		  Storage(0) = arg0
		  Storage(1) = arg1
		  Storage(2) = arg2
		  Storage(3) = arg3
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5A65726F732074686973206D61747269782E
		Sub SetZero()
		  /// Zeros this matrix.
		  
		  Storage(0) = 0.0
		  Storage(1) = 0.0
		  Storage(2) = 0.0
		  Storage(3) = 0.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536F6C766573206061202A2078203D2062602E
		Shared Sub Solve(a As VMaths.Matrix2, x As VMaths.Vector2, b As VMaths.Vector2)
		  /// Solves `a * x = b`.
		  
		  Var a11 As Double = a.entry(0, 0)
		  Var a12 As Double = A.entry(0, 1)
		  Var a21 As Double = A.entry(1, 0)
		  Var a22 As Double = A.entry(1, 1)
		  Var bx As Double = b.X
		  Var by As Double = b.Y
		  Var det As Double = a11 * a22 - a12 * a21
		  
		  If det <> 0.0 Then det = 1.0 / det
		  
		  x.X = det * (a22 * bx - a12 * by)
		  x.Y = det * (a11 * by - a21 * bx)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53706C6174732074686520646961676F6E616C20746F2060617267602E
		Sub SplatDiagonal(arg As Double)
		  /// Splats the diagonal to `arg`.
		  
		  Storage(0) = arg
		  Storage(3) = arg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562747261637420606F602066726F6D2074686973206D61747269782E204F766572726964652072657475726E7320697473656C662E
		Sub Subtract(o As VMaths.Matrix2)
		  /// Subtract `o` from this matrix. Override returns itself.
		  
		  Storage(0) = Storage(0) - o.Storage(0)
		  Storage(1) = Storage(1) - o.Storage(1)
		  Storage(2) = Storage(2) - o.Storage(2)
		  Storage(3) = Storage(3) - o.Storage(3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562747261637420606F602066726F6D2074686973206D617472697820616E64207468656E2072657475726E7320697473656C662E
		Function Subtract(o As VMaths.Matrix2) As VMaths.Matrix2
		  /// Subtract `o` from this matrix and then returns itself.
		  
		  Storage(0) = Storage(0) - o.Storage(0)
		  Storage(1) = Storage(1) - o.Storage(1)
		  Storage(2) = Storage(2) - o.Storage(2)
		  Storage(3) = Storage(3) - o.Storage(3)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061207072696E7461626C6520737472696E672E
		Function ToString() As String
		  /// Returns a printable string.
		  
		  Return "[0] " + GetRow(0).ToString + EndOfLine + "[1]" + GetRow(1).ToString + EndOfLine
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trace() As Double
		  /// Trace of the matrix.
		  
		  Return Storage(0) + Storage(3)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73666F726D206061726760207573696E6720746865207472616E73666F726D6174696F6E20646566696E65642062792074686973206D61747269782E2052657475726E7320746865206D6F64696669656420606172676020766563746F722E
		Function Transform(arg As VMaths.Vector2) As VMaths.Vector2
		  /// Transform `arg` using the transformation defined by this matrix. Returns the modified `arg` vector.
		  
		  Var x As Double = (Storage(0) * arg.X) + (Storage(2) * arg.Y)
		  Var y As Double = (Storage(1) * arg.X) + (Storage(3) * arg.Y)
		  
		  arg.X = x
		  arg.Y = y
		  
		  Return arg
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73666F726D206120636F7079206F66206061726760207573696E6720746865207472616E73666F726D6174696F6E20646566696E65642062792074686973206D61747269782E20496620606F75746020697320737570706C6965642C2074686520636F70792069732073746F72656420696E20606F7574602E
		Function Transformed(arg As VMaths.Vector2, out As VMaths.Vector2 = Nil) As VMaths.Vector2
		  /// Transform a copy of `arg` using the transformation defined by this matrix. 
		  /// If `out` is supplied, the copy is stored in `out`.
		  
		  If out = Nil Then
		    out = VMaths.Vector2.Copy(arg)
		  Else
		    out.SetFrom(arg)
		  End If
		  
		  Return Transform(out)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73706F7365732074686973206D61747269782E204F766572726964652072657475726E7320697473656C662E
		Sub Transpose()
		  /// Transposes this matrix. Override returns itself.
		  
		  Var temp As Double = Storage(2)
		  Storage(2) = Storage(1)
		  Storage(1) = temp
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73706F7365732074686973206D617472697820616E642072657475726E7320697473656C662E
		Function Transpose() As VMaths.Matrix2
		  /// Transposes this matrix and returns itself.
		  
		  Var temp As Double = Storage(2)
		  Storage(2) = Storage(1)
		  Storage(1) = temp
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207472616E73706F7365206F662074686973206D61747269782E
		Function Transposed() As VMaths.Matrix2
		  /// Returns the transpose of this matrix.
		  
		  Return Clone.Transpose
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C792074686973207472616E73706F736564206D617472697820776974682060617267602E
		Sub TransposeMultiply(arg As VMaths.Matrix2)
		  /// Multiply this transposed matrix with `arg`.
		  
		  Var m00 As Double = Storage(0)
		  Var m01 As Double = Storage(1)
		  Var m10 As Double = Storage(2)
		  Var m11 As Double = Storage(3)
		  
		  Storage(0) = (m00 * arg.Storage(0)) + (m01 * arg.Storage(1))
		  Storage(2) = (m00 * arg.Storage(2)) + (m01 * arg.Storage(3))
		  Storage(1) = (m10 * arg.Storage(0)) + (m11 * arg.Storage(1))
		  Storage(3) = (m10 * arg.Storage(2)) + (m11 * arg.Storage(3))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Zero() As VMaths.Matrix2
		  /// Returns a new zero matrix.
		  
		  Return New VMaths.Matrix2
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns row 0.
			  
			  Return GetRow(0)
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Sets row 0 to `value`
			  
			  SetRow(0, value)
			  
			End Set
		#tag EndSetter
		Row0 As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Returns row 1.
			  
			  Return GetRow(1)
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Sets row 1 to `value`
			  
			  SetRow(1, value)
			  
			End Set
		#tag EndSetter
		Row1 As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4120666978656420342D656C656D656E742061727261792073746F72696E672074686973206D6174726978277320726F772C20636F6C756D6E20646174612E
		Storage(3) As Double
	#tag EndProperty


	#tag Constant, Name = Dimension, Type = Double, Dynamic = False, Default = \"2", Scope = Public, Description = 5468652064696D656E73696F6E206F6620746865206D61747269782E
	#tag EndConstant


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

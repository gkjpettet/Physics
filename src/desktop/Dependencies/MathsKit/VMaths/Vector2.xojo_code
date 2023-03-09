#tag Class
Protected Class Vector2
	#tag Method, Flags = &h0, Description = 4162736F6C75746573207468697320766563746F72277320636F6D706F6E656E74732E
		Sub Absolute()
		  /// Absolutes this vector's components.
		  
		  X = Abs(X)
		  Y = Abs(Y)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206162736F6C757465206572726F72206265747765656E207468697320766563746F7220616E642060636F7272656374602E
		Function AbsoluteError(correct As VMaths.Vector2) As Double
		  /// The absolute error between this vector and `correct`.
		  
		  Return Self.Clone.Subtract(correct).Length
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732060766020746F207468697320766563746F722E
		Sub Add(v As VMaths.Vector2)
		  /// Adds `v` to this vector.
		  
		  X = X + v.X
		  Y = Y + v.Y
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732060766020746F207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function Add(v As VMaths.Vector2) As VMaths.Vector2
		  /// Adds `v` to this vector and returns itself.
		  
		  X = X + v.X
		  Y = Y + v.Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206076602C207363616C65642062792060666163746F726020746F207468697320766563746F722E
		Sub AddScaled(v As VMaths.Vector2, factor As Double)
		  /// Adds `v`, scaled by `factor` to this vector.
		  
		  X = X + v.X * factor
		  Y = Y + v.Y * factor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206076602C207363616C65642062792060666163746F726020746F207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function AddScaled(v As VMaths.Vector2, factor As Double) As VMaths.Vector2
		  /// Adds `v`, scaled by `factor` to this vector and returns itself.
		  
		  X = X + v.X * factor
		  Y = Y + v.Y * factor
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53706C617473206076616C75656020696E746F20616C6C206C616E6573206F662074686520766563746F722E
		Shared Function All(value As Double) As VMaths.Vector2
		  /// Splats `value` into all lanes of the vector.
		  
		  Return New VMaths.Vector2(value, value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520616E676C652028696E2072616469616E7329206265747765656E207468697320766563746F7220616E6420606F74686572602E
		Function AngleTo(other As VMaths.Vector2) As Double
		  /// Returns the angle (in radians) between this vector and `other`.
		  
		  If X = other.X And Y = other.Y Then Return 0
		  
		  Var d As Double = Dot(other) / (Length / other.Length)
		  
		  Return ACos(d.Clamp(-1.0, 1.0))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207369676E656420616E676C652028696E2072616469616E7329206265747765656E207468697320766563746F7220616E6420606F74686572602E
		Function AngleToSigned(other As VMaths.Vector2) As Double
		  /// Returns the signed angle (in radians) between this vector and `other`.
		  
		  If X = other.X And Y = other.Y Then Return 0
		  
		  Return ATan2(Cross(other), Dot(other))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F66206E65772060566563746F723260206F626A65637473206F662074686520726571756573746564206C656E6774682E
		Shared Function ArrayOf(length As Integer) As VMaths.Vector2()
		  /// Returns an array of new `Vector2` objects of the requested length.
		  
		  Var vectors() As VMaths.Vector2
		  
		  Var i As Integer
		  length = length - 1
		  For i = 0 To length
		    vectors.Add(VMaths.Vector2.Zero)
		  Next i
		  
		  Return vectors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4365696C20636F6D706F6E656E747320696E207468697320766563746F722E
		Sub Ceil()
		  /// Ceil components in this vector.
		  
		  X = Ceiling(X)
		  Y = Ceiling(Y)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C616D7073207468697320766563746F72277320636F6D706F6E656E747320284E2920696E207468652072616E6765205B6D696E4E5D20746F205B6D61784E5D2E
		Sub Clamp(min As VMaths.Vector2, max As VMaths.Vector2)
		  /// Clamps this vector's components (N) in the range [minN] to [maxN].
		  
		  X = X.Clamp(min.X, max.X)
		  Y = Y.Clamp(min.Y, max.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C616D7073207468697320766563746F72277320636F6D706F6E656E747320696E207468652072616E676520606D696E696D756D6020746F20606D6178696D756D602E
		Sub ClampScalar(minimum As Double, maximum As Double)
		  /// Clamps this vector's components in the range `minimum` to `maximum`.
		  
		  X = X.Clamp(minimum, maximum)
		  Y = Y.Clamp(minimum, maximum)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120636C6F6E65206F66207468697320766563746F722E
		Function Clone() As VMaths.Vector2
		  /// Returns a clone of this vector.
		  
		  Return New VMaths.Vector2(Self.X, Self.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620606F746865726020697320636F6E7369646572656420657175616C20746F207468697320766563746F722077697468696E2060646563696D616C506F696E7473602E
		Function Compare(other As VMaths.Vector2, decimalPoints As Integer) As Boolean
		  /// True if `other` is considered equal to this vector within `decimalPoints`.
		  
		  // Same object?
		  If Self Is other Then Return True
		  
		  Return X.Compare(other.X, decimalPoints) And Y.Compare(other.Y, decimalPoints)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(x As Double, y As Double)
		  Self.X = x
		  Self.Y = y
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720636F7079206F6620606F74686572602E
		Shared Function Copy(other As VMaths.Vector2) As VMaths.Vector2
		  /// Returns a new copy of `other`.
		  
		  Return New VMaths.Vector2(other.X, other.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F7069657320656C656D656E74732066726F6D2060646020696E746F207468697320766563746F72277320636F6D706F6E656E7473207374617274696E6720617420606F6666736574602E
		Sub CopyFromArray(d() As Double, offset As Integer = 0)
		  /// Copies elements from `d` into this vector's components starting at `offset`.
		  
		  X = d(offset)
		  Y = d(offset + 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F70696573207468697320766563746F72277320636F6D706F6E656E747320696E746F2060766020616E642072657475726E73206076602E
		Function CopyInto(ByRef v As VMaths.Vector2) As VMaths.Vector2
		  /// Copies this vector's components into `v` and returns `v`.
		  
		  v.X = X
		  v.Y = Y
		  
		  Return v
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F70696573207468697320766563746F72277320636F6D706F6E656E747320696E746F20606460207374617274696E6720617420606F6666736574602E
		Sub CopyIntoArray(ByRef d() As Double, offset As Integer = 0)
		  /// Copies this vector's components into `d` starting at `offset`.
		  
		  d(offset) = X
		  d(offset + 1) = Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652063726F73732070726F64756374206F66207468697320766563746F72207769746820606F74686572602E
		Function Cross(other As VMaths.Vector2) As Double
		  /// Returns the cross product of this vector with `other`.
		  
		  Return Self.X * other.Y - Self.Y * other.X
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652064697374616E63652066726F6D207468697320766563746F7220746F20606F74686572602E
		Function DistanceTo(other As VMaths.Vector2) As Double
		  /// The distance from this vector to `other`.
		  
		  Return Sqrt(DistanceToSquared(other))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737175617265642064697374616E63652066726F6D207468697320766563746F7220746F20606F74686572602E
		Function DistanceToSquared(other As VMaths.Vector2) As Double
		  /// The squared distance from this vector to `other`.
		  
		  Var dx As Double = X - other.X
		  Var dy As Double = Y - other.Y
		  
		  Return dx * dx + dy * dy
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44697669646573207468697320766563746F72277320636F6D706F6E656E74732062792074686520636F6D706F6E656E747320696E20606F74686572602E
		Sub Divide(other As VMaths.Vector2)
		  /// Divides this vector's components by the components in `other`.
		  
		  X = X / other.X
		  Y = Y / other.Y
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44697669646573207468697320766563746F72277320636F6D706F6E656E74732062792074686520636F6D706F6E656E747320696E20606F74686572602E
		Function Divide(other As VMaths.Vector2) As VMaths.Vector2
		  /// Divides this vector's components by the components in `other` and returns itself.
		  
		  X = X / other.X
		  Y = Y / other.Y
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646F742070726F64756374206F66207468697320766563746F7220616E6420606F74686572602E
		Function Dot(other As VMaths.Vector2) As Double
		  /// Returns the dot product of this vector and `other`.
		  
		  Return X * other.X + Y * other.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 466C6F6F72732074686520636F6D706F6E656E747320696E207468697320766563746F722E
		Sub Floor()
		  /// Floors the components in this vector.
		  
		  X = Floor(X)
		  Y = Floor(Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720566563746F723220696E697469616C6973656420776974682076616C75657320696E20606460207374617274696E6720617420606F6666736574602E
		Shared Function FromArray(d() As Double, offset As Integer = 0) As VMaths.Vector2
		  /// Returns a new `Vector2` initialised with values in `d` starting at `offset`.
		  
		  Return New VMaths.Vector2(d(offset), d(offset + 1))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574207468652076616C756573206F662060726573756C746020746F20746865206D6178696D756D206F662060616020616E642060626020666F722065616368206C696E652E
		Shared Sub Maximum(a As VMaths.Vector2, b As VMaths.Vector2, result As VMaths.Vector2)
		  /// Set the values of `result` to the maximum of `a` and `b` for each line.
		  
		  result.X = Max(a.X, b.X)
		  result.Y = Max(a.Y, b.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574207468652076616C756573206F662060726573756C746020746F20746865206D696E696D756D206F662060616020616E642060626020666F722065616368206C696E652E
		Shared Sub Minimum(a As VMaths.Vector2, b As VMaths.Vector2, result As VMaths.Vector2)
		  /// Set the values of `result` to the minimum of `a` and `b` for each line.
		  
		  result.X = Min(a.X, b.X)
		  result.Y = Min(a.Y, b.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E746572706F6C61746573206265747765656E20606D696E6020616E6420606D61786020776974682074686520616D6F756E74206F6620606160207573696E672061206C696E65617220696E746572706F6C6174696F6E20616E642073746F726573207468652076616C75657320696E2060726573756C74602E
		Shared Sub Mix(min As VMaths.Vector2, max As VMaths.Vector2, a As Double, result As VMaths.Vector2)
		  /// Interpolates between `min` and `max` with the amount of `a` using a linear interpolation and stores
		  /// the values in `result`.
		  
		  result.X = min.X + a * (max.X - min.X)
		  result.Y = min.Y + a * (max.Y - min.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C696573207468697320766563746F72277320636F6D706F6E656E747320776974682074686520636F6D706F6E656E747320696E20606F74686572602E
		Sub Multiply(other As VMaths.Vector2)
		  /// Multiplies this vector's components with the components in `other`.
		  
		  X = X * other.X
		  Y = Y * other.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C696573207468697320766563746F72277320636F6D706F6E656E747320776974682074686520636F6D706F6E656E747320696E20606F746865726020616E642072657475726E7320697473656C662E
		Function Multiply(other As VMaths.Vector2) As VMaths.Vector2
		  /// Multiplies this vector's components with the components in `other` and returns itself.
		  
		  X = X * other.X
		  Y = Y * other.Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E656761746573207468697320766563746F722E
		Sub Negate()
		  /// Negates this vector.
		  
		  X = -X
		  Y = -Y
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E656761746573207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function Negate() As VMaths.Vector2
		  /// Negates this vector and returns itself.
		  
		  X = -X
		  Y = -Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6F726D616C69736573207468697320766563746F722E
		Sub Normalize()
		  /// Normalises this vector.
		  
		  Var l As Double = Length
		  
		  If l = 0.0 Then Return
		  
		  Var d As Double = 1.0 / l
		  X = X * d
		  Y = Y * d
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6F726D616C69736573207468697320766563746F722072657475726E7320697473206F726967696E616C206C656E6774682E
		Function Normalize() As Double
		  /// Normalises this vector returns its original length.
		  
		  Var l As Double = Length
		  
		  If l = 0.0 Then Return 0
		  
		  Var d As Double = 1.0 / l
		  X = X * d
		  Y = Y * d
		  
		  Return l
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6F726D616C6973656420636F7079206F66207468697320766563746F722E205468697320766563746F7220697320756E616C74657265642E
		Function Normalized() As VMaths.Vector2
		  /// Returns a normalised copy of this vector. This vector is unaltered.
		  
		  Var v As VMaths.Vector2 = Clone
		  v.Normalize
		  Return v
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6F726D616C69736573207468697320766563746F7220696E746F20606F7574602E
		Function NormalizeInto(ByRef out As VMaths.Vector2) As VMaths.Vector2
		  /// Normalises this vector into `out` and returns `out`.
		  
		  out.SetFrom(Self)
		  out.Normalize
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(other As VMaths.Vector2) As VMaths.Vector2
		  Return Clone.Add(other)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4F76657272696465732074686520603D60206F70657261746F722E2052657475726E7320603060206966207468697320766563746F72206973206571756976616C656E7420746F20606F7468657260206F7220602D3160206F74686572776973652E
		Function Operator_Compare(other As VMaths.Vector2) As Integer
		  /// Overrides the `=` operator. Returns `0` if this vector is equivalent to `other` or `-1` otherwise.
		  ///
		  /// Note that this is doing a zero tolerance double comparison. The X and Y components must be EXACTLY
		  /// the same for the two vectors to be considered equivalent.
		  /// To compare to vectors with tolerance use the `Compare()` method.
		  
		  If other Is Nil Then
		    Return -1
		  ElseIf Self Is other Then
		    Return 0
		  ElseIf X = other.X And Y = other.Y Then
		    Return 0
		  Else
		    Return -1
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(scale As Double) As VMaths.Vector2
		  Return Clone.Scale(1.0 / scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(scale As Double) As VMaths.Vector2
		  Return Clone.Scale(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Negate() As VMaths.Vector2
		  Return Clone.Negate
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6D706F6E656E74206F662074686520766563746F722061742074686520696E646578206069602E
		Function Operator_Subscript(i As Integer) As Double
		  /// Returns the component of the vector at the index `i`.
		  
		  Select Case i
		  Case 0
		    Return X
		  Case 1
		    Return Y
		  Else
		    Raise New OutOfBoundsException("Invalid vector component index (" + i.ToString + ").")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(i As Integer, Assigns d As Double)
		  Select Case i
		  Case 0
		    X = d
		  Case 1
		    Y = d
		  Else
		    Raise New OutOfBoundsException("Invalid vector component index (" + i.ToString + ").")
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720566563746F7232206279207375627472616374696E6720606F74686572602066726F6D207468697320766563746F722E205468697320766563746F7220697320756E616C74657265642E
		Function Operator_Subtract(other As VMaths.Vector2) As VMaths.Vector2
		  /// Returns a new Vector2 by subtracting `other` from this vector. This vector is unaltered.
		  
		  Return Self.Clone.Subtract(other)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73666F726D73207468697320696E746F207468652070726F64756374206F66207468697320766563746F72206173206120726F7720766563746F722C20706F73742D6D756C7469706C696564206279206D61747269782C20606D602E
		Sub PostMultiply(m As VMaths.Matrix2)
		  /// Transforms this into the product of this vector as a row vector, post-multiplied by matrix, `m`. 
		  /// 
		  /// If `m` is a rotation matrix, this is a computational shortcut for applying the inverse of the 
		  /// transformation.
		  
		  Var v0 As Double = X
		  Var v1 As Double = Y
		  
		  X = v0 * m.Storage(0) + v1 * m.Storage(1)
		  Y = v0 * m.Storage(2) + v1 * m.Storage(3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E65772072616E646F6D20766563746F7220696E207468652072616E67652028302C20302920746F2028312C2031292E
		Shared Function Random() As VMaths.Vector2
		  /// Returns a new random vector in the range (0, 0) to (1, 1). 
		  
		  Return New VMaths.Vector2(System.Random.Number, System.Random.Number)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720566563746F72322077686F736520605860206973205B6D696E582C206D6178585D20616E642077686F736520605960206973205B6D696E592C206D6178595D2E
		Shared Function RandomInRange(minX As Integer, maxX As Integer, minY As Integer, maxY As Integer) As VMaths.Vector2
		  /// Returns a new `Vector2` whose `X` is [minX, maxX] and whose `Y` is [minY, maxY].
		  
		  Return New VMaths.Vector2( _
		  System.Random.InRange(minX, maxX), System.Random.InRange(minY, maxY))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265666C65637473207468697320766563746F722E
		Sub Reflect(normal As VMaths.Vector2)
		  /// Reflects this vector.
		  
		  Subtract(normal.Scaled(2.0 * normal.Dot(Self)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265666C65637473207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function Reflect(normal As VMaths.Vector2) As VMaths.Vector2
		  /// Reflects this vector and returns itself.
		  
		  Subtract(normal.Scaled(2.0 * normal.Dot(Self)))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061207265666C656374656420636F7079206F66207468697320766563746F722E
		Function Reflected(normal As VMaths.Vector2) As VMaths.Vector2
		  /// Returns a reflected copy of this vector.
		  
		  Return Clone.Reflect(normal)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656C6174697665206572726F72206265747765656E207468697320766563746F7220616E642060636F7272656374602E
		Function RelativeError(correct As VMaths.Vector2) As Double
		  /// The relative error between this vector and `correct`.
		  
		  Var correctNorm As Double = correct.Length
		  
		  Var tmpV As VMaths.Vector2 = Self - correct
		  Var diffNorm As Double = tmpV.Length
		  
		  Return diffNorm / correctNorm
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Round()
		  /// Rounds this vector's components.
		  
		  X = Round(X)
		  Y = Round(Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526F756E6473207468697320766563746F72277320636F6D706F6E656E747320746F7761726473207A65726F2E
		Sub RoundToZero()
		  /// Rounds this vector's components towards zero.
		  
		  X = If(X < 0.0, Ceiling(X), Floor(X))
		  Y = If(Y < 0.0, Ceiling(Y), Floor(Y))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363616C6573207468697320766563746F72206279206064602E204F766572726964652072657475726E7320697473656C662E
		Sub Scale(d As Double)
		  /// Scales this vector by `d`. Override returns itself.
		  
		  X = X * d
		  Y = Y * d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363616C6573207468697320766563746F72206279206064602E
		Function Scale(d As Double) As VMaths.Vector2
		  /// Scales this vector by `d` and returns itself.
		  
		  X = X * d
		  Y = Y * d
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120636F7079206F66207468697320766563746F72207363616C6564206279206064602E
		Function Scaled(d As Double) As VMaths.Vector2
		  /// Returns a copy of this vector scaled by `d`.
		  
		  Return Clone.Scale(d)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526F7461746573207468697320766563746F72206279203930206465677265657320616E64207468656E207363616C657320697420627920607363616C65602E2053746F7265732074686520726573756C7420696E20606F7574602E204F766572726964652072657475726E7320606F7574602E
		Sub ScaleOrthogonalInto(scale As Double, out As VMaths.Vector2)
		  /// Rotates this vector by 90 degrees and then scales it by `scale`. 
		  /// Stores the result in `out`. Override returns `out`.
		  
		  out.X = -scale * Y
		  out.Y = scale * X
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526F7461746573207468697320766563746F72206279203930206465677265657320616E64207468656E207363616C657320697420627920607363616C65602E2053746F7265732074686520726573756C7420696E20606F75746020616E642072657475726E7320606F7574602E
		Function ScaleOrthogonalInto(scale As Double, out As VMaths.Vector2) As VMaths.Vector2
		  /// Rotates this vector by 90 degrees and then scales it by `scale`. 
		  /// Stores the result in `out` and returns `out`.
		  
		  out.X = -scale * Y
		  out.Y = scale * X
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320766563746F72277320636F6D706F6E656E747320627920636F7079696E67207468656D2066726F6D20606F74686572602E
		Sub SetFrom(other As VMaths.Vector2)
		  /// Sets this vector's components by copying them from `other`.
		  
		  X = other.X
		  Y = other.Y
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320766563746F72277320636F6D706F6E656E747320627920636F7079696E67207468656D2066726F6D20606F74686572602E2052657475726E7320697473656C662E
		Function SetFrom(other As VMaths.Vector2) As VMaths.Vector2
		  /// Sets this vector's components by copying them from `other`. Returns itself.
		  
		  X = other.X
		  Y = other.Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetValues(x As Double, y As Double)
		  /// Set the values of this vector.
		  
		  Self.X = x
		  Self.Y = y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5A65726F207468697320766563746F722E
		Sub SetZero()
		  /// Zero this vector.
		  
		  X = 0.0
		  Y = 0.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53706C6174732060646020696E746F20616C6C206C616E6573206F66207468697320766563746F722E
		Sub Splat(d As Double)
		  /// Splats `d` into all lanes of this vector.
		  
		  X = d
		  Y = d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562747261637473206076602066726F6D207468697320766563746F722E
		Sub Subtract(v As VMaths.Vector2)
		  /// Subtracts `v` from this vector.
		  
		  X = X - v.X
		  Y = Y - v.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562747261637473206076602066726F6D207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function Subtract(v As VMaths.Vector2) As VMaths.Vector2
		  /// Subtracts `v` from this vector and returns itself.
		  
		  X = X - v.X
		  Y = Y - v.Y
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  /// Returns a string representation of this vector.
		  
		  Return "[" + X.ToString + "," + Y.ToString + "]"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720696E7374616E6365206F662061207A65726F20766563746F722028302C2030292E
		Shared Function Zero() As VMaths.Vector2
		  /// Returns a new instance of a zero vector (0, 0).
		  
		  Return New VMaths.Vector2(0, 0)
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620616E7920636F6D706F6E656E7420697320696E66696E6974652E
		#tag Getter
			Get
			  /// True if any component is infinite.
			  
			  Return X.IsInfinite Or Y.IsInfinite
			End Get
		#tag EndGetter
		IsInfinite As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620616E7920636F6D706F6E656E74206973204E614E2E
		#tag Getter
			Get
			  /// True if any component is not a number (NaN).
			  
			  Return X.IsNotANumber Or Y.IsNotANumber
			End Get
		#tag EndGetter
		IsNotANumber As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 536574206F7220676574207468697320766563746F722773206C656E6774682E
		#tag Getter
			Get
			  Return Sqrt(X * X + Y * Y)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Sets the length of the vector. A negative value will change the vector's orientation and a value of
			  /// zero will set the vector to zero.
			  
			  If value = 0.0 Then
			    SetZero
			  Else
			    Var l As Double = Length
			    If l = 0.0 Then Return
			    l = value / l
			    X = X * l
			    Y = Y * l
			  End If
			End Set
		#tag EndSetter
		Length As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468697320766563746F722773206C656E67746820737175617265642E
		#tag Getter
			Get
			  Return X * X + Y * Y
			  
			End Get
		#tag EndGetter
		Length2 As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468697320766563746F722773205820636F6F7264696E6174652E
		X As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320766563746F722773205920636F6F7264696E6174652E
		Y As Double
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
			Name="IsInfinite"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsNotANumber"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length2"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="X"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

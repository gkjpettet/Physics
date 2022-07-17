#tag Class
Protected Class AABB
	#tag Method, Flags = &h0, Description = 436F6D62696E657320616E6F74686572204141424220776974682074686973206F6E652E
		Sub Combine(aabb As Physics.AABB)
		  /// Combines another AABB with this one.
		  
		  LowerBound.X = _
		  If(LowerBound.X < aabb.LowerBound.X, LowerBound.X, aabb.LowerBound.X)
		  
		  LowerBound.Y = _
		  If(LowerBound.Y < aabb.LowerBound.Y, LowerBound.Y, aabb.LowerBound.Y)
		  
		  UpperBound.X = _
		  If(UpperBound.X > aabb.UpperBound.X, UpperBound.X, aabb.UpperBound.X)
		  
		  UpperBound.Y = _
		  If(UpperBound.Y > aabb.UpperBound.Y, UpperBound.Y, aabb.UpperBound.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D62696E652074776F20414142427320696E746F2074686973206F6E652E
		Sub Combine2(aabb1 As Physics.AABB, aab As Physics.AABB)
		  /// Combine two AABBs into this one.
		  
		  LowerBound.X = _
		  If(aabb1.LowerBound.X < aab.LowerBound.X, aabb1.LowerBound.X, aab.LowerBound.X)
		  
		  LowerBound.Y = _
		  If(aabb1.LowerBound.Y < aab.LowerBound.Y, aabb1.LowerBound.Y, aab.LowerBound.Y)
		  
		  UpperBound.X = _
		  If(aabb1.UpperBound.X > aab.UpperBound.X, aabb1.UpperBound.X, aab.UpperBound.X)
		  
		  UpperBound.Y = _
		  If(aabb1.UpperBound.Y > aab.UpperBound.Y, aabb1.UpperBound.Y, aab.UpperBound.Y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  LowerBound = VMaths.Vector2.Zero
		  UpperBound = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446F65732074686973204141424220636F6E7461696E207468652070726F766964656420414142423F
		Function Contains(aabb As Physics.AABB) As Boolean
		  /// Does this AABB contain the provided AABB?
		  
		  Return LowerBound.X <= aabb.LowerBound.X And _
		  LowerBound.Y <= aabb.LowerBound.Y And _
		  aabb.UpperBound.X <= UpperBound.X And _
		  aabb.UpperBound.Y <= UpperBound.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F706965732066726F6D2074686520676976656E206F626A6563742E
		Shared Function Copy(other As Physics.AABB) As Physics.AABB
		  /// Copies from the given object.
		  
		  Var box As New Physics.AABB
		  
		  box.LowerBound = other.LowerBound.Clone
		  box.UpperBound = other.UpperBound.Clone
		  
		  Return box
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExtentsToOut(ByRef out As VMaths.Vector2)
		  out.X = (UpperBound.X - LowerBound.X) * 0.5
		  out.Y = (UpperBound.Y - LowerBound.Y) * 0.5
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetVertices(argRay() As VMaths.Vector2)
		  argRay(0).SetFrom(LowerBound)
		  argRay(1).SetFrom(LowerBound)
		  argRay(1).X = argRay(1).X + (upperBound.X - LowerBound.X)
		  argRay(2).SetFrom(UpperBound)
		  argRay(3).SetFrom(UpperBound)
		  argRay(3).X = argRay(3).X - (UpperBound.X - LowerBound.X)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 56657269667920746861742074686520626F756E64732061726520736F727465642E
		Function IsValid() As Boolean
		  /// Verify that the bounds are sorted.
		  
		  Var dx As Double = UpperBound.X - LowerBound.X
		  If dx < 0.0 Then Return False
		  
		  Var dy As Double = UpperBound.Y - LowerBound.Y
		  If dy < 0.0 Then Return False
		  
		  Return (Not lowerBound.IsInfinite) And _
		  (Not LowerBound.IsNotANumber) And _
		  (Not UpperBound.IsInfinite) And _
		  (Not UpperBound.IsNotANumber)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RaycastWithPool(output As Physics.RaycastOutput, input As Physics.RaycastInput) As Boolean
		  // From Real-time Collision Detection, p179.
		  
		  Var tMix As Double = -Maths.DoubleMaxFinite
		  Var tMax As Double = Maths.DoubleMaxFinite
		  
		  Var p As Vmaths.Vector2 = VMaths.Vector2.Zero
		  Var d As Vmaths.Vector2 = VMaths.Vector2.Zero
		  Var absD As Vmaths.Vector2 = VMaths.Vector2.Zero
		  Var normal As Vmaths.Vector2 = VMaths.Vector2.Zero
		  
		  P.SetFrom(input.P1)
		  
		  d.SetFrom(input.P2)
		  d.Subtract(input.P1)
		  
		  absD.SetFrom(d)
		  absD.Absolute
		  
		  // x then y.
		  If absD.X < Physics.Settings.Epsilon Then
		    // Parallel.
		    If p.X < LowerBound.X Or UpperBound.X < p.X Then Return False
		  Else
		    Var invD As Double = 1.0 / d.X
		    Var t1 As Double = (LowerBound.X - p.X) * invD
		    Var t2 As Double = (UpperBound.X - p.X) * invD
		    
		    // Sign of the normal vector.
		    Var s As Double = -1.0
		    
		    If t1 > t2 Then
		      Var temp As Double = t1
		      t1 = t2
		      t2 = temp
		      s = 1.0
		    End If
		    
		    // Push the min up.
		    If t1 > tMix Then
		      normal.SetZero
		      normal.X = s
		      tMix = t1
		    End If
		    
		    // Pull the max down.
		    tMax = Min(tMax, t2)
		    
		    If tMix > tMax Then Return False
		  End If
		  
		  If absD.Y < Physics.Settings.Epsilon Then
		    // Parallel.
		    If p.Y < LowerBound.Y Or UpperBound.Y < p.Y Then Return False
		  Else
		    Var invD As Double = 1.0 / d.Y
		    Var t1 As Double = (LowerBound.Y - p.Y) * invD
		    Var t2 As Double = (UpperBound.Y - p.Y) * invD
		    
		    // Sign of the normal vector.
		    Var s As Double = -1.0
		    
		    If t1 > t2 Then
		      Var temp As Double = t1
		      t1 = t2
		      t2 = temp
		      s = 1.0
		    End If
		    
		    // Push the min up.
		    If t1 > tMix Then
		      normal.SetZero
		      normal.Y = s
		      tMix = t1
		    End If
		    
		    // Pull the max down.
		    tMax = Min(tMax, t2)
		    
		    If tMix > tMax Then
		      Return False
		    End If
		  End If
		  
		  // Does the ray start inside the box?
		  // Does the ray intersect beyond the max fraction?
		  If tMix < 0.0 Or input.MaxFraction < tMix Then Return False
		  
		  // Intersection.
		  output.Fraction = tMix
		  output.Normal.X = normal.X
		  output.Normal.Y = normal.Y
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206F626A6563742066726F6D2074686520676976656E206F626A6563742E
		Sub Set(aabb As Physics.AABB)
		  /// Sets this object from the given object.
		  
		  Var v As VMaths.Vector2 = aabb.LowerBound
		  LowerBound.X = v.X
		  LowerBound.Y = v.Y
		  
		  Var v1 As VMaths.Vector2 = aabb.UpperBound
		  UpperBound.X = v1.X
		  UpperBound.Y = v1.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestOverlap(a As Physics.AABB, b As Physics.AABB) As Boolean
		  If b.LowerBound.X - a.UpperBound.X > 0.0 Or _
		    b.LowerBound.Y - a.UpperBound.Y > 0.0 Then
		    Return False
		  End If
		  
		  If a.LowerBound.X - b.UpperBound.X > 0.0 Or _
		    a.LowerBound.Y - b.UpperBound.Y > 0.0 Then
		    Return False
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return "AABB[" + LowerBound.ToString + " . " + UpperBound.ToString + "]"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E2041414242206F626A656374207573696E672074686520676976656E20626F756E64696E672076657274696365732E
		Shared Function WithVec2(lowerVertex As VMaths.Vector2, upperVertex As VMaths.Vector2) As Physics.AABB
		  /// Creates an AABB object using the given bounding vertices.
		  ///
		  /// `lowerVertex` should be the bottom left vertex of the bounding box.
		  /// `upperVertex` should be the top right vertex of the bounding box.
		  
		  Var box As New Physics.AABB
		  
		  box.LowerBound = lowerVertex.Clone
		  box.UpperBound = upperVertex.Clone
		  
		  Return box
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 5468652063656E747265206F662074686520414142422E
		#tag Getter
			Get
			  Var tmp As VMaths.Vector2 = LowerBound + UpperBound
			  tmp.Scale(0.5)
			  
			  Return tmp
			  
			End Get
		#tag EndGetter
		Center As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520657874656E7473206F66207468652041414242202868616C662D776964746873292E
		#tag Getter
			Get
			  Var tmp As VMaths.Vector2 = UpperBound.Clone
			  tmp.Subtract(LowerBound)
			  tmp.Scale(0.5)
			  
			  Return tmp
			  
			End Get
		#tag EndGetter
		Extents As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 426F74746F6D206C65667420766572746578206F6620626F756E64696E6720626F782E
		LowerBound As VMaths.Vector2
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520706572696D65746572206C656E6774682E
		#tag Getter
			Get
			  Return 2.0 * (UpperBound.X - LowerBound.X + UpperBound.Y - LowerBound.Y)
			  
			End Get
		#tag EndGetter
		Perimeter As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546F7020726967687420766572746578206F6620626F756E64696E6720626F782E
		UpperBound As VMaths.Vector2
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

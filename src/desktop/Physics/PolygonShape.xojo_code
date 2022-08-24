#tag Class
Protected Class PolygonShape
Inherits Physics.Shape
	#tag Method, Flags = &h0, Description = 476574207468652063656E74726F696420616E64206170706C792074686520737570706C696564207472616E73666F726D2E
		Function ApplyToCentroid(xf As Physics.Transform) As VMaths.Vector2
		  /// Get the centroid and apply the supplied transform.
		  
		  Return Physics.Transform.MulVec2(xf, centroid)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChildCount() As Integer
		  Return 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Physics.Shape
		  Var shape As New Physics.PolygonShape
		  shape.Centroid.SetFrom(Centroid)
		  
		  For Each normal As VMaths.Vector2 In Normals
		    shape.Normals.Add(normal.Clone)
		  Next normal
		  
		  For Each vertex As VMaths.Vector2 In Vertices
		    shape.Vertices.Add(vertex.Clone)
		  Next vertex
		  
		  shape.Radius = Radius
		  
		  Return shape
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeAABB(aabb As Physics.AABB, xf As Physics.Transform, childIndex As Integer)
		  #Pragma Unused childIndex
		  
		  Var lower As VMaths.Vector2 = aabb.LowerBound
		  Var upper As VMaths.Vector2 = aabb.UpperBound
		  Var v1 As VMaths.Vector2 = Vertices(0)
		  Var xfqc As Double = xf.Q.Cos
		  Var xfqs As Double = xf.Q.Sin
		  Var xfpx As Double = xf.P.X
		  Var xfpy As Double = xf.P.Y
		  lower.X = (xfqc * v1.X - xfqs * v1.Y) + xfpx
		  lower.Y = (xfqs * v1.X + xfqc * v1.Y) + xfpy
		  upper.X = lower.X
		  upper.Y = lower.Y
		  
		  Var iLimit As Integer = Vertices.Count - 1
		  For i As Integer = 1 To iLimit
		    Var v2 As VMaths.Vector2 = vertices(i)
		    Var vx As Double = (xfqc * v2.X - xfqs * v2.Y) + xfpx
		    Var vy As Double = (xfqs * v2.X + xfqc * v2.Y) + xfpy
		    lower.X = If(lower.X < vx, lower.X, vx)
		    lower.Y = If(lower.Y < vy, lower.Y, vy)
		    upper.X = If(upper.X > vx, upper.X, vx)
		    upper.Y = If(upper.Y > vy, upper.Y, vy)
		  Next i
		  
		  lower.X = lower.X - radius
		  lower.Y = lower.Y - radius
		  upper.X = upper.X + radius
		  upper.Y = upper.Y + radius
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeCentroid(vs() As VMaths.Vector2, count As Integer)
		  #If DebugBuild
		    Assert(count >= 3)
		  #EndIf
		  
		  Centroid.SetZero
		  
		  Var area As Integer = 0.0
		  
		  // pRef is the reference point for forming triangles.
		  // It's location doesn't change the result (except for rounding error).
		  Var pRef As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  Var e1 As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var e2 As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  Const inv3 = 1.0 / 3.0
		  
		  Var iLimit As Integer = count - 1
		  For i As Integer = 0 To iLimit
		    // Triangle vertices.
		    Var p1 As VMaths.Vector2 = pRef
		    Var p2 As VMaths.Vector2 = vs(i)
		    Var p3 As VMaths.Vector2 = If(i + 1 < count, vs(i + 1), vs(0))
		    
		    e1.SetFrom(p2)
		    e1.Subtract(p1)
		    
		    e2.SetFrom(p3)
		    e2.Subtract(p1)
		    
		    Var D As Double = e1.Cross(e2)
		    
		    Var triangleArea As Double = 0.5 * D
		    area = area + Abs(triangleArea)
		    
		    // Area weighted centroid.
		    e1.SetFrom(p1)
		    e1.Add(p2)
		    e1.Add(p3)
		    e1.Scale(triangleArea * inv3)
		    Centroid.Add(e1)
		  Next i
		  
		  // Centroid.
		  #If DebugBuild
		    Assert(area > Physics.Settings.Epsilon)
		  #EndIf
		  Centroid.Scale(1.0 / area)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ComputeDistanceToOut(xf As Physics.Transform, p As VMaths.Vector2, childIndex As Integer, ByRef normalOut As VMaths.Vector2) As Double
		  #Pragma Unused childIndex
		  
		  Var xfqc As Double = xf.Q.cos
		  Var xfqs As Double = xf.Q.Sin
		  Var tx As Double = p.X - xf.P.X
		  Var ty As Double = p.Y - xf.P.Y
		  Var pLocalx As Double = xfqc * tx + xfqs * ty
		  Var pLocaly As Double = -xfqs * tx + xfqc * ty
		  
		  Var maxDistance As Double = -Maths.DoubleMaxFinite
		  Var normalForMaxDistanceX As Double = pLocalx
		  Var normalForMaxDistanceY As Double = pLocaly
		  
		  Var iLimit As Integer = Vertices.Count - 1
		  For i As Integer = 0 To iLimit
		    Var vertex As VMaths.Vector2 = Vertices(i)
		    Var normal As VMaths.Vector2 = Normals(i)
		    tx = pLocalx - vertex.X
		    ty = pLocaly - vertex.Y
		    Var dot As Double = normal.X * tx + normal.Y * ty
		    If dot > maxDistance Then
		      maxDistance = dot
		      normalForMaxDistanceX = normal.X
		      normalForMaxDistanceY = normal.Y
		    End If
		  Next i
		  
		  Var distance As Double
		  If maxDistance > 0 Then
		    Var minDistanceX As Double = normalForMaxDistanceX
		    Var minDistanceY As Double = normalForMaxDistanceY
		    Var minDistance2 As Double = maxDistance * maxDistance
		    iLimit = Vertices.Count - 1
		    For i As Integer = 0 To iLimit
		      Var vertex As VMaths.Vector2 = Vertices(i)
		      Var distanceVecX As Double = pLocalx - vertex.X
		      Var distanceVecY As Double = pLocaly - vertex.Y
		      Var distance2 As Double = _
		      distanceVecX * distanceVecX + distanceVecY * distanceVecY
		      If minDistance2 > distance2 Then
		        minDistanceX = distanceVecX
		        minDistanceY = distanceVecY
		        minDistance2 = distance2
		      End If
		    Next i
		    distance = Sqrt(minDistance2)
		    normalOut.X = xfqc * minDistanceX - xfqs * minDistanceY
		    normalOut.Y = xfqs * minDistanceX + xfqc * minDistanceY
		    normalOut.Normalize
		  Else
		    distance = maxDistance
		    normalOut.X = xfqc * normalForMaxDistanceX - xfqs * normalForMaxDistanceY
		    normalOut.Y = xfqs * normalForMaxDistanceX + xfqc * normalForMaxDistanceY
		  End If
		  
		  Return distance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeMass(massData As Physics.MassData, density As Double)
		  // Polygon mass, centroid, and inertia.
		  // Let rho be the polygon density in mass per unit area.
		  // Then:
		  // mass = rho * int(dA)
		  // centroid.x = (1/mass) * rho * int(x * dA)
		  // centroid.y = (1/mass) * rho * int(y * dA)
		  // I = rho * int((x*x + y*y) * dA)
		  //
		  // We can compute these integrals by summing all the integrals
		  // for each triangle of the polygon. To evaluate the integral
		  // for a single triangle, we make a change of variables to
		  // the (u,v) coordinates of the triangle:
		  // x = x0 + e1x * u + e2x * v
		  // y = y0 + e1y * u + e2y * v
		  // where 0 <= u && 0 <= v && u + v <= 1.
		  //
		  // We integrate u from [0,1-v] and then v from [0,1].
		  // We also need to use the Jacobian of the transformation:
		  // D = cross(e1, e2)
		  //
		  // Simplification: triangle centroid = (1/3) * (p1 + p2 + p3)
		  //
		  // The rest of the derivation is handled by computer algebra.
		  
		  #If DebugBuild
		    Assert(Vertices.Count >= 3)
		  #EndIf
		  
		  Var center As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var area As Double = 0.0
		  Var I As Double = 0.0
		  
		  // pRef is the reference point for forming triangles.
		  // It's location doesn't change the result (except for rounding error).
		  Var s As VMaths.Vector2 = VMaths.Vector2.Zero
		  // This code would put the reference point inside the polygon.
		  Var aLimit As Integer = Vertices.Count - 1
		  For a As Integer = 0 To aLimit
		    s.Add(Vertices(a))
		  Next a
		  s.Scale(1.0 / Vertices.Count)
		  
		  Const kInv3 = 1.0 / 3.0
		  
		  Var e1 As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var e2 As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  aLimit = Vertices.Count - 1
		  For a As Integer = 0 To aLimit
		    // Triangle vertices.
		    e1.SetFrom(Vertices(a))
		    e1.Subtract(s)
		    e2.SetFrom(s)
		    e2.Negate
		    e2.Add(If(a + 1 < Vertices.Count, Vertices(a + 1), Vertices(0)))
		    
		    Var D As Double = e1.Cross(e2)
		    
		    Var triangleArea As Double = 0.5 * D
		    area = area + Abs(triangleArea)
		    
		    // Area weighted centroid.
		    center.X = center.X + (triangleArea * kInv3 * (e1.X + e2.X))
		    center.Y = center.Y + (triangleArea * kInv3 * (e1.Y + e2.Y))
		    
		    Var ex1 As Double = e1.X
		    Var ey1 As Double = e1.Y
		    Var ex2 As Double = e2.X
		    Var ey2 As Double = e2.Y
		    
		    Var intx2 As Double = ex1 * ex1 + ex2 * ex1 + ex2 * ex2
		    Var inty2 As Double = ey1 * ey1 + ey2 * ey1 + ey2 * ey2
		    
		    I = I + ((0.25 * kInv3 * D) * (intx2 + inty2))
		  Next a
		  
		  // Total mass.
		  massData.Mass = density * area
		  
		  // Centre of mass.
		  #If DebugBuild
		    Assert(area > Physics.Settings.Epsilon)
		  #EndIf
		  center.Scale(1.0 / area)
		  massData.Center.SetFrom(center)
		  massData.Center.Add(s)
		  
		  // Inertia tensor relative to the local origin (point s).
		  massData.I = I * density
		  
		  // Shift to center of mass then to original body origin.
		  massData.I = massData.I + (massData.Mass * (massData.Center.Dot(massData.Center)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor(Physics.ShapeType.Polygon)
		  
		  Radius = Physics.Settings.PolygonRadius
		  
		  Centroid = VMaths.Vector2.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Raycast(output As Physics.RaycastOutput, input As Physics.RaycastInput, xf As Physics.Transform, childIndex As Integer) As Boolean
		  #Pragma Unused childIndex
		  
		  Var xfqc As Double = xf.Q.Cos
		  Var xfqs  As Double = xf.Q.Sin
		  Var xfp As VMaths.Vector2 = xf.P
		  Var tempX As Double = input.p1.X - xfp.X
		  Var tempY As Double = input.p1.Y - xfp.Y
		  Var p1x As Double = xfqc * tempX + xfqs * tempY
		  Var p1y As Double = -xfqs * tempX + xfqc * tempY
		  
		  tempX = input.p2.X - xfp.X
		  tempY = input.p2.Y - xfp.Y
		  Var p2x As Double = xfqc * tempX + xfqs * tempY
		  Var p2y As Double = -xfqs * tempX + xfqc * tempY
		  
		  Var dx As Double = p2x - p1x
		  Var dy As Double = p2y - p1y
		  
		  Var lower As Double = 0.0
		  Var upper As Double = input.MaxFraction
		  
		  Var index As Integer = -1
		  
		  Var iLimit As Integer = Vertices.Count - 1
		  For i As Integer = 0 To iLimit
		    Var normal As VMaths.Vector2 = Normals(i)
		    Var vertex As VMaths.Vector2 = Vertices(i)
		    Var tempX1 As Double = vertex.X - p1x
		    Var tempY1 As Double = vertex.Y - p1y
		    Var numerator As Double = normal.x * tempX1 + normal.y * tempY1
		    Var denominator As Double = normal.X * dx + normal.Y * dy
		    
		    If denominator = 0.0 Then
		      If numerator < 0.0 Then
		        Return False
		      End If
		    Else
		      // Note: we want this predicate without division:
		      // lower < numerator / denominator, where denominator < 0
		      // Since denominator < 0, we have to flip the inequality:
		      // lower < numerator / denominator <==> denominator * lower >
		      // numerator.
		      If denominator < 0.0 And numerator < lower * denominator Then
		        // Increase lower.
		        // The segment enters this half-space.
		        lower = numerator / denominator
		        index = i
		      ElseIf denominator > 0.0 And numerator < upper * denominator Then
		        // Decrease upper.
		        // The segment exits this half-space.
		        upper = numerator / denominator
		      End If
		    End If
		    
		    If upper < lower Then
		      Return False
		    End If
		  Next i
		  
		  #If DebugBuild
		    Assert(0.0 <= lower And lower <= input.MaxFraction)
		  #EndIf
		  
		  If index >= 0 Then
		    output.Fraction = lower
		    Var normal As VMaths.Vector2 = normals(index)
		    Var out As VMaths.Vector2 = output.Normal
		    out.X = xfqc * normal.X - xfqs * normal.Y
		    out.Y = xfqs * normal.X + xfqc * normal.Y
		    Return True
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465206120636F6E7665782068756C6C2066726F6D2074686520676976656E206172726179206F6620706F696E74732E2054686520636F756E74206F6620746865206C697374206D75737420626520696E207468652072616E6765205B332C20506879736963732E53657474696E67732E4D6178506F6C79676F6E56657274696365735D2E
		Sub Set(updatedVertices() As VMaths.Vector2)
		  /// Create a convex hull from the given array of points. The count of the
		  /// list must be in the range [3, Physics.Settings.MaxPolygonVertices].
		  ///
		  /// Warning: the points may be re-ordered, even if they form a convex polygon.
		  /// Warning: collinear points are removed.
		  
		  Var updatedCount As Integer = updatedVertices.Count
		  
		  #If DebugBuild
		    Assert(updatedCount >= 3, "Too few vertices to form a polygon.")
		    Assert(updatedCount <= Physics.Settings.MaxPolygonVertices, "Too many vertices.")
		  #EndIf
		  
		  If updatedCount < 3 Then
		    SetAsBoxXY(1.0, 1.0)
		    Return
		  End If
		  
		  // Perform welding and copy vertices into local buffer.
		  Var points() As VMaths.Vector2
		  
		  For Each v As VMaths.Vector2 In updatedVertices
		    Var unique As Boolean = True
		    Var jLimit As Integer = points.Count - 1
		    For j As Integer = 0 To jLimit
		      If v.DistanceToSquared(points(j)) < 0.5 * Physics.Settings.LinearSlop Then
		        unique = False
		        Exit
		      End If
		    Next j
		    
		    If unique Then
		      points.Add(v.Clone)
		      If points.Count = Physics.Settings.MaxPolygonVertices Then
		        Exit
		      End If
		    End If
		  Next v
		  
		  If points.Count < 3 Then
		    #If DebugBuild
		      Assert(False, "Too few vertices to be a polygon.")
		    #EndIf
		    SetAsBoxXY(1.0, 1.0)
		    Return
		  End If
		  
		  // Create the convex hull using the Gift wrapping algorithm:
		  // http://en.wikipedia.org/wiki/Gift_wrapping_algorithm
		  
		  // Find the right most point on the hull.
		  Var rightMostPoint As VMaths.Vector2 = points(0)
		  For Each point As VMaths.Vector2 In points
		    Var x As Double = point.X
		    Var y As Double = point.Y
		    Var x0 As Double = rightMostPoint.X
		    Var y0 As Double = rightMostPoint.Y
		    If x > x0 Or (x = x0 And y < y0) Then
		      rightMostPoint = point
		    End If
		  Next point
		  
		  Var hull() As VMaths.Vector2
		  hull.Add(rightMostPoint)
		  Var pointOnHull As VMaths.Vector2 = rightMostPoint
		  Do
		    // Set first point in the set as the initial candidate for the
		    // next point on the convex hull.
		    Var endPoint As VMaths.Vector2 = points(0)
		    
		    // Test the candidate point against all points in the set to find
		    // the next convex hull point.
		    For Each point As VMaths.Vector2 In points
		      // If the candidate point is the current last point on the convex
		      // hull, update the candidate point to the current point and continue
		      // checking against the remaining points.
		      If endPoint = pointOnHull Then
		        endPoint = point
		        Continue
		      End If
		      
		      // Use the cross product of the vectors from the current convex hull
		      // point to the candidate point and the test point to see if the winding
		      // changes from CCW to CW. This indicates the current point is a better
		      // candidate for a hull point. Update the candidate point.
		      Var r As VMaths.Vector2 = endPoint.Clone
		      r.Subtract(pointOnHull)
		      Var v As VMaths.Vector2 = point.Clone
		      v.Subtract(pointOnHull)
		      Var c As Double = r.Cross(v)
		      If c < 0.0 Then
		        endPoint = point
		      End If
		      
		      // Collinearity check.
		      If c = 0.0 And v.Length2 > r.Length2 Then
		        endPoint = point
		      End If
		    Next point
		    
		    // Set the end point candidate as the new current convex hull point.
		    pointOnHull = endPoint
		    If Not hull.Contains(pointOnHull) Then
		      hull.Add(pointOnHull)
		    End If
		    
		  Loop Until pointOnHull = hull(0)
		  
		  // Copy vertices.
		  vertices.ResizeTo(-1)
		  vertices.AddAll(hull)
		  For Each v As VMaths.Vector2 In vertices
		    Normals.Add(VMaths.Vector2.Zero)
		  Next v
		  
		  Var edge As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  // Compute normals. Ensure the edges have non-zero length.
		  Var iLimit As Integer = Vertices.Count - 1
		  For i As Integer = 0 To iLimit
		    Var i1 As Integer = i
		    Var i2 As Integer = (i + 1) Mod vertices.Count
		    edge.SetFrom(vertices(i2))
		    edge.Subtract(vertices(i1))
		    
		    #If DebugBuild
		      Assert(edge.Length2 > Physics.Settings.Epsilon * Physics.Settings.Epsilon)
		    #EndIf
		    
		    edge.ScaleOrthogonalInto(-1.0, normals(i))
		    normals(i).Normalize
		  Next i
		  
		  // Compute the polygon centroid.
		  ComputeCentroid(vertices, vertices.Count)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4275696C6420766572746963657320746F20726570726573656E7420616E206F7269656E74656420626F782E206063656E7465726020616E642060616E676C65602073686F756C6420626520696E206C6F63616C20636F6F7264696E617465732E
		Sub SetAsBox(halfWidth As Double, halfHeight As Double, center As VMaths.Vector2, angle As Double)
		  /// Build vertices to represent an oriented box.
		  /// `center` and `angle` should be in local coordinates.
		  
		  SetAsBoxXY(halfWidth, halfHeight)
		  Centroid.SetFrom(center)
		  
		  Var xf As Physics.Transform = Physics.Transform.Zero
		  xf.P.SetFrom(center)
		  xf.Q.SetAngle(angle)
		  
		  // Transform vertices and normals.
		  Var iLimit As Integer = Vertices.Count
		  For i As Integer = 0 to iLimit
		    Vertices(i).SetFrom(Physics.Transform.MulVec2(xf, Vertices(i)))
		    Normals(i).SetFrom(Physics.Rot.MulVec2(xf.Q, Normals(i)))
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4275696C6420766572746963657320746F20726570726573656E7420616E20617869732D616C69676E656420626F782E
		Sub SetAsBoxXY(halfWidth As Double, halfHeight As Double)
		  /// Build vertices to represent an axis-aligned box.
		  
		  Vertices.ResizeTo(-1)
		  Vertices.Add(New VMaths.Vector2(-halfWidth, -halfHeight))
		  Vertices.Add(New VMaths.Vector2(halfWidth, -halfHeight))
		  Vertices.Add(New VMaths.Vector2(halfWidth, halfHeight))
		  Vertices.Add(New VMaths.Vector2(-halfWidth, halfHeight))
		  
		  Normals.ResizeTo(-1)
		  Normals.Add(New VMaths.Vector2(0.0, -1.0))
		  Normals.Add(New VMaths.Vector2(1.0, 0.0))
		  Normals.Add(New VMaths.Vector2(0.0, 1.0))
		  Normals.Add(New VMaths.Vector2(-1.0, 0.0))
		  
		  Centroid.SetZero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574207468697320617320612073696E676C6520656467652E
		Sub SetEdge(v1 As VMaths.Vector2, v2 As VMaths.Vector2)
		  /// Set this as a single edge.
		  
		  Vertices.ResizeTo(-1)
		  Vertices.Add(v1.Clone)
		  Vertices.Add(v2.Clone)
		  
		  Centroid.SetFrom(v1)
		  Centroid.Add(v2)
		  Centroid.Scale(0.5)
		  
		  Normals.ResizeTo(-1)
		  Normals.Add(v2 - v1)
		  Normals(0).ScaleOrthogonalInto(-1.0, normals(0))
		  Normals(0).Normalize
		  Normals.Add(-normals(0))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestPoint(xf As Physics.Transform, p As VMaths.Vector2) As Boolean
		  Var xfq As Physics.Rot = xf.Q
		  
		  Var tempX As Double = p.X - xf.P.X
		  Var tempY As Double = p.Y - xf.P.Y
		  Var pLocalX As Double = xfq.Cos * tempX + xfq.Sin * tempY
		  Var pLocalY As Double = -xfq.Sin * tempX + xfq.Cos * tempY
		  
		  Var iLimit As Integer = Vertices.Count - 1
		  For i As Integer = 0 To iLimit
		    Var vertex As VMaths.Vector2= Vertices(i)
		    Var normal As VMaths.Vector2 = Normals(i)
		    tempX = pLocalX - vertex.X
		    tempY = pLocalY - vertex.Y
		    Var dot As Double = normal.X * tempX + normal.Y * tempY
		    If dot > 0.0 Then
		      Return False
		    End If
		  Next i
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 56616C696461746520636F6E7665786974792E2054686973206973206120766572792074696D6520636F6E73756D696E67206F7065726174696F6E2E
		Function Validate() As Boolean
		  /// Validate convexity. This is a very time consuming operation.
		  
		  Var iLimit As Integer = Vertices.Count - 1
		  For i As Integer = 0 To iLimit
		    Var i1 As Integer = i
		    Var i2 As Integer = If(i < vertices.Count - 1, i1 + 1, 0)
		    Var p As VMaths.Vector2 = Vertices(i1)
		    Var e As VMaths.Vector2 = VMaths.Vector2.Copy(Vertices(i2))
		    e.Subtract(p)
		    
		    Var jLimit As Integer = Vertices.Count - 1
		    For j As integer = 0 To jLimit
		      If j = i1 Or j = i2 Then
		        Continue
		      End If
		      
		      Var v As VMaths.Vector2 = VMaths.Vector2.Copy(Vertices(j))
		      v.Subtract(p)
		      Var c As Double = e.Cross(v)
		      If c < 0.0 Then
		        Return False
		      End If
		    Next j
		  Next i
		  
		  Return True
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A convex polygon shape. Polygons have a maximum number of vertices equal to
		`mMaxPolygonVertices`.
		In most cases you should not need many vertices for a convex polygon.
		
		
	#tag EndNote

	#tag Note, Name = Progress
		Up to (not including) `set()`
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 4C6F63616C20706F736974696F6E206F66207468652073686170652063656E74726F696420696E20706172656E7420626F6479206672616D652E
		Centroid As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E6F726D616C73206F66207468652073686170652E204E6F74653A207573652060566572746578436F756E74602C206E6F7420606D4E6F726D616C732E436F756E74602C20746F20676574206E756D626572206F6620616374697665206E6F726D616C732E
		Normals() As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207665727469636573206F66207468652073686170652E204E6F74653A207573652060566572746578436F756E74602C206E6F74206D56657274696365732E436F756E742829602C20746F20676574206E756D626572206F66206163746976652076657274696365732E
		Vertices() As VMaths.Vector2
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
			Name="Radius"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShapeType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Physics.ShapeType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Circle"
				"1 - Edge"
				"2 - Polygon"
				"3 - Chain"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

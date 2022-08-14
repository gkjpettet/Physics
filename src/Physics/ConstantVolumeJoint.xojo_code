#tag Class
Protected Class ConstantVolumeJoint
Inherits Physics.Joint
	#tag Method, Flags = &h21
		Private Function ConstrainEdges(positions() As Physics.Position) As Boolean
		  Var perimeter As Double = 0.0
		  
		  Var iLimit As Integer = mBodies.Count - 1
		  For i As Integer = 0 To iLimit
		    Var next_ As Integer = If(i = mBodies.Count - 1, 0, i + 1)
		    Var dx As Double= positions(mBodies(next_).IslandIndex).C.X - _
		    positions(mBodies(i).IslandIndex).C.X
		    Var dy As Double = positions(mBodies(next_).IslandIndex).C.Y - _
		    positions(mBodies(i).IslandIndex).C.Y
		    Var dist As Double = Sqrt(dx * dx + dy * dy)
		    If dist < Physics.Settings.Epsilon Then
		      dist = 1.0
		    End If
		    mNormals(i).X = dy / dist
		    mNormals(i).Y = -dx / dist
		    perimeter = perimeter + dist
		  Next i
		  
		  Var delta As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  Var deltaArea As Double = mTargetVolume - GetSolverArea(positions)
		  Var toExtrude As Double = 0.5 * deltaArea / perimeter
		  Var done As Boolean = True
		  
		  Var iLimit2 As Integer = mBodies.Count - 1
		  For i As Integer = 0 To iLimit2
		    Var next_ As Integer = If(i = mBodies.Count - 1, 0, i + 1)
		    delta.SetValues( _
		    toExtrude * (mNormals(i).X + mNormals(next_).X), _
		    toExtrude * (mNormals(i).Y + mNormals(next_).Y))
		    Var normSqrd As Double = delta.Length2
		    If normSqrd > _
		      Physics.Settings.MaxLinearCorrection * Physics.Settings.MaxLinearCorrection Then
		      delta.Scale(Physics.Settings.MaxLinearCorrection / Sqrt(normSqrd))
		    End If
		    If normSqrd > Physics.Settings.LinearSlop * Physics.Settings.LinearSlop Then
		      done = False
		    End If
		    positions(mBodies(next_).IslandIndex).C.X = positions(mBodies(next_).IslandIndex).C.X + delta.X
		    positions(mBodies(next_).IslandIndex).C.Y = positions(mBodies(next_).IslandIndex).C.Y + delta.Y
		  Next i
		  
		  Return done
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(argWorld As Physics.World, def As Physics.ConstantVolumeJointDef)
		  mBodies = def.Bodies
		  
		  Super.Constructor(def)
		  
		  mWorld = argWorld
		  
		  If def.Bodies.Count <= 2 Then
		    Raise New UnsupportedOperationException("Can't create a constant volume joint with less than three bodies.")
		  End If
		  
		  mTargetLengths.ResizeTo(mBodies.Count - 1)
		  Var iLimit As Integer = mTargetLengths.Count - 1
		  Var tmpV As VMaths.Vector2
		  For i As Integer = 0 To iLimit
		    Var next_ As Integer = If(i = mTargetLengths.Count - 1, 0, i + 1)
		    tmpV = mBodies(i).WorldCenter - mBodies(next_).WorldCenter
		    Var dist As Double = tmpV.Length
		    mTargetLengths(i) = dist
		  Next i
		  mTargetVolume = GetBodyArea
		  
		  If def.Joints.Count > 0 And def.Joints.Count <> def.Bodies.Count Then
		    Raise New UnsupportedOperationException("Incorrect joint definition. " + _
		    "`Joints` have to correspond to the `mBodies`")
		  End If
		  
		  If def.Joints.Count = 0 Then
		    Var distanceJointDef As New Physics.DistanceJointDef
		    
		    For i As Integer = 0 To mBodies.Count - 1
		      Var next_ As Integer = If(i = mBodies.Count - 1, 0, i + 1)
		      distanceJointDef.FrequencyHz = def.FrequencyHz
		      distanceJointDef.DampingRatio = def.DampingRatio
		      distanceJointDef.CollideConnected = def.CollideConnected
		      distanceJointDef.Initialize( _
		      mBodies(i), _
		      mBodies(next_), _
		      mBodies(i).WorldCenter, _
		      mBodies(next_).WorldCenter)
		      
		      Var distanceJoint As New Physics.DistanceJoint(distanceJointDef)
		      mWorld.CreateJoint(distanceJoint)
		      mDistanceJoints.Add(distanceJoint)
		    Next i
		    
		  Else
		    mDistanceJoints.ResizeTo(-1)
		    For Each j As Physics.Joint In def.Joints
		      mDistanceJoints.Add(Physics.DistanceJoint(j))
		    Next j
		  End If
		  
		  mNormals.ResizeTo(mBodies.Count - 1)
		  For i As Integer = 0 To mBodies.LastIndex
		    mNormals(i) = VMaths.Vector2.Zero
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destroy()
		  Var iLimit As Integer = mDistanceJoints.Count - 1
		  For i As Integer = 0 To iLimit
		    mWorld.DestroyJoint(mDistanceJoints(i))
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBodies() As Physics.Body()
		  Return mBodies
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBodyArea() As Double
		  Var area As Double = 0
		  Var iLimit As Integer = mBodies.Count - 1
		  For i As Integer = 0 To iLimit
		    Var next_ As Integer = If(i = mBodies.Count - 1,  0, i + 1)
		    area = area + (mBodies(i).WorldCenter.X * mBodies(next_).WorldCenter.Y - _
		    mBodies(next_).WorldCenter.X * mBodies(i).WorldCenter.Y)
		  Next i
		  
		  area = area * 0.5
		  
		  Return area
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetJoints() As Physics.DistanceJoint()
		  Return mDistanceJoints
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSolverArea(positions() As Physics.Position) As Double
		  Var area As Double = 0.0
		  
		  Var iLimit As Integer = mBodies.Count - 1
		  For i As Integer = 0 To iLimit
		    Var next_ As Integer = If(i = mBodies.Count - 1,  0, i + 1)
		    area = area + (positions(mBodies(i).IslandIndex).C.X * _
		    positions(mBodies(next_).IslandIndex).C.Y - _
		    positions(mBodies(next_).IslandIndex).C.X * _
		    positions(mBodies(i).IslandIndex).C.Y)
		  Next i
		  
		  area = area * 0.5
		  
		  Return area
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Inflate(factor As Double)
		  mTargetVolume = mTargetVolume * factor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitVelocityConstraints(step_ As Physics.SolverData)
		  Var velocities() As Physics.Velocity = step_.Velocities
		  Var positions() As Physics.Position = step_.Positions
		  
		  Var d() As VMaths.Vector2
		  d.ResizeTo(mBodies.Count - 1)
		  Var iLimit As Integer = mBodies.Count - 1
		  For i As Integer = 0 To iLimit
		    Var prev As Integer = If(i = 0, mBodies.Count - 1, i - 1)
		    Var next_ As Integer = If(i = mBodies.Count - 1, 0, i + 1)
		    d(i) = positions(mBodies(next_).islandIndex).C - _
		    positions(mBodies(prev).IslandIndex).C
		  Next i
		  
		  If step_.Step_.WarmStarting Then
		    mImpulse = mImpulse * step_.Step_.DtRatio
		    Var iLimit2 As Integer = mBodies.Count - 1
		    For i As Integer = 0 To iLimit2
		      velocities(mBodies(i).IslandIndex).V.X = _
		      velocities(mBodies(i).IslandIndex).V.X + (mBodies(i).InverseMass * d(i).Y * 0.5 * mImpulse)
		      velocities(mBodies(i).IslandIndex).V.Y = _
		      velocities(mBodies(i).IslandIndex).V.Y + (mBodies(i).InverseMass * -d(i).X * 0.5 * mImpulse)
		    Next i
		  Else
		    mImpulse = 0.0
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionForce(invDt As Double) As VMaths.Vector2
		  #Pragma Unused invDt
		  
		  // No-op.
		  Return VMaths.Vector2.Zero
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionTorque(invDt As Double) As Double
		  #Pragma Unused invDt
		  
		  // No-op.
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SolvePositionConstraints(step_ As Physics.SolverData) As Boolean
		  Return ConstrainEdges(step_.Positions)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveVelocityConstraints(step_ As Physics.SolverData)
		  Var crossMassSum As Double = 0.0
		  Var dotMassSum As Double = 0.0
		  
		  Var velocities() As Physics.Velocity = step_.velocities
		  Var positions() As Physics.Position = step_.positions
		  
		  Var d() As VMaths.Vector2
		  d.ResizeTo(mBodies.Count - 1)
		  
		  Var iLimit As Integer = d.LastIndex
		  For i As Integer = 0 To iLimit
		    Var prev As Integer = If(i = 0, mBodies.Count - 1, i - 1)
		    Var next_ As Integer = If(i = mBodies.Count - 1, 0, i + 1)
		    Var v As VMaths.Vector2 = positions(mBodies(next_).IslandIndex).C - _
		    positions(mBodies(prev).IslandIndex).C
		    dotMassSum = dotMassSum + ((v.Length2) / mBodies(i).Mass)
		    crossMassSum = crossMassSum + (velocities(mBodies(i).IslandIndex).V.Cross(v))
		    d(i) = v
		  Next i
		  
		  Var lambda As Double = -2.0 * crossMassSum / dotMassSum
		  mImpulse = mImpulse + lambda
		  
		  Var iLimit2 As Integer = mBodies.Count - 1
		  For i As Integer = 0 To iLimit2
		    velocities(mBodies(i).IslandIndex).V.X = _
		    velocities(mBodies(i).IslandIndex).V.X + (mBodies(i).InverseMass * d(i).Y * 0.5 * lambda)
		    velocities(mBodies(i).IslandIndex).V.Y = _
		    velocities(mBodies(i).IslandIndex).V.Y + (mBodies(i).InverseMass * -d(i).X * 0.5 * lambda)
		  Next i
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // No-op.
			  Return VMaths.Vector2.Zero
			End Get
		#tag EndGetter
		AnchorA As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // No-op.
			  Return VMaths.Vector2.Zero
			End Get
		#tag EndGetter
		AnchorB As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBodies() As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDistanceJoints() As Physics.DistanceJoint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImpulse As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNormals() As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetLengths() As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetVolume As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorld As Physics.World
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
			Name="IslandFlag"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CollideConnected"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RenderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mBodies()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

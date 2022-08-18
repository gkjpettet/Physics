#tag Class
Protected Class DistanceJoint
Inherits Physics.Joint
	#tag Method, Flags = &h0
		Sub Constructor(def As Physics.DistanceJointDef)
		  Super.Constructor(def)
		  
		  mU = VMaths.Vector2.Zero
		  mRA = VMaths.Vector2.Zero
		  mRB = VMaths.Vector2.Zero
		  mLocalCenterA = VMaths.Vector2.Zero
		  mLocalCenterB = VMaths.Vector2.Zero
		  
		  mLength = def.Length
		  mFrequencyHz = def.FrequencyHz
		  mDampingRatio = def.DampingRatio
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitVelocityConstraints(data As Physics.SolverData)
		  mIndexA = BodyA.IslandIndex
		  mIndexB = BodyB.IslandIndex
		  mLocalCenterA.SetFrom(BodyA.Sweep.LocalCenter)
		  mLocalCenterB.SetFrom(BodyB.Sweep.LocalCenter)
		  mInvMassA = BodyA.InverseMass
		  mInvMassB = BodyB.InverseMass
		  mInvIA = BodyA.InverseInertia
		  mInvIB = BodyB.InverseInertia
		  
		  Var cA As VMaths.Vector2 = data.Positions(mIndexA).C
		  Var aA As Double = data.Positions(mIndexA).A
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  var wA As Double = data.Velocities(mIndexA).W
		  
		  Var cB As VMaths.Vector2 = data.Positions(mIndexB).C
		  Var aB As Double = data.Positions(mIndexB).A
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  Var wB As Double = data.Velocities(mIndexB).W
		  
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  // Use mU as temporary variable.
		  mU.SetFrom(LocalAnchorA)
		  mU.Subtract(mLocalCenterA)
		  mRA.SetFrom(Physics.Rot.MulVec2(qA, mU))
		  mU.SetFrom(LocalAnchorB)
		  mU.Subtract(mLocalCenterB)
		  mRB.SetFrom(Physics.Rot.MulVec2(qB, mU))
		  mU.SetFrom(cB)
		  mU.Add(mRB)
		  mU.Subtract(cA)
		  mU.Subtract(mRA)
		  
		  // Handle singularity.
		  Var length As Double = mU.Length
		  If length > Physics.Settings.LinearSlop Then
		    mU.X = mU.X * (1.0 / length)
		    mU.Y = mU.Y * (1.0 / length)
		  Else
		    mU.SetValues(0.0, 0.0)
		  End If
		  
		  Var crAu As Double = mrA.Cross(mU)
		  Var crBu As Double = mRB.Cross(mU)
		  Var invMass As Double = _
		  mInvMassA + mInvIA * crAu * crAu + mInvMassB + mInvIB * crBu * crBu
		  
		  // Compute the effective mass matrix.
		  mMass = If(invMass <> 0.0, 1.0 / invMass, 0.0)
		  
		  If mFrequencyHz > 0.0 Then
		    Var c As Double = length - mLength
		    
		    // Frequency.
		    Var omega As Double = 2.0 * Maths.PI * mFrequencyHz
		    
		    // Damping coefficient.
		    Var d As Double = 2.0 * mMass * mDampingRatio * omega
		    
		    // Spring stiffness.
		    Var k As Double = mMass * omega * omega
		    
		    // Magic formulas.
		    Var dt As Double = data.Step_.Dt
		    mGamma = dt * (d + dt * k)
		    mGamma = If(mGamma <> 0.0, 1.0 / mGamma, 0.0)
		    mBias = c * dt * k * mGamma
		    
		    invMass = invMass + mGamma
		    mMass = If(invMass <> 0.0, 1.0 / invMass, 0.0)
		  Else
		    mGamma = 0.0
		    mBias = 0.0
		  End If
		  If data.Step_.WarmStarting Then
		    // Scale the impulse to support a variable time step.
		    mImpulse = mImpulse * data.Step_.DtRatio
		    
		    Var p As VMaths.Vector2 = VMaths.Vector2.Copy(mU).Scale(mImpulse)
		    
		    vA.X = vA.X - (mInvMassA * p.X)
		    vA.Y = vA.Y - (mInvMassA * p.Y)
		    wA = wA - (mInvIA * mRA.Cross(p))
		    
		    vB.X = vB.X + (mInvMassB * p.X)
		    vB.Y = vB.Y + (mInvMassB * p.Y)
		    wB = wB + (mInvIB * mRB.Cross(p))
		  Else
		    mImpulse = 0.0
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865207265616374696F6E20666F72636520676976656E2074686520696E76657273652074696D6520737465702E20556E6974206973204E2E
		Function ReactionForce(invDt As Double) As VMaths.Vector2
		  /// Get the reaction force given the inverse time step. Unit is N.
		  
		  Return New VMaths.Vector2( _
		  mImpulse * mU.X * invDt, _
		  mImpulse * mU.Y * invDt)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865207265616374696F6E20746F7271756520676976656E2074686520696E76657273652074696D6520737465702E20556E6974206973204E2A6D2E205468697320697320616C77617973207A65726F20666F7220612064697374616E6365206A6F696E742E
		Function ReactionTorque(invDt As Double) As Double
		  /// Get the reaction torque given the inverse time step. Unit is N*m. 
		  /// This is always zero for a distance joint.
		  
		  #Pragma Unused invDt
		  
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Render(debugDraw As Physics.DebugDraw)
		  Var p1 As VMaths.Vector2 = AnchorA
		  Var p2 As VMaths.Vector2 = AnchorB
		  
		  debugDraw.DrawSegment(p1, p2, RenderColor)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SolvePositionConstraints(data As Physics.SolverData) As Boolean
		  If mFrequencyHz > 0.0 Then
		    Return True
		  End If
		  
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  Var rA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rB As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var u As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  Var cA As VMaths.Vector2 = data.Positions(mIndexA).C
		  var aA As Double = data.Positions(mIndexA).A
		  Var cB As VMaths.Vector2 = data.Positions(mIndexB).C
		  var aB As Double = data.Positions(mIndexB).A
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  u.SetFrom(LocalAnchorA)
		  u.Subtract(mLocalCenterA)
		  rA.SetFrom(Physics.Rot.MulVec2(qA, u))
		  u.SetFrom(LocalAnchorB)
		  u.Subtract(mLocalCenterB)
		  rB.SetFrom(Physics.Rot.MulVec2(qB, u))
		  u.SetFrom(cB)
		  u.Add(rB)
		  u.Subtract(cA)
		  u.Subtract(rA)
		  
		  Var length As Double = u.Normalize
		  Var C as Double = Maths.Clamp(length - mLength, _
		  -Physics.Settings.MaxLinearCorrection, Physics.Settings.MaxLinearCorrection)
		  
		  Var impulse As Double = -mMass * C
		  Var pX As Double = impulse * u.X
		  Var pY As Double = impulse * u.Y
		  
		  cA.X = cA.X - (mInvMassA * pX)
		  cA.Y = cA.Y - (mInvMassA * pY)
		  aA = aA - (mInvIA * (rA.X * pY - rA.Y * pX))
		  cB.X = cB.X + (mInvMassB * pX)
		  cB.Y = cB.Y + (mInvMassB * pY)
		  aB = aB + (mInvIB * (rB.X * pY - rB.Y * pX))
		  
		  data.Positions(mIndexA).A = aA
		  data.Positions(mIndexB).A = aB
		  
		  Return Abs(C) < Physics.Settings.LinearSlop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveVelocityConstraints(data As Physics.SolverData)
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  Var wA As Double = data.Velocities(mIndexA).W
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  Var wB As Double = data.Velocities(mIndexB).W
		  
		  Var vpA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var vpB As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  mRA.ScaleOrthogonalInto(wA, vpA)
		  vpA.Add(vA)
		  mRB.ScaleOrthogonalInto(wB, vpB)
		  vpB.Add(vB)
		  Var cDot As Double = mU.Dot(vpB.Subtract(vpA))
		  
		  Var impulse As Double = -mMass * (cDot + mBias + mGamma * mImpulse)
		  mImpulse = mImpulse + impulse
		  
		  Var pX As Double = impulse * mU.X
		  Var pY As Double = impulse * mU.Y
		  
		  vA.X = vA.X - (mInvMassA * pX)
		  vA.Y = vA.Y - (mInvMassA * pY)
		  wA = wA - (mInvIA * (mRA.X * pY - mRA.Y * pX))
		  vB.X = vB.X + (mInvMassB * pX)
		  vB.Y = vB.Y + (mInvMassB * pY)
		  wB = wB + (mInvIB * (mRB.X * pY - mRB.Y * pX))
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A distance joint constrains two points on two bodies to remain at a fixed
		distance from each other. You can view this as a massless, rigid rod.
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mBias As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDampingRatio As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrequencyHz As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGamma As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImpulse As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexA As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexB As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvIA As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvIB As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvMassA As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvMassB As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLength As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mU As VMaths.Vector2
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

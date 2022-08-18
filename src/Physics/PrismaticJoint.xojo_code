#tag Class
Protected Class PrismaticJoint
Inherits Physics.Joint
	#tag Method, Flags = &h0
		Sub Constructor(def As Physics.PrismaticJointDef)
		  mImpulse = VMaths.Vector3.Zero
		  mLocalCenterA = VMaths.Vector2.Zero
		  mLocalCenterB = VMaths.Vector2.Zero
		  mAxis = VMaths.Vector2.Zero
		  mPerp = VMaths.Vector2.Zero
		  mK = VMaths.Matrix3.Zero
		  
		  LocalAnchorA = VMaths.Vector2.Copy(def.LocalAnchorA)
		  LocalAnchorB = VMaths.Vector2.Copy(def.LocalAnchorB)
		  LocalXAxisA = VMaths.Vector2.Copy(def.LocalAxisA)
		  LocalXAxisA.Normalize
		  mLocalYAxisA = VMaths.Vector2.Zero
		  
		  Super.Constructor(def)
		  
		  LocalXAxisA.ScaleOrthogonalInto(1.0, mLocalYAxisA)
		  mReferenceAngle = def.ReferenceAngle
		  
		  mLowerTranslation = def.LowerTranslation
		  mUpperTranslation = def.UpperTranslation
		  mMaxMotorForce = def.MaxMotorForce
		  mMotorSpeed = def.MotorSpeed
		  mEnableLimit = def.EnableLimit
		  mEnableMotor = def.EnableMotor
		  mLimitState = Physics.LimitState.Inactive
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 456E61626C652F64697361626C6520746865206A6F696E74206C696D69742E
		Sub EnableLimit(flag As Boolean)
		  /// Enable/disable the joint limit.
		  
		  If flag <> mEnableLimit Then
		    BodyA.SetAwake(True)
		    BodyB.SetAwake(True)
		    mEnableLimit = flag
		    mImpulse.Z = 0.0
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 456E61626C652F64697361626C6520746865206A6F696E74206D6F746F722E
		Sub EnableMotor(flag As Boolean)
		  /// Enable/disable the joint motor.
		  
		  BodyA.SetAwake(True)
		  BodyB.SetAwake(True)
		  mEnableMotor = flag
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetJointSpeed() As Double
		  /// Get the current joint translation, usually in meters.
		  
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rB As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var p1 As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var p2 As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var d As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var axis As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp2 As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp3 As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  temp.SetFrom(LocalAnchorA)
		  temp.Subtract(bodyA.Sweep.LocalCenter)
		  rA.SetFrom(Physics.Rot.MulVec2(BodyA.Transform.Q, temp))
		  
		  temp.SetFrom(LocalAnchorB)
		  temp.Subtract(bodyB.Sweep.LocalCenter)
		  rB.SetFrom(Physics.Rot.MulVec2(BodyB.Transform.Q, temp))
		  
		  p1.SetFrom(BodyA.Sweep.C)
		  p1.Add(rA)
		  
		  p2.SetFrom(BodyB.Sweep.C)
		  p2.Add(rB)
		  
		  d.SetFrom(p2)
		  d.Subtract(p1)
		  axis.SetFrom(Physics.Rot.MulVec2(BodyA.Transform.Q, LocalXAxisA))
		  
		  Var vA As VMaths.Vector2 = BodyA.LinearVelocity
		  Var vB As VMaths.Vector2 = BodyB.LinearVelocity
		  Var wA As Double = BodyA.AngularVelocity
		  Var wB As Double = BodyB.AngularVelocity
		  
		  axis.ScaleOrthogonalInto(wA, temp)
		  rB.ScaleOrthogonalInto(wB, temp2)
		  rA.ScaleOrthogonalInto(wA, temp3)
		  
		  temp2.Add(vB)
		  temp2.Subtract(vA)
		  temp2.Subtract(temp3)
		  Var speed As Double = d.Dot(temp) + axis.Dot(temp2)
		  
		  Return speed
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetJointTranslation() As Double
		  Var pA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var pB As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var axis as VMaths.Vector2 = VMaths.Vector2.Zero
		  pA.SetFrom(BodyA.WorldPoint(LocalAnchorA))
		  pB.SetFrom(BodyB.WorldPoint(LocalAnchorB))
		  axis.SetFrom(BodyA.WorldVector(LocalXAxisA))
		  pB.Subtract(pA)
		  Var translation As Double = pB.Dot(axis)
		  Return translation
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLocalAxis() As VMaths.Vector2
		  Return LocalXAxisA
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865206C6F776572206A6F696E74206C696D69742C20757375616C6C7920696E206D65747265732E
		Function GetLowerLimit() As Double
		  /// Get the lower joint limit, usually in metres.
		  
		  Return mLowerTranslation
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaxMotorForce() As Double
		  Return mMaxMotorForce
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574207468652063757272656E74206D6F746F7220666F7263652C20757375616C6C7920696E204E2E
		Function GetMotorForce(invDt As Double) As Double
		  /// Get the current motor force, usually in N.
		  
		  Return mMotorImpulse * invDt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetReferenceAngle() As Double
		  Return mReferenceAngle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865207570706572206A6F696E74206C696D69742C20757375616C6C7920696E206D65747265732E
		Function GetUpperLimit() As Double
		  /// Get the upper joint limit, usually in metres.
		  
		  Return mUpperTranslation
		  
		  
		End Function
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
		  Var wA As Double = data.Velocities(mIndexA).W
		  
		  Var cB As VMaths.Vector2 = data.Positions(mIndexB).C
		  Var aB As Double = data.Positions(mIndexB).A
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  Var wB As Double = data.Velocities(mIndexB).W
		  
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  Var d As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rB As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  // Compute the effective masses.
		  d.SetFrom(LocalAnchorA)
		  d.Subtract(mLocalCenterA)
		  rA.SetFrom(Physics.Rot.MulVec2(qA, d))
		  d.SetFrom(LocalAnchorB)
		  d.Subtract(mLocalCenterB)
		  rB.SetFrom(Physics.Rot.MulVec2(qB, d))
		  d.SetFrom(cB)
		  d.Subtract(cA)
		  d.Add(rB)
		  d.Subtract(rA)
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  // Compute motor Jacobian and effective mass.
		  If True Then // Scope block.
		    mAxis.SetFrom(Physics.Rot.MulVec2(qA, LocalXAxisA))
		    temp.SetFrom(d)
		    temp.Add(rA)
		    mA1 = temp.Cross(mAxis)
		    mA2 = rB.Cross(mAxis)
		    
		    mMotorMass = mA + mB + iA * mA1 * mA1 + iB * mA2 * mA2
		    If mMotorMass > 0.0 Then
		      mMotorMass = 1.0 / mMotorMass
		    End If
		  End If
		  
		  // Prismatic constraint.
		  If True Then // Scope block.
		    mPerp.SetFrom(Physics.Rot.MulVec2(qA, mLocalYAxisA))
		    
		    temp.SetFrom(d)
		    temp.Add(rA)
		    mS1 = temp.Cross(mPerp)
		    mS2 = rB.Cross(mPerp)
		    
		    Var k11 As Double = mA + mB + iA * mS1 * mS1 + iB * mS2 * mS2
		    Var k12 As Double = iA * mS1 + iB * mS2
		    Var k13 As Double = iA * mS1 * mA1 + iB * mS2 * mA2
		    Var k22 As Double = iA + iB
		    If k22 = 0.0 Then
		      // For bodies with fixed rotation.
		      k22 = 1.0
		    End If
		    Var k23 As Double = iA * mA1 + iB * mA2
		    Var k33 As Double = mA + mB + iA * mA1 * mA1 + iB * mA2 * mA2
		    
		    mk.SetValues(k11, k12, k13, k12, k22, k23, k13, k23, k33)
		  End If
		  
		  // Compute motor and limit terms.
		  If mEnableLimit Then
		    Var jointTranslation As Double = mAxis.Dot(d)
		    If Abs(mUpperTranslation - mLowerTranslation) < 2.0 * Physics.Settings.LinearSlop Then
		      mLimitState = Physics.LimitState.Equal
		    ElseIf jointTranslation <= mLowerTranslation Then
		      If mLimitState <> Physics.LimitState.AtLower Then
		        mLimitState = Physics.LimitState.AtLower
		        mImpulse.Z = 0.0
		      End If
		    ElseIf jointTranslation >= mUpperTranslation Then
		      If mLimitState <> Physics.LimitState.AtUpper Then
		        mLimitState = Physics.LimitState.AtUpper
		        mImpulse.Z = 0.0
		      End If
		    Else
		      mLimitState = Physics.LimitState.Inactive
		      mImpulse.Z = 0.0
		    End If
		  Else
		    mLimitState = Physics.LimitState.Inactive
		    mImpulse.Z = 0.0
		  End If
		  
		  If mEnableMotor = False Then
		    mMotorImpulse = 0.0
		  End If
		  
		  If data.Step_.WarmStarting Then
		    // Account for variable time step.
		    mImpulse.Scale(data.Step_.DtRatio)
		    mMotorImpulse = mMotorImpulse * data.Step_.DtRatio
		    
		    Var p As VMaths.Vector2 = VMaths.Vector2.Zero
		    temp.SetFrom(mAxis)
		    temp.Scale(mMotorImpulse + mImpulse.Z)
		    p.SetFrom(mPerp)
		    p.Scale(mImpulse.X)
		    p.Add(temp)
		    
		    Var lA As Double = _
		    mImpulse.X * mS1 + mImpulse.Y + (mMotorImpulse + mImpulse.Z) * mA1
		    Var lB As Double = _
		    mImpulse.X * mS2 + mImpulse.Y + (mMotorImpulse + mImpulse.Z) * mA2
		    
		    vA.X = vA.X - (mA * p.X)
		    vA.Y = vA.Y - (mA * p.Y)
		    wA = wA - (iA * lA)
		    
		    vB.X = vB.X + (mB * p.X)
		    vB.Y = vB.Y + (mB * p.Y)
		    wB = wB + (iB * lB)
		  Else
		    mImpulse.SetZero
		    mMotorImpulse = 0.0
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 497320746865206A6F696E74206C696D697420656E61626C65643F
		Function IsLimitEnabled() As Boolean
		  /// Is the joint limit enabled?
		  
		  Return mEnableLimit
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5768657468657220746865206A6F696E74206D6F746F7220697320656E61626C65642E
		Function IsMotorEnabled() As Boolean
		  /// Whether the joint motor is enabled.
		  
		  Return mEnableMotor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionForce(invDt As Double) As VMaths.Vector2
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  temp.SetFrom(mAxis)
		  temp.Scale(mMotorImpulse + mImpulse.Z)
		  Var out As VMaths.Vector2 = VMaths.Vector2.Copy(mPerp)
		  out.Scale(mImpulse.X)
		  out.Add(temp)
		  out.Scale(invDt)
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionTorque(invDt As Double) As Double
		  Return invDt * mImpulse.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Render(debugDraw As Physics.DebugDraw)
		  Var xf1 As Physics.Transform = BodyA.Transform
		  Var xf2 As Physics.Transform = BodyB.Transform
		  Var x1 As VMaths.Vector2 = xf1.P
		  Var x2 As VMaths.Vector2 = xf2.P
		  Var p1 As VMaths.Vector2 = AnchorA
		  Var p2 As VMaths.Vector2 = AnchorB
		  
		  debugDraw.DrawSegment(x1, p1, RenderColor)
		  debugDraw.DrawSegment(p1, p2, RenderColor)
		  debugDraw.DrawSegment(x2, p2, RenderColor)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657420746865206A6F696E74206C696D6974732C20757375616C6C7920696E206D65747265732E
		Sub SetLimits(lower As Double, upper As Double)
		  /// Set the joint limits, usually in metres.
		  
		  #If DebugBuild
		    Assert(lower <= upper)
		  #EndIf
		  
		  If lower <> mLowerTranslation Or upper <> mUpperTranslation Then
		    BodyA.SetAwake(True)
		    BodyB.SetAwake(True)
		    mLowerTranslation = lower
		    mUpperTranslation = upper
		    mImpulse.Z = 0.0
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657420746865206D6178696D756D206D6F746F7220666F7263652C20757375616C6C7920696E204E2E
		Sub SetMaxMotorForce(force As Double)
		  /// Set the maximum motor force, usually in N.
		  
		  BodyA.SetAwake(True)
		  BodyB.SetAwake(True)
		  mMaxMotorForce = force
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SolvePositionConstraints(data As Physics.SolverData) As Boolean
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  Var rA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rB As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var d As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var axis As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var perp As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var c1 As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  Var impulse As VMaths.Vector3 = VMaths.Vector3.Zero
		  
		  Var cA As VMaths.Vector2 = data.positions(mIndexA).c
		  Var aA As Double = data.positions(mIndexA).a
		  Var cB As VMaths.Vector2 = data.positions(mIndexB).c
		  Var aB As Double = data.positions(mIndexB).a
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  // Compute fresh Jacobians
		  temp.SetFrom(LocalAnchorA)
		  temp.Subtract(mLocalCenterA)
		  rA.SetFrom(Physics.Rot.MulVec2(qA, temp))
		  temp.SetFrom(LocalAnchorB)
		  temp.Subtract(mLocalCenterB)
		  rB.SetFrom(Physics.Rot.MulVec2(qB, temp))
		  d.SetFrom(cB)
		  d.Add(rB)
		  d.Subtract(cA)
		  d.Subtract(rA)
		  
		  axis.SetFrom(Physics.Rot.MulVec2(qA, LocalXAxisA))
		  temp.SetFrom(d).Add(rA)
		  Var a1 As Double = temp.Cross(axis)
		  Var a2 As Double = rB.Cross(axis)
		  perp.SetFrom(Physics.Rot.MulVec2(qA, mLocalYAxisA))
		  
		  temp.SetFrom(d).Add(rA)
		  Var s1 As Double = temp.Cross(perp)
		  Var s2 As Double = rB.Cross(perp)
		  
		  c1.X = perp.Dot(d)
		  c1.Y = aB - aA - mReferenceAngle
		  
		  Var linearError As Double = Abs(c1.X)
		  Var angularError As Double = Abs(c1.Y)
		  
		  Var active As Boolean = False
		  Var c2 As Double = 0.0
		  If mEnableLimit Then
		    Var translation As Double = axis.Dot(d)
		    If Abs(mUpperTranslation - mLowerTranslation) < 2.0 * Physics.Settings.LinearSlop Then
		      // Prevent large angular corrections.
		      c2 = Maths.Clamp(translation, -Physics.Settings.MaxLinearCorrection, Physics.Settings.MaxLinearCorrection)
		      linearError = Max(linearError, Abs(translation))
		      active = True
		    ElseIf translation <= mLowerTranslation Then
		      // Prevent large linear corrections and allow some slop.
		      c2 = Maths.Clamp(translation - mLowerTranslation + Physics.Settings.LinearSlop, _
		      -Physics.Settings.MaxLinearCorrection, 0.0)
		      linearError = Max(linearError, mLowerTranslation - translation)
		      active = True
		    ElseIf translation >= mUpperTranslation Then
		      // Prevent large linear corrections and allow some slop.
		      c2 = Maths.Clamp(translation - mUpperTranslation - Physics.Settings.linearSlop, _
		      0.0, Physics.Settings.MaxLinearCorrection)
		      linearError = Max(linearError, translation - mUpperTranslation)
		      active = True
		    End If
		  End If
		  
		  If active Then
		    Var k11 As Double = mA + mB + iA * s1 * s1 + iB * s2 * s2
		    Var k12 As Double = iA * s1 + iB * s2
		    Var k13 As Double = iA * s1 * a1 + iB * s2 * a2
		    Var k22 As Double = iA + iB
		    If k22 = 0.0 Then
		      // For fixed rotation.
		      k22 = 1.0
		    End If
		    Var k23 As Double = iA * a1 + iB * a2
		    Var k33 As Double = mA + mB + iA * a1 * a1 + iB * a2 * a2
		    
		    Var k As VMaths.Matrix3 = VMaths.Matrix3.Zero
		    k.SetValues(k11, k12, k13, k12, k22, k23, k13, k23, k33)
		    
		    Var c As VMaths.Vector3 = VMaths.Vector3.Zero
		    c.X = c1.X
		    c.Y = c1.Y
		    c.Z = c2
		    
		    VMaths.Matrix3.Solve(k, impulse, c.Negate)
		  Else
		    Var k11 As Double = mA + mB + iA * s1 * s1 + iB * s2 * s2
		    Var k12 As Double = iA * s1 + iB * s2
		    Var k22 As Double = If(iA + iB = 0.0, 1.0, iA + iB)
		    
		    Var k As VMaths.Matrix2 = VMaths.Matrix2.Zero
		    
		    k.SetValues(k11, k12, k12, k22)
		    // temp is impulse1.
		    VMaths.Matrix2.Solve(k, temp, c1.Negate)
		    c1.Negate
		    
		    impulse.X = temp.X
		    impulse.Y = temp.Y
		    impulse.Z = 0.0
		  End If
		  
		  Var pX As Double = impulse.X * perp.X + impulse.Z * axis.X
		  Var pY As Double = impulse.X * perp.Y + impulse.Z * axis.Y
		  Var lA As Double = impulse.X * s1 + impulse.Y + impulse.Z * a1
		  Var lB As Double = impulse.X * s2 + impulse.Y + impulse.Z * a2
		  
		  cA.X = cA.X - (mA * pX)
		  cA.Y = cA.Y - (mA * pY)
		  aA = aA - (iA * lA)
		  cB.X = cB.X + (mB * pX)
		  cB.Y = cB.Y + (mB * pY)
		  aB = aB + (iB * lB)
		  
		  data.Positions(mIndexA).A = aA
		  data.Positions(mIndexB).A = aB
		  
		  Return linearError <= Physics.Settings.LinearSlop And _
		  angularError <= Physics.Settings.AngularSlop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveVelocityConstraints(data As Physics.SolverData)
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  Var wA As Double = data.Velocities(mIndexA).W
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  Var wB As Double = data.Velocities(mIndexB).W
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  // Solve linear motor constraint.
		  If mEnableMotor And mLimitState <> Physics.LimitState.Equal Then
		    temp.SetFrom(vB)
		    temp.Subtract(vA)
		    Var cDot As Double = mAxis.Dot(temp) + mA2 * wB - mA1 * wA
		    Var impulse As Double = mMotorMass * (mMotorSpeed - cDot)
		    Var oldImpulse As Double = mMotorImpulse
		    Var maxImpulse As Double = data.Step_.Dt * mMaxMotorForce
		    mMotorImpulse = Maths.Clamp(mMotorImpulse + impulse, -maxImpulse, maxImpulse)
		    impulse = mMotorImpulse - oldImpulse
		    
		    Var P As VMaths.Vector2 = VMaths.Vector2.Zero
		    P.SetFrom(mAxis)
		    P.Scale(impulse)
		    Var lA As Double = impulse * mA1
		    Var lB As Double = impulse * mA2
		    
		    vA.X = vA.X - (mA * P.X)
		    vA.Y = vA.Y - (mA * P.Y)
		    wA = wA - (iA * lA)
		    
		    vB.X = vB.X + (mB * P.X)
		    vB.Y = vB.Y + (mB * P.Y)
		    wB = wB + (iB * lB)
		  End If
		  
		  Var cDot1 As VMaths.Vector2 = VMaths.Vector2.Zero
		  temp.SetFrom(vB)
		  temp.Subtract(vA)
		  cDot1.X = mPerp.Dot(temp) + mS2 * wB - mS1 * wA
		  cDot1.Y = wB - wA
		  
		  If mEnableLimit And mLimitState <> Physics.LimitState.inactive Then
		    // Solve prismatic and limit constraint in block form.
		    Var cDot2 As Double = mAxis.Dot(vB - vA) + mA2 * wB - mA1 * wA
		    Var cDot As New VMaths.Vector3(cDot1.X, cDot1.Y, cDot2)
		    Var f1 As VMaths.Vector3 = VMaths.Vector3.Zero
		    Var df As VMaths.Vector3 = VMaths.Vector3.Zero
		    
		    f1.SetFrom(mImpulse)
		    VMaths.Matrix3.Solve(mK, df, cDot.Negate)
		    
		    mImpulse.Add(df)
		    
		    If mLimitState = Physics.LimitState.AtLower Then
		      mImpulse.Z = Max(mImpulse.Z, 0.0)
		    ElseIf mLimitState = Physics.LimitState.AtUpper Then
		      mImpulse.Z = Min(mImpulse.Z, 0.0)
		    End If
		    
		    Var b As VMaths.Vector2 = VMaths.Vector2.Zero
		    Var f2r As VMaths.Vector2 = VMaths.Vector2.Zero
		    
		    temp.SetValues(mK.Entry(0, 2), mK.Entry(1, 2))
		    temp.Scale(mImpulse.Z - f1.Z)
		    b.SetFrom(cDot1)
		    b.Negate
		    b.Subtract(temp)
		    
		    VMaths.Matrix3.Solve2(mK, f2r, b)
		    f2r.Add(New VMaths.Vector2(f1.X, f1.Y))
		    mImpulse.X = f2r.X
		    mImpulse.Y = f2r.Y
		    
		    df.SetFrom(mImpulse)
		    df.Subtract(f1)
		    
		    Var P As VMaths.Vector2 = VMaths.Vector2.Zero
		    temp.SetFrom(mAxis)
		    temp.Scale(df.Z)
		    P.SetFrom(mPerp)
		    P.Scale(df.X)
		    P.Add(temp)
		    
		    Var lA As Double = df.X * mS1 + df.Y + df.Z * mA1
		    Var lB As Double = df.X * mS2 + df.Y + df.Z * mA2
		    
		    vA.X = vA.X - (mA * P.X)
		    vA.Y = vA.Y - (mA * P.Y)
		    wA = wA - (iA * lA)
		    
		    vB.X = vB.X + (mB * P.X)
		    vB.Y = vB.Y + (mB * P.Y)
		    wB = wB + (iB * lB)
		  Else
		    // Limit is inactive, just solve the prismatic constraint in block form.
		    Var df As VMaths.Vector2 = VMaths.Vector2.Zero
		    VMaths.Matrix3.Solve2(mK, df, cDot1.Negate)
		    cDot1.Negate
		    
		    mImpulse.X = mImpulse.X + df.X
		    mImpulse.Y = mImpulse.Y + df.Y
		    
		    Var p As VMaths.Vector2 = VMaths.Vector2.Zero
		    p.SetFrom(mPerp)
		    p.Scale(df.X)
		    Var lA As Double = df.X * mS1 + df.Y
		    Var lB As Double = df.X * mS2 + df.Y
		    
		    vA.X = vA.X - (mA * p.X)
		    vA.Y = vA.Y - (mA * p.Y)
		    wA = wA - (iA * lA)
		    
		    vB.X = vB.X + (mB * p.X)
		    vB.Y = vB.Y + (mB * p.Y)
		    wB = wB + (iB * lB)
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		LocalXAxisA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mA1 As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mA2 As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAxis As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnableLimit As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnableMotor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImpulse As VMaths.Vector3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexA As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexB As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvIA As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvIB As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvMassA As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvMassB As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mK As VMaths.Matrix3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLimitState As Physics.LimitState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalYAxisA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLowerTranslation As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxMotorForce As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMotorImpulse As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 456666656374697665206D61737320666F72206D6F746F722F6C696D6974207472616E736C6174696F6E616C20636F6E73747261696E742E
		Private mMotorMass As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMotorSpeed As Double = 0.0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206D6F746F722073706565642C20757375616C6C7920696E206D657472657320706572207365636F6E642E
		#tag Getter
			Get
			  Return mMotorSpeed
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  BodyA.SetAwake(True)
			  BodyB.SetAwake(True)
			  mMotorSpeed = value
			  
			End Set
		#tag EndSetter
		MotorSpeed As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mPerp As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReferenceAngle As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mS1 As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mS2 As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpperTranslation As Double = 0.0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mReferenceAngle
			  
			End Get
		#tag EndGetter
		ReferenceAngle As Double
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
			Name="LocalXAxisA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

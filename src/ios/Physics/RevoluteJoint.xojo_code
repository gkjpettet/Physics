#tag Class
Protected Class RevoluteJoint
Inherits Physics.Joint
	#tag Method, Flags = &h0
		Sub Constructor(def As Physics.RevoluteJointDef)
		  Super.Constructor(def)
		  
		  mImpulse = VMaths.Vector3.Zero
		  mRA = VMaths.Vector2.Zero
		  mRB = VMaths.Vector2.Zero
		  mLocalCenterA = VMaths.Vector2.Zero
		  mLocalCenterB = VMaths.Vector2.Zero
		  
		  mMass = VMaths.Matrix3.Zero
		  
		  LocalAnchorA.SetFrom(def.LocalAnchorA)
		  LocalAnchorB.SetFrom(def.LocalAnchorB)
		  mReferenceAngle = def.ReferenceAngle
		  
		  mLowerAngle = def.LowerAngle
		  mUpperAngle = def.UpperAngle
		  mMaxMotorTorque = def.MaxMotorTorque
		  mMotorSpeed = def.MotorSpeed
		  mEnableLimit = def.EnableLimit
		  mEnableMotor = def.EnableMotor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableLimit(flag As Boolean)
		  If flag <> mEnableLimit Then
		    BodyA.SetAwake(True)
		    BodyB.SetAwake(True)
		    mEnableLimit = flag
		    mImpulse.Z = 0.0
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableMotor(flag As Boolean)
		  BodyA.SetAwake(True)
		  BodyB.SetAwake(True)
		  mEnableMotor = flag
		  
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
		  
		  Var aA As Double = data.Positions(mIndexA).A
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  var wA As Double = data.Velocities(mIndexA).W
		  
		  Var aB As Double = data.Positions(mIndexB).A
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  var wB As Double = data.Velocities(mIndexB).W
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  // Compute the effective masses.
		  temp.SetFrom(LocalAnchorA)
		  temp.Subtract(mLocalCenterA)
		  mRA.SetFrom(Physics.Rot.MulVec2(qA, temp))
		  temp.SetFrom(LocalAnchorB)
		  temp.Subtract(mLocalCenterB)
		  mRB.SetFrom(Physics.Rot.MulVec2(qB, temp))
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  Var fixedRotation As Boolean = iA + iB = 0
		  
		  Var exX As Double = mA + mB + mRA.Y * mRA.y * iA + mRB.Y * mRB.Y * iB
		  Var eyX As Double = -mRA.Y * mRA.X * iA - mRB.Y * mRB.X * iB
		  Var ezX As Double = -mRA.Y * iA - mRB.Y * iB
		  Var exY As Double = mMass.Entry(0, 1)
		  Var eyY As Double = mA + mB + mRA.X * mRA.X * iA + mRB.X * mRB.X * iB
		  Var ezY As Double = mRA.X * iA + mRB.X * iB
		  Var exZ As Double = mMass.Entry(0, 2)
		  Var eyZ As Double = mMass.Entry(1, 2)
		  Var ezZ As Double = iA + iB
		  
		  mMass.SetValues(exX, exY, exZ, eyX, eyY, eyZ, ezX, ezY, ezZ)
		  
		  mMotorMass = iA + iB
		  If mMotorMass > 0.0 Then
		    mMotorMass = 1.0 / mMotorMass
		  End If
		  
		  If mEnableMotor = False Or fixedRotation Then
		    mMotorImpulse = 0.0
		  End If
		  
		  If mEnableLimit And fixedRotation = False Then
		    Var jointAngle As Double = aB - aA - mReferenceAngle
		    If Abs(mUpperAngle - mLowerAngle) < 2.0 * Physics.Settings.AngularSlop Then
		      mLimitState = Physics.LimitState.Equal
		    ElseIf jointAngle <= mLowerAngle Then
		      If mLimitState <> Physics.LimitState.AtLower Then
		        mImpulse.Z = 0.0
		      End If
		      mLimitState = Physics.LimitState.AtLower
		    ElseIf jointAngle >= mUpperAngle Then
		      If mLimitState <> Physics.LimitState.AtUpper Then
		        mImpulse.Z = 0.0
		      End If
		      mLimitState = Physics.LimitState.AtUpper
		    Else
		      mLimitState = Physics.LimitState.Inactive
		      mImpulse.Z = 0.0
		    End If
		  Else
		    mLimitState = Physics.LimitState.Inactive
		  End If
		  
		  If data.Step_.WarmStarting Then
		    Var P As VMaths.Vector2  = VMaths.Vector2.Zero
		    // Scale impulses to support a variable time step.
		    mImpulse.X = mImpulse.X * data.Step_.DtRatio
		    mImpulse.Y = mImpulse.Y * data.Step_.DtRatio
		    mMotorImpulse = mMotorImpulse * data.Step_.DtRatio
		    
		    P.X = mImpulse.X
		    P.Y = mImpulse.Y
		    
		    vA.X = vA.X - (mA * P.X)
		    vA.Y = vA.Y - (mA * P.Y)
		    wA = wA - (iA * (mRA.Cross(P) + mMotorImpulse + mImpulse.Z))
		    
		    vB.X = vB.X + (mB * P.X)
		    vB.Y = vB.Y + (mB * P.Y)
		    wB = wB + (iB * (mRB.Cross(P) + mMotorImpulse + mImpulse.Z))
		  Else
		    mImpulse.SetZero
		    mMotorImpulse = 0.0
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JointAngle() As Double
		  Return BodyB.Sweep.A - BodyA.Sweep.A - ReferenceAngle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JointSpeed() As Double
		  Return BodyB.AngularVelocity - BodyA.AngularVelocity
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MotorTorque(invDt As Double) As Double
		  Return mMotorImpulse * invDt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionForce(invDt As Double) As VMaths.Vector2
		  Var v As New VMaths.Vector2(mImpulse.X, mImpulse.Y)
		  
		  v.Scale(invDt)
		  
		  Return v
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionTorque(invDt As Double) As Double
		  Return invDt * mImpulse.Z
		  
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

	#tag Method, Flags = &h0
		Sub SetLimits(lower As Double, upper As Double)
		  #If DebugBuild
		    Assert(lower <= upper)
		  #EndIf
		  
		  If lower <> mLowerAngle Or upper <> mUpperAngle Then
		    BodyA.SetAwake(True)
		    BodyB.SetAwake(True)
		    mImpulse.Z = 0.0
		    mLowerAngle = lower
		    mUpperAngle = upper
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetMaxMotorTorque(torque As Double)
		  BodyA.SetAwake(True)
		  BodyB.SetAwake(True)
		  mMaxMotorTorque = torque
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SolvePositionConstraints(data As Physics.SolverData) As Boolean
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  Var cA As VMaths.Vector2 = data.Positions(mIndexA).C
		  var aA As Double = data.Positions(mIndexA).A
		  Var cB As VMaths.Vector2 = data.Positions(mIndexB).C
		  var aB As Double = data.Positions(mIndexB).A
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  Var angularError As Double  = 0.0
		  var positionError As Double  = 0.0
		  
		  Var fixedRotation As Boolean = mInvIA + mInvIB = 0.0
		  
		  // Solve angular limit constraint.
		  If mEnableLimit And _
		    mLimitState <> Physics.LimitState.Inactive And _
		    fixedRotation = False Then
		    Var angle As Double = aB - aA - mReferenceAngle
		    Var limitImpulse As Double = 0.0
		    
		    If mLimitState = Physics.LimitState.equal Then
		      // Prevent large angular corrections.
		      Var c As Double = Maths.Clamp(angle - mLowerAngle, _
		      -Physics.Settings.MaxAngularCorrection, _
		      Physics.Settings.MaxAngularCorrection)
		      limitImpulse = -mMotorMass * c
		      angularError = Abs(c)
		    ElseIf mLimitState = Physics.LimitState.AtLower Then
		      Var C As Double = angle - mLowerAngle
		      angularError = -C
		      
		      // Prevent large angular corrections and allow some slop.
		      C = Maths.Clamp(C + Physics.Settings.AngularSlop, _
		      -Physics.Settings.MaxAngularCorrection, 0.0)
		      limitImpulse = -mMotorMass * C
		    ElseIf mLimitState = Physics.LimitState.AtUpper Then
		      Var C As Double = angle - mUpperAngle
		      angularError = C
		      
		      // Prevent large angular corrections and allow some slop.
		      C = Maths.Clamp(C - Physics.Settings.AngularSlop, _
		      0.0, Physics.Settings.MaxAngularCorrection)
		      limitImpulse = -mMotorMass * C
		    End If
		    
		    aA = aA - (mInvIA * limitImpulse)
		    aB = aB + (mInvIB * limitImpulse)
		  End If
		  
		  // Solve point-to-point constraint.
		  If True Then // Just a scope block.
		    qA.SetAngle(aA)
		    qB.SetAngle(aB)
		    
		    Var rA As VMaths.Vector2 = VMaths.Vector2.Zero
		    Var rB As VMaths.Vector2 = VMaths.Vector2.Zero
		    Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		    Var impulse As VMaths.Vector2 = VMaths.Vector2.Zero
		    
		    temp.SetFrom(LocalAnchorA)
		    temp.Subtract(mLocalCenterA)
		    rA.SetFrom(Physics.Rot.MulVec2(qA, temp))
		    temp.SetFrom(LocalAnchorB)
		    temp.Subtract(mLocalCenterB)
		    rB.SetFrom(Physics.Rot.MulVec2(qB, temp))
		    
		    temp.SetFrom(cB)
		    temp.Add(rB)
		    temp.Subtract(cA)
		    temp.Subtract(rA)
		    positionError = temp.Length
		    
		    Var mA As Double = mInvMassA
		    Var mB As Double = mInvMassB
		    Var iA As Double = mInvIA
		    Var iB As Double = mInvIB
		    
		    Var K As VMaths.Matrix2 = VMaths.Matrix2.Zero
		    Var a11 As Double = mA + mB + iA * rA.Y * rA.Y + iB * rB.Y * rB.Y
		    Var a21 As Double = -iA * rA.X * rA.Y - iB * rB.X * rB.Y
		    Var a12 As Double = a21
		    Var a22 As Double = mA + mB + iA * rA.X * rA.X + iB * rB.X * rB.X
		    
		    K.SetValues(a11, a21, a12, a22)
		    VMaths.Matrix2.Solve(K, impulse, temp)
		    impulse.Negate
		    
		    cA.X = cA.X - (mA * impulse.X)
		    cA.Y = cA.Y - (mA * impulse.Y)
		    aA = aA - (iA * rA.Cross(impulse))
		    
		    cB.X = cB.X + (mB * impulse.X)
		    cB.Y = cB.Y + (mB * impulse.Y)
		    aB = aB + (iB * rB.Cross(impulse))
		  End If
		  
		  data.Positions(mIndexA).A = aA
		  data.Positions(mIndexB).A = aB
		  
		  Return positionError <= Physics.Settings.LinearSlop And _
		  angularError <= Physics.Settings.AngularSlop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveVelocityConstraints(data As Physics.SolverData)
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  var wA As Double = data.velocities(mIndexA).W
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  var wB As Double = data.velocities(mIndexB).W
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  Var fixedRotation As Boolean = iA + iB = 0.0
		  
		  // Solve motor constraint.
		  If mEnableMotor And _
		    mLimitState <> Physics.LimitState.Equal And _
		    fixedRotation = False Then
		    Var cDot As Double = wB - wA - mMotorSpeed
		    var impulse As Double = -mMotorMass * cDot
		    Var oldImpulse As Double = mMotorImpulse
		    Var maxImpulse As Double = data.Step_.Dt * mMaxMotorTorque
		    mMotorImpulse = Maths.Clamp(mMotorImpulse + impulse, -maxImpulse, maxImpulse)
		    impulse = mMotorImpulse - oldImpulse
		    
		    wA = wA - (iA * impulse)
		    wB = wB + (iB * impulse)
		  End If
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  // Solve limit constraint.
		  If mEnableLimit And _
		    mLimitState <> Physics.LimitState.Inactive And _
		    fixedRotation = False Then
		    Var cDot1 As VMaths.Vector2 = VMaths.Vector2.Zero
		    Var cDot As VMaths.Vector3 = VMaths.Vector3.Zero
		    
		    // Solve point-to-point constraint.
		    mRA.ScaleOrthogonalInto(wA, temp)
		    mRB.ScaleOrthogonalInto(wB, cDot1)
		    cDot1.Add(vB)
		    cDot1.Subtract(vA)
		    cDot1.Subtract(temp)
		    Var cDot2 As Double = wB - wA
		    cDot.SetValues(cDot1.X, cDot1.Y, cDot2)
		    
		    Var impulse As VMaths.Vector3 = VMaths.Vector3.Zero
		    VMaths.Matrix3.Solve(mMass, impulse, cDot)
		    impulse.Negate
		    
		    If mLimitState = Physics.LimitState.Equal Then
		      mImpulse.Add(impulse)
		    ElseIf mLimitState = Physics.LimitState.AtLower Then
		      Var newImpulse As Double = mImpulse.Z + impulse.Z
		      If newImpulse < 0.0 Then
		        Var rhs As VMaths.Vector2 = VMaths.Vector2.Zero
		        rhs.SetValues(mMass.Entry(0, 2), mMass.Entry(1, 2))
		        rhs.Scale(mImpulse.Z)
		        rhs.Subtract(cDot1)
		        VMaths.Matrix3.Solve2(mMass, temp, rhs)
		        impulse.X = temp.X
		        impulse.Y = temp.Y
		        impulse.Z = -mImpulse.Z
		        mImpulse.X = mImpulse.X + temp.X
		        mImpulse.Y = mImpulse.Y + temp.Y
		        mImpulse.Z = 0.0
		      Else
		        mImpulse.Add(impulse)
		      End If
		    ElseIf mLimitState = Physics.LimitState.AtUpper Then
		      Var newImpulse As Double = mImpulse.Z + impulse.Z
		      If newImpulse > 0.0 Then
		        Var rhs As VMaths.Vector2 = VMaths.Vector2.Zero
		        rhs.SetValues(mMass.Entry(0, 2), mMass.Entry(1, 2))
		        rhs.Scale(mImpulse.Z)
		        rhs.Subtract(cDot1)
		        VMaths.Matrix3.Solve2(mMass, temp, rhs)
		        impulse.X = temp.X
		        impulse.Y = temp.Y
		        impulse.Z = -mImpulse.Z
		        mImpulse.X = mImpulse.X + temp.X
		        mImpulse.Y = mImpulse.Y + temp.Y
		        mImpulse.Z = 0.0
		      Else
		        mImpulse.Add(impulse)
		      End If
		    End If
		    Var p As VMaths.Vector2 = VMaths.Vector2.Zero
		    
		    p.SetValues(impulse.X, impulse.Y)
		    
		    vA.X = vA.X - (mA * p.X)
		    vA.Y = vA.Y - (mA * p.Y)
		    wA = wA - (iA * (mRA.Cross(p) + impulse.Z))
		    
		    vB.X = vB.X + (mB * p.X)
		    vB.Y = vB.Y + (mB * p.Y)
		    wB = wB + (iB * (mRB.Cross(p) + impulse.Z))
		  Else
		    // Solve point-to-point constraint.
		    Var cDot As VMaths.Vector2 = VMaths.Vector2.Zero
		    Var impulse As VMaths.Vector2 = VMaths.Vector2.Zero
		    
		    mRA.ScaleOrthogonalInto(wA, temp)
		    mRB.ScaleOrthogonalInto(wB, cDot)
		    cDot.Add(vB)
		    cDot.Subtract(vA)
		    cDot.Subtract(temp)
		    VMaths.Matrix3.Solve2(mMass, impulse, cDot.Negate)
		    
		    mImpulse.X = mImpulse.X + impulse.X
		    mImpulse.Y = mImpulse.Y + impulse.Y
		    
		    vA.X = vA.X - (mA * impulse.X)
		    vA.Y = vA.Y - (mA * impulse.Y)
		    wA = wA - (iA * mRA.Cross(impulse))
		    
		    vB.X = vB.X + (mB * impulse.X)
		    vB.Y = vB.Y + (mB * impulse.Y)
		    wB = wB + (iB * mRB.Cross(impulse))
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A revolute joint constrains two bodies to share a common point while they
		are free to rotate about the point. The relative rotation about the shared
		point is the joint angle. You can limit the relative rotation with a joint
		limit that specifies a lower and upper angle. You can use a motor to drive
		the relative rotation about the shared point. A maximum motor torque is
		provided so that infinite forces are not generated.
		
		Point-to-point constraint
		C = p2 - p1
		Cdot = v2 - v1
		     = v2 + cross(w2, r2) - v1 - cross(w1, r1)
		J = [-I -r1_skew I r2_skew ]
		Identity used:
		w k % (rx i + ry j) = w * (-ry i + rx j)
		
		Motor constraint
		Cdot = w2 - w1
		J = [0 0 -1 0 0 1]
		K = invI1 + invI2
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mEnableLimit
			  
			End Get
		#tag EndGetter
		LimitEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLowerAngle
			End Get
		#tag EndGetter
		LowerLimit As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mMaxMotorTorque
			  
			End Get
		#tag EndGetter
		MaxMotorTorque As Double
	#tag EndComputedProperty

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
		Private mLimitState As Physics.LimitState = Physics.LimitState.Inactive
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLowerAngle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 456666656374697665206D61737320666F7220706F696E742D746F2D706F696E7420636F6E73747261696E742E
		Private mMass As VMaths.Matrix3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxMotorTorque As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMotorImpulse As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 456666656374697665206D61737320666F72206D6F746F722F6C696D697420616E67756C617220636F6E73747261696E742E
		Private mMotorMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMotorSpeed As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mEnableMotor
			End Get
		#tag EndGetter
		MotorEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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
		Private mRA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReferenceAngle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpperAngle As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mReferenceAngle
			  
			End Get
		#tag EndGetter
		ReferenceAngle As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mUpperAngle
			  
			End Get
		#tag EndGetter
		UpperLimit As Double
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
			Name="MotorEnabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxMotorTorque"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MotorSpeed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LimitEnabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReferenceAngle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LowerLimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UpperLimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

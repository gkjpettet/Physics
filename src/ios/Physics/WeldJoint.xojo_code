#tag Class
Protected Class WeldJoint
Inherits Physics.Joint
	#tag Method, Flags = &h0
		Sub Constructor(def As Physics.WeldJointDef)
		  mrA = VMaths.Vector2.Zero
		  mrB = VMaths.Vector2.Zero
		  mMass = VMaths.Matrix3.Zero
		  
		  mLocalCenterA = VMaths.Vector2.Copy(def.LocalAnchorA)
		  mLocalCenterB = VMaths.Vector2.Copy(def.LocalAnchorB)
		  mImpulse = VMaths.Vector3.Zero
		  
		  Super.Constructor(def)
		  
		  mReferenceAngle = def.ReferenceAngle
		  mFrequencyHz = def.FrequencyHz
		  mDampingRatio = def.DampingRatio
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetReferenceAngle() As Double
		  Return mReferenceAngle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitVelocityConstraints(data As Physics.SolverData)
		  mIndexA = bodyA.IslandIndex
		  mIndexB = bodyB.IslandIndex
		  mLocalCenterA.SetFrom(BodyA.Sweep.LocalCenter)
		  mLocalCenterB.SetFrom(BodyB.Sweep.LocalCenter)
		  mInvMassA = BodyA.InverseMass
		  mInvMassB = BodyB.InverseMass
		  mInvIA = BodyA.InverseInertia
		  mInvIB = BodyB.InverseInertia
		  
		  Var aA As Double = data.Positions(mIndexA).A
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  Var wA As Double = data.Velocities(mIndexA).W
		  
		  Var aB As Double = data.Positions(mIndexB).A
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  Var wB As Double = data.Velocities(mIndexB).W
		  
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  // Compute the effective masses.
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Copy(LocalAnchorA).Subtract(mLocalCenterA)
		  mrA.SetFrom(Physics.Rot.MulVec2(qA, temp))
		  temp.SetFrom(LocalAnchorB)
		  temp.Subtract(mLocalCenterB)
		  mrB.SetFrom(Physics.Rot.MulVec2(qB, temp))
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  Var K As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  
		  Var exX As Double = mA + mB + mrA.Y * mrA.Y * iA + mrB.Y * mrB.Y * iB
		  Var eyX As Double = -mrA.Y * mrA.X * iA - mrB.Y * mrB.X * iB
		  Var ezX As Double = -mrA.Y * iA - mrB.Y * iB
		  Var exY As Double = K.Entry(0, 1)
		  Var eyY As Double = mA + mB + mrA.X * mrA.X * iA + mrB.X * mrB.X * iB
		  Var ezY As Double = mrA.X * iA + mrB.X * iB
		  Var exZ As Double = K.Entry(0, 2)
		  Var eyZ As Double = K.Entry(1, 2)
		  Var ezZ As Double = iA + iB
		  
		  K.SetValues(exX, exY, exZ, eyX, eyY, eyZ, ezX, ezY, ezZ)
		  
		  If mFrequencyHz > 0.0 Then
		    mMass.SetFrom(mMatrix3GetInverse22(K))
		    
		    Var invM As Double = iA + iB
		    Var m As Double = If(invM > 0.0, 1.0 / invM, 0.0)
		    
		    Var c As Double = aB - aA - mReferenceAngle
		    
		    // Frequency.
		    Var omega As Double = 2.0 * Maths.PI * mFrequencyHz
		    
		    // Damping coefficient.
		    Var d As Double = 2.0 * m * mDampingRatio * omega
		    
		    // Spring stiffness.
		    Var k_ As Double = m * omega * omega
		    
		    // magic formulas
		    Var dt As Double = data.Step_.Dt
		    mGamma = dt * (d + dt * k_)
		    mGamma = If(mGamma <> 0.0, 1.0 / mGamma, 0.0)
		    mBias = c * dt * k_ * mGamma
		    
		    invM = invM + mGamma
		    mMass.SetEntry(2, 2, If(invM <> 0.0, 1.0 / invM, 0.0))
		  Else
		    mMass.SetFrom(mMatrix3GetSymInverse33(K, mMass))
		    mGamma = 0.0
		    mBias = 0.0
		  End If
		  
		  If data.Step_.WarmStarting Then
		    // Scale impulses to support a Variable time step.
		    mImpulse.Scale(data.Step_.DtRatio)
		    
		    Var P As New VMaths.Vector2(mImpulse.X, mImpulse.Y)
		    
		    vA.X = vA.X - (mA * P.X)
		    vA.Y = vA.Y - (mA * P.Y)
		    wA = wA - (iA * (mrA.Cross(P) + mImpulse.Z))
		    
		    vB.X = vB.X + (mB * P.X)
		    vB.Y = vB.Y + (mB * P.Y)
		    wB = wB + (iB * (mrB.Cross(P) + mImpulse.Z))
		  Else
		    mImpulse.SetZero
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mMatrix3GetInverse22(m As VMaths.Matrix3) As VMaths.Matrix3
		  Var a As Double = m.Entry(1, 0)
		  Var b As Double = m.Entry(0, 1)
		  Var c As Double = m.Entry(1, 0)
		  Var d As Double = m.Entry(1, 1)
		  Var det As Double = a * d - b * c
		  
		  If det <> 0.0 Then
		    det = 1.0 / det
		  End If
		  
		  Var exX As Double = det * d
		  Var eyX As Double = -det * b
		  Const ezX = 0.0
		  Var exY As Double = -det * c
		  Var eyY As Double = det * a
		  Const ezY = 0.0
		  Const exZ = 0.0
		  Const eyZ = 0.0
		  Const ezZ = 0.0
		  
		  Return New VMaths.Matrix3(exX, exY, exZ, eyX, eyY, eyZ, ezX, ezY, ezZ)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865207A65726F206D61747269782069662073696E67756C61722E
		Private Function mMatrix3GetSymInverse33(m As VMaths.Matrix3, m2 As VMaths.Matrix3) As VMaths.Matrix3
		  /// Returns the zero matrix if singular.
		  
		  Var bx As Double = m.Entry(1, 1) * m.Entry(2, 2) - m.Entry(2, 1) * m.Entry(1, 2)
		  Var by As Double = m.Entry(2, 1) * m.Entry(0, 2) - m.Entry(0, 1) * m.Entry(2, 2)
		  Var bz As Double = m.Entry(0, 1) * m.Entry(1, 2) - m.Entry(1, 1) * m.Entry(0, 2)
		  Var det As Double = m.Entry(0, 0) * bx + m.Entry(1, 0) * by + m.Entry(2, 0) * bz
		  
		  If det <> 0.0 Then
		    det = 1.0 / det
		  End If
		  
		  Var a11 As Double = m.Entry(0, 0)
		  Var a12 As Double = m.Entry(0, 1)
		  Var a13 As Double = m.Entry(0, 2)
		  Var a22 As Double = m.Entry(1, 1)
		  Var a23 As Double = m.Entry(1, 2)
		  Var a33 As Double = m.Entry(2, 2)
		  
		  Var exX As Double = det * (a22 * a33 - a23 * a23)
		  Var exY As Double = det * (a13 * a23 - a12 * a33)
		  Var exZ As Double = det * (a12 * a23 - a13 * a22)
		  
		  Var eyX As Double = m2.Entry(1, 0)
		  Var eyY As Double = det * (a11 * a33 - a13 * a13)
		  Var eyZ As Double = det * (a13 * a12 - a11 * a23)
		  
		  Var ezX As Double = m2.Entry(2, 0)
		  Var ezY As Double = m2.Entry(2, 1)
		  Var ezZ As Double = det * (a11 * a22 - a12 * a12)
		  
		  Return New VMaths.Matrix3(exX, exY, exZ, eyX, eyY, eyZ, ezX, ezY, ezZ)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionForce(invDt As Double) As VMaths.Vector2
		  Var v As New VMaths.Vector2(mImpulse.X, mImpulse.Y) 
		  Return v.Scale(invDt)
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
		Function SolvePositionConstraints(data As Physics.SolverData) As Boolean
		  Var cA As VMaths.Vector2 = data.Positions(mIndexA).C
		  Var aA As Double = data.Positions(mIndexA).A
		  Var cB As VMaths.Vector2 = data.Positions(mIndexB).C
		  Var aB As Double = data.Positions(mIndexB).A
		  Var qA As New Physics.Rot
		  Var qB As New Physics.Rot
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Copy(localAnchorA)
		  temp.Subtract(mLocalCenterA)
		  Var rA As VMaths.Vector2 = VMaths.Vector2.Copy(Physics.Rot.MulVec2(qA, temp))
		  temp.SetFrom(localAnchorB)
		  temp.Subtract(mLocalCenterB)
		  Var rB As VMaths.Vector2 = VMaths.Vector2.Copy(Physics.Rot.MulVec2(qB, temp))
		  Var positionError, angularError As Double
		  
		  Var k As VMaths.Matrix3 = VMaths.Matrix3.Zero
		  Var c1 As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var p As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  Var exX As Double = mA + mB + rA.Y * rA.Y * iA + rB.Y * rB.Y * iB
		  Var eyX As Double = -rA.Y * rA.X * iA - rB.Y * rB.X * iB
		  Var ezX As Double = -rA.Y * iA - rB.Y * iB
		  Var exY As Double = k.Entry(0, 1)
		  Var eyY As Double = mA + mB + rA.X * rA.X * iA + rB.X * rB.X * iB
		  Var ezY As Double = rA.X * iA + rB.X * iB
		  Var exZ As Double = k.Entry(0, 2)
		  Var eyZ As Double = k.Entry(1, 2)
		  Var ezZ As Double = iA + iB
		  
		  k.SetValues(exX, exY, exZ, eyX, eyY, eyZ, ezX, ezY, ezZ)
		  
		  If mFrequencyHz > 0.0 Then
		    c1.SetFrom(cB)
		    c1.Add(rB)
		    c1.Subtract(cA)
		    c1.Subtract(rA)
		    
		    positionError = c1.Length
		    angularError = 0.0
		    
		    VMaths.Matrix3.Solve2(k, p, c1)
		    p.Negate
		    
		    cA.X = cA.X - (mA * p.X)
		    cA.Y = cA.Y - (mA * p.Y)
		    aA = aA - (iA * rA.Cross(p))
		    
		    cB.X = cB.X + (mB * p.X)
		    cB.Y = cB.Y + (mB * p.Y)
		    aB = aB + (iB * rB.Cross(p))
		  Else
		    c1.SetFrom(cB)
		    c1.Add(rB)
		    c1.Subtract(cA)
		    c1.Subtract(rA)
		    Var c2 As Double = aB - aA - mReferenceAngle
		    
		    positionError = c1.Length
		    angularError = Abs(c2)
		    
		    Var C As New VMaths.Vector3(c1.X, c1.Y, c2)
		    Var impulse As VMaths.Vector3 = VMaths.Vector3.Zero
		    
		    VMaths.Matrix3.Solve(k, impulse, C)
		    impulse.Negate
		    p.SetValues(impulse.X, impulse.Y)
		    
		    cA.X = cA.X - (mA * p.X)
		    cA.Y = cA.Y - (mA * p.Y)
		    aA = aA - (iA * (rA.Cross(p) + impulse.Z))
		    
		    cB.X = cB.X + (mB * p.X)
		    cB.Y = cB.Y + (mB * p.Y)
		    aB = aB + (iB * (rB.Cross(p) + impulse.Z))
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
		  Var wA As Double = data.Velocities(mIndexA).W
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  Var wB As Double = data.Velocities(mIndexB).W
		  
		  Var mA As Double = mInvMassA
		  Var mB As Double = mInvMassB
		  Var iA As Double = mInvIA
		  Var iB As Double = mInvIB
		  
		  Var cDot1 As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var p As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  If mFrequencyHz > 0.0 Then
		    Var cDot2 As Double = wB - wA
		    
		    Var impulse2 As Double = _
		    -mMass.Entry(2, 2) * (cDot2 + mBias + mGamma * mImpulse.Z)
		    mImpulse.Z = mImpulse.Z + impulse2
		    
		    wA = wA - (iA * impulse2)
		    wB = wB + (iB * impulse2)
		    
		    mrB.ScaleOrthogonalInto(wB, cDot1)
		    mrA.ScaleOrthogonalInto(wA, temp)
		    cDot1.Add(vB)
		    cDot1.Subtract(vA)
		    cDot1.Subtract(temp)
		    
		    Var impulse1 As New VMaths.Vector2( _
		    mMass.Entry(1, 0) * cDot1.X + mMass.Entry(1, 1) * cDot1.Y, _
		    mMass.Entry(0, 0) * cDot1.X + mMass.Entry(0, 1) * cDot1.Y)
		    impulse1.Negate
		    
		    mImpulse.X = mImpulse.X + impulse1.X
		    mImpulse.Y = mImpulse.Y + impulse1.Y
		    
		    vA.X = vA.X - (mA * p.X)
		    vA.Y = vA.Y - (mA * p.Y)
		    wA = wA - (iA * mrA.Cross(p))
		    
		    vB.X = vB.X + (mB * p.X)
		    vB.Y = vB.Y + (mB * p.Y)
		    wB = wB + (iB * mrB.Cross(p))
		  Else
		    mrA.ScaleOrthogonalInto(wA, temp)
		    mrB.ScaleOrthogonalInto(wB, cDot1)
		    cDot1.Add(vB)
		    cDot1.Subtract(vA)
		    cDot1.Subtract(temp)
		    Var cDot2 As Double = wB - wA
		    
		    Var impulse As New VMaths.Vector3(cDot1.X, cDot1.Y, cDot2)
		    impulse.ApplyMatrix3(mMass)
		    impulse.Negate
		    mImpulse.Add(impulse)
		    
		    p.SetValues(impulse.X, impulse.Y)
		    
		    vA.X = vA.X - (mA * p.X)
		    vA.Y = vA.Y - (mA * p.Y)
		    wA = wA - (iA * (mrA.Cross(p) + impulse.Z))
		    
		    vB.X = vB.X + (mB * p.X)
		    vB.Y = vB.Y + (mB * p.Y)
		    wB = wB + (iB * (mrB.Cross(p) + impulse.Z))
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A weld joint essentially glues two bodies together. A weld joint may distort
		somewhat because the island constraint solver is approximate.
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mBias As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDampingRatio As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrequencyHz As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGamma As Double = 0.0
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
		Private mLocalCenterA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMass As VMaths.Matrix3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mrA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mrB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReferenceAngle As Double = 0.0
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

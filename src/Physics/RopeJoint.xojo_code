#tag Class
Protected Class RopeJoint
Inherits Physics.Joint
	#tag Method, Flags = &h0
		Sub Constructor(def As Physics.RopeJointDef)
		  Super.Constructor(def)
		  
		  LocalAnchorA = VMaths.Vector2.Zero
		  LocalAnchorB = VMaths.Vector2.Zero
		  
		  mU = VMaths.Vector2.Zero
		  mRA = VMaths.Vector2.Zero
		  mRB = VMaths.Vector2.Zero
		  mLocalCenterA = VMaths.Vector2.Zero
		  mLocalCenterB = VMaths.Vector2.Zero
		  
		  LocalAnchorA.SetFrom(def.LocalAnchorA)
		  LocalAnchorB.SetFrom(def.LocalAnchorB)
		  
		  mMaxLength = def.MaxLength
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLimitState() As Physics.LimitState
		  Return mState
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaxLength() As Double
		  Return mMaxLength
		  
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
		  
		  Var cA As VMaths.Vector2 = data.Positions(mIndexA).C
		  Var aA As Double = data.Positions(mIndexA).A
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  var wA As Double = data.Velocities(mIndexA).W
		  
		  Var cB As VMaths.Vector2 = data.Positions(mIndexB).C
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
		  
		  mU.SetFrom(cB)
		  mU.Add(mRB)
		  mU.Subtract(cA)
		  mU.Subtract(mRA)
		  
		  mLength = mU.Length
		  
		  Var c As Double = mLength - mMaxLength
		  If c > 0.0 Then
		    mState = Physics.LimitState.AtUpper
		  Else
		    mState = Physics.LimitState.Inactive
		  End If
		  
		  If mLength > Physics.Settings.LinearSlop Then
		    mU.Scale(1.0 / mLength)
		  Else
		    mU.SetZero
		    mMass = 0.0
		    mImpulse = 0.0
		    Return
		  End If
		  
		  // Compute effective mass.
		  Var crA As Double = mRA.Cross(mU)
		  Var crB As Double = mRB.Cross(mU)
		  Var invMass As Double = mInvMassA + mInvIA * crA * crA + mInvMassB + mInvIB * crB * crB
		  
		  mMass = If(invMass <> 0.0, 1.0 / invMass, 0.0)
		  
		  If data.Step_.WarmStarting Then
		    // Scale the impulse to support a variable time step.
		    mImpulse = mImpulse * data.Step_.DtRatio
		    
		    Var pX As Double = mImpulse * mU.X
		    Var pY As Double = mImpulse * mU.Y
		    vA.X = vA.X - (mInvMassA * pX)
		    vA.Y = vA.Y - (mInvMassA * pY)
		    wA = wA - (mInvIA * (mRA.X * pY - mRA.Y * pX))
		    
		    vB.X = vB.X + (mInvMassB * pX)
		    vB.Y = vB.Y + (mInvMassB * pY)
		    wB = wB + (mInvIB * (mRB.X * pY - mRB.Y * pX))
		  Else
		    mImpulse = 0.0
		  End If
		  
		  data.Velocities(mIndexA).W = wA
		  data.Velocities(mIndexB).W = wB
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionForce(invDt As Double) As VMaths.Vector2
		  Return VMaths.Vector2.Copy(mU).Scale(invDt).Scale(mImpulse)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReactionTorque(invDt As Double) As Double
		  #Pragma Unused invDt
		  
		  Return 0.0
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
		Sub SetMaxLength(maxLength As Double)
		  mMaxLength = maxLength
		  
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
		  Var u As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var rB As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  qA.SetAngle(aA)
		  qB.SetAngle(aB)
		  
		  // Compute the effective masses.
		  temp.SetFrom(LocalAnchorA)
		  temp.Subtract(mLocalCenterA)
		  rA.SetFrom(Physics.Rot.MulVec2(qA, temp))
		  temp.SetFrom(LocalAnchorB)
		  temp.Subtract(mLocalCenterB)
		  rB.SetFrom(Physics.Rot.MulVec2(qB, temp))
		  
		  u.SetFrom(cB)
		  u.Add(rB)
		  u.Subtract(cA)
		  u.Subtract(rA)
		  
		  Var length As Double = u.Normalize
		  Var c As Double = length - mMaxLength
		  
		  c = Maths.Clamp(c, 0.0, Physics.Settings.MaxLinearCorrection)
		  
		  Var impulse As Double = -mMass * c
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
		  
		  Return length - mMaxLength < Physics.Settings.LinearSlop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveVelocityConstraints(data As Physics.SolverData)
		  Var vA As VMaths.Vector2 = data.Velocities(mIndexA).V
		  var wA As Double = data.Velocities(mIndexA).W
		  Var vB As VMaths.Vector2 = data.Velocities(mIndexB).V
		  var wB As Double = data.Velocities(mIndexB).W
		  
		  Var vpA As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var vpB As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  
		  mRA.ScaleOrthogonalInto(wA, vpA)
		  vpA.Add(vA)
		  mRB.ScaleOrthogonalInto(wB, vpB)
		  vpB.Add(vB)
		  
		  Var c As Double = mLength - mMaxLength
		  temp.SetFrom(vpB)
		  temp.Subtract(vpA)
		  Var cDot As Double = mU.Dot(temp)
		  
		  // Predictive constraint.
		  If c < 0.0 Then
		    cDot = cDot + (data.Step_.InvDt * c)
		  End If
		  
		  Var impulse As Double = -mMass * cDot
		  Var oldImpulse As Double = mImpulse
		  mImpulse = Min(0.0, mImpulse + impulse)
		  impulse = mImpulse - oldImpulse
		  
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
		A rope joint enforces a maximum distance between two points on two bodies.
		It has no other effect.
		
		Warning: if you attempt to change the maximum length during the simulation
		you will get some non-physical behavior. A model that would allow you to
		dynamically modify the length would have some sponginess, so I chose not to
		implement it that way. See DistanceJoint if you want to dynamically control
		length.
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mImpulse As Double = 0.0
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
		Private mLength As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMass As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxLength As Double = 0.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mState As Physics.LimitState = Physics.LimitState.Inactive
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
			Name="mMaxLength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

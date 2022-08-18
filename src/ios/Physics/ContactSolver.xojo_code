#tag Class
Protected Class ContactSolver
	#tag Method, Flags = &h0
		Sub Constructor()
		  mXfA = Physics.Transform.Zero
		  mXfB = Physics.Transform.Zero
		  mWorldManifold = New Physics.WorldManifold
		  mPSolver = New Physics.PositionSolverManifold
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CrossDoubleVector2(s As Double, a As VMaths.Vector2) As VMaths.Vector2
		  Return New VMaths.Vector2(-s * a.Y, s * a.X)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init(def As Physics.ContactSolverDef)
		  mStep = def.Step_
		  mPositions = def.Positions
		  mVelocities = def.Velocities
		  mContacts = def.Contacts
		  
		  For Each contact As Physics.Contact In mContacts
		    Var fixtureA As Physics.Fixture = contact.FixtureA
		    Var fixtureB As Physics.Fixture = contact.FixtureB
		    Var shapeA As Physics.Shape = fixtureA.Shape
		    Var shapeB As Physics.Shape = fixtureB.Shape
		    Var radiusA As Double = shapeA.Radius
		    Var radiusB As Double = shapeB.Radius
		    Var bodyA As Physics.Body = fixtureA.Body
		    Var bodyB As Physics.Body = fixtureB.Body
		    Var manifold As Physics.Manifold = contact.Manifold
		    
		    Var pointCount As Integer = manifold.PointCount
		    
		    #If DebugBuild
		      Assert(pointCount > 0)
		    #EndIf
		    
		    Var velocityConstraint As Physics.ContactVelocityConstraint = contact.VelocityConstraint
		    velocityConstraint.Friction = contact.Friction
		    velocityConstraint.Restitution = contact.Restitution
		    velocityConstraint.TangentSpeed = contact.TangentSpeed
		    velocityConstraint.IndexA = bodyA.IslandIndex
		    velocityConstraint.IndexB = bodyB.IslandIndex
		    velocityConstraint.InvMassA = bodyA.InverseMass
		    velocityConstraint.InvMassB = bodyB.InverseMass
		    velocityConstraint.InvIA = bodyA.InverseInertia
		    velocityConstraint.InvIB = bodyB.InverseInertia
		    velocityConstraint.ContactIndex = mContacts.IndexOf(contact)
		    velocityConstraint.PointCount = pointCount
		    velocityConstraint.K.SetZero
		    velocityConstraint.NormalMass.SetZero
		    
		    Var positionConstraint As Physics.ContactPositionConstraint = contact.PositionConstraint
		    positionConstraint.indexA = bodyA.IslandIndex
		    positionConstraint.indexB = bodyB.IslandIndex
		    positionConstraint.InvMassA = bodyA.InverseMass
		    positionConstraint.InvMassB = bodyB.InverseMass
		    positionConstraint.LocalCenterA.setFrom(bodyA.Sweep.LocalCenter)
		    positionConstraint.LocalCenterB.setFrom(bodyB.Sweep.LocalCenter)
		    positionConstraint.InvIA = bodyA.InverseInertia
		    positionConstraint.InvIB = bodyB.InverseInertia
		    positionConstraint.LocalNormal.SetFrom(manifold.LocalNormal)
		    positionConstraint.LocalPoint.SetFrom(manifold.LocalPoint)
		    positionConstraint.PointCount = pointCount
		    positionConstraint.RadiusA = radiusA
		    positionConstraint.RadiusB = radiusB
		    positionConstraint.Type = manifold.Type
		    
		    Var jLimit As Integer = pointCount - 1
		    For j As Integer = 0 To jLimit
		      Var cp As Physics.ManifoldPoint = manifold.Points(j)
		      Var vcp As Physics.VelocityConstraintPoint = velocityConstraint.Points(j)
		      
		      If mStep.WarmStarting Then
		        vcp.NormalImpulse = mStep.DtRatio * cp.NormalImpulse
		        vcp.TangentImpulse = mStep.DtRatio * cp.TangentImpulse
		      Else
		        vcp.NormalImpulse = 0.0
		        vcp.TangentImpulse = 0.0
		      End If
		      
		      vcp.RA.SetZero
		      vcp.RB.SetZero
		      vcp.NormalMass = 0.0
		      vcp.TangentMass = 0.0
		      vcp.VelocityBias = 0.0
		      positionConstraint.LocalPoints(j).X = cp.LocalPoint.X
		      positionConstraint.LocalPoints(j).Y = cp.LocalPoint.Y
		    Next j
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitializeVelocityConstraints()
		  For Each contact As Physics.Contact In mContacts
		    Var velocityConstraint As Physics.ContactVelocityConstraint = _
		    contact.VelocityConstraint
		    Var positionConstraint As Physics.ContactPositionConstraint = _
		    contact.PositionConstraint
		    
		    Var radiusA As Double = positionConstraint.RadiusA
		    Var radiusB As Double = positionConstraint.RadiusB
		    Var manifold As Physics.Manifold = mContacts(velocityConstraint.ContactIndex).Manifold
		    
		    Var indexA As Integer = velocityConstraint.IndexA
		    Var indexB As Integer = velocityConstraint.IndexB
		    
		    Var mA As Double = velocityConstraint.InvMassA
		    Var mB As Double = velocityConstraint.InvMassB
		    Var iA As Double = velocityConstraint.InvIA
		    Var iB As Double = velocityConstraint.InvIB
		    Var localCenterA As VMaths.Vector2 = positionConstraint.LocalCenterA
		    Var localCenterB As VMaths.Vector2 = positionConstraint.LocalCenterB
		    
		    Var cA As VMaths.Vector2 = mPositions(indexA).C
		    Var aA As Double = mPositions(indexA).A
		    Var vA As VMaths.Vector2 = mVelocities(indexA).V
		    Var wA As Double = mVelocities(indexA).W
		    
		    Var cB As VMaths.Vector2 = mPositions(indexB).C
		    Var aB As Double = mPositions(indexB).A
		    Var vB As VMaths.Vector2 = mVelocities(indexB).V
		    Var wB As Double = mVelocities(indexB).W
		    
		    #If DebugBuild
		      Assert(manifold.PointCount > 0)
		    #EndIf
		    
		    Var xfAq As Physics.Rot = mXfA.Q
		    Var xfBq As Physics.Rot = mXfB.Q
		    xfAq.SetAngle(aA)
		    xfBq.SetAngle(aB)
		    mXfA.P.X = cA.X - (xfAq.Cos * localCenterA.X - xfAq.Sin * localCenterA.Y)
		    mXfA.P.Y = cA.Y - (xfAq.Sin * localCenterA.X + xfAq.Cos * localCenterA.Y)
		    mXfB.P.X = cB.X - (xfBq.Cos * localCenterB.X - xfBq.Sin * localCenterB.Y)
		    mXfB.P.Y = cB.Y - (xfBq.Sin * localCenterB.X + xfBq.Cos * localCenterB.Y)
		    
		    mWorldManifold.Initialize(manifold, mXfA, radiusA, mXfB, radiusB)
		    
		    Var vcNormal As VMaths.Vector2 = velocityConstraint.Normal
		    vcNormal.X = mWorldManifold.Normal.X
		    vcNormal.Y = mWorldManifold.Normal.Y
		    
		    Var pointCount As Integer = velocityConstraint.PointCount
		    Var jLimit As Integer = pointCount - 1
		    For j As Integer = 0 To jLimit
		      Var vcp As Physics.VelocityConstraintPoint = velocityConstraint.Points(j)
		      Var wmPj As VMaths.Vector2 = mWorldManifold.Points(j)
		      Var vcprA As VMaths.Vector2 = vcp.RA
		      Var vcprB As VMaths.Vector2 = vcp.RB
		      vcprA.X = wmPj.X - cA.X
		      vcprA.Y = wmPj.Y - cA.Y
		      vcprB.X = wmPj.X - cB.X
		      vcprB.Y = wmPj.Y - cB.Y
		      
		      Var rnA As Double = vcprA.X * vcNormal.Y - vcprA.Y * vcNormal.X
		      Var rnB As Double = vcprB.X * vcNormal.Y - vcprB.Y * vcNormal.X
		      
		      Var kNormal As Double = mA + mB + iA * rnA * rnA + iB * rnB * rnB
		      
		      vcp.NormalMass = If(kNormal > 0.0, 1.0 / kNormal, 0.0)
		      
		      Var tangentX As Double = 1.0 * vcNormal.Y
		      Var tangentY As Double = -1.0 * vcNormal.X
		      
		      Var rtA As Double = vcprA.X * tangentY - vcprA.Y * tangentX
		      Var rtB As Double = vcprB.X * tangentY - vcprB.Y * tangentX
		      
		      Var kTangent As Double = mA + mB + iA * rtA * rtA + iB * rtB * rtB
		      
		      vcp.TangentMass = If(kTangent > 0.0, 1.0 / kTangent, 0.0)
		      
		      // Setup a velocity bias for restitution.
		      vcp.VelocityBias = 0.0
		      Var tempX As Double = vB.X + -wB * vcprB.Y - vA.X - (-wA * vcprA.Y)
		      Var tempY As Double = vB.Y + wB * vcprB.X - vA.Y - (wA * vcprA.X)
		      Var vRel As Double = vcNormal.X * tempX + vcNormal.Y * tempY
		      If vRel < -Physics.Settings.VelocityThreshold Then
		        vcp.VelocityBias = -velocityConstraint.Restitution * vRel
		      End If
		    Next j
		    
		    // If we have two points, then prepare the block solver.
		    If velocityConstraint.PointCount = 2 Then
		      Var vcp1 As Physics.VelocityConstraintPoint = velocityConstraint.Points(0)
		      Var vcp2 As Physics.VelocityConstraintPoint = velocityConstraint.Points(1)
		      Var rn1A As Double = vcp1.rA.X * vcNormal.Y - vcp1.rA.Y * vcNormal.X
		      Var rn1B As Double = vcp1.rB.X * vcNormal.Y - vcp1.rB.Y * vcNormal.X
		      Var rn2A As Double = vcp2.rA.X * vcNormal.Y - vcp2.rA.Y * vcNormal.X
		      Var rn2B As Double = vcp2.rB.X * vcNormal.Y - vcp2.rB.Y * vcNormal.X
		      
		      Var k11 As Double = mA + mB + iA * rn1A * rn1A + iB * rn1B * rn1B
		      Var k22 As Double = mA + mB + iA * rn2A * rn2A + iB * rn2B * rn2B
		      Var k12 As Double = mA + mB + iA * rn1A * rn2A + iB * rn1B * rn2B
		      If k11 * k11 < maxConditionNumber * (k11 * k22 - k12 * k12) Then
		        // K is safe to invert.
		        velocityConstraint.K.SetValues(k11, k12, k12, k22)
		        velocityConstraint.NormalMass.SetFrom(velocityConstraint.K)
		        Call velocityConstraint.NormalMass.Invert
		      Else
		        // The constraints are redundant, just use one.
		        velocityConstraint.PointCount = 1
		      End If
		    End If
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657175656E7469616C20736F6C7665722E
		Function SolvePositionConstraints() As Boolean
		  /// Sequential solver.
		  
		  var minSeparation As Double = 0.0
		  
		  For Each contact As Physics.Contact In mContacts
		    Var pc As Physics.ContactPositionConstraint = contact.PositionConstraint
		    
		    Var indexA As Integer = pc.IndexA
		    Var indexB As Integer = pc.IndexB
		    
		    Var mA As Double = pc.InvMassA
		    Var iA As Double = pc.InvIA
		    Var localCenterA As VMaths.Vector2 = pc.LocalCenterA
		    Var localCenterAx As Double = localCenterA.X
		    Var localCenterAy As Double = localCenterA.Y
		    Var mB As Double = pc.InvMassB
		    Var iB As Double = pc.InvIB
		    Var localCenterB As VMaths.Vector2 = pc.LocalCenterB
		    Var localCenterBx As Double = localCenterB.X
		    Var localCenterBy As Double = localCenterB.Y
		    Var pointCount As Integer = pc.PointCount
		    
		    Var cA As VMaths.Vector2 = mPositions(indexA).C
		    var aA As Double = mPositions(indexA).A
		    Var cB As VMaths.Vector2 = mPositions(indexB).C
		    var aB As Double = mPositions(indexB).A
		    
		    // Solve normal constraints.
		    Var jLimit As Integer = pointCount - 1
		    For j As Integer = 0 To jLimit
		      Var xfAq As Physics.Rot = mxfA.Q
		      Var xfBq As Physics.Rot = mxfB.Q
		      xfAq.SetAngle(aA)
		      xfBq.SetAngle(aB)
		      mxfA.P.X = cA.X - xfAq.Cos * localCenterAx + xfAq.Sin * localCenterAy
		      mxfA.P.Y = cA.Y - xfAq.Sin * localCenterAx - xfAq.Cos * localCenterAy
		      mxfB.P.X = cB.X - xfBq.Cos * localCenterBx + xfBq.Sin * localCenterBy
		      mxfB.P.Y = cB.Y - xfBq.Sin * localCenterBx - xfBq.Cos * localCenterBy
		      
		      Var psm As Physics.PositionSolverManifold = mPSolver
		      psm.Initialize(pc, mxfA, mxfB, j)
		      Var normal As VMaths.Vector2 = psm.Normal
		      Var point As VMaths.Vector2 = psm.Point
		      Var separation As Double = psm.Separation
		      
		      Var rAx As Double = point.X - cA.X
		      Var rAy As Double = point.Y - cA.Y
		      Var rBx As Double = point.X - cB.X
		      Var rBy As Double = point.Y - cB.Y
		      
		      // Track max constraint error.
		      minSeparation = Min(minSeparation, separation)
		      
		      // Prevent large corrections and allow slop.
		      Var C As Double = _
		      Maths.Clamp(Physics.Settings.Baumgarte * (separation + Physics.Settings.LinearSlop), _
		      -Physics.Settings.MaxLinearCorrection, 0.0)
		      
		      // Compute the effective mass.
		      Var rnA As Double = rAx * normal.Y - rAy * normal.X
		      Var rnB As Double = rBx * normal.Y - rBy * normal.X
		      Var K As Double = mA + mB + iA * rnA * rnA + iB * rnB * rnB
		      
		      // Compute normal impulse.
		      Var impulse As Double = If(K > 0.0, -C / K, 0.0)
		      
		      Var pX As Double = normal.X * impulse
		      Var pY As Double = normal.Y * impulse
		      
		      cA.X = cA.X - (pX * mA)
		      cA.Y = cA.Y - (pY * mA)
		      aA = aA - (iA * (rAx * pY - rAy * pX))
		      
		      cB.X = cB.X + (pX * mB)
		      cB.Y = cB.Y + (pY * mB)
		      aB = aB + (iB * (rBx * pY - rBy * pX))
		    Next j
		    
		    mPositions(indexA).A = aA
		    mPositions(indexB).A = aB
		  Next contact
		  
		  // We can't expect minSeparation >= -linearSlop because we don't
		  // push the separation above -linearSlop.
		  Return minSeparation >= -3.0 * Physics.Settings.LinearSlop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657175656E7469616C20706F736974696F6E20736F6C76657220666F7220706F736974696F6E20636F6E73747261696E74732E
		Function SolveTOIPositionConstraints(toiIndexA As Integer, toiIndexB As Integer) As Boolean
		  /// Sequential position solver for position constraints.
		  
		  Var minSeparation As Double = 0.0
		  
		  For Each contact As Physics.Contact In mContacts
		    Var pc As Physics.ContactPositionConstraint = contact.PositionConstraint
		    
		    Var indexA As Integer = pc.IndexA
		    Var indexB As Integer = pc.IndexB
		    Var localCenterA As VMaths.Vector2 = pc.LocalCenterA
		    Var localCenterB As VMaths.Vector2 = pc.LocalCenterB
		    Var localCenterAx As Double = localCenterA.X
		    Var localCenterAy As Double = localCenterA.Y
		    Var localCenterBx As Double = localCenterB.X
		    Var localCenterBy As Double = localCenterB.Y
		    Var pointCount As Integer = pc.PointCount
		    
		    Var mA As Double = 0.0
		    Var iA As Double = 0.0
		    If indexA = toiIndexA Or indexA = toiIndexB Then
		      mA = pc.InvMassA
		      iA = pc.InvIA
		    End If
		    
		    Var mB As Double = 0.0
		    Var iB As Double = 0.0
		    If indexB = toiIndexA Or indexB = toiIndexB Then
		      mB = pc.InvMassB
		      iB = pc.InvIB
		    End If
		    
		    Var cA As VMaths.Vector2 = mPositions(indexA).C
		    Var aA As Double = mPositions(indexA).A
		    
		    Var cB As VMaths.Vector2 = mPositions(indexB).C
		    Var aB As Double = mPositions(indexB).A
		    
		    // Solve normal constraints.
		    Var jLimit As Integer = pointCount - 1
		    For j As Integer = 0 To jLimit
		      Var xfAq As Physics.Rot = mxfA.Q
		      Var xfBq As Physics.Rot = mxfB.Q
		      xfAq.SetAngle(aA)
		      xfBq.SetAngle(aB)
		      mxfA.P.X = cA.X - xfAq.Cos * localCenterAx + xfAq.Sin * localCenterAy
		      mxfA.P.Y = cA.Y - xfAq.Sin * localCenterAx - xfAq.Cos * localCenterAy
		      mxfB.P.X = cB.X - xfBq.Cos * localCenterBx + xfBq.Sin * localCenterBy
		      mxfB.P.Y = cB.Y - xfBq.Sin * localCenterBx - xfBq.Cos * localCenterBy
		      
		      Var psm As Physics.PositionSolverManifold = mPSolver
		      psm.Initialize(pc, mxfA, mxfB, j)
		      Var normal As VMaths.Vector2 = psm.Normal
		      
		      Var point As VMaths.Vector2 = psm.Point
		      Var separation As Double = psm.Separation
		      
		      Var rAx As Double = point.X - cA.X
		      Var rAy As Double = point.Y - cA.Y
		      Var rBx As Double = point.X - cB.X
		      Var rBy As Double = point.Y - cB.Y
		      
		      // Track max constraint error.
		      minSeparation = min(minSeparation, separation)
		      
		      // Prevent large corrections and allow slop.
		      Var C As Double = _
		      Maths.Clamp(Physics.Settings.Baumgarte * (separation + Physics.Settings.LinearSlop), _
		      -Physics.Settings.MaxLinearCorrection, 0.0)
		      
		      // Compute the effective mass.
		      Var rnA As Double = rAx * normal.Y - rAy * normal.X
		      Var rnB As Double = rBx * normal.Y - rBy * normal.X
		      Var k As Double = mA + mB + iA * rnA * rnA + iB * rnB * rnB
		      
		      // Compute normal impulse.
		      Var impulse As Double = If(k > 0.0, -C / k, 0.0)
		      
		      Var pX As Double = normal.X * impulse
		      Var pY As Double = normal.Y * impulse
		      
		      cA.X = cA.X - (pX * mA)
		      cA.Y = cA.Y - (pY * mA)
		      aA = aA - (iA * (rAx * pY - rAy * pX))
		      
		      cB.X = cB.X + (pX * mB)
		      cB.Y = cB.Y + (pY * mB)
		      aB = aB + (iB * (rBx * pY - rBy * pX))
		    Next j
		    
		    mPositions(indexA).A = aA
		    mPositions(indexB).A = aB
		  Next contact
		  
		  // We can't expect minSeparation >= -_linearSlop because we don't
		  // push the separation above -_linearSlop.
		  Return minSeparation >= -1.5 * Physics.Settings.LinearSlop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveVelocityConstraints()
		  For Each contact As Physics.Contact In mContacts
		    Var vc as Physics.ContactVelocityConstraint = contact.VelocityConstraint
		    
		    Var indexA As Integer = vc.IndexA
		    Var indexB As Integer = vc.IndexB
		    
		    Var mA As Double = vc.InvMassA
		    Var mB As Double = vc.InvMassB
		    Var iA As Double = vc.InvIA
		    Var iB As Double = vc.InvIB
		    Var pointCount As Integer = vc.PointCount
		    
		    Var vA As VMaths.Vector2 = mVelocities(indexA).V
		    Var wA As Double = mVelocities(indexA).W
		    Var vB As VMaths.Vector2 = mVelocities(indexB).V
		    Var wB As Double = mVelocities(indexB).W
		    
		    Var normal As VMaths.Vector2 = vc.Normal
		    Var normalX As Double = normal.X
		    Var normalY As Double = normal.Y
		    Var tangentX As Double = 1.0 * vc.Normal.Y
		    Var tangentY As Double = -1.0 * vc.Normal.X
		    Var friction As Double = vc.Friction
		    
		    #If DebugBuild
		      Assert(pointCount = 1 Or pointCount = 2)
		    #EndIf
		    
		    // Solve tangent constraints.
		    Var jLimit As Integer = pointCount - 1
		    For j As Integer = 0 To jLimit
		      Var vcp As Physics.VelocityConstraintPoint = vc.Points(j)
		      Var a As VMaths.Vector2 = vcp.RA
		      Var dvx As Double = -wB * vcp.RB.Y + vB.X - vA.X + wA * a.Y
		      Var dvy As Double = wB * vcp.RB.X + vB.Y - vA.Y - wA * a.X
		      
		      // Compute tangent force.
		      Var vt As Double = dvx * tangentX + dvy * tangentY - vc.TangentSpeed
		      Var lambda As Double = vcp.TangentMass * (-vt)
		      
		      // Clamp the accumulated force.
		      Var maxFriction As Double = Abs(friction * vcp.NormalImpulse)
		      Var newImpulse As Double = _
		      Maths.Clamp(vcp.TangentImpulse + lambda, -maxFriction, maxFriction)
		      
		      lambda = newImpulse - vcp.TangentImpulse
		      vcp.TangentImpulse = newImpulse
		      
		      // Apply contact impulse.
		      Var pX As Double = tangentX * lambda
		      Var pY As Double = tangentY * lambda
		      
		      vA.X = vA.X - (pX * mA)
		      vA.Y = vA.Y - (pY * mA)
		      wA = wA - (iA * (vcp.RA.X * pY - vcp.RA.Y * pX))
		      
		      // vB += invMassB * P
		      vB.X = vB.X + (pX * mB)
		      vB.Y = vB.Y + (pY * mB)
		      wB = wB + (iB * (vcp.RB.X * pY - vcp.RB.Y * pX))
		    Next j
		    
		    // Solve normal constraints.
		    If vc.PointCount = 1 Then
		      Var vcp As Physics.VelocityConstraintPoint = vc.Points(0)
		      
		      // Relative velocity at contact.
		      Var dvx As Double = -wB * vcp.RB.Y + vB.X - vA.X + wA * vcp.RA.Y
		      Var dvy As Double = wB * vcp.RB.X + vB.Y - vA.Y - wA * vcp.RA.X
		      
		      // Compute normal impulse.
		      Var vn As Double = dvx * normalX + dvy * normalY
		      Var lambda As Double = -vcp.NormalMass * (vn - vcp.VelocityBias)
		      
		      // Clamp the accumulated impulse.
		      Var a As Double = vcp.NormalImpulse + lambda
		      Var newImpulse As Double = If(a > 0.0, a, 0.0)
		      lambda = newImpulse - vcp.NormalImpulse
		      vcp.NormalImpulse = newImpulse
		      
		      // Apply contact impulse.
		      Var pX As Double = normalX * lambda
		      Var pY As Double = normalY * lambda
		      
		      vA.X = vA.X - (pX * mA)
		      vA.Y = vA.Y - (pY * mA)
		      wA = wA - (iA * (vcp.RA.X * pY - vcp.RA.Y * pX))
		      
		      // vB += invMassB * P
		      vB.X = vB.X + (pX * mB)
		      vB.Y = vB.Y + (pY * mB)
		      wB = wB + (iB * (vcp.RB.X * pY - vcp.RB.Y * pX))
		    Else
		      // Block solver developed in collaboration with Dirk Gregorius
		      // (back in 01/07 on Box2D_Lite).
		      // Build the mini LCP for this contact patch
		      //
		      // vn = A * x + b, vn >= 0, , vn >= 0, x >= 0 and vn_i * x_i = 0
		      // with i = 1..2
		      //
		      // A = J * W * JT and J = ( -n, -r1 x n, n, r2 x n )
		      // b = vn_0 - velocityBias
		      //
		      // The system is solved using the "Total enumeration method" (s. Murty).
		      // The complementary constraint vn_i * x_i
		      // implies that we must have in any solution either vn_i = 0 or x_i = 0.
		      // So for the 2D contact problem the cases
		      // vn1 = 0 and vn2 = 0, x1 = 0 and x2 = 0, x1 = 0 and vn2 = 0, x2 = 0
		      // and vn1 = 0 need to be tested.
		      // The first valid solution that satisfies the problem is chosen.
		      //
		      // In order to account of the accumulated impulse 'a'
		      // (because of the iterative nature of the solver which only requires
		      // that the accumulated impulse is clamped and not the incremental
		      // impulse) we change the impulse variable (x_i).
		      //
		      // Substitute:
		      //
		      // x = a + d
		      //
		      // a := old total impulse
		      // x := new total impulse
		      // d := incremental impulse
		      //
		      // For the current iteration we extend the formula for the incremental
		      // impulse to compute the new total impulse:
		      //
		      // vn = A * d + b
		      // = A * (x - a) + b
		      // = A * x + b - A * a
		      // = A * x + b'
		      // b' = b - A * a
		      
		      Var cp1 As Physics.VelocityConstraintPoint = vc.Points(0)
		      Var cp2 As Physics.VelocityConstraintPoint = vc.Points(1)
		      Var cp1rA As VMaths.Vector2 = cp1.RA
		      Var cp1rB As VMaths.Vector2 = cp1.RB
		      Var cp2rA As VMaths.Vector2 = cp2.RA
		      Var cp2rB As VMaths.Vector2 = cp2.RB
		      Var ax As Double = cp1.NormalImpulse
		      Var ay As Double = cp2.NormalImpulse
		      
		      #If DebugBuild
		        Assert(ax >= 0.0 And ay >= 0.0)
		      #EndIf
		      
		      // Relative velocity at contact.
		      Var dv1x As Double = -wB * cp1rB.Y + vB.X - vA.X + wA * cp1rA.Y
		      Var dv1y As Double = wB * cp1rB.X + vB.Y - vA.Y - wA * cp1rA.X
		      
		      Var dv2x As Double = -wB * cp2rB.Y + vB.X - vA.X + wA * cp2rA.Y
		      Var dv2y As Double = wB * cp2rB.X + vB.Y - vA.Y - wA * cp2rA.X
		      
		      // Compute normal velocity.
		      Var vn1 As Double = dv1x * normalX + dv1y * normalY
		      Var vn2 As Double = dv2x * normalX + dv2y * normalY
		      
		      Var bx As Double = vn1 - cp1.VelocityBias
		      Var by As Double = vn2 - cp2.VelocityBias
		      
		      // Compute b'
		      Var r As VMaths.Matrix2 = vc.K
		      bx = bx - (r.Entry(0, 0) * ax + r.Entry(0, 1) * ay)
		      by = by - (r.Entry(1, 0) * ax + r.Entry(1, 1) * ay)
		      
		      Do
		        //
		        // Case 1: vn = 0
		        //
		        // 0 = A * x' + b'
		        //
		        // Solve for x':
		        //
		        // x' = - inv(A) * b'
		        //
		        // Vec2 x = - Mul(c.normalMass, b)
		        Var r1 As VMaths.Matrix2 = vc.NormalMass
		        Var xx As Double = r1.Entry(0, 0) * bx + r1.Entry(0, 1) * by
		        Var xy As Double = r1.Entry(1, 0) * bx + r1.Entry(1, 1) * by
		        xx = xx * -1
		        xy = xy * -1
		        
		        If xx >= 0.0 And xy >= 0.0 Then
		          // Get the incremental impulse.
		          Var dx As Double = xx - ax
		          Var dy As Double = xy - ay
		          
		          // Apply incremental impulse.
		          Var p1x As Double = dx * normalX
		          Var p1y As Double = dx * normalY
		          Var p2x As Double = dy * normalX
		          Var p2y As Double = dy * normalY
		          
		          // vA -= invMassA * (P1 + P2) wA -= invIA * (Cross(cp1.rA, P1) +
		          //       Cross(cp2.rA, P2))
		          //
		          // vB += invMassB * (P1 + P2) wB += invIB * (Cross(cp1.rB, P1) +
		          //       Cross(cp2.rB, P2))
		          
		          vA.X = vA.X - (mA * (p1x + p2x))
		          vA.Y = vA.Y - (mA * (p1y + p2y))
		          vB.X = vB.X + (mB * (p1x + p2x))
		          vB.Y = vB.Y + (mB * (p1y + p2y))
		          
		          wA = wA - (iA * _
		          (cp1rA.X * p1y - _
		          cp1rA.Y * p1x + _
		          (cp2rA.X * p2y - cp2rA.Y * p2x)))
		          
		          wB = wB + (iB * _
		          (cp1rB.X * p1y - _
		          cp1rB.Y * p1x + _
		          (cp2rB.X * p2y - cp2rB.Y * p2x)))
		          
		          // Accumulate.
		          cp1.NormalImpulse = xx
		          cp2.NormalImpulse = xy
		          
		          // Postconditions
		          // dv1 = vB + Cross(wB, cp1.rB) - vA - Cross(wA, cp1.rA)
		          // dv2 = vB + Cross(wB, cp2.rB) - vA - Cross(wA, cp2.rA)
		          //
		          // Compute normal velocity
		          // vn1 = Dot(dv1, normal) vn2 = Dot(dv2, normal)
		          If debugSolver Then
		            // Postconditions
		            Var dv1 As VMaths.Vector2 = _
		            vB + CrossDoubleVector2(wB, cp1rB).Subtract(vA).Subtract(CrossDoubleVector2(wA, cp1rA))
		            Var dv2 As VMaths.Vector2 = _
		            vB + CrossDoubleVector2(wB, cp2rB).Subtract(vA).Subtract(CrossDoubleVector2(wA, cp2rA))
		            
		            // Compute normal velocity.
		            vn1 = dv1.Dot(normal)
		            vn2 = dv2.Dot(normal)
		            
		            #If DebugBuild
		              Assert(Abs(vn1 - cp1.VelocityBias) < errorTol)
		              Assert(Abs(vn2 - cp2.VelocityBias) < errorTol)
		            #EndIf
		          End If
		          Exit
		        End If
		        
		        //
		        // Case 2: vn1 = 0 and x2 = 0
		        //
		        // 0 = a11 * x1' + a12 * 0 + b1'
		        // vn2 = a21 * x1' + a22 * 0 + '
		        //
		        xx = -cp1.NormalMass * bx
		        xy = 0.0
		        vn1 = 0.0
		        vn2 = vc.K.Entry(1, 0) * xx + by
		        
		        If xx >= 0.0 And vn2 >= 0.0 Then
		          // Get the incremental impulse.
		          Var dx As Double = xx - ax
		          Var dy As Double = xy - ay
		          
		          // Apply incremental impulse.
		          Var p1x As Double = normalX * dx
		          Var p1y As Double = normalY * dx
		          Var p2x As Double = normalX * dy
		          Var p2y As Double = normalY * dy
		          
		          vA.X = vA.X - (mA * (p1x + p2x))
		          vA.Y = vA.Y - (mA * (p1y + p2y))
		          vB.X = vB.X + (mB * (p1x + p2x))
		          vB.Y = vB.Y + (mB * (p1y + p2y))
		          
		          wA = wA - (iA * _
		          (cp1rA.X * p1y -_
		          cp1rA.Y * p1x + _
		          (cp2rA.X * p2y - cp2rA.Y * p2x)))
		          
		          wB = wB + (iB * _
		          (cp1rB.X * p1y - _
		          cp1rB.Y * p1x + _
		          (cp2rB.X * p2y - cp2rB.Y * p2x)))
		          
		          // Accumulate.
		          cp1.NormalImpulse = xx
		          cp2.NormalImpulse = xy
		          
		          If debugSolver Then
		            // Postconditions
		            Var dv1 As VMaths.Vector2 = _
		            vB + CrossDoubleVector2(wB, cp1rB).Subtract(vA).Subtract(CrossDoubleVector2(wA, cp1rA))
		            
		            // Compute normal velocity.
		            vn1 = dv1.Dot(normal)
		            
		            #If DebugBuild
		              Assert(Abs(vn1 - cp1.VelocityBias) < errorTol)
		            #EndIf
		          End If
		          Exit
		        End If
		        
		        //
		        // Case 3: wB = 0 and x1 = 0
		        //
		        // vn1 = a11 * 0 + a12 * x2' + b1'
		        // 0 = a21 * 0 + a22 * x2' + '
		        //
		        xx = 0.0
		        xy = -cp2.NormalMass * by
		        vn1 = vc.K.Entry(0, 1) * xy + bx
		        vn2 = 0.0
		        
		        If xy >= 0.0 And vn1 >= 0.0 Then
		          // Resubstitute for the incremental impulse.
		          Var dx As Double = xx - ax
		          Var dy As Double = xy - ay
		          
		          // Apply incremental impulse.
		          Var p1x As Double = normalX * dx
		          Var p1y As Double = normalY * dx
		          Var p2x As Double = normalX * dy
		          Var p2y As Double = normalY * dy
		          
		          vA.X = vA.X - (mA * (p1x + p2x))
		          vA.Y = vA.Y - (mA * (p1y + p2y))
		          vB.X = vB.X + (mB * (p1x + p2x))
		          vB.Y = vB.Y + (mB * (p1y + p2y))
		          
		          wA = wA - (iA * _
		          (cp1rA.X * p1y - _
		          cp1rA.Y * p1x + _
		          (cp2rA.X * p2y - cp2rA.Y * p2x)))
		          
		          wB = wB + (iB * _
		          (cp1rB.X * p1y - _
		          cp1rB.Y * p1x + _
		          (cp2rB.X * p2y - cp2rB.Y * p2x)))
		          
		          // Accumulate.
		          cp1.NormalImpulse = xx
		          cp2.NormalImpulse = xy
		          
		          If debugSolver Then
		            // Postconditions
		            Var dv2 As VMaths.Vector2 = _
		            vB + CrossDoubleVector2(wB, cp2rB).Subtract(vA).Subtract(CrossDoubleVector2(wA, cp2rA))
		            
		            // Compute normal velocity.
		            vn2 = dv2.Dot(normal)
		            
		            #If DebugBuild
		              Assert(Abs(vn2 - cp2.VelocityBias) < errorTol)
		            #EndIf
		          End If
		          Exit
		        End If
		        
		        //
		        // Case 4: x1 = 0 and x2 = 0
		        //
		        // vn1 = b1
		        // vn2 = 
		        xx = 0.0
		        xy = 0.0
		        vn1 = bx
		        vn2 = by
		        
		        If vn1 >= 0.0 And vn2 >= 0.0 Then
		          // Resubstitute for the incremental impulse.
		          Var dx As Double = xx - ax
		          Var dy As Double = xy - ay
		          
		          // Apply incremental impulse.
		          Var p1x As Double = normalX * dx
		          Var p1y As Double = normalY * dx
		          Var p2x As Double = normalX * dy
		          Var p2y As Double = normalY * dy
		          
		          vA.X = vA.X - (mA * (p1x + p2x))
		          vA.Y = vA.Y - (mA * (p1y + p2y))
		          vB.X = vB.X + (mB * (p1x + p2x))
		          vB.Y = vB.Y + (mB * (p1y + p2y))
		          
		          wA = wA - (iA * _
		          (cp1rA.X * p1y - _
		          cp1rA.Y * p1x + _
		          (cp2rA.X * p2y - cp2rA.Y * p2x)))
		          
		          wB = wB + (iB * _
		          (cp1rB.X * p1y - _
		          cp1rB.Y * p1x + _
		          (cp2rB.X * p2y - cp2rB.Y * p2x)))
		          
		          // Accumulate.
		          cp1.NormalImpulse = xx
		          cp2.NormalImpulse = xy
		          
		          Exit
		        End If
		        
		        // No solution, give up.
		        // This is hit sometimes, but it doesn't seem to matter.
		        Exit
		      Loop
		    End If
		    
		    mVelocities(indexA).W = wA
		    mVelocities(indexB).W = wB
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StoreImpulses()
		  For Each contact As Physics.Contact In mContacts
		    Var vc As Physics.ContactVelocityConstraint = contact.VelocityConstraint
		    Var manifold As Physics.Manifold = mContacts(vc.ContactIndex).Manifold
		    
		    Var jLimit As Integer = vc.PointCount - 1
		    For j As Integer = 0 To jLimit
		      manifold.Points(j).NormalImpulse = vc.Points(j).NormalImpulse
		      manifold.Points(j).TangentImpulse = vc.Points(j).TangentImpulse
		    Next j
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WarmStart()
		  For Each contact As Physics.Contact In mContacts
		    Var velocityConstraint As Physics.ContactVelocityConstraint = contact.VelocityConstraint
		    
		    Var indexA As Integer = velocityConstraint.IndexA
		    Var indexB As Integer = velocityConstraint.IndexB
		    Var mA As Double = velocityConstraint.InvMassA
		    Var iA As Double = velocityConstraint.InvIA
		    Var mB As Double = velocityConstraint.InvMassB
		    Var iB As Double = velocityConstraint.InvIB
		    Var pointCount As Integer = velocityConstraint.PointCount
		    
		    Var vA As VMaths.Vector2 = mVelocities(indexA).V
		    var wA As Double = mVelocities(indexA).W
		    Var vB As VMaths.Vector2 = mVelocities(indexB).V
		    var wB As Double = mVelocities(indexB).W
		    
		    Var normal As VMaths.Vector2 = velocityConstraint.Normal
		    Var tangentX As Double = 1.0 * normal.Y
		    Var tangentY As Double = -1.0 * normal.X
		    
		    Var jLimit As Integer = pointCount - 1
		    For j As Integer = 0 To jLimit
		      Var vcp As Physics.VelocityConstraintPoint = velocityConstraint.Points(j)
		      Var pX As Double = tangentX * vcp.TangentImpulse + normal.X * vcp.NormalImpulse
		      Var pY As Double = tangentY * vcp.TangentImpulse + normal.Y * vcp.NormalImpulse
		      
		      wA = wA - (iA * (vcp.RA.X * pY - vcp.RA.Y * pX))
		      vA.X = vA.X - (pX * mA)
		      vA.Y = vA.y - (pY * mA)
		      wB = wB + (iB * (vcp.RB.X * pY - vcp.RB.Y * pX))
		      vB.X = vB.x + (pX * mB)
		      vB.Y = vB.Y + (pY * mB)
		    Next j
		    
		    mVelocities(indexA).W = wA
		    mVelocities(indexB).W = wB
		  Next contact
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContacts() As Physics.Contact
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPositions() As Physics.Position
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPSolver As Physics.PositionSolverManifold
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStep As Physics.TimeStep
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVelocities() As Physics.Velocity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorldManifold As Physics.WorldManifold
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mXfA As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mXfB As Physics.Transform
	#tag EndProperty


	#tag Constant, Name = DebugSolver, Type = Boolean, Dynamic = False, Default = \"False", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorTol, Type = Double, Dynamic = False, Default = \"1e-3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MaxConditionNumber, Type = Double, Dynamic = False, Default = \"100.0", Scope = Public, Description = 456E73757265206120726561736F6E61626C6520636F6E646974696F6E206E756D6265722E20666F722074686520626C6F636B20736F6C7665722E
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

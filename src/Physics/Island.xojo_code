#tag Class
Protected Class Island
	#tag Method, Flags = &h0
		Sub AddBody(body As Physics.Body)
		  body.IslandIndex = Bodies.Count
		  bodies.Add(New Physics.BodyMeta(body))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddContact(contact As Physics.Contact)
		  mContacts.Add(contact)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddJoint(joint As Physics.Joint)
		  mJoints.Add(joint)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  Bodies.ResizeTo(-1)
		  mContacts.ResizeTo(-1)
		  mJoints.ResizeTo(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mContacts.ResizeTo(-1)
		  mJoints.ResizeTo(-1)
		  
		  mContactSolver = New Physics.ContactSolver
		  mSolverData = New Physics.SolverData
		  mSolverDef = New Physics.ContactSolverDef
		  mToiContactSolver = New Physics.ContactSolver
		  mToiSolverDef = New Physics.ContactSolverDef
		  mImpulse = New Physics.ContactImpulse
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init(listener As Physics.ContactListener = Nil)
		  mListener = listener
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mPositions() As Physics.Position()
		  Var result() As Physics.Position
		  
		  For Each bodyMeta As Physics.BodyMeta In Bodies
		    result.Add(bodyMeta.Position)
		  Next bodyMeta
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mVelocities() As Physics.Velocity()
		  Var result() As Physics.Velocity
		  
		  For Each bodyMeta As Physics.BodyMeta In Bodies
		    result.Add(bodyMeta.Velocity)
		  Next bodyMeta
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReportVelocityConstraints()
		  If mListener = Nil Then Return
		  
		  For Each contact As Physics.Contact In mContacts
		    Var vc As Physics.ContactVelocityConstraint = contact.VelocityConstraint
		    mImpulse.Count = vc.PointCount
		    Var jLimit As Integer = vc.PointCount - 1
		    For j As Integer = 0 To jLimit
		      mImpulse.NormalImpulses(j) = vc.Points(j).NormalImpulse
		      mImpulse.TangentImpulses(j) = vc.points(j).TangentImpulse
		    Next j
		    
		    mListener.PostSolve(contact, mImpulse)
		  Next contact
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Solve(profile As Physics.Profile, step_ As Physics.TimeStep, gravity As VMaths.Vector2, allowSleep As Boolean)
		  #Pragma Unused profile
		  
		  Var dt As Double = step_.Dt
		  
		  // Integrate velocities and apply damping. Initialise the body state.
		  For Each bodyMeta As Physics.BodyMeta In Bodies
		    Var b As Physics.Body = bodyMeta.Body
		    Var bmSweep As Physics.Sweep = b.Sweep
		    Var c As VMaths.Vector2 = bmSweep.C
		    Var a As Double = bmSweep.A
		    Var v As VMaths.Vector2 = b.LinearVelocity
		    var w As Double = b.AngularVelocity
		    
		    // Store positions for continuous collision.
		    bmSweep.C0.SetFrom(bmSweep.C)
		    bmSweep.A0 = bmSweep.A
		    
		    If b.BodyType = Physics.BodyType.Dynamic Then
		      // Integrate velocities.
		      Var bodyGravity As VMaths.Vector2 = _
		      If(b.GravityOverride = Nil, gravity, b.GravityOverride)
		      v.X = v.X + (dt * (If(b.GravityScale = Nil, 1, b.GravityScale.X) * _
		      bodyGravity.X + b.InverseMass * b.Force.X))
		      
		      v.Y = v.Y + (dt * (If(b.GravityScale = Nil, 1, b.GravityScale.Y) * _
		      bodyGravity.Y + b.InverseMass * b.Force.Y))
		      
		      w = w + (dt * b.InverseInertia * b.Torque)
		      
		      // Apply damping.
		      v.X = v.X * (1.0 / (1.0 + dt * b.LinearDamping))
		      v.Y = v.Y * (1.0 / (1.0 + dt * b.LinearDamping))
		      w = w * (1.0 / (1.0 + dt * b.AngularDamping))
		    End If
		    
		    bodyMeta.position.c.x = c.x
		    bodyMeta.position.c.y = c.y
		    bodyMeta.position.a = a
		    bodyMeta.velocity.v.x = v.x
		    bodyMeta.velocity.v.y = v.y
		    bodyMeta.velocity.w = w
		  Next bodyMeta
		  
		  // Solver data
		  mSolverData.Step_ = step_
		  mSolverData.Positions = mPositions
		  mSolverData.Velocities = mVelocities
		  
		  // Initialise velocity constraints.
		  mSolverDef.Step_ = step_
		  mSolverDef.Contacts = mContacts
		  mSolverDef.Positions = mPositions
		  mSolverDef.Velocities = mVelocities
		  
		  mContactSolver.Init(mSolverDef)
		  mContactSolver.InitializeVelocityConstraints
		  
		  If step_.WarmStarting Then
		    mContactSolver.WarmStart
		  End If
		  
		  For Each joint As Physics.Joint In mJoints
		    joint.InitVelocityConstraints(mSolverData)
		  Next joint
		  
		  Var iLimit As Integer = step_.VelocityIterations - 1
		  For i As Integer = 0 To iLimit
		    For Each joint As Physics.Joint In mJoints
		      joint.SolveVelocityConstraints(mSolverData)
		    Next joint
		    
		    mContactSolver.SolveVelocityConstraints
		  Next i
		  
		  // Store impulses for warm starting.
		  mContactSolver.StoreImpulses
		  
		  // Integrate positions.
		  For Each bodyMeta As Physics.BodyMeta In Bodies
		    Var c As VMaths.Vector2 = bodyMeta.Position.C
		    Var a As Double = bodyMeta.Position.A
		    Var v As VMaths.Vector2 = bodyMeta.Velocity.V
		    Var w As Double = bodyMeta.Velocity.W
		    
		    // Check for large velocities.
		    Var translationX As Double = v.X * dt
		    Var translationY As Double = v.Y * dt
		    
		    If translationX * translationX + translationY * translationY > _
		      Physics.Settings.MaxTranslationSquared Then
		      Var ratio As Double = Physics.Settings.MaxTranslation / _
		      Sqrt(translationX * translationX + translationY * translationY)
		      v.X = v.X * ratio
		      v.Y = v.Y * ratio
		    End If
		    
		    Var rotation As Double = dt * w
		    If rotation * rotation > Physics.Settings.MaxRotationSquared Then
		      Var ratio As Double = Physics.Settings.MaxRotation / Abs(rotation)
		      w = w * ratio
		    End If
		    
		    // Integrate
		    c.X = c.X + (dt * v.X)
		    c.Y = c.Y + (dt * v.Y)
		    a = a + (dt * w)
		    
		    bodyMeta.Position.A = a
		    bodyMeta.Velocity.W = w
		  Next bodyMeta
		  
		  // Solve position constraints
		  Var positionSolved As Boolean = False
		  iLimit = step_.PositionIterations - 1
		  For i As Integer = 0 To iLimit
		    Var contactsOkay As Boolean = mContactSolver.SolvePositionConstraints
		    
		    Var jointsOkay As Boolean = True
		    For Each joint As Physics.Joint In mJoints
		      Var jointOkay As Boolean = joint.SolvePositionConstraints(mSolverData)
		      jointsOkay = jointsOkay And jointOkay
		    Next joint
		    
		    If contactsOkay And jointsOkay Then
		      // Exit early if the position errors are small.
		      positionSolved = True
		      Exit
		    End If
		  Next i
		  
		  // Copy state buffers back to the bodies.
		  For Each bodyMeta As Physics.BodyMeta In Bodies
		    Var body As Physics.Body = bodyMeta.Body
		    body.Sweep.C.X = bodyMeta.Position.C.X
		    body.Sweep.C.Y = bodyMeta.Position.C.Y
		    body.Sweep.A = bodyMeta.Position.A
		    body.LinearVelocity.X = bodyMeta.Velocity.V.X
		    body.LinearVelocity.Y = bodyMeta.Velocity.V.Y
		    body.AngularVelocity = bodyMeta.Velocity.W
		    body.SynchronizeTransform
		  Next bodyMeta
		  
		  ReportVelocityConstraints
		  
		  If allowSleep Then
		    Var minSleepTime As Double = Maths.DoubleMaxFinite
		    
		    Var linTolSqr As Double = _
		    Physics.Settings.LinearSleepTolerance * Physics.Settings.LinearSleepTolerance
		    Var angTolSqr As Double = _
		    Physics.Settings.AngularSleepTolerance * Physics.Settings.AngularSleepTolerance
		    
		    For Each bodyMeta As Physics.BodyMeta In Bodies
		      Var b As Physics.Body = bodyMeta.Body
		      If b.BodyType = Physics.BodyType.Static_ Then
		        Continue
		      End If
		      
		      If (b.Flags And Physics.Body.AutoSleepFlag) = 0 Or _
		        b.AngularVelocity * b.AngularVelocity > angTolSqr Or _
		        b.LinearVelocity.Dot(b.LinearVelocity) > linTolSqr Then
		        b.SleepTime = 0.0
		        minSleepTime = 0.0
		      Else 
		        b.SleepTime = b.SleepTime + dt
		        minSleepTime = Min(minSleepTime, b.SleepTime)
		      End If
		    Next bodyMeta
		    
		    If minSleepTime >= Physics.Settings.TimeToSleep And positionSolved Then
		      For Each b As Physics.BodyMeta In Bodies
		        b.Body.SetAwake(False)
		      Next b
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveTOI(subStep As Physics.TimeStep, toiIndexA As Integer, toiIndexB As Integer)
		  #If DebugBuild
		    Assert(toiIndexA < Bodies.Count)
		    Assert(toiIndexB < Bodies.Count)
		  #EndIf
		  
		  // Initialise the body state.
		  For Each bodyMeta As Physics.BodyMeta In Bodies
		    Var body As Physics.Body = bodyMeta.Body
		    bodyMeta.Position.C.X = body.Sweep.C.X
		    bodyMeta.Position.C.Y = body.Sweep.C.Y
		    bodyMeta.Position.A = body.Sweep.A
		    bodyMeta.Velocity.V.X = body.LinearVelocity.X
		    bodyMeta.Velocity.V.Y = body.LinearVelocity.Y
		    bodyMeta.Velocity.W = body.AngularVelocity
		  Next bodyMeta
		  
		  mToiSolverDef.Contacts = mContacts
		  mToiSolverDef.Step_ = subStep
		  mToiSolverDef.Positions = mPositions
		  mToiSolverDef.Velocities = mVelocities
		  mToiContactSolver.Init(mToiSolverDef)
		  
		  // Solve position constraints.
		  Var iLimit As Integer = subStep.PositionIterations - 1
		  For i As Integer = 0 To iLimit
		    Var contactsOkay As Boolean = _
		    mToiContactSolver.SolveTOIPositionConstraints(toiIndexA, toiIndexB)
		    If contactsOkay Then
		      Exit
		    End If
		  Next i
		  
		  // Leap of faith to new safe state.
		  Var tmpPositions() As Physics.Position = mPositions
		  Bodies(toiIndexA).Body.Sweep.C0.X = tmpPositions(toiIndexA).C.X
		  Bodies(toiIndexA).Body.Sweep.C0.Y = tmpPositions(toiIndexA).C.Y
		  Bodies(toiIndexA).Body.Sweep.A0 = tmpPositions(toiIndexA).A
		  Bodies(toiIndexB).Body.Sweep.C0.SetFrom(tmpPositions(toiIndexB).C)
		  Bodies(toiIndexB).Body.Sweep.A0 = tmpPositions(toiIndexB).A
		  
		  // No warm starting is needed for TOI events because warm
		  // starting impulses were applied in the discrete solver.
		  mToiContactSolver.InitializeVelocityConstraints
		  
		  // Solve velocity constraints.
		  iLimit = subStep.VelocityIterations - 1
		  For i As Integer = 0 To iLimit
		    mToiContactSolver.SolveVelocityConstraints
		  Next i
		  
		  // Don't store the TOI contact forces for warm starting
		  // because they can be quite large.
		  
		  Var dt As Double = subStep.Dt
		  
		  // Integrate positions.
		  For Each bodyMeta As Physics.BodyMeta In Bodies
		    Var position As Physics.Position = bodyMeta.Position
		    Var velocity As Physics.Velocity = bodyMeta.Velocity
		    Var c As VMaths.Vector2 = position.C
		    var a As Double = position.A
		    Var v As VMaths.Vector2 = velocity.V
		    var w As Double = velocity.W
		    
		    // Check for large velocities.
		    Var translationX As Double = v.X * dt
		    Var translationY As Double = v.Y * dt
		    If translationX * translationX + translationY * translationY > _
		      Physics.Settings.MaxTranslationSquared Then
		      Var ratio As Double = Physics.Settings.MaxTranslation / _
		      Sqrt(translationX * translationX + translationY * translationY)
		      v.Scale(ratio)
		    End If
		    
		    Var rotation As Double = dt * w
		    If rotation * rotation > Physics.Settings.MaxRotationSquared Then
		      Var ratio As Double = Physics.Settings.MaxRotation / Abs(rotation)
		      w = w * ratio
		    End If
		    
		    // Integrate.
		    c.X = c.X + (v.X * dt)
		    c.Y = c.Y + (v.Y * dt)
		    a = a + (dt * w)
		    
		    position.C.X = c.X
		    position.C.Y = c.Y
		    position.A = a
		    velocity.V.X = v.X
		    velocity.V.Y = v.Y
		    velocity.W = w
		    
		    // Sync bodies.
		    Var body As Physics.Body = bodyMeta.Body
		    body.Sweep.C.X = c.X
		    body.Sweep.C.Y = c.Y
		    body.Sweep.A = a
		    body.LinearVelocity.X = v.X
		    body.LinearVelocity.Y = v.Y
		    body.AngularVelocity = w
		    body.SynchronizeTransform
		  Next bodyMeta
		  
		  ReportVelocityConstraints
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Notes
		I tried several algorithms for position correction of the 2D revolute joint.
		 I looked at these systems:
		 - simple pendulum (1m diameter sphere on massless 5m stick) with initial
		   angular velocity of 100 rad/s.
		 - suspension bridge with 30 1m long planks of length 1m.
		 - multi-link chain with 30 1m long links.
		
		 Here are the algorithms:
		
		 Baumgarte - A fraction of the position error is added to the velocity error.
		 There is no  separate position solver.
		
		 Pseudo Velocities - After the velocity solver and position integration,
		 the position error, Jacobian, and effective mass are recomputed. Then
		 the velocity constraints are solved with pseudo velocities and a fraction
		 of the position error is added to the pseudo velocity error. The pseudo
		 velocities are initialized to zero and there is no warm-starting. After
		 the position solver, the pseudo velocities are added to the positions.
		 This is also called the First Order World method or the Position LCP method.
		
		 Modified Nonlinear Gauss-Seidel (NGS) - Like Pseudo Velocities except the
		 position error is re-computed for each raint and the positions are updated
		 after the raint is solved. The radius vectors (aka Jacobians) are
		 re-computed too (otherwise the algorithm has horrible instability). The pseudo
		 velocity states are not needed because they are effectively zero at the
		 beginning of each iteration. Since we have the current position error, we allow
		 the iterations to terminate early if the error becomes smaller than Settings.
		 linearSlop.
		
		 Full NGS or just NGS - Like Modified NGS except the effective mass are
		 re-computed each time a raint is solved.
		
		 Here are the results:
		
		 Baumgarte - this is the cheapest algorithm but it has some stability problems,
		 especially with the bridge. The chain links separate easily close to the root
		 and they jitter as they struggle to pull together. This is one of the most
		 common methods in the field. The big drawback is that the position correction
		 artificially affects the momentum, thus leading to instabilities and false
		 bounce. I used a bias factor of 0.2. A larger bias factor makes the bridge less
		 stable, a smaller factor makes joints and contacts more spongy.
		
		 Pseudo Velocities - the is more stable than the Baumgarte method. The bridge is
		 stable. However, joints still separate with large angular velocities. Drag the
		 simple pendulum in a circle quickly and the joint will separate. The chain
		 separates easily and does not recover. I used a bias factor of 0.2. A larger
		 value lead to the bridge collapsing when a heavy cube drops on it.
		
		 Modified NGS - this algorithm is better in some ways than Baumgarte and Pseudo
		 Velocities, but in other ways it is worse. The bridge and chain are much more
		 stable, but the simple pendulum goes unstable at high angular velocities.
		
		 Full NGS - stable in all tests. The joints display good stiffness. The bridge
		 still sags, but this is better than infinite forces.
		
		 Recommendations
		 Pseudo Velocities are not really worthwhile because the bridge and chain cannot
		 recover from joint separation. In other cases the benefit over Baumgarte is
		 small.
		
		 Modified NGS is not a robust method for the revolute joint due to the violent
		 instability seen in the simple pendulum. Perhaps it is viable with other raint
		 types, especially scalar constraints where the effective mass is a scalar.
		
		 This leaves Baumgarte and Full NGS. Baumgarte has small, but manageable
		 instabilities and is very fast. I don't think we can escape Baumgarte,
		 especially in highly demanding cases where high raint fidelity is not needed.
		
		 Full NGS is robust and easy on the eyes. I recommend this as an option for
		 higher fidelity simulation and certainly for suspension bridges and long
		 chains.
		 Full NGS might be a good choice for ragdolls, especially motorized ragdolls
		 where joint separation can be problematic. The number of NGS iterations can be
		 reduced for better performance without harming robustness much.
		
		 Each joint in a can be handled differently in the position solver. So I
		 recommend a system where the user can select the algorithm on a per joint
		 basis. I would probably default to the slower Full NGS and let the user select
		 the faster Baumgarte method in performance critical scenarios.
		
		 Cache Performance
		 The Box2D solvers are dominated by cache misses. Data structures are designed
		 to increase the number of cache hits. Much of misses are due to random access
		 to body data. The raint structures are iterated over linearly, which leads
		 to few cache misses.
		
		 The bodies are not accessed during iteration. Instead read only data, such as
		 the mass values are stored with the constraints. The mutable data are the raint
		 impulses and the bodies velocities/positions. The impulses are held inside the
		 raint structures. The body velocities/positions are held in compact, temporary
		 arrays to increase the number of cache hits. Linear and angular velocity are
		 stored in a single array since multiple arrays lead to multiple misses.
		
		 2D Rotation
		 R = [cos(theta) -sin(theta)]
		 [sin(theta) cos(theta) ]
		
		 thetaDot = omega
		
		 Let q1 = cos(theta), q2 = sin(theta).
		 R = [q1 -q2]
		 [q2  q1]
		
		 q1Dot = -thetaDot * q2
		 q2Dot = thetaDot * q1
		
		 q1_new = q1_old - dt * w * q2
		 q2_new = q2_old + dt * w * q1
		 then normalize.
		
		 This might be faster than computing sin+cos.
		 However, we can compute sin+cos of the same angle fast.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Bodies() As Physics.BodyMeta
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContacts() As Physics.Contact
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContactSolver As Physics.ContactSolver
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImpulse As Physics.ContactImpulse
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJoints() As Physics.Joint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mListener As Physics.ContactListener
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSolverData As Physics.SolverData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSolverDef As Physics.ContactSolverDef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToiContactSolver As Physics.ContactSolver
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToiSolverDef As Physics.ContactSolverDef
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

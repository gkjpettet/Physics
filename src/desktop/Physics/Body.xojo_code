#tag Class
Protected Class Body
	#tag Method, Flags = &h0, Description = 416476616E636520746F20746865206E657720736166652074696D652E205468697320646F65736E27742073796E63207468652062726F61642D70686173652E
		Sub Advance(t As Double)
		  /// Advance to the new safe time. This doesn't sync the broad-phase.
		  
		  Sweep.Advance(t)
		  Sweep.C.SetFrom(Sweep.C0)
		  Sweep.A = Sweep.A0
		  Transform.Q.SetAngle(Sweep.A)
		  Transform.P.SetFrom(Physics.Rot.MulVec2(Transform.Q, Sweep.LocalCenter))
		  
		  Transform.P.Scale(-1.0)
		  Transform.P.Add(Sweep.C)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4170706C7920616E20616E67756C617220696D70756C73652E
		Sub ApplyAngularImpulse(impulse As Double)
		  /// Apply an angular impulse.
		  ///
		  /// angular `impulse` in units of kg*m*m/s
		  
		  If mBodyType <> Physics.BodyType.Dynamic Then
		    Return
		  End If
		  
		  If IsAwake = False Then
		    SetAwake(True)
		  End If
		  
		  mAngularVelocity = mAngularVelocity + (InverseInertia * impulse)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4170706C79206120666F726365206174206120776F726C6420706F696E742E2049662074686520666F726365206973206E6F74206170706C696564206174207468652063656E747265206F66206D6173732C2069742077696C6C206166666563742074686520616E67756C61722076656C6F636974792E20546869732077616B65732075702074686520626F64792E
		Sub ApplyForce(force As VMaths.Vector2, point As VMaths.Vector2 = Nil)
		  /// Apply a force at a world point. If the force is not applied at the centre
		  /// of mass, it will affect the angular velocity.
		  /// This wakes up the body.
		  ///
		  /// `point` is the world position of the point of application (defaults 
		  /// to the centre of mass).
		  
		  point = If(point = Nil, WorldCenter, point)
		  ApplyForceToCenter(force)
		  mTorque = mTorque + _
		  ((point.X - Sweep.C.X) * force.Y - (point.Y - Sweep.C.Y) * force.X)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4170706C79206120666F72636520746F207468652063656E747265206F66206D6173732E20546869732077616B65732075702074686520626F64792E2060666F7263656020697320757375616C6C7920696E204E6577746F6E7320284E292E
		Sub ApplyForceToCenter(force As VMaths.Vector2)
		  /// Apply a force to the centre of mass. This wakes up the body.
		  /// `force` is usually in Newtons (N).
		  
		  If mBodyType <> Physics.BodyType.Dynamic Then
		    Return
		  End If
		  
		  If IsAwake = False Then
		    SetAwake(True)
		  End If
		  
		  Self.Force.X = Self.Force.X + force.X
		  Self.Force.Y = Self.Force.Y + force.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4170706C7920616E20696D70756C7365206174206120706F696E742E205468697320696D6D6564696174656C79206D6F646966696573207468652076656C6F636974792E20497420616C736F206D6F6469666965732074686520616E67756C61722076656C6F636974792069662074686520706F696E74206F66206170706C69636174696F6E206973206E6F74206174207468652063656E746572206F66206D6173732E
		Sub ApplyLinearImpulse(impulse As VMaths.Vector2, point As VMaths.Vector2 = Nil, wake As Boolean = True)
		  /// Apply an impulse at a point. This immediately modifies the velocity. It
		  /// also modifies the angular velocity if the point of application is not at
		  /// the center of mass. 
		  ///
		  /// This wakes up the body if 'wake' is set to true. If
		  /// the body is sleeping and 'wake' is False, then there is no effect.
		  ///
		  /// `impulse` is the world impulse vector, usually in N-seconds or kg-m/s.
		  /// `point` is the world position of the point of application
		  /// (default: centre of mass).
		  /// `wake` decides whether to wake up the body if it is sleeping (default: true).
		  
		  If mBodyType <> Physics.BodyType.Dynamic Then
		    Return
		  End If
		  
		  point = If(point = Nil, WorldCenter, point)
		  
		  If Not IsAwake Then
		    If wake Then
		      SetAwake(True)
		    Else
		      Return
		    End If
		  End If
		  
		  LinearVelocity = LinearVelocity + (impulse * mInverseMass)
		  mAngularVelocity = mAngularVelocity + _
		  (InverseInertia *((point.X - Sweep.C.X) * impulse.Y - (point.Y - Sweep.C.Y) * impulse.X))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4170706C79206120746F727175652E205468697320616666656374732074686520616E67756C61722076656C6F6369747920776974686F757420616666656374696E6720746865206C696E6561722076656C6F63697479206F66207468652063656E747265206F66206D6173732E20546869732077616B65732075702074686520626F64792E
		Sub ApplyTorque(torque As Double)
		  /// Apply a torque. This affects the angular velocity without affecting the
		  /// linear velocity of the centre of mass. This wakes up the body.
		  ///
		  /// `torque` is usually in N-m.
		  
		  If mBodyType <> Physics.BodyType.Dynamic Then
		    Return
		  End If
		  
		  If IsAwake = False Then
		    SetAwake(True)
		  End If
		  
		  mTorque = mTorque + torque
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766520616C6C207468652063757272656E7420666F72636573206F6E2074686520626F64792E
		Sub ClearForces()
		  /// Remove all the current forces on the body.
		  
		  Force.SetZero
		  mTorque = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Transform = Physics.Transform.Zero
		  Self.PreviousTransform = Physics.Transform.Zero
		  Self.Sweep = New Physics.Sweep
		  mLinearVelocity = VMaths.Vector2.Zero
		  Self.Force = VMaths.Vector2.Zero
		  mPMD = New Physics.MassData
		  mPXF = Physics.Transform.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(bd As Physics.BodyDef, world As Physics.World)
		  #If DebugBuild
		    Assert(Not bd.Position.IsInfinite And Not bd.Position.IsNotANumber)
		    Assert(Not bd.LinearVelocity.IsInfinite And Not bd.LinearVelocity.IsNotANumber)
		    Assert(bd.AngularDamping >= 0.0)
		    Assert(bd.LinearDamping >= 0.0)
		  #EndIf
		  
		  Constructor
		  
		  Self.World = world
		  
		  flags = 0
		  
		  If bd.Bullet Then flags = flags Or BulletFlag
		  If bd.FixedRotation Then flags = flags Or FixedRotationFlag
		  If bd.AllowSleep Then flags = flags Or AutoSleepFlag
		  If bd.IsAwake Then flags = flags Or AwakeFlag
		  If bd.Active Then flags = flags Or ActiveFlag
		  
		  Self.Transform.P.SetFrom(bd.Position)
		  Self.Transform.Q.SetAngle(bd.Angle)
		  
		  Self.Sweep.LocalCenter.SetZero
		  Self.Sweep.C0.SetFrom(Self.Transform.P)
		  Self.Sweep.C.SetFrom(Self.Transform.P)
		  Self.Sweep.A0 = bd.Angle
		  Self.Sweep.A = bd.Angle
		  Self.Sweep.Alpha0 = 0.0
		  
		  LinearVelocity.SetFrom(bd.LinearVelocity)
		  mAngularVelocity = bd.AngularVelocity
		  
		  LinearDamping = bd.LinearDamping
		  AngularDamping = bd.AngularDamping
		  GravityOverride = bd.GravityOverride
		  GravityScale = bd.GravityScale
		  
		  Force.SetZero
		  
		  SleepTime = 0.0
		  
		  mBodyType = bd.Type
		  
		  If mBodyType = Physics.BodyType.Dynamic Then
		    mMass = 1.0
		    mInverseMass = 1.0
		  Else
		    mMass = 0.0
		    mInverseMass = 0.0
		  End If
		  
		  Inertia = 0.0
		  InverseInertia = 0.0
		  
		  UserData = bd.UserData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43726561746573206120666978747572652066726F6D20606465666020616E6420617474616368657320697420746F207468697320626F64792E204F766572726964652072657475726E732074686520666978747572652E
		Sub CreateFixture(def As Physics.FixtureDef)
		  /// Creates a fixture from `def` and attaches it to this body. Override returns the fixture.
		  ///
		  /// Use this if you need to set some fixture parameters. Otherwise you can
		  /// create the fixture directly from a shape. 
		  ///
		  /// If the density is non-zero, this function automatically updates the mass of the body. 
		  /// Contacts are not created until the next time step.
		  ///
		  /// Warning: This function is locked during callbacks.
		  
		  #If DebugBuild
		    Assert(Not world.IsLocked, "The world is locked.")
		  #EndIf
		  
		  Var fixture As New Physics.Fixture(Self, def)
		  
		  If (Flags And ActiveFlag) = ActiveFlag Then
		    Var broadPhase As Physics.Broadphase = World.ContactManager.BroadPhase
		    fixture.CreateProxies(broadPhase, Transform)
		  End If
		  
		  fixtures.Add(fixture)
		  
		  // Adjust mass properties if needed.
		  If fixture.Density > 0.0 Then
		    ResetMassData
		  End If
		  
		  // Let the world know we have a new fixture. This will cause new contacts
		  // to be created at the beginning of the next time step.
		  world.Flags = world.Flags Or World.NewFixture
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43726561746573206120666978747572652066726F6D20606465666020616E6420617474616368657320697420746F207468697320626F64792E204F766572726964652072657475726E732074686520666978747572652E
		Function CreateFixture(def As Physics.FixtureDef) As Physics.Fixture
		  /// Creates a fixture from `def` and attaches it to this body. Override returns the fixture.
		  ///
		  /// Use this if you need to set some fixture parameters. Otherwise you can
		  /// create the fixture directly from a shape. 
		  ///
		  /// If the density is non-zero, this function automatically updates the mass of the body. 
		  /// Contacts are not created until the next time step.
		  ///
		  /// Warning: This function is locked during callbacks.
		  
		  #If DebugBuild
		    Assert(Not world.IsLocked, "The world is locked.")
		  #EndIf
		  
		  Var fixture As New Physics.Fixture(Self, def)
		  
		  If (Flags And ActiveFlag) = ActiveFlag Then
		    Var broadPhase As Physics.Broadphase = World.ContactManager.BroadPhase
		    fixture.CreateProxies(broadPhase, Transform)
		  End If
		  
		  fixtures.Add(fixture)
		  
		  // Adjust mass properties if needed.
		  If fixture.Density > 0.0 Then
		    ResetMassData
		  End If
		  
		  // Let the world know we have a new fixture. This will cause new contacts
		  // to be created at the beginning of the next time step.
		  world.Flags = world.Flags Or World.NewFixture
		  
		  Return fixture
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43726561746573206120666978747572652066726F6D206120736861706520616E6420617474616368657320697420746F207468697320626F64792E2054686973206973206120636F6E76656E69656E63652066756E6374696F6E2E205573652060466978747572654465666020696620796F75206E65656420746F2073657420706172616D6574657273206C696B65206672696374696F6E2C207265737469747574696F6E2C207573657220646174612C206F722066696C746572696E672E
		Function CreateFixtureFromShape(shape As Physics.Shape, density As Double = 0.0) As Physics.Fixture
		  /// Creates a fixture from a shape and attaches it to this body. This is a
		  /// convenience function. Use `FixtureDef` if you need to set parameters like
		  /// friction, restitution, user data, or filtering.
		  /// 
		  /// If the density is non-zero, this function automatically updates the mass
		  /// of the body.
		  ///
		  /// `shape` is the shape to be cloned.
		  /// `density` is the shape density (set to zero for static bodies).
		  ///
		  /// Warning: This function is locked during callbacks.
		  
		  Var tmp As New Physics.FixtureDef(shape)
		  tmp.Density = density
		  
		  Return CreateFixture(tmp)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657374726F79206120666978747572652E20546869732072656D6F7665732074686520666978747572652066726F6D207468652062726F6164706861736520616E642064657374726F797320616C6C20636F6E7461637473206173736F6369617465642077697468207468697320666978747572652E
		Sub DestroyFixture(fixture As Physics.Fixture)
		  /// Destroy a fixture. This removes the fixture from the broadphase and
		  /// destroys all contacts associated with this fixture. 
		  ///
		  /// This will automatically adjust the mass of the body if the body is dynamic and the
		  /// fixture has positive density. All fixtures attached to a body are
		  /// implicitly destroyed when the body is destroyed.
		  ///
		  /// Warning: This function is locked during callbacks.
		  
		  #If DebugBuild
		    Assert(Not world.IsLocked, "The world is locked.")
		    Assert(fixture.Body = Self, "The fixture's body is not this body.")
		  #EndIf
		  
		  // Remove the fixture from this body's singly linked list.
		  #If DebugBuild
		    Assert(Fixtures.Count > 0, "The body has no fixtures.")
		  #EndIf
		  Var removed As Boolean = Fixtures.RemoveFixture(fixture)
		  
		  // You tried to remove a shape that is not attached to this body.
		  #If DebugBuild
		    Assert(removed, "You tried to remove a fixture that is not attached to this body")
		  #EndIf
		  
		  // Destroy any contacts associated with the fixture.
		  Var i As Integer = 0
		  While i < Contacts.Count
		    Var contact As Physics.Contact = Contacts(i)
		    If fixture = contact.FixtureA Or fixture = contact.FixtureB Then
		      // This destroys the contact and removes it from this body's contact list.
		      World.ContactManager.Destroy(contact)
		    Else
		      /// Increase index only if contact was not deleted and need move to next one.
		      /// If contact was deleted, then index should not be increased.
		      i = i + 1
		    End If
		  Wend
		  
		  If (Flags And ActiveFlag) = ActiveFlag Then
		    Var broadPhase As Physics.Broadphase = World.ContactManager.BroadPhase
		    fixture.DestroyProxies(broadPhase)
		  End If
		  
		  // Reset the mass data.
		  ResetMassData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574207468652063656E7472616C20726F746174696F6E616C20696E6572746961206F662074686520626F64792C20757375616C6C7920696E206B672D6D5E322E
		Function GetInertia() As Double
		  /// Get the central rotational inertia of the body, usually in kg-m^2.
		  
		  Return Inertia + _
		  mMass * _
		  (Sweep.LocalCenter.X * Sweep.LocalCenter.X + _
		  Sweep.LocalCenter.Y * Sweep.LocalCenter.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865206C6F63616C20706F736974696F6E206F66207468652063656E747265206F66206D6173732E20446F206E6F74206D6F646966792E
		Function GetLocalCenter() As VMaths.Vector2
		  /// Get the local position of the centre of mass. Do not modify.
		  
		  Return Sweep.LocalCenter
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865206D6173732064617461206F662074686520626F64792E2054686520726F746174696F6E616C20696E65727469612069732072656C617469766520746F207468652063656E747265206F66206D6173732E
		Function GetMassData() As Physics.MassData
		  /// Get the mass data of the body. The rotational inertia is relative to the
		  /// centre of mass.
		  
		  Var md As New Physics.MassData
		  
		  md.Mass = mMass
		  md.I = Inertia + GetInertia
		  md.Center.X = Sweep.LocalCenter.X
		  md.Center.Y = Sweep.LocalCenter.Y
		  
		  Return md
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4973207468697320626F64792074726561746564206C696B6520612062756C6C657420666F7220636F6E74696E756F757320636F6C6C6973696F6E20646574656374696F6E3F
		Function IsBullet() As Boolean
		  /// Is this body treated like a bullet for continuous collision detection?
		  
		  Return (Flags And BulletFlag) = BulletFlag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446F6573207468697320626F6479206861766520666978656420726F746174696F6E3F
		Function IsFixedRotation() As Boolean
		  /// Does this body have fixed rotation?
		  
		  Return (Flags And FixedRotationFlag) = FixedRotationFlag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57686574686572207468697320626F647920697320616C6C6F77656420746F20736C6565702E
		Function IsSleepingAllowed() As Boolean
		  /// Whether this body is allowed to sleep.
		  
		  Return (Flags And AutoSleepFlag) = AutoSleepFlag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520776F726C642076656C6F63697479206F662061206C6F63616C20706F696E742E
		Function LinearVelocityFromLocalPoint(localPoint As VMaths.Vector2) As VMaths.Vector2
		  /// Get the world velocity of a local point.
		  
		  Return LinearVelocityFromWorldPoint(WorldPoint(localPoint))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520776F726C64206C696E6561722076656C6F63697479206F66206120776F726C6420706F696E7420617474616368656420746F207468697320626F64792E
		Function LinearVelocityFromWorldPoint(worldPoint As VMaths.Vector2) As VMaths.Vector2
		  /// Get the world linear velocity of a world point attached to this body.
		  
		  Return New VMaths.Vector2( _
		  -mAngularVelocity * (worldPoint.Y - Sweep.C.Y) + LinearVelocity.X, _
		  mAngularVelocity * (worldPoint.X - Sweep.C.X) + LinearVelocity.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574732061206C6F63616C20706F696E742072656C617469766520746F2074686520626F64792773206F726967696E20676976656E206120776F726C6420706F696E742E
		Function LocalPoint(worldPoint As VMaths.Vector2) As VMaths.Vector2
		  /// Gets a local point relative to the body's origin given a world point.
		  
		  Return Transform.MulTransVec2(Transform, worldPoint)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574732061206C6F63616C20766563746F7220676976656E206120776F726C6420766563746F722E
		Function LocalVector(worldVector As VMaths.Vector2) As VMaths.Vector2
		  /// Gets a local vector given a world vector.
		  
		  Return Physics.Rot.MulTransVec2(Transform.Q, worldVector)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 546869732072657365747320746865206D6173732070726F7065727469657320746F207468652073756D206F6620746865206D6173732070726F70657274696573206F66207468652066697874757265732E
		Private Sub ResetMassData()
		  /// This resets the mass properties to the sum of the mass properties of the
		  /// fixtures.
		  ///
		  /// This normally does not need to be called unless you called
		  /// `SetMassData` to override the mass and you later want to reset the mass.
		  
		  // Compute mass data from shapes. Each shape has its own density.
		  mMass = 0.0
		  mInverseMass = 0.0
		  Inertia = 0.0
		  InverseInertia = 0.0
		  Sweep.LocalCenter.SetZero
		  
		  // Static and kinematic bodies have zero mass.
		  If mBodyType = Physics.BodyType.Static_ Or mBodyType = Physics.BodyType.Kinematic Then
		    Sweep.C0.SetFrom(Transform.P)
		    Sweep.C.SetFrom(Transform.P)
		    Sweep.A0 = Sweep.A
		    Return
		  End If
		  
		  #If DebugBuild
		    Assert(mBodyType = Physics.BodyType.Dynamic, "The body's type is not dynamic.")
		  #EndIf
		  
		  // Accumulate mass over all fixtures.
		  Var localCenter As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Zero
		  Var massData As Physics.MassData = mPMD
		  For Each f As Physics.Fixture In Fixtures
		    If f.Density = 0.0 Then
		      Continue
		    End If
		    f.GetMassData(massData)
		    mMass = mMass + massData.Mass
		    
		    temp.SetFrom(massData.Center)
		    temp.Scale(massData.Mass)
		    
		    localCenter.Add(temp)
		    Inertia = Inertia + massData.I
		  Next f
		  
		  // Compute centre of mass.
		  If mMass > 0.0 Then
		    mInverseMass = 1.0 / mMass
		    localCenter.Scale(mInverseMass)
		  Else
		    // Force all dynamic bodies to have a positive mass.
		    mMass = 1.0
		    mInverseMass = 1.0
		  End If
		  
		  If inertia > 0.0 And (Flags And FixedRotationFlag) = 0.0 Then
		    // Centre the inertia about the centre of mass.
		    Inertia = Inertia - (mMass * localCenter.Dot(localCenter))
		    #If DebugBuild
		      Assert(Inertia > 0.0, "Inertia is <= 0.0.")
		    #EndIf
		    InverseInertia = 1.0 / Inertia
		  Else
		    Inertia = 0.0
		    InverseInertia = 0.0
		  End If
		  
		  // Move centre of mass.
		  Var oldCenter As VMaths.Vector2 = VMaths.Vector2.Copy(Sweep.C)
		  Sweep.LocalCenter.SetFrom(localCenter)
		  Sweep.C0.SetFrom(Transform.MulVec2(Transform, Sweep.LocalCenter))
		  Sweep.C.SetFrom(Sweep.C0)
		  
		  // Update centre of mass velocity.
		  temp.SetFrom(Sweep.C)
		  temp.Subtract(oldCenter)
		  
		  Var temp2 As VMaths.Vector2 = oldCenter
		  temp.ScaleOrthogonalInto(mAngularVelocity, temp2)
		  LinearVelocity.Add(temp2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742074686520616374697665207374617465206F662074686520626F64792E20416E20696E61637469766520626F6479206973206E6F742073696D756C6174656420616E642063616E6E6F7420626520636F6C6C696465642077697468206F7220776F6B656E2075702E
		Sub SetActive(flag As Boolean)
		  /// Set the active state of the body. An inactive body is not simulated and
		  /// cannot be collided with or woken up. 
		  ///
		  /// `If flag = True`, all fixtures will be added to the broad-phase. 
		  /// If `flag = False`, all fixtures will be removed from the broad-phase and 
		  /// all contacts will be destroyed. 
		  /// Fixtures and joints are otherwise unaffected. You may continue
		  /// to create/destroy fixtures and joints on inactive bodies. Fixtures on an
		  /// inactive body are implicitly inactive and will not participate in
		  /// collisions, ray-casts, or queries. Joints connected to an inactive body
		  /// are implicitly inactive. An inactive body is still owned by a `World` object
		  /// and remains in the body list.
		  
		  #If DebugBuild
		    Assert(Not World.IsLocked, "The world is locked.")
		  #EndIf
		  
		  If flag = IsActive Then
		    Return
		  End If
		  
		  If flag Then
		    Flags = Flags Or ActiveFlag
		    
		    // Create all proxies.
		    Var broadPhase As Physics.Broadphase = World.ContactManager.BroadPhase
		    For Each f As Physics.Fixture In Fixtures
		      f.CreateProxies(broadPhase, Transform)
		    Next f
		    
		    // Contacts are created the next time step.
		  Else
		    Flags = Flags And OnesComplement(ActiveFlag)
		    
		    // Destroy all proxies.
		    Var broadPhase As Physics.Broadphase = World.ContactManager.BroadPhase
		    For Each f As Physics.Fixture In Fixtures
		      f.DestroyProxies(broadPhase)
		    Next f
		    
		    // Destroy the attached contacts.
		    While Contacts.Count > 0
		      World.ContactManager.Destroy(Contacts(0))
		    Wend
		    Contacts.ResizeTo(-1)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742074686520736C656570207374617465206F662074686520626F64792E204120736C656570696E6720626F6479206861732076657279206C6F772043505520636F73742E
		Sub SetAwake(awaken As Boolean)
		  /// Set the sleep state of the body. A sleeping body has very low CPU cost.
		  
		  If awaken Then
		    If (Flags And AwakeFlag) = 0 Then
		      Flags = Flags Or AwakeFlag
		      SleepTime = 0.0
		    End If
		  Else
		    Flags = Flags And OnesComplement(AwakeFlag)
		    SleepTime = 0.0
		    LinearVelocity.SetZero
		    mAngularVelocity = 0.0
		    Force.SetZero
		    mTorque = 0.0
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57686574686572207468697320626F64792073686F756C642062652074726561746564206C696B6520612062756C6C657420666F7220636F6E74696E756F757320636F6C6C6973696F6E20646574656374696F6E2E
		Sub SetBullet(flag As Boolean)
		  /// Whether this body should be treated like a bullet for continuous collision
		  /// detection.
		  
		  If flag Then
		    Flags = Flags Or BulletFlag
		  Else
		    Flags = Flags And OnesComplement(BulletFlag)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574207468697320626F647920746F206861766520666978656420726F746174696F6E2E20546869732063617573657320746865206D61737320746F2062652072657365742E
		Sub SetFixedRotation(flag As Boolean)
		  /// Set this body to have fixed rotation. This causes the mass to be reset.
		  
		  If flag Then
		    Flags = Flags Or FixedRotationFlag
		  Else
		    Flags = Flags And OnesComplement(FixedRotationFlag)
		  End If
		  
		  ResetMassData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657420746865206D6173732070726F7065727469657320746F206F7665727269646520746865206D6173732070726F70657274696573206F66207468652066697874757265732E
		Sub SetMassData(massData As Physics.MassData)
		  /// Set the mass properties to override the mass properties of the fixtures.
		  ///
		  /// Note that this changes the centre of mass position.
		  /// Note that creating or destroying fixtures can also alter the mass.
		  /// This function has no effect if the body isn't dynamic.
		  
		  #If DebugBuild
		    Assert(Not World.IsLocked, "The world is locked.")
		  #EndIf
		  
		  If mBodyType <> Physics.BodyType.dynamic Then
		    Return
		  End If
		  
		  mInverseMass = 0.0
		  Inertia = 0.0
		  InverseInertia = 0.0
		  
		  mMass = massData.Mass
		  If mMass <= 0.0 Then
		    mMass = 1.0
		  End If
		  
		  mInverseMass = 1.0 / mMass
		  
		  If massData.I > 0.0 And (Flags And FixedRotationFlag) = 0.0 Then
		    Inertia = massData.I - mMass * massData.Center.Dot(massData.Center)
		    #If DebugBuild
		      Assert(Inertia > 0.0)
		    #EndIf
		    InverseInertia = 1.0 / Inertia
		  End If
		  
		  // Move centre of mass.
		  Var oldCenter As Vmaths.Vector2 = VMaths.Vector2.Copy(Sweep.C)
		  Sweep.LocalCenter.SetFrom(massData.Center)
		  Sweep.C0.SetFrom(Transform.MulVec2(Transform, Sweep.LocalCenter))
		  Sweep.C.SetFrom(Sweep.C0)
		  
		  // Update centre of mass velocity.
		  Var temp As VMaths.Vector2 = VMaths.Vector2.Copy(Sweep.C)
		  temp.Subtract(oldCenter)
		  temp.ScaleOrthogonalInto(mAngularVelocity, temp)
		  LinearVelocity.Add(temp)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 596F752063616E2064697361626C6520736C656570696E67206F6E207468697320626F64792E20496620796F752064697361626C6520736C656570696E672C2074686520626F64792077696C6C20626520776F6B656E2E
		Sub SetSleepingAllowed(flag As Boolean)
		  /// You can disable sleeping on this body. If you disable sleeping, the body
		  /// will be woken.
		  
		  If flag Then
		    Flags = Flags Or AutoSleepFlag
		  Else
		    Flags = Flags And OnesComplement(AutoSleepFlag)
		    SetAwake(True)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742074686520706F736974696F6E206F662074686520626F64792773206F726967696E20616E6420726F746174696F6E2E205468697320627265616B7320616E7920636F6E746163747320616E642077616B657320746865206F7468657220626F646965732E
		Sub SetTransform(position As VMaths.Vector2, angle As Double)
		  /// Set the position of the body's origin and rotation. This breaks any contacts and 
		  /// wakes the other bodies. 
		  ///
		  /// Manipulating a body's transform may cause non-physical behavior.
		  ///
		  /// Note: contacts are updated on the next call to `World.Step()`.
		  
		  #If DebugBuild
		    Assert(Not World.IsLocked, "The world is locked.")
		  #EndIf
		  
		  Transform.Q.SetAngle(angle)
		  Transform.P.SetFrom(position)
		  
		  Sweep.C.SetFrom(Transform.MulVec2(Transform, Sweep.LocalCenter))
		  Sweep.A = angle
		  
		  Sweep.C0.SetFrom(Sweep.C)
		  Sweep.A0 = Sweep.A
		  
		  Var broadPhase As Physics.Broadphase = World.ContactManager.BroadPhase
		  For Each f As Physics.Fixture In Fixtures
		    f.synchronize(broadPhase, Transform, Transform)
		  Next f
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574207468652074797065206F66207468697320626F64792E2054686973206D617920616C74657220746865206D61737320616E642076656C6F636974792E2E
		Sub SetType(type As Physics.BodyType)
		  /// Set the type of this body. This may alter the mass and velocity..
		  
		  #If DebugBuild
		    Assert(Not World.IsLocked, "The world is locked.")
		  #EndIf
		  
		  If mBodyType = type Then Return
		  
		  mBodyType = type
		  
		  ResetMassData
		  
		  If mBodyType = Physics.BodyType.Static_ Then
		    LinearVelocity.SetZero
		    mAngularVelocity = 0.0
		    Sweep.A0 = Sweep.A
		    Sweep.C0.SetFrom(Sweep.C)
		    SynchronizeFixtures
		  End If
		  
		  SetAwake(True)
		  
		  Force.SetZero
		  mTorque = 0.0
		  
		  // Delete the attached contacts.
		  While Contacts.Count > 0
		    World.ContactManager.Destroy(Contacts(0))
		  Wend
		  Contacts.ResizeTo(-1)
		  
		  // Touch the proxies so that new contacts will be created (when appropriate).
		  Var broadPhase As Physics.Broadphase = World.ContactManager.BroadPhase
		  For Each f As Physics.Fixture In Fixtures
		    Var proxyCount As Integer = f.ProxyCount
		    Var iLimit As Integer = proxyCount - 1
		    For i As Integer = 0 To iLimit
		      broadPhase.TouchProxy(f.Proxies(i).ProxyId)
		    Next i
		  Next f
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206973207573656420746F2070726576656E7420636F6E6E656374656420626F646965732066726F6D20636F6C6C6964696E672E204974206D6179206C69652C20646570656E64696E67206F6E207468652060436F6C6C696465436F6E6E65637465646020666C61672E
		Function ShouldCollide(other As Physics.Body) As Boolean
		  /// This is used to prevent connected bodies from colliding. It may lie,
		  /// depending on the `CollideConnected` flag.
		  
		  // At least one body should be dynamic.
		  If mBodyType <> Physics.BodyType.Dynamic And _
		    other.BodyType <> Physics.BodyType.Dynamic Then
		    Return False
		  End If
		  
		  // Does a joint prevent collision?
		  For Each joint As Physics.Joint In Joints
		    If joint.ContainsBody(other) And Not joint.CollideConnected Then
		      Return False
		    End If
		  Next joint
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SynchronizeFixtures()
		  Var xf1 As Physics.Transform = mPXF
		  xf1.Q.Sin = Sin(Sweep.A0)
		  xf1.Q.Cos = Cos(Sweep.A0)
		  xf1.P.X = Sweep.C0.X - _
		  xf1.Q.Cos * Sweep.LocalCenter.X + _
		  xf1.Q.Sin * Sweep.LocalCenter.Y
		  xf1.P.Y = Sweep.C0.Y - _
		  xf1.Q.Sin * Sweep.LocalCenter.X - _
		  xf1.Q.Cos * Sweep.LocalCenter.Y
		  
		  For Each f As Physics.Fixture In Fixtures
		    f.Synchronize(World.ContactManager.BroadPhase, xf1, Transform)
		  Next f
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SynchronizeTransform()
		  Transform.Q.Sin = Sin(Sweep.A)
		  Transform.Q.Cos = Cos(Sweep.A)
		  Var q As Physics.Rot = Transform.Q
		  Var v As VMaths.Vector2 = Sweep.LocalCenter
		  Transform.P.X = Sweep.C.X - q.Cos * v.X + q.Sin * v.Y
		  Transform.P.Y = Sweep.C.Y - q.Sin * v.X - q.Cos * v.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return "Body[" + _
		  "Pos: " + Position.ToString + " " + _
		  "LinVel: " + LinearVelocity.ToString + " " + _
		  "AngVel: " + AngularVelocity.ToString + "]"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520776F726C6420636F6F7264696E61746573206F66206120706F696E7420676976656E20746865206C6F63616C20636F6F7264696E617465732E
		Function WorldPoint(localPoint As VMaths.Vector2) As VMaths.Vector2
		  /// Get the world coordinates of a point given the local coordinates.
		  ///
		  /// `localPoint` is a point on the body measured relative the the body's origin.
		  
		  Return Transform.MulVec2(Transform, localPoint)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520776F726C6420636F6F7264696E61746573206F66206120766563746F7220676976656E20746865206C6F63616C20636F6F7264696E617465732E
		Function WorldVector(localVector As VMaths.Vector2) As VMaths.Vector2
		  /// Get the world coordinates of a vector given the local coordinates.
		  ///
		  /// `localVector` is a vector fixed in the body.
		  
		  Return Physics.Rot.MulVec2(Transform.Q, localVector)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A rigid body. These are created via `World.CreateBody()`.
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 476574207468652063757272656E7420776F726C6420726F746174696F6E20616E676C6520696E2072616469616E732E
		#tag Getter
			Get
			  Return Sweep.A
			  
			End Get
		#tag EndGetter
		Angle As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 416E67756C61722064616D70696E672069732075736520746F207265647563652074686520616E67756C61722076656C6F636974792E205468652064616D70696E6720706172616D657465722063616E206265203E203120627574207468652064616D70696E6720656666656374206265636F6D65732073656E73697469766520746F207468652074696D652073746570207768656E207468652064616D70696E6720706172616D65746572206973206C617267652E
		AngularDamping As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520616E67756C61722076656C6F6369747920696E2072616469616E732F7365636F6E642E
		#tag Getter
			Get
			  Return mAngularVelocity
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // `value` is the new angular velocity in radians/second.
			  
			  If mBodyType = Physics.BodyType.Static_ Then
			    Return
			  End If
			  
			  If value * value > 0.0 Then
			    SetAwake(True)
			  End If
			  
			  mAngularVelocity = value
			  
			End Set
		#tag EndSetter
		AngularVelocity As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5374617469632C206B696E656D617469632C206F722064796E616D69632E204E6F74653A20412060426F6479547970652E44796E616D69636020626F64792077697468207A65726F206D6173732C2077696C6C20686176652061206D617373206F66206F6E652E
		#tag Getter
			Get
			  Return mBodyType
			  
			End Get
		#tag EndGetter
		BodyType As Physics.BodyType
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Contacts() As Physics.Contact
	#tag EndProperty

	#tag Property, Flags = &h0
		Fixtures() As Physics.Fixture
	#tag EndProperty

	#tag Property, Flags = &h0
		Flags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 446F206E6F74206D6F64696679206469726563746C792E
		Force As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4368616E67657320686F772074686520776F726C642074726561747320746865206772617669747920666F72207468697320626F64792E
		GravityOverride As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D756C7469706C69657220666F722074686520626F6479277320677261766974792E2049662060477261766974794F7665727269646560206973207370656369666965642C20746869732076616C756520616C736F20616666656374732069742E
		GravityScale As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526F746174696F6E616C20696E65727469612061626F7574207468652063656E747265206F66206D6173732E
		Inertia As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526F746174696F6E616C20696E65727469612061626F7574207468652063656E747265206F66206D6173732E
		InverseInertia As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mInverseMass
			  
			End Get
		#tag EndGetter
		InverseMass As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 576865746865722074686520626F647920697320616374697665206F72206E6F742E
		#tag Getter
			Get
			  Return (Flags And ActiveFlag) = ActiveFlag
			  
			End Get
		#tag EndGetter
		IsActive As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 576865746865722074686520626F6479206973206177616B65206F7220736C656570696E672E
		#tag Getter
			Get
			  Return (Flags And AwakeFlag) = AwakeFlag
			  
			End Get
		#tag EndGetter
		IsAwake As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		IslandIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Joints() As Physics.Joint
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4C696E6561722064616D70696E672069732075736520746F2072656475636520746865206C696E6561722076656C6F636974792E205468652064616D70696E6720706172616D657465722063616E206265203E203120627574207468652064616D70696E6720656666656374206265636F6D65732073656E73697469766520746F207468652074696D652073746570207768656E207468652064616D70696E6720706172616D65746572206973206C617267652E
		LinearDamping As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E6561722076656C6F63697479206F66207468652063656E747265206F66206D6173732E20446F206E6F74206D6F64696679206469726563746C792C20696E73746561642075736520604170706C794C696E656172496D70756C736560206F7220604170706C79466F726365602E
		#tag Getter
			Get
			  Return mLinearVelocity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mBodyType = Physics.BodyType.Static_ Then
			    Return
			  End If
			  
			  If value.Dot(value) > 0.0 Then
			    SetAwake(True)
			  End If
			  
			  mLinearVelocity.SetFrom(value)
			  
			End Set
		#tag EndSetter
		LinearVelocity As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520616E67756C61722076656C6F6369747920696E2072616469616E732F7365636F6E642E
		mAngularVelocity As Double = 0.0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520746F74616C206D617373206F662074686520626F64792C20757375616C6C7920696E206B696C6F6772616D7320286B67292E
		#tag Getter
			Get
			  Return mMass
			  
			End Get
		#tag EndGetter
		Mass As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBodyType As Physics.BodyType = Physics.BodyType.Static_
	#tag EndProperty

	#tag Property, Flags = &h0
		mInverseMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E6561722076656C6F63697479206F66207468652063656E747265206F66206D6173732E20446F206E6F74206D6F64696679206469726563746C792C20696E73746561642075736520604170706C794C696E656172496D70756C736560206F7220604170706C79466F726365602E
		Private mLinearVelocity As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		mMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPMD As Physics.MassData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPXF As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 446F206E6F74206D6F64696679206469726563746C792E
		mTorque As Double = 0.0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4765742074686520776F726C6420626F6479206F726967696E20706F736974696F6E2E
		#tag Getter
			Get
			  Return Transform.P
			  
			End Get
		#tag EndGetter
		Position As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652070726576696F7573207472616E73666F726D20666F72207061727469636C652073696D756C6174696F6E2E
		PreviousTransform As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		SleepTime As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207377657074206D6F74696F6E20666F72204343442E
		Sweep As Physics.Sweep
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mTorque
			  
			End Get
		#tag EndGetter
		Torque As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520626F6479206F726967696E207472616E73666F726D2E
		Transform As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557365207468697320746F2073746F726520796F7572206170706C69636174696F6E20737065636966696320646174612E
		UserData As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4765742074686520776F726C6420706F736974696F6E206F66207468652063656E747265206F66206D6173732E20446F206E6F74206D6F646966792E
		#tag Getter
			Get
			  Return Sweep.C
			  
			End Get
		#tag EndGetter
		WorldCenter As VMaths.Vector2
	#tag EndComputedProperty


	#tag Constant, Name = ActiveFlag, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AutoSleepFlag, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AwakeFlag, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BulletFlag, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FixedRotationFlag, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IslandFlag, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TOIFlag, Type = Double, Dynamic = False, Default = \"&h0040", Scope = Public
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
		#tag ViewProperty
			Name="Angle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SleepTime"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AngularDamping"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LinearDamping"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InverseInertia"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Inertia"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InverseMass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mInverseMass"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mMass"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Torque"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mTorque"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AngularVelocity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mAngularVelocity"
			Visible=false
			Group="Behavior"
			InitialValue="0.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IslandIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Flags"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BodyType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Physics.BodyType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Static_"
				"1 - Kinematic"
				"2 - Dynamic"
			#tag EndEnumValues
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
			Name="IsAwake"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

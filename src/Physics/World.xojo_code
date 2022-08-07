#tag Class
Protected Class World
	#tag Method, Flags = &h0
		Sub ClearForces()
		  /// Call this after you are done with time steps to clear the forces. You
		  /// normally call this after each call to `StepDt()`, unless you are performing
		  /// sub-steps.
		  /// By default, forces will be automatically cleared, so you don't need to
		  /// call this function.
		  
		  For Each b As Physics.Body In Bodies
		    b.ClearForces
		  Next b
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(gravity As VMaths.Vector2 = Nil, broadphase As Physics.Broadphase = Nil)
		  If gravity = Nil Then
		    mGravity = VMaths.Vector2.Zero
		  Else
		    mGravity = gravity
		  End If
		  
		  If broadphase = Nil Then
		    broadphase = New Physics.DefaultBroadphaseBuffer(New Physics.DynamicTree)
		  End If
		  
		  mWarmStarting = True
		  mContinuousPhysics = True
		  mSubStepping = False
		  mStepComplete = True
		  
		  mAllowSleep = True
		  
		  flags = ClearForcesBit
		  
		  mInvDt0 = 0.0
		  
		  ContactManager = New Physics.ContactManager(broadPhase)
		  mProfile = New Physics.Profile
		  
		  ParticleSystem = New Physics.ParticleSystem(Self)
		  
		  mStep = New Physics.TimeStep
		  mStepTimer = New Physics.Timer
		  mTempTimer = New Physics.Timer
		  
		  Colour = Physics.Color3i.Zero
		  Xf = Physics.Transform.Zero
		  CA = VMaths.Vector2.Zero
		  CB = VMaths.Vector2.Zero
		  
		  mWorldQueryWrapper = New Physics.WorldQueryWrapper
		  
		  mRaycastWrapper = New Physics.WorldRayCastWrapper
		  mInput = New Physics.RaycastInput
		  
		  Island = New Physics.Island
		  BroadphaseTimer = New Physics.Timer
		  
		  mToiIsland = New Physics.Island
		  mToiInput = New Physics.TOIInput
		  mToiOutput = New Physics.TOIOutput
		  mSubStep = New Physics.TimeStep
		  mBackup1 = New Physics.Sweep
		  mBackup2 = New Physics.Sweep
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465206120726967696420626F647920676976656E206120646566696E6974696F6E2E204E6F207265666572656E636520746F2074686520646566696E6974696F6E2069732072657461696E65642E
		Function CreateBody(def As Physics.BodyDef) As Physics.Body
		  /// Create a rigid body given a definition. No reference to the definition is
		  /// retained.
		  ///
		  /// Warning: This function is locked during callbacks.
		  
		  #If DebugBuild
		    Assert(Not IsLocked)
		  #EndIf
		  
		  Var body As New Physics.Body(def, Self)
		  
		  Bodies.Add(body)
		  
		  Return body
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732061206A6F696E7420746F20636F6E73747261696E20626F6469657320746F6765746865722E
		Sub CreateJoint(joint As Physics.Joint)
		  /// Adds a joint to constrain bodies together.
		  ///
		  /// This may cause the connected bodies to cease colliding.
		  ///
		  /// Adding a joint doesn't wake up the bodies.
		  ///
		  /// Warning: This function is locked during callbacks.
		  
		  #If DebugBuild
		    Assert(Not IsLocked)
		  #EndIf
		  
		  joints.Add(joint)
		  
		  Var bodyA As Physics.Body = joint.BodyA
		  Var bodyB As Physics.Body = joint.BodyB
		  bodyA.Joints.Add(joint)
		  bodyB.Joints.Add(joint)
		  
		  // If the joint prevents collisions, then flag any contacts for filtering.
		  If Not joint.CollideConnected Then
		    For Each contact As Physics.Contact In bodyB.Contacts
		      If contact.GetOtherBody(bodyB) = bodyA Then
		        // Flag the contact for filtering at the next time step (where either
		        // body is awake).
		        contact.FlagForFiltering
		      End If
		    Next contact
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657374726F7973206120726967696420626F647920676976656E206120646566696E6974696F6E2E204E6F207265666572656E636520746F2074686520646566696E6974696F6E2069732072657461696E65642E20546869732066756E6374696F6E206973206C6F636B656420647572696E672063616C6C6261636B732E
		Sub DestroyBody(body As Physics.Body)
		  /// Destroys a rigid body given a definition. No reference to the definition
		  /// is retained. This function is locked during callbacks.
		  ///
		  /// Warning: This automatically deletes all associated shapes and joints.
		  /// Warning: This function is locked during callbacks.
		  
		  #If DebugBuild
		    Assert(Bodies.Count > 0)
		    assert(Not IsLocked)
		  #EndIf
		  
		  // Delete the attached joints.
		  While body.Joints.Count > 0
		    Var joint As Physics.Joint = body.Joints(0)
		    If DestroyListener <> Nil Then
		      DestroyListener.OnDestroyJoint(joint)
		    End If
		    DestroyJoint(joint)
		  Wend
		  
		  // Delete the attached contacts.
		  While body.Contacts.Count > 0
		    ContactManager.Destroy(body.Contacts(0))
		  Wend
		  body.Contacts.ResizeTo(-1)
		  
		  For Each f As Physics.Fixture In body.Fixtures
		    If DestroyListener <> Nil Then
		      DestroyListener.OnDestroyFixture(f)
		    End If
		    f.DestroyProxies(ContactManager.Broadphase)
		  Next f
		  
		  Bodies.Remove(body)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657374726F79732061206A6F696E742E2054686973206D61792063617573652074686520636F6E6E656374656420626F6469657320746F20626567696E20636F6C6C6964696E672E
		Sub DestroyJoint(joint As Physics.Joint)
		  /// Destroys a joint. This may cause the connected bodies to begin colliding.
		  ///
		  /// Warning: This function is locked during callbacks.
		  
		  #If DebugBuild
		    Assert(Not IsLocked)
		  #EndIf
		  
		  Var collideConnected As Boolean = joint.CollideConnected
		  joints.Remove(joint)
		  
		  // Disconnect from island graph.
		  Var bodyA As Physics.Body = joint.BodyA
		  Var bodyB As Physics.Body = joint.BodyB
		  
		  // Wake up connected bodies.
		  bodyA.SetAwake(True)
		  bodyB.SetAwake(True)
		  
		  bodyA.Joints.Remove(joint)
		  bodyB.Joints.Remove(joint)
		  
		  Joint.Destroy(joint)
		  
		  // If the joint prevents collisions, then flag any contacts for filtering.
		  If Not collideConnected Then
		    For Each contact As Physics.Contact In bodyB.Contacts
		      If contact.GetOtherBody(bodyB) = bodyA Then
		        // Flag the contact for filtering at the next time step (where either
		        // body is awake).
		        contact.FlagForFiltering
		      End If
		    Next contact
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C207468697320746F20647261772073686170657320616E64206F74686572206465627567206472617720646174612E
		Sub DrawDebugData()
		  /// Call this to draw shapes and other debug draw data.
		  
		  If debugDraw = Nil Then
		    Return
		  End If
		  
		  DebugDraw.BeginDrawing
		  
		  Var flags As Integer = DebugDraw.DrawFlags
		  Var wireframe As Boolean = (flags And Physics.DebugDrawWireFrameDrawingBit) <> 0
		  
		  If (flags And Physics.DebugDrawShapeBit) <> 0 Then
		    For Each body As Physics.Body In Bodies
		      Xf.Set(body.Transform)
		      For Each fixture As Physics.Fixture In body.Fixtures
		        If Not body.IsActive Then
		          Colour.SetFromRGBd(0.5, 0.5, 0.3)
		          fixture.Render(DebugDraw, Xf, Colour, wireframe)
		          
		        ElseIf body.BodyType = Physics.BodyType.Static_ Then
		          Colour.SetFromRGBd(0.5, 0.9, 0.3)
		          fixture.Render(DebugDraw, Xf, Colour, wireframe)
		          
		        ElseIf body.BodyType = Physics.BodyType.Kinematic Then
		          Colour.SetFromRGBd(0.5, 0.5, 0.9)
		          fixture.Render(DebugDraw, Xf, Colour, wireframe)
		          
		        ElseIf Not body.IsAwake Then
		          Colour.SetFromRGBd(0.5, 0.5, 0.5)
		          fixture.Render(DebugDraw, Xf, Colour, wireframe)
		          
		        Else
		          Colour.SetFromRGBd(0.9, 0.7, 0.7)
		          fixture.Render(DebugDraw, Xf, Colour, wireframe)
		        End If
		      Next fixture
		    Next body
		    particleSystem.Render(DebugDraw)
		  End If
		  
		  If (flags And Physics.DebugDrawJointBit) <> 0 Then
		    For Each j As Physics.Joint In Joints
		      j.Render(DebugDraw)
		    Next j
		  End If
		  
		  If (flags And Physics.DebugDrawPairBit) <> 0 Then
		    Colour.SetFromRGBd(0.3, 0.9, 0.9)
		    For Each c As Physics.Contact In ContactManager.Contacts
		      Var fixtureA As Physics.Fixture = c.FixtureA
		      Var fixtureB As Physics.Fixture = c.FixtureB
		      CA.SetFrom(fixtureA.GetAABB(c.IndexA).Center)
		      CB.SetFrom(fixtureB.GetAABB(c.IndexB).Center)
		      DebugDraw.DrawSegment(CA, CB, Colour)
		    Next c
		  End If
		  
		  If (flags And Physics.DebugDrawAABBBit) <> 0 Then 
		    Colour.SetFromRGBd(0.9, 0.3, 0.9)
		    
		    For Each b As Physics.Body In Bodies
		      If b.IsActive = False Then
		        Continue
		      End If
		      
		      For Each f As Physics.Fixture In b.Fixtures
		        Var iLimit As Integer = f.ProxyCount - 1
		        For i As Integer = 0 To iLimit
		          Var proxy As Physics.FixtureProxy = f.Proxies(i)
		          Var aabb As Physics.AABB = ContactManager.Broadphase.FatAABB(proxy.ProxyId)
		          Var vs() As VMaths.Vector2 = Array( _
		          New VMaths.Vector2(aabb.LowerBound.X, aabb.LowerBound.Y), _
		          New VMaths.Vector2(aabb.UpperBound.X, aabb.LowerBound.Y), _
		          New VMaths.Vector2(aabb.UpperBound.X, aabb.UpperBound.Y), _
		          New VMaths.Vector2(aabb.LowerBound.X, aabb.UpperBound.Y))
		          DebugDraw.DrawPolygon(vs, Colour)
		        Next i
		      Next f
		    Next b
		  End If
		  
		  If (flags And Physics.DebugDrawCenterOfMassBit) <> 0 Then
		    Var xfColor As New Physics.Color3i(255, 0, 0)
		    For Each b As Physics.Body In Bodies
		      Xf.Set(b.Transform)
		      Xf.P.SetFrom(b.WorldCenter)
		      DebugDraw.DrawTransform(Xf, xfColor)
		    Next b
		  End If
		  
		  If (flags And Physics.DebugDrawDynamicTreeBit) <> 0 Then
		    ContactManager.Broadphase.DrawTree(DebugDraw)
		  End If
		  
		  DebugDraw.EndDrawing
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657473207468652062616C616E6365206F66207468652064796E616D696320747265652E
		Function GetTreeBalance() As Integer
		  /// Gets the balance of the dynamic tree.
		  
		  Return ContactManager.Broadphase.GetTreeBalance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574732074686520686569676874206F66207468652064796E616D696320747265652E
		Function GetTreeHeight() As Integer
		  /// Gets the height of the dynamic tree.
		  
		  Return ContactManager.Broadphase.GetTreeHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765747320746865207175616C697479206F66207468652064796E616D696320747265652E
		Function GetTreeQuality() As Double
		  /// Gets the quality of the dynamic tree.
		  
		  Return ContactManager.Broadphase.GetTreeQuality
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAllowSleep() As Boolean
		  Return mAllowSleep
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSubStepping() As Boolean
		  Return mSubStepping
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 51756572792074686520776F726C6420666F7220616C6C206669787475726573207468617420706F74656E7469616C6C79206F7665726C6170207468652070726F766964656420414142422E
		Sub QueryAABB(callback As Physics.QueryCallback, aabb As Physics.AABB)
		  /// Query the world for all fixtures that potentially overlap the provided
		  /// AABB.
		  
		  mWorldQueryWrapper.BroadPhase = ContactManager.Broadphase
		  mWorldQueryWrapper.Callback = callback
		  ContactManager.Broadphase.Query(mWorldQueryWrapper, aabb)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 51756572792074686520776F726C6420666F7220616C6C207061727469636C6573207468617420706F74656E7469616C6C79206F7665726C6170207468652070726F766964656420414142422E
		Sub QueryAABBParticle(particleCallback As Physics.ParticleQueryCallback, aabb As Physics.AABB)
		  /// Query the world for all particles that potentially overlap the provided
		  /// AABB.
		  
		  ParticleSystem.QueryAABB(particleCallback, aabb)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 51756572792074686520776F726C6420666F7220616C6C20666978747572657320616E64207061727469636C6573207468617420706F74656E7469616C6C79206F7665726C6170207468652070726F766964656420414142422E
		Sub QueryAABBTwoCallbacks(callback As Physics.QueryCallback, particleCallback As Physics.ParticleQueryCallback, aabb As Physics.AABB)
		  /// Query the world for all fixtures and particles that potentially overlap
		  /// the provided AABB.
		  
		  mWorldQueryWrapper.BroadPhase = ContactManager.Broadphase
		  mWorldQueryWrapper.Callback = callback
		  ContactManager.Broadphase.Query(mWorldQueryWrapper, aabb)
		  ParticleSystem.QueryAABB(particleCallback, aabb)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5261792D636173742074686520776F726C6420666F7220616C6C20666978747572657320696E207468652070617468206F6620746865207261792E20596F75722063616C6C6261636B20636F6E74726F6C73207768657468657220796F75206765742074686520636C6F7365737420706F696E742C20616E7920706F696E742C206F72206E2D706F696E74732E20546865207261792D636173742069676E6F72657320736861706573207468617420636F6E7461696E20746865207374617274696E6720706F696E742E
		Sub Raycast(callback As Physics.RaycastCallback, point1 As VMaths.Vector2, point2 As VMaths.Vector2)
		  /// Ray-cast the world for all fixtures in the path of the ray. Your callback
		  /// controls whether you get the closest point, any point, or n-points.
		  /// The ray-cast ignores shapes that contain the starting point.
		  ///
		  /// `point1` is the ray's starting point.
		  /// `point2` is the ray's ending point.
		  
		  mRaycastWrapper.BroadPhase = ContactManager.Broadphase
		  mRaycastWrapper.Callback = callback
		  mInput.MaxFraction = 1.0
		  mInput.P1.SetFrom(point1)
		  mInput.P2.SetFrom(point2)
		  ContactManager.Broadphase.Raycast(mRaycastWrapper, mInput)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5261792D636173742074686520776F726C6420666F7220616C6C207061727469636C657320696E207468652070617468206F6620746865207261792E20596F75722063616C6C6261636B20636F6E74726F6C73207768657468657220796F75206765742074686520636C6F7365737420706F696E742C20616E7920706F696E742C206F72206E2D706F696E74732E
		Sub RaycastParticle(particleCallback As Physics.ParticleRaycastCallback, point1 As VMaths.Vector2, point2 As VMaths.Vector2)
		  /// Ray-cast the world for all particles in the path of the ray. Your callback
		  /// controls whether you get the closest point, any point, or n-points.
		  ///
		  /// `point1` is the ray's starting point.
		  /// `point2` is the ray's ending point.
		  
		  ParticleSystem.Raycast(particleCallback, point1, point2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5261792D636173742074686520776F726C6420666F7220616C6C20666978747572657320616E64207061727469636C657320696E207468652070617468206F6620746865207261792E20596F75722063616C6C6261636B20636F6E74726F6C73207768657468657220796F75206765742074686520636C6F7365737420706F696E742C20616E7920706F696E742C206F72206E2D706F696E74732E20546865207261792D636173742069676E6F72657320736861706573207468617420636F6E7461696E20746865207374617274696E6720706F696E742E
		Sub RaycastTwoCallBacks(callback As Physics.RaycastCallback, particleCallback As Physics.ParticleRaycastCallback, point1 As VMaths.Vector2, point2 As VMaths.Vector2)
		  /// Ray-cast the world for all fixtures and particles in the path of the ray.
		  /// Your callback controls whether you get the closest point, any point, or
		  /// n-points. The ray-cast ignores shapes that contain the starting point.
		  ///
		  /// `point1` is the ray's starting point.
		  /// `point2` is the ray's ending point.
		  
		  mRaycastWrapper.BroadPhase = ContactManager.Broadphase
		  mRaycastWrapper.Callback = callback
		  mInput.MaxFraction = 1.0
		  mInput.P1.SetFrom(point1)
		  mInput.P2.SetFrom(point2)
		  ContactManager.Broadphase.Raycast(mRaycastWrapper, mInput)
		  ParticleSystem.Raycast(particleCallback, point1, point2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetAllowSleep(flag As Boolean)
		  If flag = mAllowSleep Then Return
		  
		  mAllowSleep = flag
		  If Not mAllowSleep Then
		    For Each b As Physics.Body In Bodies
		      b.SetAwake(True)
		    Next b
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657420666C616720746F20636F6E74726F6C206175746F6D6174696320636C656172696E67206F6620666F7263657320616674657220656163682074696D6520737465702E
		Sub SetAutoClearForces(shouldAutoClear As Boolean)
		  /// Set flag to control automatic clearing of forces after each time step.
		  
		  If shouldAutoClear Then
		    Flags = Flags Or ClearForcesBit
		  Else
		    Flags = Flags And Bitwise.OnesComplement(ClearForcesBit)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265676973746572206120636F6E746163742066696C74657220746F2070726F7669646520737065636966696320636F6E74726F6C206F76657220636F6C6C6973696F6E2E204F7468657277697365207468652064656661756C742066696C74657220697320757365642028606D44656661756C7446696C74657260292E20546865206C697374656E6572206973206F776E656420627920796F7520616E64206D7573742072656D61696E20696E2073636F70652E
		Sub SetContactFilter(filter As Physics.ContactFilter)
		  /// Register a contact filter to provide specific control over collision.
		  /// Otherwise the default filter is used (`mDefaultFilter`).
		  /// The listener is owned by you and must remain in scope.
		  
		  ContactManager.ContactFilter = filter
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265676973746572206120636F6E74616374206576656E74206C697374656E65722E20546865206C697374656E6572206973206F776E656420627920796F7520616E64206D7573742072656D61696E20696E2073636F70652E
		Sub SetContactListener(listener As Physics.ContactListener)
		  /// Register a contact event listener. The listener is owned by you and must
		  /// remain in scope.
		  
		  ContactManager.ContactListener = listener
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4368616E67652074686520676C6F62616C206772617669747920766563746F722E
		Sub SetGravity(gravity As VMaths.Vector2)
		  /// Change the global gravity vector.
		  
		  mGravity.SetFrom(gravity)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetSubStepping(subStepping As Boolean)
		  mSubStepping = subStepping
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Solve(step_ As Physics.TimeStep)
		  mProfile.SolveInit.StartAccum
		  mProfile.SolveVelocity.StartAccum
		  mProfile.SolvePosition.StartAccum
		  
		  // Update previous transforms.
		  For Each b As Physics.Body In Bodies
		    b.PreviousTransform.Set(b.Transform)
		  Next b
		  
		  // Size the island for the worst case.
		  island.Init(ContactManager.ContactListener)
		  
		  // Clear all the island flags.
		  For Each b As Physics.Body In Bodies
		    b.Flags = b.Flags And Bitwise.OnesComplement(Physics.Body.IslandFlag)
		  Next b
		  
		  For Each c As Physics.Contact In ContactManager.Contacts
		    c.Flags = c.Flags And Bitwise.OnesComplement(Physics.Contact.IslandFlag)
		  Next c
		  
		  For Each j As Physics.Joint In Joints
		    j.IslandFlag = False
		  Next j
		  
		  For Each seed As Physics.Body In Bodies
		    If (seed.Flags And Physics.Body.IslandFlag) = Physics.Body.IslandFlag Then
		      Continue
		    End If
		    
		    If seed.IsAwake = False Or seed.IsActive = False Then
		      Continue
		    End If
		    
		    // The seed can be dynamic or kinematic.
		    If seed.BodyType = Physics.BodyType.Static_ Then
		      Continue
		    End If
		    
		    // Reset island and stack.
		    island.Clear
		    stack.ResizeTo(-1)
		    stack.Add(seed)
		    seed.Flags = seed.Flags Or Physics.Body.IslandFlag
		    
		    // Perform a depth first search (DFS) on the constraint graph.
		    While stack.Count > 0
		      // Grab the next body off the stack and add it to the island.
		      Var body As Physics.Body = stack.Pop
		      
		      #If DebugBuild
		        Assert(body.IsActive)
		      #EndIf
		      
		      island.AddBody(body)
		      
		      // Make sure the body is awake.
		      body.SetAwake(True)
		      
		      // To keep islands as small as possible, we don't
		      // propagate islands across static bodies.
		      If body.BodyType = Physics.BodyType.Static_ Then
		        Continue
		      End If
		      
		      // Search all contacts connected to this body.
		      For Each contact As Physics.Contact In body.Contacts
		        // Has this contact already been added to an island?
		        If (contact.Flags And Contact.IslandFlag) = Physics.Contact.IslandFlag Then
		          Continue
		        End If
		        
		        // Is this contact solid and touching?
		        If contact.IsEnabled = False Or contact.IsTouching = False Then
		          Continue
		        End If
		        
		        // Skip sensors.
		        Var sensorA As Boolean = contact.FixtureA.IsSensor
		        Var sensorB AS Boolean = contact.FixtureB.IsSensor
		        If sensorA Or sensorB Then
		          Continue
		        End If
		        
		        island.AddContact(contact)
		        contact.Flags = contact.Flags Or Physics.Contact.IslandFlag
		        
		        Var other As Physics.Body = contact.GetOtherBody(body)
		        
		        // Was the other body already added to this island?
		        If (other.Flags And Physics.Body.IslandFlag) = Physics.Body.IslandFlag Then
		          Continue
		        End If
		        
		        stack.Add(other)
		        other.Flags = other.Flags Or Physics.Body.islandFlag
		      Next contact
		      
		      // Search all joints connect to this body.
		      For Each joint As Physics.Joint In body.Joints
		        If joint.IslandFlag Then
		          Continue
		        End If
		        
		        Var other As Physics.Body = joint.OtherBody(body)
		        
		        // Don't simulate joints connected to inactive bodies.
		        If Not other.IsActive Then
		          Continue
		        End If
		        
		        island.AddJoint(joint)
		        joint.IslandFlag = True
		        
		        If (other.Flags And Physics.Body.IslandFlag) = Physics.Body.IslandFlag Then
		          Continue
		        End If
		        
		        stack.Add(other)
		        other.Flags = other.Flags Or Physics.Body.IslandFlag
		      Next joint
		    Wend
		    
		    island.Solve(mProfile, step_, mGravity, mAllowSleep)
		    
		    // Post solve clean up.
		    For Each bodyMeta As Physics.BodyMeta In island.Bodies
		      // Allow static bodies to participate in other islands.
		      Var b As Physics.Body = bodyMeta.Body
		      If b.BodyType = Physics.BodyType.Static_ Then
		        b.Flags = b.Flags And Bitwise.OnesComplement(Physics.Body.IslandFlag)
		      End If
		    Next bodyMeta
		  Next seed
		  
		  mProfile.SolveInit.endAccum
		  mProfile.SolveVelocity.endAccum
		  mProfile.SolvePosition.endAccum
		  
		  BroadphaseTimer.Reset
		  
		  // Synchronize fixtures, check for out of range bodies.
		  For Each b As Physics.Body In Bodies
		    // If a body was not in an island then it did not move.
		    If (b.Flags And Physics.Body.IslandFlag) = 0 Then
		      Continue
		    End If
		    
		    If b.BodyType = Physics.BodyType.Static_ Then
		      Continue
		    End If
		    
		    // Update fixtures (for broad-phase).
		    b.SynchronizeFixtures
		  Next b
		  
		  // Look for new contacts.
		  ContactManager.FindNewContacts
		  mProfile.Broadphase.Record(BroadphaseTimer.GetMilliseconds)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveTOI(step_ As Physics.TimeStep)
		  mToiIsland.Init(ContactManager.ContactListener)
		  Var island As Physics.Island = mToiIsland
		  
		  If mStepComplete Then
		    For Each b As Physics.Body In Bodies
		      b.Flags = b.Flags And Bitwise.OnesComplement(Physics.Body.IslandFlag)
		      b.Sweep.Alpha0 = 0.0
		    Next b
		    
		    For Each c As Physics.Contact In ContactManager.Contacts
		      // Invalidate TOI.
		      c.Flags = c.Flags And Bitwise.OnesComplement((Physics.Contact.TOIFlag Or Physics.Contact.IslandFlag))
		      c.TOICount = 0
		      c.TOI = 1.0
		    Next c
		  End If
		  
		  // Find TOI events and solve them.
		  Do
		    // Find the first TOI.
		    Var minContact As Physics.Contact
		    Var minAlpha As Double = 1.0
		    
		    For Each contact As Physics.Contact In ContactManager.Contacts
		      // Is this contact disabled?
		      If contact.IsEnabled = False Then
		        Continue
		      End If
		      
		      // Prevent excessive sub-stepping.
		      If contact.TOICount > Physics.Settings.MaxSubSteps Then
		        Continue
		      End If
		      
		      Var alpha As Double = 1.0
		      If (contact.Flags And Physics.Contact.TOIFlag) <> 0 Then
		        // This contact has a valid cached TOI.
		        alpha = contact.TOI
		      Else
		        Var fixtureA As Physics.Fixture = contact.FixtureA
		        Var fixtureB As Physics.Fixture = contact.FixtureB
		        
		        // Is there a sensor?
		        If fixtureA.IsSensor Or fixtureB.IsSensor Then
		          Continue
		        End If
		        
		        Var bodyA As Physics.Body = fixtureA.Body
		        Var bodyB As Physics.Body = fixtureB.Body
		        
		        Var typeA As Physics.BodyType = bodyA.BodyType
		        Var typeB As Physics.BodyType = bodyB.BodyType
		        
		        #If DebugBuild
		          Assert(typeA = Physics.BodyType.Dynamic Or typeB = Physics.BodyType.Dynamic)
		        #EndIf
		        
		        Var activeA As Boolean = bodyA.IsAwake And typeA <> Physics.BodyType.Static_
		        Var activeB As Boolean = bodyB.IsAwake And typeB <> Physics.BodyType.Static_
		        
		        // Is at least one body active (awake and dynamic or kinematic)?
		        If activeA = False And activeB = False Then
		          Continue
		        End If
		        
		        Var collideA As Boolean = bodyA.IsBullet Or typeA <> Physics.BodyType.Dynamic
		        Var collideB As Boolean = bodyB.isBullet Or typeB <> Physics.BodyType.Dynamic
		        
		        // Are these two non-bullet dynamic bodies?
		        If collideA = False And collideB = False Then
		          Continue
		        End If
		        
		        // Compute the TOI for this contact.
		        // Put the sweeps onto the same time interval.
		        Var alpha0 As Double = bodyA.Sweep.Alpha0
		        
		        If bodyA.Sweep.Alpha0 < bodyB.Sweep.Alpha0 Then
		          alpha0 = bodyB.Sweep.Alpha0
		          bodyA.Sweep.Advance(alpha0)
		        ElseIf bodyB.Sweep.Alpha0 < bodyA.Sweep.Alpha0 Then
		          alpha0 = bodyA.Sweep.Alpha0
		          bodyB.Sweep.Advance(alpha0)
		        End If
		        
		        #If DebugBuild
		          Assert(alpha0 < 1.0)
		        #EndIf
		        
		        Var indexA As Integer = contact.IndexA
		        Var indexB As Integer = contact.IndexB
		        
		        // Compute the time of impact in interval (0, minTOI).
		        Var input As Physics.TOIInput = mToiInput
		        input.ProxyA.Set(fixtureA.Shape, indexA)
		        input.ProxyB.Set(fixtureB.Shape, indexB)
		        Call input.SweepA.Set(bodyA.Sweep)
		        Call input.SweepB.Set(bodyB.Sweep)
		        input.TMax = 1.0
		        
		        toi.TimeOfImpact_(mToiOutput, input)
		        
		        // Beta is the fraction of the remaining portion of the .
		        Var beta As Double = mToiOutput.T
		        If mToiOutput.State = Physics.TOIOutputState.Touching Then
		          alpha = Min(alpha0 + (1.0 - alpha0) * beta, 1.0)
		        Else
		          alpha = 1.0
		        End If
		        
		        contact.TOI = alpha
		        contact.Flags = contact.Flags Or Physics.Contact.TOIFlag
		      End If
		      
		      If alpha < minAlpha Then
		        // This is the minimum TOI found so far.
		        minContact = contact
		        minAlpha = alpha
		      End If
		    Next contact
		    
		    If minContact = Nil Or 1.0 - 10.0 * Physics.Settings.Epsilon < minAlpha Then
		      // No more TOI events. Done!
		      mStepComplete = True
		      Exit
		    End If
		    
		    Var bodyA As Physics.Body = minContact.FixtureA.Body
		    Var bodyB As Physics.Body = minContact.FixtureB.Body
		    
		    Call mBackup1.Set(bodyA.Sweep)
		    Call mBackup2.Set(bodyB.Sweep)
		    
		    // Advance the bodies to the TOI.
		    bodyA.Advance(minAlpha)
		    bodyB.Advance(minAlpha)
		    
		    // The TOI contact likely has some new contact points.
		    minContact.Update(ContactManager.ContactListener)
		    minContact.Flags = minContact.Flags And Bitwise.OnesComplement(Physics.Contact.TOIFlag)
		    minContact.TOICount = minContact.TOICount + 1
		    
		    // Is the contact solid?
		    If minContact.IsEnabled = False Or minContact.IsTouching = False Then
		      // Restore the sweeps.
		      minContact.SetEnabled(False)
		      Call bodyA.Sweep.Set(mBackup1)
		      Call bodyB.Sweep.Set(mBackup2)
		      bodyA.SynchronizeTransform
		      bodyB.SynchronizeTransform
		      Continue
		    End If
		    
		    bodyA.SetAwake(True)
		    bodyB.SetAwake(True)
		    
		    // Build the island.
		    island.Clear
		    island.AddBody(bodyA)
		    island.AddBody(bodyB)
		    island.AddContact(minContact)
		    
		    bodyA.Flags = bodyA.Flags Or Physics.Body.IslandFlag
		    bodyB.Flags = bodyB.Flags Or Physics.Body.IslandFlag
		    minContact.Flags = minContact.Flags Or Physics.Contact.IslandFlag
		    
		    // Get contacts on bodyA and bodyB.
		    Var tmpBodies() As Physics.Body = Array(bodyA, bodyB)
		    For Each body As Physics.Body In tmpBodies
		      If body.BodyType = Physics.BodyType.Dynamic Then
		        For Each contact As Physics.Contact In body.Contacts
		          // Has this contact already been added to the island?
		          If (contact.Flags And Physics.Contact.IslandFlag) <> 0 Then
		            Continue
		          End If
		          
		          // Only add static, kinematic, or bullet bodies.
		          Var other As Physics.Body = contact.GetOtherBody(body)
		          If other.BodyType = Physics.BodyType.Dynamic And _
		            body.IsBullet = False And _
		            other.IsBullet = False Then
		            Continue
		          End If
		          
		          // Skip sensors.
		          Var sensorA As Boolean = contact.FixtureA.IsSensor
		          Var sensorB As Boolean = contact.FixtureB.IsSensor
		          If sensorA Or sensorB Then
		            Continue
		          End If
		          
		          // Tentatively advance the body to the TOI.
		          Call mBackup1.Set(other.Sweep)
		          If (other.Flags And Physics.Body.IslandFlag) = 0 Then
		            other.Advance(minAlpha)
		          End If
		          
		          // Update the contact points.
		          contact.Update(contactManager.ContactListener)
		          
		          // Was the contact disabled by the user?
		          If contact.IsEnabled = False Then
		            Call other.Sweep.Set(mBackup1)
		            other.SynchronizeTransform
		            Continue
		          End If
		          
		          // Are there contact points?
		          If contact.IsTouching = False Then
		            Call other.Sweep.Set(mBackup1)
		            other.SynchronizeTransform
		            Continue
		          End If
		          
		          // Add the contact to the island.
		          contact.Flags = contact.Flags Or Physics.Contact.IslandFlag
		          island.AddContact(contact)
		          
		          // Has the other body already been added to the island?
		          If (other.Flags And Physics.Body.IslandFlag) <> 0 Then
		            Continue
		          End If
		          
		          // Add the other body to the island.
		          other.Flags = other.Flags Or Physics.Body.IslandFlag
		          
		          If other.BodyType <> Physics.BodyType.Static_ Then
		            other.SetAwake(True)
		          End If
		          
		          island.AddBody(other)
		        Next contact
		      End If
		    Next body
		    
		    mSubStep.Dt = (1.0 - minAlpha) * step_.Dt
		    mSubStep.InvDt = 1.0 / mSubStep.Dt
		    mSubStep.DtRatio = 1.0
		    mSubStep.PositionIterations = 20
		    mSubStep.VelocityIterations = step_.VelocityIterations
		    mSubStep.WarmStarting = False
		    island.SolveTOI(mSubStep, bodyA.IslandIndex, bodyB.IslandIndex)
		    
		    // Reset island flags and synchronize broad-phase proxies.
		    For Each bodyMeta As Physics.BodyMeta In island.Bodies
		      Var body As Physics.Body = bodyMeta.Body
		      body.Flags = body.Flags And Bitwise.OnesComplement(Physics.Body.IslandFlag)
		      
		      If body.BodyType <> Physics.BodyType.Dynamic Then
		        Continue
		      End If
		      
		      body.SynchronizeFixtures
		      
		      // Invalidate all contact TOIs on this displaced body.
		      For Each contact As Physics.Contact In body.Contacts
		        contact.Flags = _
		        contact.Flags And Bitwise.OnesComplement((Physics.Contact.TOIFlag Or Physics.Contact.IslandFlag))
		      Next contact
		    Next bodyMeta
		    
		    // Commit fixture proxy movements to the broad-phase so that new contacts
		    // are created. Also, some contacts can be destroyed.
		    ContactManager.FindNewContacts
		    
		    If mSubStepping Then
		      mStepComplete = False
		      Exit
		    End If
		  Loop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54616B6520612074696D6520737465702E205468697320706572666F726D7320636F6C6C6973696F6E20646574656374696F6E2C20696E746567726174696F6E2C20616E6420636F6E73747261696E7420736F6C7574696F6E2E
		Sub StepDt(dt As Double)
		  /// Take a time step. This performs collision detection, integration, and
		  /// constraint solution.
		  ///
		  /// `dt` should be the amount of time (in seconds) that has passed since the
		  /// last step.
		  
		  mStepTimer.Reset
		  mTempTimer.Reset
		  
		  // If new fixtures were added, we need to find the new contacts.
		  If (flags And newFixture) = newFixture Then
		    ContactManager.FindNewContacts
		    Flags = Flags And Bitwise.OnesComplement(newFixture)
		  End If
		  
		  Flags = Flags Or Locked
		  
		  mStep.Dt = dt
		  mStep.VelocityIterations = Physics.Settings.VelocityIterations
		  mStep.PositionIterations = Physics.Settings.PositionIterations
		  If dt > 0.0 Then
		    mStep.InvDt = 1.0 / dt
		  Else
		    mStep.InvDt = 0.0
		  End If
		  
		  mStep.DtRatio = mInvDt0 * dt
		  
		  mStep.WarmStarting = mWarmStarting
		  mProfile.StepInit.Record(mTempTimer.GetMilliseconds)
		  
		  // Update contacts. This is where some contacts are destroyed.
		  mTempTimer.Reset
		  ContactManager.Collide
		  mProfile.Collide.Record(mTempTimer.GetMilliseconds)
		  
		  // Integrate velocities, solve velocity constraints, and integrate
		  // positions.
		  If mStepComplete And mStep.Dt > 0.0 Then
		    mTempTimer.Reset
		    ParticleSystem.Solve(mStep) // Particle Simulation.
		    mProfile.SolveParticleSystem.Record(mTempTimer.GetMilliseconds)
		    mTempTimer.Reset
		    Solve(mStep)
		    mProfile.Solve.Record(mTempTimer.GetMilliseconds)
		  End If
		  
		  // Handle TOI events.
		  If mContinuousPhysics And mStep.Dt > 0.0 Then
		    mTempTimer.Reset
		    SolveTOI(mStep)
		    mProfile.SolveTOI.Record(mTempTimer.GetMilliseconds)
		  End If
		  
		  If mStep.Dt > 0.0 Then
		    mInvDt0 = mStep.InvDt
		  End If
		  
		  If (Flags And ClearForcesBit) = ClearForcesBit Then
		    ClearForces
		  End If
		  
		  Flags = Flags And Bitwise.OnesComplement(Locked)
		  
		  mProfile.Step_.Record(mStepTimer.GetMilliseconds)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Flags And ClearForcesBit) = ClearForcesBit
			  
			End Get
		#tag EndGetter
		AutoClearForces As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Bodies() As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		BroadphaseTimer As Physics.Timer
	#tag EndProperty

	#tag Property, Flags = &h0
		CA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		CB As VMaths.Vector2
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Static mCollision As New Physics.Collision
			  Return mCollision
			End Get
		#tag EndGetter
		Shared Collision As Physics.Collision
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Colour As Physics.Color3i
	#tag EndProperty

	#tag Property, Flags = &h0
		ContactManager As Physics.ContactManager
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C20636C61737320746861742068616E646C65732064726177696E67207468697320776F726C64277320646562756720696E666F726D6174696F6E2028776972656672616D65732C20657463292E
		DebugDraw As Physics.DebugDraw
	#tag EndProperty

	#tag Property, Flags = &h0
		DestroyListener As Physics.DestroyListener
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Static mDistance As New Physics.Distance
			  Return mDistance
			End Get
		#tag EndGetter
		Shared Distance As Physics.Distance
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Flags As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mGravity
			  
			End Get
		#tag EndGetter
		Gravity As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Island As Physics.Island
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49732074686520776F726C64206C6F636B65642028696E20746865206D6964646C65206F6620612074696D652073746570293F
		#tag Getter
			Get
			  Return (Flags And Locked) = Locked
			  
			End Get
		#tag EndGetter
		IsLocked As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Joints() As Physics.Joint
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowSleep As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBackup1 As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBackup2 As Physics.Sweep
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContinuousPhysics As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGravity As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInput As Physics.RaycastInput
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F20636F6D70757465207468652074696D65207374657020726174696F20746F20737570706F72742061207661726961626C652074696D6520737465702E0A
		Private mInvDt0 As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Physics.Profile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRaycastWrapper As Physics.WorldRayCastWrapper
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStep As Physics.TimeStep
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStepComplete As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStepTimer As Physics.Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubStep As Physics.TimeStep
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubStepping As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempTimer As Physics.Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToiInput As Physics.TOIInput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToiIsland As Physics.Island
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToiOutput As Physics.TOIOutput
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWarmStarting As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		mWorldQueryWrapper As Physics.WorldQueryWrapper
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleDestroyListener As Physics.ParticleDestroyListener
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleSystem As Physics.ParticleSystem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 47657420746865206E756D626572206F662062726F61642D70686173652070726F786965732E
		#tag Getter
			Get
			  Return ContactManager.Broadphase.ProxyCount
			  
			End Get
		#tag EndGetter
		ProxyCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Stack() As Physics.Body
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Static mTOI As New Physics.TimeOfImpact
			  Return mTOI
			  
			End Get
		#tag EndGetter
		Shared TOI As Physics.TimeOfImpact
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Xf As Physics.Transform
	#tag EndProperty


	#tag Constant, Name = ClearForcesBit, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Locked, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NewFixture, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
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
			Name="IsLocked"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="ProxyCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

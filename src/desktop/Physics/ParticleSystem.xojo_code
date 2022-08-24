#tag Class
Protected Class ParticleSystem
	#tag Method, Flags = &h0
		Sub AddContact(particleA As Physics.Particle, particleB As Physics.Particle)
		  #If DebugBuild
		    Assert(particleA <> particleB, "The particles in contact can't be the same.")
		  #EndIf
		  
		  Var pa As VMaths.Vector2 = particleA.Position
		  Var pb As VMaths.Vector2 = particleB.Position
		  Var dx As Double = pb.X - pa.X
		  Var dy As Double = pb.Y - pa.Y
		  Var d2 As Double = dx * dx + dy * dy
		  
		  If d2 < SquaredDiameter Then
		    Var invD As Double = If(d2 <> 0, Sqrt(1 / d2), Maths.DoubleMaxFinite)
		    Var contact As New Physics.ParticleContact(particleA, particleB)
		    contact.Flags = particleA.Flags Or particleB.Flags
		    contact.Weight = 1 - d2 * invD * InverseDiameter
		    contact.Normal.X = invD * dx
		    contact.Normal.Y = invD * dy
		    contactBuffer.Add(contact)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeDepthForGroup(group As Physics.ParticleGroup)
		  For Each particle As Physics.Particle In group.Particles
		    particle.Accumulation = 0.0
		  Next particle
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    Var particleA As Physics.Particle = contact.ParticleA
		    Var particleB As Physics.Particle = contact.ParticleB
		    If group.Contains(particleA) And group.Contains(particleB) Then
		      Var w As Double = contact.Weight
		      particleA.Accumulation = particleA.Accumulation + w
		      particleB.Accumulation = particleB.Accumulation + w
		    End If
		  Next contact
		  
		  For Each particle As Physics.Particle In group.Particles
		    particle.Depth = If(particle.Accumulation < 0.8, 0.0, Maths.DoubleMaxFinite)
		  Next particle
		  
		  For t As Integer = 0 To group.Particles.LastIndex
		    var updated As Boolean = False
		    
		    For Each contact As Physics.ParticleContact In ContactBuffer
		      Var particleA As Physics.Particle = contact.ParticleA
		      Var particleB As Physics.Particle = contact.ParticleB
		      If group.Contains(particleA) And group.Contains(particleB) Then
		        Var r As Double = 1 - contact.Weight
		        If particleA.Depth > particleB.Depth + r Then
		          particleA.Depth = particleB.Depth + r
		          updated = True
		        End If
		        If particleB.Depth > particleA.Depth + r Then
		          particleB.Depth = particleA.Depth + r
		          updated = True
		        End If
		      End If
		    Next contact
		    
		    If Not updated Then Exit
		  Next t
		  
		  For Each particle As Physics.Particle In group.Particles
		    If particle.Depth < Maths.DoubleMaxFinite Then
		      particle.Depth = particle.Depth * particleDiameter
		    Else
		      particle.Depth = 0.0
		    End If
		  Next particle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ComputeParticleCollisionEnergy() As Double
		  Var sumV2 As Double = 0.0
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    Var collisionVelocity As VMaths.Vector2 = _
		    contact.ParticleA.Velocity - contact.ParticleB.Velocity
		    Var vn As Double = collisionVelocity.Dot(contact.Normal)
		    
		    If vn < 0 Then
		      sumV2 = sumV2 + (vn * vn)
		    End If
		  Next contact
		  
		  Return 0.5 * ParticleMass * sumV2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ComputeRelativeTag(tag As Integer, x As Integer, y As Integer) As Integer
		  Return _
		  tag + Bitwise.ShiftLeft(y, YShift) + Bitwise.ShiftLeft(x, XShift)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ComputeTag(x As Double, y As Double) As Integer
		  Return (Bitwise.ShiftLeft(y + yOffset, yShift) + _
		  (xScale * x) + xOffset)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(world As Physics.World, pressureStrength As Double = 0.05, dampingStrength As Double = 1, elasticStrength As Double = 0.25, springStrength As Double = 0.25, viscousStrength As Double = 0.25, surfaceTensionStrengthA As Double = 0.1, surfaceTensionStrengthB As Double = 0.2, powderStrength As Double = 0.5, ejectionStrength As Double = 0.5, colorMixingStrength As Double = 0.5)
		  Self.World = world
		  Self.PressureStrength = pressureStrength
		  Self.DampingStrength = dampingStrength
		  Self.ElasticStrength = elasticStrength
		  Self.SpringStrength = springStrength
		  Self.ViscousStrength = viscousStrength
		  Self.SurfaceTensionStrengthA = SurfaceTensionStrengthA
		  Self.SurfaceTensionStrengthB = SurfaceTensionStrengthB
		  Self.PowderStrength = powderStrength
		  Self.EjectionStrength = ejectionStrength
		  Self.ColorMixingStrength = colorMixingStrength
		  Self.GroupBuffer = New Physics.ParticleGroupSet
		  
		  mTemp = New Physics.AABB
		  mTemp2 = New Physics.AABB
		  mTempVec = VMaths.Vector2.Zero
		  mTempTransform = Physics.Transform.Zero
		  mTempTransform2 = Physics.Transform.Zero
		  mSolveCollisionCallback = New Physics.SolveCollisionCallback
		  mTempRot = New Physics.Rot
		  mTempXf = Physics.Transform.Zero
		  mTempXf2 = Physics.Transform.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateParticle(particle As Physics.Particle)
		  particle.Group.Add(particle)
		  Call GroupBuffer.Add(particle.Group)
		  ProxyBuffer.Add(New Physics.PsProxy(particle))
		  mParticles.Add(particle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateParticleGroup(groupDef As Physics.ParticleGroupDef) As Physics.ParticleGroup
		  Var stride As Double = ParticleStride
		  mTempTransform.SetIdentity
		  Var identity As Physics.Transform = mTempTransform
		  mTempTransform2.SetIdentity
		  Var transform As Physics.Transform = mTempTransform2
		  
		  Var group As New Physics.ParticleGroup(Self)
		  group.GroupFlags = groupDef.GroupFlags
		  group.Strength = groupDef.Strength
		  group.UserData = groupDef.UserData
		  group.Transform.Set(transform)
		  group.DestroyAutomatically = groupDef.DestroyAutomatically
		  
		  If groupDef.Shape <> Nil Then
		    Var seedParticle As New Physics.Particle(Self, group)
		    seedParticle.Flags = groupDef.Flags
		    seedParticle.Colour = groupDef.Colour
		    seedParticle.UserData = groupDef.UserData
		    Var shape As Physics.Shape = groupDef.Shape
		    transform.SetVec2Angle(groupDef.Position, groupDef.Angle)
		    Var aabb As Physics.AABB = mTemp
		    Var childCount As Integer = shape.ChildCount
		    Var childIndexLimit As Integer = childCount - 1
		    For childIndex As Integer = 0 To childIndexLimit
		      If childIndex = 0 Then
		        shape.ComputeAABB(aabb, identity, childIndex)
		      Else
		        Var childAABB As Physics.AABB = mTemp2
		        shape.ComputeAABB(childAABB, identity, childIndex)
		        aabb.Combine(childAABB)
		      End If
		    Next childIndex
		    Var upperBoundY As Double = aabb.UpperBound.Y
		    Var upperBoundX As Double = aabb.UpperBound.X
		    For y As Double = Floor(aabb.LowerBound.Y / stride) * stride To upperBoundY Step stride
		      For x As Double = Floor(aabb.lowerBound.x / stride) * stride To upperBoundX Step stride
		        'mTempVec.SetValues(x, y)
		        Var p As VMaths.Vector2 = mTempVec
		        p.X = x
		        p.Y = y
		        If shape.TestPoint(identity, p) Then
		          p.SetFrom(Physics.Transform.MulVec2(transform, p))
		          Var particle As Physics.Particle = seedParticle.Clone
		          particle.Lifespan = groupDef.Lifespan
		          particle.Position.SetFrom(p)
		          p.ScaleOrthogonalInto(groupDef.AngularVelocity, particle.Velocity)
		          particle.Velocity.Add(groupDef.LinearVelocity)
		          CreateParticle(particle)
		        End If
		      Next x
		    Next y
		    Call GroupBuffer.Add(group)
		  End If
		  
		  UpdateContacts(True)
		  If (groupDef.Flags And PairFlags) <> 0 Then
		    For Each contact As Physics.ParticleContact In ContactBuffer
		      Var particleA As Physics.Particle = contact.ParticleA
		      Var particleB As Physics.Particle = contact.ParticleB
		      If group.Particles.Contains(particleA) And _
		        group.Particles.Contains(particleB) Then
		        Var pair_ As New Physics.PsPair(particleA, particleB)
		        pair_.Flags = contact.Flags
		        pair_.Strength = groupDef.Strength
		        pair_.Distance = particleA.Position.DistanceTo(particleB.Position)
		        pairBuffer.Add(pair_)
		      End If
		    Next contact
		  End If
		  If (groupDef.Flags And triadFlags) <> 0 Then
		    Var diagram As New Physics.VoronoiDiagram
		    For Each particle As Physics.Particle In group.Particles
		      diagram.AddGenerator(particle.Position, particle)
		    Next particle
		    diagram.Generate(stride / 2)
		    Var cpgCallback As New Physics.CreateParticleGroupCallback(Self, groupDef)
		    diagram.Nodes(cpgCallback)
		  End If
		  If (groupDef.GroupFlags And Physics.ParticleGroupType.SolidParticleGroup) <> 0 Then
		    ComputeDepthForGroup(group)
		  End If
		  
		  Return group
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DestroyParticle(particle As Physics.Particle, callDestructionListener As Boolean)
		  Var flags As Integer = Physics.ParticleType.ZombieParticle
		  
		  If callDestructionListener Then
		    flags = flags Or Physics.ParticleType.DestroyListener
		  End If
		  
		  particle.Flags = particle.Flags Or flags
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DestroyParticlesInGroup(group As Physics.ParticleGroup, callDestructionListener As Boolean = False)
		  For Each p As Physics.Particle In group.Particles
		    DestroyParticle(p, callDestructionListener)
		  Next p
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657374726F79207061727469636C657320696E7369646520612073686170652E
		Sub DestroyParticlesInShape(shape As Physics.Shape, xf As Physics.Transform, callDestructionListener As Boolean = False)
		  /// Destroy particles inside a shape. 
		  ///
		  /// In addition, this function immediately
		  /// destroys particles in the shape in contrast to `DestroyParticle()` which
		  /// defers the destruction until the next simulation step.
		  
		  Var callback As New Physics.DestroyParticlesInShapeCallback( _
		  Self, shape, xf, callDestructionListener)
		  shape.ComputeAABB(mTemp, xf, 0)
		  Self.World.QueryAABBParticle(callback, mTemp)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCriticalPressure(step_ As Physics.TimeStep) As Double
		  Return ParticleDensity * GetCriticalVelocitySquared(step_)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCriticalVelocity(step_ As Physics.TimeStep) As Double
		  Return ParticleDiameter * step_.InvDt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCriticalVelocitySquared(step_ As Physics.TimeStep) As Double
		  Var velocity As Double = GetCriticalVelocity(step_)
		  Return velocity * velocity
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsZombie(particle As Physics.Particle) As Boolean
		  Return (particle.Flags And Physics.ParticleType.ZombieParticle) <> 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub JoinParticleGroups(groupA As Physics.ParticleGroup, groupB As Physics.ParticleGroup)
		  Var particleFlags As Integer = 0
		  
		  Var joinedParticles() As Physics.Particle
		  For Each p As Physics.Particle In groupA.Particles
		    joinedParticles.Add(p)
		  Next p
		  For Each p As Physics.Particle In groupB.Particles
		    joinedParticles.Add(p)
		  Next p
		  
		  For Each particle As Physics.Particle In joinedParticles
		    particleFlags = particleFlags Or particle.Flags
		  Next particle
		  
		  UpdateContacts(True)
		  
		  If (particleFlags And PairFlags) <> 0 Then
		    For Each contact As Physics.ParticleContact In ContactBuffer
		      Var particleA As Physics.Particle = contact.ParticleA
		      Var particleB As Physics.Particle = contact.ParticleB
		      If groupA.Particles.Contains(particleA) And _
		        groupB.Particles.Contains(particleB) Then
		        Var pair_ As New Physics.PsPair(particleA, particleB)
		        pair_.Flags = contact.Flags
		        pair_.Strength = Min(groupA.Strength, groupB.Strength)
		        pair_.Distance = particleA.Position.DistanceTo(particleB.Position)
		        pairBuffer.Add(pair_)
		      End If
		    Next contact
		  End If
		  
		  If (particleFlags And TriadFlags) <> 0 Then
		    Var diagram As New Physics.VoronoiDiagram
		    For Each particle As Physics.Particle In joinedParticles
		      If (particle.Flags And Physics.ParticleType.ZombieParticle) = 0 Then
		        diagram.AddGenerator(particle.Position, particle)
		      End If
		    Next particle
		    diagram.Generate(ParticleStride / 2)
		    Var callback As New Physics.JoinParticleGroupsCallback(Self, groupA, groupB)
		    diagram.Nodes(callback)
		  End If
		  
		  for Each particle As Physics.Particle In groupB.Particles
		    groupA.Add(particle)
		    particle.Group = groupA
		  Next particle
		  
		  Var groupFlags As Integer = groupA.GroupFlags Or groupB.GroupFlags
		  groupA.GroupFlags = groupFlags
		  
		  // Remove group b, since all its particles are in group a now
		  If Self.World.ParticleDestroyListener <> Nil Then
		    Self.World.ParticleDestroyListener.OnDestroyParticleGroup(groupB)
		  End If
		  Call GroupBuffer.Remove(groupB)
		  
		  If (groupFlags And Physics.ParticleGroupType.SolidParticleGroup) <> 0 Then
		    ComputeDepthForGroup(groupA)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function LowerBound(ray() As Physics.PsProxy, tag As Integer) As Integer
		  Var left As Integer = 0
		  Var step_, current As Integer
		  Var length As Integer = ray.Count
		  
		  While length > 0
		    step_ = length \ 2
		    current = left + step_
		    If ray(current).Tag < tag Then
		      left = current + 1
		      length = length - (step_ + 1)
		    Else
		      length = step_
		    End If
		  Wend
		  
		  Return left
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QueryAABB(callback As Physics.ParticleQueryCallback, aabb As Physics.AABB)
		  If proxyBuffer.Count = 0 Then Return
		  
		  Var lowerBoundX As Double = aabb.LowerBound.X
		  Var lowerBoundY As Double = aabb.LowerBound.Y
		  Var upperBoundX As Double = aabb.UpperBound.X
		  Var upperBoundY As Double = aabb.upperBound.Y
		  Var firstProxy As Integer = LowerBound( _
		  ProxyBuffer, _
		  ComputeTag( _
		  inverseDiameter * lowerBoundX, _
		  inverseDiameter * lowerBoundY) _
		  )
		  
		  Var lastProxy As Integer = UpperBound( _
		  ProxyBuffer, _
		  ComputeTag( _
		  inverseDiameter * upperBoundX, _
		  inverseDiameter * upperBoundY) _
		  )
		  
		  Var iLimit As Integer = lastProxy - 1
		  For i As Integer = firstProxy To iLimit
		    Var particle As Physics.Particle = proxyBuffer(i).Particle
		    Var p As VMaths.Vector2 = particle.Position
		    If lowerBoundX < p.X And p.X < upperBoundX And _
		      lowerBoundY < p.Y And p.Y < upperBoundY Then
		      If Not callback.ReportParticle(particle) Then
		        Exit
		      End If
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Raycast(callback As Physics.ParticleRaycastCallback, point1 As VMaths.Vector2, point2 As VMaths.Vector2)
		  If ProxyBuffer.Count = 0 Then Return
		  
		  Var firstProxy As Integer = LowerBound( _
		  ProxyBuffer, _
		  ComputeTag( _
		  InverseDiameter * Min(point1.X, point2.X) - 1, _
		  InverseDiameter * Min(point1.Y, point2.Y) - 1))
		  
		  Var lastProxy As Integer = UpperBound( _
		  ProxyBuffer, _
		  ComputeTag( _
		  InverseDiameter * Max(point1.X, point2.X) + 1, _
		  InverseDiameter * Max(point1.Y, point2.Y) + 1))
		  
		  Var fraction As Double = 1.0
		  // Solving the following equation:
		  // ((1-t)*point1+t*point2-position)^2=diameter^2
		  // where t is a potential fraction.
		  Var vx As Double = point2.X - point1.X
		  Var vy As Double = point2.Y - point1.Y
		  Var v2 As Double = vx * vx + vy * vy
		  v2 = If(v2 = 0, Maths.DoubleMaxFinite, v2)
		  
		  Var iLimit As Integer = lastProxy - 1
		  For i As Integer = firstProxy To iLimit
		    Var positionI As VMaths.Vector2 = ProxyBuffer(i).Particle.Position
		    Var px As Double = point1.X - positionI.X
		    Var py As Double = point1.Y - positionI.Y
		    Var pv As Double = px * vx + py * vy
		    Var p2 As Double = px * px + py * py
		    Var determinant As Double = pv * pv - v2 * (p2 - squaredDiameter)
		    
		    If determinant >= 0 Then
		      Var sqrtDeterminant As Double = Sqrt(determinant)
		      // Find a solution between 0 and fraction.
		      Var t As Double = (-pv - sqrtDeterminant) / v2
		      
		      If t > fraction Then Continue
		      
		      If t < 0 Then
		        t = (-pv + sqrtDeterminant) / v2
		        If t < 0 Or t > fraction Then Continue
		      End If
		      
		      Var n As VMaths.Vector2 = mTempVec
		      mTempVec.X = px + t * vx
		      mTempVec.Y = py + t * vy
		      n.Normalize
		      Var point As New VMaths.Vector2(point1.X + t * vx, point1.Y + t * vy)
		      Var f As Double = callback.ReportParticle(i, point, n, t)
		      fraction = Min(fraction, f)
		      If fraction <= 0 Then
		        Exit
		      End If
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Render(debugDraw As Physics.DebugDraw)
		  If Particles.count > 1 Then
		    If debugDraw.ShouldDrawWireframes Then
		      debugDraw.DrawParticlesWireframe(Particles.ToArray, ParticleRadius)
		    Else
		      debugDraw.DrawParticles(Particles.ToArray, ParticleRadius)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Solve(step_ As Physics.Timestep)
		  TimeStamp = TimeStamp + 1
		  
		  If mParticles.Count = 0 Then Return
		  
		  AllParticleFlags = 0
		  For Each particle As Physics.Particle In mParticles
		    // Tell this particle we are beginning the `Solve` step. This will determine if the particle has expired.
		    particle.PreSolve(step_.Dt)
		    AllParticleFlags = AllParticleFlags Or particle.Flags
		  Next particle
		  
		  If (AllParticleFlags And Physics.ParticleType.ZombieParticle) <> 0 Then
		    SolveZombie
		  End If
		  
		  If mParticles.Count = 0 Then Return
		  
		  AllGroupFlags = 0
		  
		  For i As Integer = 0 To GroupBuffer.LastIndex
		    Var group As Physics.ParticleGroup = GroupBuffer.ElementAt(i)
		    AllGroupFlags = AllGroupFlags Or group.GroupFlags
		  Next i
		  
		  Var gravityX As Double = step_.Dt * gravityScale * world.Gravity.X
		  Var gravityY As Double = step_.Dt * gravityScale * world.Gravity.Y
		  Var criticalVelocitySquared As Double = GetCriticalVelocitySquared(step_)
		  For Each particle As Physics.Particle In mParticles
		    Var v As VMaths.Vector2 = particle.Velocity
		    v.X = v.X + gravityX
		    v.Y = v.Y + gravityY
		    Var v2 As Double = v.X * v.X + v.Y * v.Y
		    If v2 > criticalVelocitySquared Then
		      Var a As Double = _
		      If(v2 = 0, Maths.doublemaxFinite, Sqrt(criticalVelocitySquared / v2))
		      v.X = v.X * a
		      v.Y = v.Y * a
		    End If
		  Next particle
		  
		  SolveCollision(step_)
		  
		  If (AllGroupFlags And Physics.ParticleGroupType.RigidParticleGroup) <> 0 Then
		    SolveRigid(step_)
		  End If
		  
		  If (AllParticleFlags And Physics.ParticleType.WallParticle) <> 0 Then
		    SolveWall(step_)
		  End If
		  
		  For Each particle As Physics.Particle In mParticles
		    particle.Position.SetFrom(particle.Position + (particle.Velocity * step_.Dt))
		  Next particle
		  
		  UpdateBodyContacts
		  UpdateContacts(False)
		  
		  If (AllParticleFlags And Physics.ParticleType.ViscousParticle) <> 0 Then
		    SolveViscous(step_)
		  End If
		  
		  If (AllParticleFlags And Physics.ParticleType.PowderParticle) <> 0 Then
		    SolvePowder(step_)
		  End If
		  
		  If (AllParticleFlags And Physics.ParticleType.TensileParticle) <> 0 Then
		    SolveTensile(step_)
		  End If
		  
		  If (AllParticleFlags And Physics.ParticleType.ElasticParticle) <> 0 Then
		    SolveElastic(step_)
		  End If
		  
		  If (AllParticleFlags And Physics.ParticleType.SpringParticle) <> 0 Then
		    SolveSpring(step_)
		  End If
		  
		  If (AllGroupFlags And Physics.ParticleGroupType.SolidParticleGroup) <> 0 Then
		    SolveSolid(step_)
		  End If
		  
		  If (AllParticleFlags And Physics.ParticleType.ColorMixingParticle) <> 0 Then
		    SolveColorMixing(step_)
		  End If
		  
		  SolvePressure(step_)
		  SolveDamping(step_)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveCollision(step_ As Physics.TimeStep)
		  Var aabb As Physics.AABB = mTemp
		  Var lowerBound As VMaths.Vector2 = aabb.LowerBound
		  Var upperBound As VMaths.Vector2 = aabb.UpperBound
		  lowerBound.X = Maths.DoubleMaxFinite
		  lowerBound.Y = Maths.DoubleMaxFinite
		  upperBound.X = -Maths.DoubleMaxFinite
		  upperBound.Y = -Maths.DoubleMaxFinite
		  
		  For Each particle As Physics.Particle In mParticles
		    Var v As VMaths.Vector2 = particle.Velocity
		    Var p1 As VMaths.Vector2 = particle.Position
		    Var p2x As Double = p1.X + step_.Dt * v.X
		    Var p2y As Double = p1.Y + step_.Dt * v.Y
		    Var bx As Double = If(p1.X < p2x, p1.X, p2x)
		    Var by As Double = If(p1.Y < p2y, p1.Y, p2y)
		    lowerBound.X = If(lowerBound.X < bx, lowerBound.X, bx)
		    lowerBound.Y = If(lowerBound.Y < by, lowerBound.Y, by)
		    Var b1x As Double = If(p1.X > p2x, p1.X, p2x)
		    Var b1y As Double = If(p1.Y > p2y, p1.Y, p2y)
		    upperBound.X = If(upperBound.X > b1x, upperBound.X, b1x)
		    upperBound.Y = If(upperBound.Y > b1y, upperBound.Y, b1y)
		  Next particle
		  
		  mSolveCollisionCallback.Step_ = step_
		  mSolveCollisionCallback.System = Self
		  Self.World.QueryAABB(mSolveCollisionCallback, aabb)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveColorMixing(step_ As Physics.TimeStep)
		  // Mixes colour between contacting particles.
		  
		  #Pragma Unused step_
		  
		  Var colorMixing256 As Integer = 256 * ColorMixingStrength
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    Var particleA As Physics.Particle = contact.ParticleA
		    Var particleB As Physics.Particle = contact.particleA
		    If (particleA.Flags And particleB.Flags And _
		      Physics.ParticleType.ColorMixingParticle) <> 0 Then
		      Var colorA As Color = particleA.Colour
		      Var colorB As Color = particleB.Colour
		      Var dr As Integer = Bitwise.ShiftRight(colorMixing256 * (colorB.Red - colorA.Red), 8)
		      Var dg As Integer = Bitwise.ShiftRight(colorMixing256 * (colorB.Green - colorA.Green), 8)
		      Var db As Integer = Bitwise.ShiftRight(colorMixing256 * (colorB.Blue - colorA.Blue), 8)
		      Var da As Integer = Bitwise.ShiftRight((colorMixing256 * (colorB.Alpha - colorA.Alpha)), 8)
		      colorA = _
		      Color.RGB(colorA.Red + dr, colorA.Green + dg, colorA.Blue + db, colorA.Alpha + da)
		      colorB = _
		      Color.RGB(colorB.Red - dr, colorB.Green - dg, colorB.Blue - db, colorB.Alpha - da)
		    End If
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveDamping(step_ As Physics.TimeStep)
		  #Pragma Unused step_
		  
		  Var  damping As Double = DampingStrength
		  
		  For Each contact As Physics.ParticleBodyContact In BodyContactBuffer
		    Var particle As Physics.Particle = contact.Particle
		    Var b As Physics.Body = contact.Body
		    Var w As Double = contact.Weight
		    Var m As Double = contact.Mass
		    Var n As VMaths.Vector2 = contact.Normal
		    Var p As VMaths.Vector2 = particle.Position
		    Var tempX As Double = p.X - b.Sweep.C.X
		    Var tempY As Double = p.Y - b.Sweep.C.Y
		    Var velA As VMaths.Vector2 = particle.Velocity
		    Var vx As Double = -b.AngularVelocity * tempY + b.LinearVelocity.X - velA.X
		    Var vy  As Double = b.AngularVelocity * tempX + b.LinearVelocity.Y - velA.Y
		    Var vn As Double = vx * n.X + vy * n.Y
		    If vn < 0 Then
		      Var f As VMaths.Vector2 = mTempVec
		      f.X = damping * w * m * vn * n.X
		      f.Y = damping * w * m * vn * n.Y
		      velA.X = velA.X + (ParticleInverseMass * f.X)
		      velA.Y = velA.Y + (ParticleInverseMass * f.Y)
		      f.X = -f.X
		      f.Y = -f.Y
		      b.ApplyLinearImpulse(f, p)
		    End If
		  Next contact
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    Var particleA As Physics.Particle = contact.ParticleA
		    Var particleB As Physics.Particle = contact.ParticleB
		    Var w As Double = contact.Weight
		    Var n As VMaths.Vector2 = contact.Normal
		    Var velA As VMaths.Vector2 = particleA.Velocity
		    Var velB As VMaths.Vector2 = particleB.Velocity
		    Var vx As Double = velB.X - velA.X
		    Var vy As Double = velB.Y - velA.Y
		    Var vn As Double = vx * n.X + vy * n.Y
		    If vn < 0 Then
		      Var fx As Double = damping * w * vn * n.X
		      Var fy As Double = damping * w * vn * n.Y
		      velA.X = velA.X + fx
		      velA.Y = velA.Y + fy
		      velB.X = velB.X - fx
		      velB.Y = velB.Y - fy
		    End If
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveElastic(step_ As Physics.TimeStep)
		  Var elasticStrength As Double = step_.InvDt * Self.ElasticStrength
		  For Each triad As Physics.PsTriad In TriadBuffer
		    If (triad.Flags And Physics.ParticleType.ElasticParticle) <> 0 Then
		      Var particleA As Physics.Particle = triad.ParticleA
		      Var particleB As Physics.Particle = triad.ParticleB
		      Var particleC As Physics.Particle = triad.ParticleC
		      Var oa As VMaths.Vector2 = triad.Pa
		      Var ob As VMaths.Vector2 = triad.Pb
		      Var oc As VMaths.Vector2 = triad.Pc
		      Var pa As VMaths.Vector2 = particleA.Position
		      Var pb As VMaths.Vector2 = particleB.Position
		      Var pc As VMaths.Vector2 = particleC.Position
		      Var px As Double = 1.0 / 3 * (pa.X + pb.X + pc.X)
		      Var py As Double = 1.0 / 3 * (pa.Y + pb.Y + pc.Y)
		      var rs As Double = oa.Cross(pa) + ob.Cross(pb) + oc.Cross(pc)
		      var rc As Double = oa.Dot(pa) + ob.Dot(pb) + oc.Dot(pc)
		      Var r2 As Double = rs * rs + rc * rc
		      Var invR As Double = If(r2 = 0, Maths.DoubleMaxFinite, Sqrt(1.0 / r2))
		      rs = rs * invR
		      rc = rc * invR
		      Var strength As Double = elasticStrength * triad.Strength
		      Var roax As Double = rc * oa.X - rs * oa.Y
		      Var roay As Double = rs * oa.X + rc * oa.Y
		      Var robx As Double = rc * ob.X - rs * ob.Y
		      Var roby As Double = rs * ob.X + rc * ob.Y
		      Var rocx As Double = rc * oc.X - rs * oc.Y
		      Var rocy As Double = rs * oc.X + rc * oc.Y
		      Var va As VMaths.Vector2 = particleA.Velocity
		      Var vb As VMaths.Vector2 = particleB.Velocity
		      Var vc As VMaths.Vector2 = particleC.Velocity
		      va.X = va.X + (strength * (roax - (pa.X - px)))
		      va.Y = va.Y + (strength * (roay - (pa.Y - py)))
		      vb.X = vb.X + (strength * (robx - (pb.X - px)))
		      vb.Y = vb.Y + (strength * (roby - (pb.Y - py)))
		      vc.X = vc.X + (strength * (rocx - (pc.X - px)))
		      vc.Y = vc.Y + (strength * (rocy - (pc.Y - py)))
		    End If
		  Next triad
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolvePowder(step_ As Physics.TimeStep)
		  Var powderStrength As Double = Self.PowderStrength * GetCriticalVelocity(step_)
		  Var minWeight As Double = 1.0 - Physics.Settings.ParticleStride
		  
		  For Each contact As Physics.ParticleBodyContact In BodyContactBuffer
		    Var particle As Physics.Particle = contact.Particle
		    If (particle.Flags And Physics.ParticleType.PowderParticle) <> 0 Then
		      Var w As Double = contact.Weight
		      If w > minWeight Then
		        Var b As Physics.Body = contact.Body
		        Var m As Double = contact.Mass
		        Var p As VMaths.Vector2 = particle.Position
		        Var n As VMaths.Vector2 = contact.Normal
		        Var f As VMaths.Vector2 = mTempVec
		        Var va As VMaths.Vector2 = particle.Velocity
		        Var inter As Double = powderStrength * m * (w - minWeight)
		        Var pInvMass As Double = ParticleInverseMass
		        f.X = inter * n.X
		        f.Y = inter * n.Y
		        va.X = va.X - (pInvMass * f.X)
		        va.Y = va.Y - (pInvMass * f.Y)
		        b.ApplyLinearImpulse(f, p)
		      End If
		    End If
		  Next contact
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    If (contact.Flags And Physics.ParticleType.PowderParticle) <> 0 Then
		      Var w As Double = contact.Weight
		      If w > minWeight Then
		        Var particleA As Physics.Particle = contact.ParticleA
		        Var particleB As Physics.Particle = contact.ParticleB
		        Var n As VMaths.Vector2 = contact.Normal
		        Var va As VMaths.Vector2 = particleA.Velocity
		        Var vb As VMaths.Vector2 = particleB.Velocity
		        Var inter As Double = powderStrength * (w - minWeight)
		        Var fx As Double = inter * n.X
		        Var fy As Double = inter * n.Y
		        va.X = va.X - fx
		        va.Y = va.Y - fy
		        vb.X = vb.X + fx
		        vb.Y = vb.Y + fy
		      End If
		    End If
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolvePressure(step_ As Physics.TimeStep)
		  For Each particle As Physics.Particle In mParticles
		    particle.Accumulation = 0.0
		  Next particle
		  
		  For Each contact As Physics.ParticleBodyContact In BodyContactBuffer
		    contact.Particle.Accumulation = _
		    contact.Particle.Accumulation + contact.Weight
		  Next contact
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    contact.ParticleA.Accumulation = _
		    contact.ParticleA.Accumulation + contact.Weight
		    contact.ParticleB.Accumulation = _
		    contact.ParticleB.Accumulation + contact.Weight
		  Next contact
		  
		  // Ignores powder particles.
		  If (AllParticleFlags And NoPressureFlags) <> 0 Then
		    For Each particle As Physics.Particle In mParticles
		      If (particle.Flags And NoPressureFlags) <> 0 Then
		        particle.Accumulation = 0.0
		      End If
		    Next particle
		  End If
		  
		  // Calculates pressure as a linear function of density.
		  Var pressurePerWeight As Double = pressureStrength * GetCriticalPressure(step_)
		  For Each particle As Physics.Particle In mParticles
		    Var w As Double = particle.Accumulation
		    Var h As Double = pressurePerWeight * _
		    Max( _
		    0.0, _
		    Min(w, Physics.Settings.MaxParticleWeight) - Physics.Settings.MinParticleWeight)
		    particle.Accumulation = h
		  Next particle
		  
		  // Applies pressure between each particles in contact.
		  Var velocityPerPressure as Double = step_.dt / (mParticleDensity * ParticleDiameter)
		  For Each contact As Physics.ParticleBodyContact In BodyContactBuffer
		    Var particle As Physics.Particle = contact.Particle
		    Var b As Physics.Body = contact.Body
		    Var w As Double = contact.Weight
		    Var m As Double = contact.Mass
		    Var n As VMaths.Vector2 = contact.Normal
		    Var p As VMaths.Vector2 = particle.Position
		    Var h As Double = particle.Accumulation + pressurePerWeight * w
		    Var f As VMaths.Vector2 = mTempVec
		    Var coef As Double = velocityPerPressure * w * m * h
		    f.X = coef * n.X
		    f.Y = coef * n.Y
		    Var velData As VMaths.Vector2 = particle.Velocity
		    velData.X = velData.X - (particleInverseMass * f.X)
		    velData.Y = velData.Y - (particleInverseMass * f.Y)
		    b.ApplyLinearImpulse(f, p)
		  Next contact
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    Var particleA As Physics.Particle = contact.ParticleA
		    Var particleB As Physics.Particle = contact.ParticleB
		    Var w As Double = contact.Weight
		    Var n As VMaths.Vector2 = contact.Normal
		    Var h As Double = particleA.Accumulation + particleB.Accumulation
		    Var fx As Double = velocityPerPressure * w * h * n.X
		    Var fy As Double = velocityPerPressure * w * h * n.Y
		    Var velDataA As VMaths.Vector2 = particleA.Velocity
		    Var velDataB As VMaths.Vector2 = particleB.Velocity
		    velDataA.X = velDataA.X - fx
		    velDataA.Y = velDataA.Y - fy
		    velDataB.X = velDataB.X + fx
		    velDataB.Y = velDataB.Y + fy
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveRigid(step_ As Physics.TimeStep)
		  Var iLimit As Integer = GroupBuffer.LastIndex
		  For i As Integer = 0 To iLimit
		    Var group As Physics.ParticleGroup = GroupBuffer.ElementAt(i)
		    If (group.GroupFlags And Physics.ParticleGroupType.RigidParticleGroup) <> 0 Then
		      group.UpdateStatistics
		      Var temp As VMaths.Vector2 = mTempVec
		      Var rotation As Physics.Rot = mTempRot
		      rotation.SetAngle(step_.Dt * group.AngularVelocity)
		      Var cross As VMaths.Vector2  = Physics.Rot.MulVec2(rotation, group.Center)
		      temp.SetFrom(group.LinearVelocity)
		      temp.Scale(step_.Dt)
		      temp.Add(group.Center)
		      temp.Subtract(cross)
		      mTempXf.P.SetFrom(temp)
		      mTempXf.Q.SetFrom(rotation)
		      group.Transform.Set(Physics.Transform.Mul(mTempXf, group.Transform))
		      Var velocityTransform As Physics.Transform = mTempXf2
		      velocityTransform.P.X = step_.InvDt * mTempXf.P.X
		      velocityTransform.P.Y = step_.InvDt * mTempXf.P.Y
		      velocityTransform.Q.Sin = step_.InvDt * mTempXf.Q.Sin
		      velocityTransform.Q.Cos = step_.InvDt * (mTempXf.Q.Cos - 1)
		      For Each particle As Physics.Particle In group.Particles
		        particle.Velocity.SetFrom( _
		        Physics.Transform.MulVec2(velocityTransform, particle.Position))
		      Next particle
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveSolid(step_ As Physics.TimeStep)
		  Var ejectionStrength as Double = step_.InvDt * Self.EjectionStrength
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    Var particleA As Physics.Particle = contact.ParticleA
		    Var particleB As Physics.Particle = contact.ParticleB
		    If particleA.Group <> particleB.Group Then
		      Var w As Double = contact.Weight
		      Var n As VMaths.Vector2 = contact.Normal
		      Var h As Double = particleA.Depth + particleB.Depth
		      Var va As VMaths.Vector2 = particleA.Velocity
		      Var vb As VMaths.Vector2 = particleA.Velocity
		      Var inter As Double = ejectionStrength * h * w
		      Var fx As Double = inter * n.X
		      Var fy As Double = inter * n.Y
		      va.X = va.X - fx
		      va.Y = va.Y - fy
		      va.Y = va.Y + fx
		      vb.Y = vb.Y + fy
		    End If
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveSpring(step_ As Physics.TimeStep)
		  Var springStrength As Double = step_.InvDt * Self.SpringStrength
		  
		  For Each pair_ As Physics.PsPair In PairBuffer
		    If (pair_.Flags And Physics.ParticleType.SpringParticle) <> 0 Then
		      Var particleA As Physics.Particle = pair_.particleA
		      Var particleB As Physics.Particle = pair_.particleB
		      Var pa As VMaths.Vector2 = particleA.Position
		      Var pb As VMaths.Vector2 = particleB.Position
		      Var dx As Double = pb.X - pa.X
		      Var dy As Double = pb.Y - pa.Y
		      Var r0 As Double = pair_.Distance
		      Var r1 As Double = Sqrt(dx * dx + dy * dy)
		      r1 = If(r1 = 0, Maths.DoubleMaxFinite, r1)
		      Var strength As Double = springStrength * pair_.Strength
		      Var fx As Double = strength * (r0 - r1) / r1 * dx
		      Var fy As Double = strength * (r0 - r1) / r1 * dy
		      Var va As VMaths.Vector2 = particleA.Velocity
		      Var vb As VMaths.Vector2 = particleB.Velocity
		      va.X = va.X - fx
		      va.Y = va.Y - fy
		      vb.X = vb.X + fx
		      vb.Y = vb.Y + fy
		    End If
		  Next pair_
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveTensile(step_ As Physics.TimeStep)
		  For Each particle As Physics.Particle In mParticles
		    particle.Accumulation = 0.0
		    particle.AccumulationVector.SetZero
		  Next particle
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    If (contact.Flags And Physics.ParticleType.TensileParticle) <> 0 Then
		      Var particleA As Physics.Particle = contact.ParticleA
		      Var particleB As Physics.Particle = contact.ParticleB
		      Var w As Double = contact.Weight
		      Var n As VMaths.Vector2 = contact.Normal
		      particleA.Accumulation = particleA.Accumulation + w
		      particleB.Accumulation = particleB.Accumulation + w
		      Var a2A As VMaths.Vector2 = particleA.AccumulationVector
		      Var a2B As VMaths.Vector2 = particleB.AccumulationVector
		      Var inter As Double = (1 - w) * w
		      a2A.X = a2A.X - (inter * n.X)
		      a2A.Y = a2A.Y - (inter * n.Y)
		      a2B.X = a2B.X + (inter * n.X)
		      a2B.Y = a2B.Y + (inter * n.Y)
		    End If
		  Next contact
		  
		  Var strengthA As Double = surfaceTensionStrengthA * GetCriticalVelocity(step_)
		  Var strengthB As Double = surfaceTensionStrengthB * GetCriticalVelocity(step_)
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    If (contact.Flags And Physics.ParticleType.TensileParticle) <> 0 Then
		      Var particleA As Physics.Particle = contact.ParticleA
		      Var particleB As Physics.Particle = contact.ParticleB
		      Var w As Double = contact.Weight
		      Var n As VMaths.Vector2 = contact.Normal
		      Var a2A As VMaths.Vector2 = particleA.AccumulationVector
		      Var a2B As VMaths.Vector2 = particleB.AccumulationVector
		      Var h As Double = particleA.Accumulation + particleB.Accumulation
		      Var sx As Double = a2B.X - a2A.X
		      Var sy As Double = a2B.Y - a2A.Y
		      Var fn As Double = _
		      (strengthA * (h - 2) + strengthB * (sx * n.X + sy * n.Y)) * w
		      Var fx As Double = fn * n.X
		      Var fy As Double = fn * n.Y
		      Var va As VMaths.Vector2 = particleA.Velocity
		      Var vb As VMaths.Vector2 = particleB.Velocity
		      va.X = va.X - fx
		      va.Y = va.Y - fy
		      vb.X = vb.X + fx
		      vb.Y = vb.Y + fy
		    End If
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveViscous(step_ As Physics.TimeStep)
		  #Pragma Unused step_
		  
		  For Each contact As Physics.ParticleBodyContact In BodyContactBuffer
		    Var particle As Physics.Particle = contact.Particle
		    If (particle.Flags And Physics.ParticleType.ViscousParticle) <> 0 Then
		      Var b As Physics.Body = contact.Body
		      Var w As Double = contact.Weight
		      Var m As Double = contact.Mass
		      Var p As VMaths.Vector2 = particle.Position
		      Var va As VMaths.Vector2 = particle.Velocity
		      Var tempX As Double = p.X - b.Sweep.C.X
		      Var tempY As Double = p.Y - b.Sweep.C.Y
		      Var vx As Double = -b.AngularVelocity * tempY + b.LinearVelocity.X - va.X
		      Var vy As Double = b.AngularVelocity * tempX + b.LinearVelocity.Y - va.Y
		      Var f As VMaths.Vector2 = mTempVec
		      Var pInvMass As Double = ParticleInverseMass
		      f.X = viscousStrength * m * w * vx
		      f.Y = viscousStrength * m * w * vy
		      va.X = va.X + (pInvMass * f.X)
		      va.Y = va.Y + (pInvMass * f.Y)
		      f.X = -f.X
		      f.Y = -f.Y
		      b.ApplyLinearImpulse(f, p)
		    End If
		  Next contact
		  
		  For Each contact As Physics.ParticleContact In ContactBuffer
		    If (contact.Flags And Physics.ParticleType.ViscousParticle) <> 0 Then
		      Var particleA As Physics.Particle = contact.ParticleA
		      Var particleB As Physics.Particle = contact.ParticleB
		      Var w As Double = contact.Weight
		      Var va As VMaths.Vector2 = particleA.Velocity
		      Var vb As VMaths.Vector2 = particleB.Velocity
		      Var vx As Double = vb.X - va.X
		      Var vy As Double = vb.Y - va.Y
		      Var fx As Double = viscousStrength * w * vx
		      Var fy As Double = viscousStrength * w * vy
		      va.X = va.X + fx
		      va.Y = va.Y + fy
		      vb.X = vb.X - fx
		      vb.Y = vb.Y - fy
		    End If
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveWall(step_ As Physics.TimeStep)
		  #Pragma Unused step_
		  
		  For Each particle As Physics.Particle In mParticles
		    If (particle.Flags And Physics.ParticleType.WallParticle) <> 0 Then
		      particle.Velocity.SetZero
		    End If
		  Next particle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766573207061727469636C65732077697468207A6F6D62696520666C61672E
		Sub SolveZombie()
		  /// Removes particles with zombie flag.
		  
		  For i As Integer = mParticles.LastIndex DownTo 0
		    Var p As Physics.Particle = mParticles(i)
		    If IsZombie(p) Then
		      If (p.Flags And Physics.ParticleType.DestroyListener) <> 0 Then
		        If Self.World.ParticleDestroyListener <> Nil Then
		          Self.World.ParticleDestroyListener.OnDestroyParticle(p)
		        End If
		      End If
		      mParticles.RemoveAt(i)
		    End If
		  Next i
		  
		  
		  For i As Integer = ProxyBuffer.LastIndex DownTo 0
		    Var proxy As Physics.PsProxy = ProxyBuffer(i)
		    If IsZombie(proxy.Particle) Then
		      ProxyBuffer.RemoveAt(i)
		    End If
		  Next i
		  
		  For i As Integer = ContactBuffer.LastIndex DownTo 0
		    Var c As Physics.ParticleContact = ContactBuffer(i)
		    If IsZombie(c.ParticleA) Or IsZombie(c.ParticleB) Then
		      ContactBuffer.RemoveAt(i)
		    End If
		  Next i
		  
		  For i As Integer = BodyContactBuffer.LastIndex DownTo 0
		    If IsZombie(BodyContactBuffer(i).Particle) Then
		      BodyContactBuffer.RemoveAt(i)
		    End If
		  Next i
		  
		  For i As Integer = PairBuffer.LastIndex DownTo 0
		    Var p As Physics.PsPair = PairBuffer(i)
		    If IsZombie(p.ParticleA) Or IsZombie(p.ParticleB) Then
		      PairBuffer.RemoveAt(i)
		    End If
		  Next i
		  
		  For i As Integer = TriadBuffer.LastIndex DownTo 0
		    Var t As Physics.PsTriad = TriadBuffer(i)
		    If IsZombie(t.ParticleA) Or IsZombie(t.ParticleB) Or IsZombie(t.ParticleC) Then
		      TriadBuffer.RemoveAt(i)
		    End If
		  Next i
		  
		  For i As Integer = GroupBuffer.LastIndex DownTo 0
		    Var g As Physics.ParticleGroup = GroupBuffer.ElementAt(i)
		    
		    For j As Integer = g.Particles.LastIndex DownTo 0
		      If IsZombie(g.Particles(j)) Then
		        g.Particles.RemoveAt(j)
		      End If
		    Next j
		    
		    Var toBeRemoved As Boolean = _
		    g.DestroyAutomatically And g.Particles.Count = 0
		    
		    If toBeRemoved And Self.World.ParticleDestroyListener <> Nil Then
		      Self.World.ParticleDestroyListener.OnDestroyParticleGroup(g)
		    End If
		    
		    If toBeRemoved Then
		      GroupBuffer.RemoveAt(i)
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateBodyContacts()
		  Var aabb As Physics.AABB = mTemp
		  aabb.LowerBound.X = Maths.DoubleMaxFinite
		  aabb.LowerBound.Y = Maths.DoubleMaxFinite
		  aabb.UpperBound.X = -Maths.DoubleMaxFinite
		  aabb.UpperBound.Y = -Maths.DoubleMaxFinite
		  
		  For Each particle As Physics.Particle In mParticles
		    Var position As VMaths.Vector2 = particle.Position
		    VMaths.Vector2.Minimum(aabb.LowerBound, position, aabb.LowerBound)
		    VMaths.Vector2.Maximum(aabb.UpperBound, position, aabb.UpperBound)
		  Next particle
		  
		  aabb.LowerBound.X = aabb.LowerBound.X - particleDiameter
		  aabb.LowerBound.Y = aabb.LowerBound.Y - particleDiameter
		  aabb.UpperBound.X = aabb.UpperBound.X + particleDiameter
		  aabb.UpperBound.Y = aabb.UpperBound.Y + particleDiameter
		  
		  Var callback As New Physics.UpdateBodyContactsCallback(Self)
		  Self.World.QueryAABB(callback, aabb)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateContacts(exceptZombie As Boolean)
		  For Each proxy As Physics.PsProxy In ProxyBuffer
		    Var pos As VMaths.Vector2 = proxy.Particle.Position
		    proxy.Tag = ComputeTag(InverseDiameter * pos.X, InverseDiameter * pos.Y)
		  Next proxy
		  
		  proxyBuffer.Sort(AddressOf Physics.PsProxy.SortDelegate)
		  contactBuffer.ResizeTo(-1)
		  
		  Var cIndex As Integer = 0
		  For i As Integer = 0 To ProxyBuffer.LastIndex
		    Var proxyA As Physics.PsProxy = proxyBuffer(i)
		    Var rightTag As Integer = ComputeRelativeTag(proxyA.Tag, 1, 0)
		    For j As Integer = i + 1 To ProxyBuffer.LastIndex
		      Var proxyB As Physics.PsProxy = proxyBuffer(j)
		      
		      If rightTag < proxyB.Tag Then Exit
		      
		      AddContact(proxyA.Particle, proxyB.Particle)
		    Next j
		    
		    Var bottomLeftTag As Integer = ComputeRelativeTag(proxyA.Tag, -1, 1)
		    
		    While cIndex < ProxyBuffer.Count
		      Var c As Physics.PsProxy = ProxyBuffer(cIndex)
		      If bottomLeftTag <= c.Tag Then Exit
		      cIndex = cIndex + 1
		    Wend
		    
		    Var bottomRightTag As Integer = ComputeRelativeTag(proxyA.Tag, 1, 1)
		    
		    For bIndex As Integer = cIndex To ProxyBuffer.LastIndex
		      Var proxyB As Physics.PsProxy = ProxyBuffer(bIndex)
		      If bottomRightTag < proxyB.Tag Then Exit
		      AddContact(proxyA.Particle, proxyB.Particle)
		    Next bIndex
		  Next i
		  
		  If exceptZombie Then
		    var j As Integer = contactBuffer.Count
		    Var iLimit As Integer = j - 1
		    For i As Integer = 0 To iLimit
		      If (ContactBuffer(i).Flags And Physics.ParticleType.ZombieParticle) <> 0 Then
		        j = j - 1
		        Var temp As Physics.ParticleContact = ContactBuffer(j)
		        ContactBuffer(j) = ContactBuffer(i)
		        ContactBuffer(i) = temp
		        i = i - 1
		      End If
		    Next i
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function UpperBound(ray() As Physics.PsProxy, tag As Integer) As Integer
		  Var left As Integer = 0
		  Var step_, current As Integer
		  Var length As Integer = ray.Count
		  
		  While length > 0
		    step_ = length \ 2
		    current = left + step_
		    If ray(current).Tag >= tag Then
		      left = current + 1
		      length = length - (step_ + 1)
		    Else
		      length = step_
		    End If
		  Wend
		  
		  Return left
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		AllGroupFlags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		AllParticleFlags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		BodyContactBuffer() As Physics.ParticleBodyContact
	#tag EndProperty

	#tag Property, Flags = &h0
		ColorMixingStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ContactBuffer() As Physics.ParticleContact
	#tag EndProperty

	#tag Property, Flags = &h0
		DampingStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		EjectionStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ElasticStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		GravityScale As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		GroupBuffer As Physics.ParticleGroupSet
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mInverseDensity
			  
			End Get
		#tag EndGetter
		InverseDensity As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		InverseDiameter As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInverseDensity As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParticleDensity As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParticles() As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSolveCollisionCallback As Physics.SolveCollisionCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemp2 As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempRot As Physics.Rot
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempTransform As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempTransform2 As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempVec As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempXf As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTempXf2 As Physics.Transform
	#tag EndProperty

	#tag Property, Flags = &h0
		PairBuffer() As Physics.PsPair
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mParticles.Count
			End Get
		#tag EndGetter
		ParticleCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mParticleDensity
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mParticleDensity = value
			  mInverseDensity = 1 / value
			  
			End Set
		#tag EndSetter
		ParticleDensity As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ParticleDiameter As Double = 1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return GroupBuffer.Count
			End Get
		#tag EndGetter
		ParticleGroupCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return 1.777777 * InverseDensity * InverseDiameter * InverseDiameter
			  
			End Get
		#tag EndGetter
		ParticleInverseMass As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ParticleDensity * ParticleStride * ParticleStride
			  
			End Get
		#tag EndGetter
		ParticleMass As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ParticleDiameter / 2
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ParticleDiameter = 2 * value
			  SquaredDiameter = ParticleDiameter * ParticleDiameter
			  InverseDiameter = 1 / ParticleDiameter
			  
			End Set
		#tag EndSetter
		ParticleRadius As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New UnmodifiableParticleArrayView(mParticles)
			  
			End Get
		#tag EndGetter
		Particles As Physics.UnmodifiableParticleArrayView
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Physics.Settings.ParticleStride * ParticleDiameter
			  
			End Get
		#tag EndGetter
		ParticleStride As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		PowderStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		PressureStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ProxyBuffer() As Physics.PsProxy
	#tag EndProperty

	#tag Property, Flags = &h0
		SpringStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		SquaredDiameter As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		SurfaceTensionStrengthA As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		SurfaceTensionStrengthB As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		TimeStamp As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		TriadBuffer() As Physics.PsTriad
	#tag EndProperty

	#tag Property, Flags = &h0
		ViscousStrength As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		World As Physics.World
	#tag EndProperty


	#tag Constant, Name = NoPressureFlags, Type = Double, Dynamic = False, Default = \"Physics.ParticleType.PowderParticle", Scope = Public, Description = 416C6C207061727469636C652074797065732074686174207265717569726520636F6D707574696E672064657074682E
	#tag EndConstant

	#tag Constant, Name = PairFlags, Type = Double, Dynamic = False, Default = \"Physics.ParticleType.SpringParticle", Scope = Public, Description = 416C6C207061727469636C6520747970657320746861742072657175697265206372656174696E672070616972732E
	#tag EndConstant

	#tag Constant, Name = TagBits, Type = Double, Dynamic = False, Default = \"31", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TriadFlags, Type = Double, Dynamic = False, Default = \"Physics.ParticleType.ElasticParticle", Scope = Public, Description = 416C6C207061727469636C6520747970657320746861742072657175697265206372656174696E67207472696164732E
	#tag EndConstant

	#tag Constant, Name = XMask, Type = Double, Dynamic = False, Default = \"4095", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XOffset, Type = Double, Dynamic = False, Default = \"262144", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XScale, Type = Double, Dynamic = False, Default = \"128", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XShift, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XTruncBits, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YMask, Type = Double, Dynamic = False, Default = \"4095", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YOffset, Type = Double, Dynamic = False, Default = \"2048", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YShift, Type = Double, Dynamic = False, Default = \"19", Scope = Public
	#tag EndConstant

	#tag Constant, Name = YTruncBits, Type = Double, Dynamic = False, Default = \"12", Scope = Public
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
			Name="TimeStamp"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllParticleFlags"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllGroupFlags"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GravityScale"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleDiameter"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InverseDiameter"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SquaredDiameter"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleGroupCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PressureStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DampingStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ElasticStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpringStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViscousStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SurfaceTensionStrengthA"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SurfaceTensionStrengthB"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PowderStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EjectionStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorMixingStrength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleRadius"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InverseDensity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleDensity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleInverseMass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleMass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParticleStride"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

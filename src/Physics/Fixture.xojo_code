#tag Class
Protected Class Fixture
	#tag Method, Flags = &h0, Description = 436F6D70757465207468652064697374616E63652066726F6D207468697320666978747572652E
		Function ComputeDistance(point As VMaths.Vector2, childIndex As Integer, normalOut As VMaths.Vector2) As Double
		  /// Compute the distance from this fixture.
		  ///
		  /// `point` should be in world coordinates.
		  
		  Return Self.Shape.ComputeDistanceToOut( _
		  Self.Body.Transform, _
		  point, _
		  childIndex, _
		  normalOut)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(body As Physics.Body, def As Physics.FixtureDef)
		  mFilter = New Physics.Filter
		  mPool1 = New Physics.AABB
		  mPool2 = New Physics.AABB
		  mDisplacement = VMaths.Vector2.Zero
		  
		  Self.Body = body
		  
		  UserData = def.UserData
		  Friction = def.Friction
		  Restitution = def.Restitution
		  
		  mFilter.Set(def.Filter)
		  
		  mIsSensor = def.IsSensor
		  
		  Self.Shape = def.Shape.Clone
		  
		  // Reserve proxy space.
		  Var childCount As Integer = Self.Shape.ChildCount
		  If Proxies.Count < childCount Then
		    Var old() As Physics.FixtureProxy = Proxies
		    Var newCount As Integer = Max(old.Count * 2, childCount)
		    Proxies.RemoveAll
		    Var xLimit As Integer = newCount - 1
		    For x As Integer = 0 To xLimit
		      Var fp As New Physics.FixtureProxy(Self)
		      fp.ProxyId = Physics.Broadphase.NullProxy
		      Proxies.Add(fp)
		    Next x
		  End If
		  
		  mProxyCount = 0
		  mDensity = def.Density
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865736520737570706F727420626F64792061637469766174696F6E2F646561637469766174696F6E2E
		Sub CreateProxies(broadphase As Physics.Broadphase, xf As Physics.Transform)
		  /// These support body activation/deactivation.
		  
		  #If DebugBuild
		    Assert(mProxyCount = 0)
		  #EndIf
		  
		  // Create proxies in the broadphase.
		  mProxyCount = Self.Shape.ChildCount
		  
		  Var iLimit As Integer = mProxyCount - 1
		  for i As Integer = 0 To iLimit
		    Var proxy As Physics.FixtureProxy = Proxies(i)
		    Self.Shape.ComputeAABB(proxy.AABB, xf, i)
		    proxy.ProxyId = broadPhase.CreateProxy(proxy.AABB, proxy)
		    proxy.ChildIndex = i
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E7465726E616C206D6574686F642E
		Sub DestroyProxies(broadphase As Physics.Broadphase)
		  /// Internal method.
		  
		  // Destroy proxies in the broad-phase.
		  Var iLimit As Integer = mProxyCount - 1
		  For i As Integer = 0 To iLimit
		    Var proxy As Physics.FixtureProxy = Proxies(i)
		    broadPhase.DestroyProxy(proxy.ProxyId)
		    proxy.ProxyId = Physics.BroadPhase.NullProxy
		  Next i
		  
		  mProxyCount = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574207468652066697874757265277320414142422E20546869732041414242206D617920626520656E6C617267656420616E642F6F72207374616C652E20496620796F75206E6565642061206D6F726520616363757261746520414142422C20636F6D70757465206974207573696E672074686520736861706520616E642074686520626F6479207472616E73666F726D2E
		Function GetAABB(childIndex As Integer) As Physics.AABB
		  /// Get the fixture's AABB. This AABB may be enlarged and/or stale. If you
		  /// need a more accurate AABB, compute it using the shape and the body
		  /// transform.
		  
		  #If DebugBuild
		    Assert(childIndex >= 0 And childIndex < mProxyCount)
		  #EndIf
		  
		  Return Proxies(childIndex).AABB
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865206D617373206461746120666F72207468697320666978747572652E20546865206D6173732064617461206973206261736564206F6E207468652064656E7369747920616E64207468652073686170652E2054686520726F746174696F6E616C20696E65727469612069732061626F7574207468652073686170652773206F726967696E2E
		Sub GetMassData(massData As Physics.MassData)
		  /// Get the mass data for this fixture. The mass data is based on the density
		  /// and the shape. The rotational inertia is about the shape's origin.
		  
		  Self.Shape.ComputeMass(massData, mDensity)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4361737420612072617920616761696E737420746869732073686170652E
		Function Raycast(output As Physics.RaycastOutput, input As Physics.RaycastInput, childIndex As Integer) As Boolean
		  /// Cast a ray against this shape.
		  
		  Return Self.Shape.Raycast(output, input, Self.Body.Transform, childIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C207468697320696620796F752077616E7420746F2065737461626C69736820636F6C6C6973696F6E2074686174207761732070726576696F75736C792064697361626C65642062792060436F6E7461637446696C7465722E53686F756C64436F6C6C696465602E
		Sub Refilter()
		  /// Call this if you want to establish collision that was previously disabled
		  /// by `ContactFilter.ShouldCollide`.
		  
		  // Flag associated contacts for filtering.
		  For Each contact As Physics.Contact In Self.Body.Contacts
		    Var fixtureA As Physics.Fixture = contact.FixtureA
		    Var fixtureB As Physics.Fixture = contact.FixtureB
		    
		    If fixtureA = Self Or fixtureB = Self Then
		      contact.FlagForFiltering
		    End If
		  Next contact
		  
		  // Touch each proxy so that new pairs may be created.
		  Var broadPhase As Physics.Broadphase = Self.Body.World.ContactManager.BroadPhase
		  Var iLimit As Integer = mProxyCount - 1
		  For i As Integer = 0 To iLimit
		    broadPhase.TouchProxy(Proxies(i).ProxyId)
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365742069662074686973206669787475726520697320612073656E736F722E
		Sub SetSensor(sensor As Boolean)
		  /// Set if this fixture is a sensor.
		  
		  If sensor <> mIsSensor Then
		    Self.Body.SetAwake(True)
		    mIsSensor = sensor
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Synchronize(broadphase As Physics.Broadphase, transform1 As Physics.Transform, transform2 As Physics.Transform)
		  If mProxyCount = 0 Then Return
		  
		  Var iLimit As Integer = mProxyCount - 1
		  For i As Integer = 0 To iLimit
		    Var proxy As Physics.FixtureProxy = Proxies(i)
		    
		    // Compute an AABB that covers the swept shape (may miss some rotation effect).
		    Var aabb1 As Physics.AABB = mPool1
		    Var aab As Physics.AABB = mPool2
		    
		    Self.Shape.ComputeAABB(aabb1, transform1, proxy.ChildIndex)
		    Self.Shape.ComputeAABB(aab, transform2, proxy.ChildIndex)
		    
		    proxy.AABB.LowerBound.X = _
		    If(aabb1.LowerBound.X < aab.LowerBound.X, aabb1.LowerBound.X, aab.LowerBound.X)
		    
		    proxy.AABB.LowerBound.Y = _
		    If(aabb1.LowerBound.Y < aab.LowerBound.Y, aabb1.LowerBound.Y, aab.LowerBound.Y)
		    
		    proxy.AABB.UpperBound.X = _
		    If(aabb1.UpperBound.X > aab.UpperBound.X, aabb1.UpperBound.X, aab.UpperBound.X)
		    
		    proxy.aabb.UpperBound.Y = _
		    If(aabb1.UpperBound.Y > aab.UpperBound.Y, aabb1.UpperBound.Y, aab.UpperBound.Y)
		    
		    mDisplacement.X = transform2.P.X - transform1.P.X
		    mDisplacement.Y = transform2.P.Y - transform1.P.Y
		    
		    broadPhase.MoveProxy(proxy.ProxyId, proxy.AABB, mDisplacement)
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54657374206120706F696E7420666F7220636F6E7461696E6D656E7420696E207468697320666978747572652E2054686973206F6E6C7920776F726B7320666F7220636F6E766578207368617065732E
		Function TestPoint(point As VMaths.Vector2) As Boolean
		  /// Test a point for containment in this fixture. 
		  /// This only works for convex shapes.
		  ///
		  /// `point` should be in world coordinates.
		  
		  Return Self.Shape.TestPoint(Self.Body.Transform, point)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A fixture is used to attach a shape to a body for collision detection. A
		fixture inherits its transform from its parent. Fixtures hold additional
		non-geometric data such as friction, collision filters, etc. Fixtures are
		created via `Body.CreateFixture()`.
		
		You cannot reuse fixtures.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Body As Physics.Body
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mDensity
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #If DebugBuild
			    Assert(density >= 0.9)
			  #EndIf
			  
			  mDensity = value
			  
			End Set
		#tag EndSetter
		Density As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6E746163742066696C746572696E6720646174612E
		#tag Getter
			Get
			  /// Get the contact filtering data.
			  
			  Return mFilter
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Set the contact filtering data. This is an expensive operation and should
			  /// not be called frequently.
			  ///
			  /// This will not update contacts until the next
			  /// time step when either parent body is awake.
			  /// This automatically calls `Refilter`.
			  
			  mFilter.Set(value)
			  Refilter
			  
			End Set
		#tag EndSetter
		FilterData As Physics.Filter
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Friction As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49732074686973206669787475726520612073656E736F7220286E6F6E2D736F6C6964293F
		#tag Getter
			Get
			  Return mIsSensor
			  
			End Get
		#tag EndGetter
		IsSensor As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDensity As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisplacement As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFilter As Physics.Filter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsSensor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPool1 As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPool2 As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProxyCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Proxies() As Physics.FixtureProxy
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mProxyCount
			  
			End Get
		#tag EndGetter
		ProxyCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Restitution As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Shape As Physics.Shape
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 476574207468652074797065206F6620746865206368696C642073686170652E20596F752063616E20757365207468697320746F20646F776E206361737420746F2074686520636F6E63726574652073686170652E
		#tag Getter
			Get
			  Return Self.Shape.ShapeType
			End Get
		#tag EndGetter
		Type As Physics.ShapeType
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 557365207468697320746F2073746F726520796F7572206170706C69636174696F6E20737065636966696320646174612E
		UserData As Variant
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
			Name="Friction"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Restitution"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
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
		#tag ViewProperty
			Name="IsSensor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Density"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Physics.ShapeType"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

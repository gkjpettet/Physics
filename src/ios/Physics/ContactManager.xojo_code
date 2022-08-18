#tag Class
Protected Class ContactManager
Implements Physics.PairCallback
	#tag Method, Flags = &h0
		Sub AddPair(proxyUserDataA As Variant = Nil, proxyUserDataB As Variant = Nil)
		  // Part of the Physics.PairCallback interface.
		  
		  Var proxyA As Physics.FixtureProxy = proxyUserDataA
		  Var proxyB As Physics.FixtureProxy = proxyUserDataB
		  
		  Var fixtureA As Physics.Fixture = proxyA.Fixture
		  Var fixtureB As Physics.Fixture = proxyB.Fixture
		  
		  Var indexA As Integer = proxyA.ChildIndex
		  Var indexB As Integer = proxyB.ChildIndex
		  
		  Var bodyA As Physics.Body = fixtureA.Body
		  Var bodyB As Physics.Body = fixtureB.Body
		  
		  // Are the fixtures on the same body?
		  If bodyA = bodyB Then
		    Return
		  End If
		  
		  // Check whether a contact already exists.
		  For Each contact As Physics.Contact In bodyB.Contacts
		    If contact.ContainsBody(bodyA) Then
		      If contact.RepresentsArguments(fixtureA, indexA, fixtureB, indexB) Then
		        // A contact already exists.
		        Return
		      End If
		    End If
		  Next contact
		  
		  // Does a joint override collision? Is at least one body dynamic?
		  If Not bodyB.ShouldCollide(bodyA) Then
		    Return
		  End If
		  
		  // Check user filtering.
		  If ContactFilter <> Nil Then
		    If ContactFilter.shouldCollide(fixtureA, fixtureB) = False Then
		      Return
		    End If
		  End If
		  
		  Var contact As Physics.Contact = Physics.Contact.Init(fixtureA, indexA, fixtureB, indexB)
		  
		  // Insert into the world.
		  Contacts.Add(contact)
		  
		  // Connect to island graph.
		  
		  // Connect to the bodies
		  bodyA.Contacts.Add(contact)
		  bodyB.Contacts.Add(contact)
		  
		  // Wake up the bodies.
		  If Not fixtureA.IsSensor And Not fixtureB.IsSensor Then
		    bodyA.SetAwake(True)
		    bodyB.SetAwake(True)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732069732074686520746F70206C6576656C20636F6C6C6973696F6E2063616C6C20666F72207468652074696D6520737465702E204865726520616C6C20746865206E6172726F7720706861736520636F6C6C6973696F6E2069732070726F63657373656420666F722074686520776F726C6420636F6E74616374206C6973742E
		Sub Collide()
		  /// This is the top level collision call for the time step. Here all the
		  /// narrow phase collision is processed for the world contact list.
		  
		  Var contactRemovals() As Physics.Contact
		  
		  // Update awake contacts.
		  For Each c As Physics.Contact In Contacts
		    Var fixtureA As Physics.Fixture = c.FixtureA
		    Var fixtureB As Physics.Fixture = c.FixtureB
		    Var indexA As Integer = c.IndexA
		    Var indexB As Integer = c.IndexB
		    Var bodyA As Physics.Body = fixtureA.Body
		    Var bodyB As Physics.Body = fixtureB.Body
		    
		    // Is this contact flagged for filtering?
		    If (c.Flags And Contact.FilterFlag) = Physics.Contact.FilterFlag Then
		      // Should these bodies collide?
		      If Not bodyB.ShouldCollide(bodyA) Then
		        contactRemovals.Add(c)
		        Continue
		      End If
		      
		      // Check user filtering.
		      If ContactFilter <> Nil Then
		        If ContactFilter.shouldCollide(fixtureA, fixtureB) = False Then
		          contactRemovals.Add(c)
		          Continue
		        End If
		      End If
		      
		      // Clear the filtering flag.
		      c.Flags = c.Flags And OnesComplement(Contact.FilterFlag)
		    End If
		    
		    Var activeA As Boolean = bodyA.IsAwake And bodyA.BodyType <> Physics.BodyType.Static_
		    Var activeB As Boolean = bodyB.IsAwake And bodyB.BodyType <> Physics.BodyType.Static_
		    
		    // At least one body must be awake and it must be dynamic or kinematic.
		    If activeA = False And activeB = False Then
		      Continue
		    End If
		    
		    Var proxyIdA As Integer = fixtureA.Proxies(indexA).ProxyId
		    Var proxyIdB As Integer = fixtureB.Proxies(indexB).ProxyId
		    
		    // Here we destroy contacts that cease to overlap in the broadphase.
		    If Not Broadphase.TestOverlap(proxyIdA, proxyIdB) Then
		      contactRemovals.Add(c)
		      Continue
		    End If
		    
		    // The contact persists.
		    c.Update(contactListener)
		  Next c
		  
		  For Each contact As Physics.Contact In contactRemovals
		    Destroy(contact)
		  Next contact
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(broadphase As Physics.Broadphase)
		  Self.Broadphase = broadphase
		  ContactFilter = New Physics.ContactFilter
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destroy(c As Physics.Contact)
		  Var fixtureA As Physics.Fixture = c.FixtureA
		  Var fixtureB As Physics.Fixture = c.FixtureB
		  
		  If c.IsTouching And ContactListener <> Nil Then
		    ContactListener.EndContact(c)
		  End If
		  
		  Contacts.Remove(c)
		  c.BodyA.Contacts.Remove(c)
		  c.bodyB.contacts.Remove(c)
		  
		  If c.Manifold.PointCount > 0 And Not fixtureA.IsSensor And Not fixtureB.IsSensor Then
		    fixtureA.Body.SetAwake(True)
		    fixtureB.Body.SetAwake(True)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FindNewContacts()
		  Broadphase.UpdatePairs(Self)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Broadphase As Physics.Broadphase
	#tag EndProperty

	#tag Property, Flags = &h0
		ContactFilter As Physics.ContactFilter
	#tag EndProperty

	#tag Property, Flags = &h0
		ContactListener As Physics.ContactListener
	#tag EndProperty

	#tag Property, Flags = &h0
		Contacts() As Physics.Contact
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

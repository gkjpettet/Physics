#tag Class
 Attributes ( Abstract ) Protected Class Contact
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  PositionConstraint = New Physics.ContactPositionConstraint
		  VelocityConstraint = New Physics.ContactPositionConstraint
		  Manifold = New Physics.Manifold
		  mOldManifold = New Physics.Manifold
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fixtureA As Physics.Fixture, indexA As Integer, fixtureB As Physics.Fixture, indexB As Integer)
		  Constructor
		  
		  Self.FixtureA = fixtureA
		  Self.IndexA = indexA
		  Self.FixtureB = fixtureB
		  Self.IndexB = indexB
		  
		  Flags = EnabledFlag
		  Manifold.PointCount = 0
		  
		  mFriction = _
		  Physics.Contact.MixFriction(Self.FixtureA.Friction, Self.FixtureB.Friction)
		  
		  mRestitution = _
		  Physics.Contact.MixRestitution(Self.FixtureA.Restitution, Self.FixtureB.Restitution)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 576865746865722074686520626F647920697320636F6E6E656374656420746F20746865206A6F696E742E
		Function ContainsBody(body As Physics.Body) As Boolean
		  /// Whether the body is connected to the joint.
		  
		  Return body Is BodyA Or body Is BodyB
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Evaluate(manifold As Physics.Manifold, xfA As Physics.Transform, xfB As Physics.Transform)
		  Raise New UnsupportedOperationException("Subclasses should override this method.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 466C6167207468697320636F6E7461637420666F722066696C746572696E672E2046696C746572696E672077696C6C206F6363757220746865206E6578742074696D6520737465702E
		Sub FlagForFiltering()
		  /// Flag this contact for filtering. Filtering will occur the next time step.
		  
		  Flags = Flags Or FilterFlag
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865206F7468657220626F6479207468616E2074686520617267756D656E7420696E2074686520636F6E746163742E
		Function GetOtherBody(body As Physics.Body) As Physics.Body
		  /// Get the other body than the argument in the contact.
		  
		  #If DebugBuild
		    Assert(ContainsBody(body), "Body is not in contact.")
		  #EndIf
		  
		  Return If(body Is BodyA, BodyB, BodyA)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4765742074686520776F726C64206D616E69666F6C642E
		Sub GetWorldManifold(worldManifold As Physics.WorldManifold)
		  /// Get the world manifold.
		  
		  worldManifold.Initialize( _
		  Manifold, _
		  FixtureA.Body.Transform, _
		  FixtureA.Shape.Radius, _
		  FixtureB.Body.Transform, _
		  FixtureB.Shape.Radius)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Init(fixtureA As Physics.Fixture, indexA As Integer, fixtureB As Physics.Fixture, indexB As Integer) As Physics.Contact
		  // Remember that we use the order in the enumeration here to determine in which
		  // order the arguments should come in the different contact classes.
		  // { CIRCLE, EDGE, POLYGON, CHAIN }
		  
		  // This is horrid and needs tidying up but for now we will just port Forge2D verbatim.
		  
		  Var typeA As Physics.ShapeType = _
		  If(Integer(fixtureA.Type) < Integer(fixtureB.Type), fixtureA.Type, fixtureB.Type)
		  
		  Var typeB As Physics.ShapeType = _
		  If(fixtureA.Type = typeA, fixtureB.Type, fixtureA.Type)
		  
		  Var indexTemp As Integer = indexA
		  Var firstIndex As Integer = If(fixtureA.Type = typeA, indexA, indexB)
		  Var secondIndex As Integer = If(fixtureB.Type = typeB, indexB, indexTemp)
		  Var temp As Physics.Fixture = fixtureA
		  Var firstFixture As Physics.Fixture = If(fixtureA.Type = typeA, fixtureA, fixtureB)
		  Var secondFixture As Physics.Fixture = If(fixtureB.Type = typeB, fixtureB, temp)
		  
		  If typeA = Physics.ShapeType.Circle And typeB = Physics.ShapeType.Circle Then
		    Return New Physics.CircleContact(firstFixture, secondFixture)
		    
		  ElseIf typeA = Physics.ShapeType.Polygon And typeB = Physics.ShapeType.Polygon Then
		    Return New Physics.PolygonContact(firstFixture, secondFixture)
		    
		  ElseIf typeA = Physics.ShapeType.Circle And typeB = Physics.ShapeType.Polygon Then
		    Return New PolygonAndCircleContact(secondFixture, firstFixture)
		    
		  ElseIf typeA = Physics.ShapeType.Circle And typeB = Physics.ShapeType.Edge Then
		    Return New Physics.EdgeAndCircleContact(secondFixture, secondIndex, _
		    firstFixture, firstIndex)
		    
		  ElseIf typeA = Physics.ShapeType.Edge And typeB = Physics.ShapeType.Polygon Then
		    Return New Physics.EdgeAndPolygonContact(firstFixture, firstIndex, _
		    secondFixture, secondIndex)
		    
		  ElseIf typeA = Physics.ShapeType.Circle And typeB = Physics.ShapeType.Chain Then
		    Return New Physics.ChainAndCircleContact(secondFixture, secondIndex, _
		    firstFixture, firstIndex)
		    
		  ElseIf typeA = Physics.ShapeType.Polygon And typeB = Physics.ShapeType.Chain Then
		    Return New Physics.ChainAndPolygonContact(secondFixture, secondIndex, _
		    firstFixture, firstIndex)
		    
		  Else
		    Assert(False, "Incompatible contact type.")
		    Return New Physics.CircleContact(firstFixture, secondFixture)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 486173207468697320636F6E74616374206265656E2064697361626C65643F
		Function IsEnabled() As Boolean
		  /// Has this contact been disabled?
		  
		  Return (Flags And EnabledFlag) = EnabledFlag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4973207468697320636F6E7461637420746F756368696E673F
		Function IsTouching() As Boolean
		  /// Is this contact touching?
		  
		  Return (Flags And TouchingFlag) = TouchingFlag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4672696374696F6E206D6978696E67206C61772E20546865206964656120697320746F20616C6C6F7720656974686572206669787475726520746F20647269766520746865207265737469747574696F6E20746F207A65726F2E20466F72206578616D706C652C20616E797468696E6720736C69646573206F6E206963652E
		Shared Function MixFriction(friction1 As Double, friction2 As Double) As Double
		  /// Friction mixing law. The idea is to allow either fixture to drive the
		  /// restitution to zero. For example, anything slides on ice.
		  
		  Return Sqrt(friction1 * friction2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265737469747574696F6E206D6978696E67206C61772E20546865206964656120697320616C6C6F7720666F7220616E797468696E6720746F20626F756E6365206F666620616E20696E656C617374696320737572666163652E20466F72206578616D706C652C20612073757065722062616C6C20626F756E636573206F6E20616E797468696E672E
		Shared Function MixRestitution(restitution1 As Double, restitution2 As Double) As Double
		  /// Restitution mixing law. The idea is allow for anything to bounce off an
		  /// inelastic surface. For example, a super ball bounces on anything.
		  
		  Return If(restitution1 > restitution2, restitution1, restitution2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RepresentsArguments(fixtureA As Physics.Fixture, indexA As Integer, fixtureB As Physics.Fixture, indexB As Integer) As Boolean
		  Return (Self.fixtureA Is fixtureA And _
		  Self.indexA = indexA And _
		  Self.fixtureB Is fixtureB And _
		  Self.indexB = indexB) Or _
		  (Self.fixtureA Is fixtureB And _ 
		  Self.indexA = indexB And _ 
		  Self.fixtureB Is fixtureA And _
		  Self.indexB = indexA)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetFriction()
		  mFriction = Physics.Contact.MixFriction(FixtureA.Friction, FixtureB.Friction)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetRestitution()
		  mRestitution = _
		  Physics.Contact.MixRestitution(FixtureA.Restitution, FixtureB.restitution)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 456E61626C652F64697361626C65207468697320636F6E746163742E20546869732063616E206265207573656420696E7369646520746865207072652D736F6C766520636F6E74616374206C697374656E65722E2054686520636F6E74616374206973206F6E6C792064697361626C656420666F72207468652063757272656E742074696D65207374657020286F72207375622D7374657020696E20636F6E74696E756F757320636F6C6C6973696F6E73292E
		Sub SetEnabled(enable As Boolean)
		  /// Enable/disable this contact. This can be used inside the pre-solve contact listener. 
		  /// The contact is only disabled for the current time step
		  /// (or sub-step in continuous collisions).
		  
		  If enable Then
		    Flags = Flags Or EnabledFlag
		  Else
		    Flags = Flags And OnesComplement(EnabledFlag)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update(listener As Physics.ContactListener)
		  mOldManifold.Set(Manifold)
		  
		  // Re-enable this contact.
		  Flags = Flags Or EnabledFlag
		  
		  Var touching As Boolean = False
		  Var wasTouching As Boolean = (Flags And TouchingFlag) = TouchingFlag
		  
		  Var sensorA As Boolean = FixtureA.IsSensor
		  Var sensorB As Boolean = FixtureB.IsSensor
		  Var sensor As Boolean = sensorA Or sensorB
		  
		  Var bodA As Physics.Body = FixtureA.Body
		  Var bodB As Physics.Body = FixtureB.Body
		  Var xfA As Physics.Tranform = bodA.Transform
		  Var xfB As Physics.Transform = bodB.Transform
		  
		  If sensor Then
		    Var shapeA As Physics.Shape = FixtureA.Shape
		    Var shapeB As Physics.Shape = FixtureB.Shape
		    touching = World.collision.testOverlap( shapeA, indexA, shapeB, indexB, xfA, xfB)
		    
		    // Sensors don't generate manifolds.
		    Manifold.PointCount = 0
		  Else
		    Evaluate(Manifold, xfA, xfB)
		    touching = Manifold.PointCount > 0
		    
		    // Match old contact ids to new contact ids and copy the
		    // stored impulses to warm start the solver.
		    Var iLimit As Integer = Manifold.PointCount - 1
		    For i As Integer = 0 To iLimit
		      Var mp2 As Physics.ManifoldPoint = Manifold.Points(i)
		      mp2.NormalImpulse = 0.0
		      mp2.TangentImpulse = 0.0
		      Var id2 As Physics.ContactID = mp2.ID
		      
		      Var jLimit As Integer = mOldManifold.PointCount - 1
		      For j As Integer = 0 To jLimit
		        Var mp1 As Physics.ManifoldPoint = mOldManifold.Points(j)
		        
		        If mp1.ID.IsEqual(id2) Then
		          mp2.NormalImpulse = mp1.NormalImpulse
		          mp2.TangentImpulse = mp1.TangentImpulse
		          Exit
		        End If
		      Next j
		    Next i
		    
		    If touching <> wasTouching Then
		      bodA.SetAwake(True)
		      bodB.SetAwake(True)
		    End If
		  End If
		  
		  If touching Then
		    Flags = Flags Or TouchingFlag
		  Else
		    Flags = Flags And OnesComplement(TouchingFlag)
		  End If
		  
		  If listener = Nil Then
		    Return
		  End If
		  
		  If Not wasTouching And touching Then
		    listener.BeginContact(Self)
		  End If
		  
		  If wasTouching And Not touching Then
		    listener.EndContact(Self)
		  End If
		  
		  If Not sensor And touching Then
		    listener.PreSolve(Self, mOldManifold)
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		The class manages contact between two shapes. A contact exists for each
		overlapping AABB in the broad-phase (except if filtered). Therefore a
		contact object may exist that has no contact points.
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return FixtureA.Body
			  
			End Get
		#tag EndGetter
		BodyA As Physics.Body
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return FixtureB.Body
			  
			End Get
		#tag EndGetter
		BodyB As Physics.Body
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		FixtureA As Physics.Fixture
	#tag EndProperty

	#tag Property, Flags = &h0
		FixtureB As Physics.Fixture
	#tag EndProperty

	#tag Property, Flags = &h0
		Flags As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mFriction
			  
			End Get
		#tag EndGetter
		Friction As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		IndexA As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		IndexB As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Manifold As Physics.Manifold
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFriction As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOldManifold As Physics.Manifold
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRestitution As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		PositionConstraint As Physics.ContactPositionConstraint
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mRestitution
			  
			End Get
		#tag EndGetter
		Restitution As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		TangentSpeed As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		TOI As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		TOICount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		VelocityConstraint As Physics.ContactPositionConstraint
	#tag EndProperty


	#tag Constant, Name = BulletHitFlag, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Public, Description = 546869732062756C6C657420636F6E7461637420686164206120544F49206576656E742E
	#tag EndConstant

	#tag Constant, Name = EnabledFlag, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public, Description = 5468697320636F6E746163742063616E2062652064697361626C6564202862792075736572292E
	#tag EndConstant

	#tag Constant, Name = FilterFlag, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Public, Description = 5468697320636F6E74616374206E656564732066696C746572696E672062656361757365206120666978747572652066696C74657220776173206368616E6765642E
	#tag EndConstant

	#tag Constant, Name = IslandFlag, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public, Description = 55736564207768656E20637261776C696E6720636F6E74616374206772617068207768656E20666F726D696E672069736C616E64732E
	#tag EndConstant

	#tag Constant, Name = TOIFlag, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TouchingFlag, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public, Description = 536574207768656E20746865207368617065732061726520746F756368696E672E
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
			Name="Flags"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

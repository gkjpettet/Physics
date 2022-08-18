#tag Class
Protected Class ManifoldPoint
	#tag Method, Flags = &h0, Description = 426C616E6B206D616E69666F6C6420706F696E7420776974682065766572797468696E67207A65726F6564206F75742E
		Sub Constructor()
		  /// Blank manifold point with everything zeroed out.
		  
		  LocalPoint = VMaths.Vector2.Zero
		  Id = New Physics.ContactID
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465732061206D616E69666F6C6420706F696E74206173206120636F7079206F662074686520676976656E20706F696E742E
		Shared Function Copy(manifoldPoint As Physics.ManifoldPoint) As Physics.ManifoldPoint
		  /// Creates a manifold point as a copy of the given point.
		  
		  Var newPoint As New Physics.ManifoldPoint
		  
		  newPoint.LocalPoint = manifoldPoint.LocalPoint.Clone
		  newPoint.NormalImpulse = manifoldPoint.NormalImpulse
		  newPoint.TangentImpulse = manifoldPoint.TangentImpulse
		  newPoint.ID = Physics.ContactID.Copy(manifoldPoint.ID)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206D616E69666F6C6420706F696E742066726F6D2074686520676976656E206F6E652E
		Sub Set(manifoldPoint As Physics.ManifoldPoint)
		  /// Sets this manifold point from the given one.
		  
		  LocalPoint.SetFrom(manifoldPoint.LocalPoint)
		  NormalImpulse = manifoldPoint.NormalImpulse
		  TangentImpulse = manifoldPoint.TangentImpulse
		  ID.Set(manifoldPoint.ID)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		 A manifold point is a contact point belonging to a contact
		 manifold. It holds details related to the geometry and dynamics
		 of the contact points.
		
		 The local point usage depends on the manifold type:
		
		  - e_circles: the local center of circleB.
		  - e_faceA: the local center of cirlceB or the clip point of polygonB.
		  - e_faceB: the clip point of polygonA.
		
		 This structure is stored across time steps, so we keep it small.
		 Note: the impulses are used for internal caching and may not
		 provide reliable contact forces, especially for high speed collisions.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 556E697175656C79206964656E746966696573206120636F6E7461637420706F696E74206265747765656E2074776F207368617065732E
		ID As Physics.ContactID
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557361676520646570656E6473206F6E206D616E69666F6C6420747970652E
		LocalPoint As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E6F6E2D70656E6574726174696F6E20696D70756C73652E
		NormalImpulse As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206672696374696F6E20696D70756C73652E
		TangentImpulse As Double = 0
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
			Name="NormalImpulse"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TangentImpulse"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

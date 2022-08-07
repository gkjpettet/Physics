#tag Class
 Attributes ( Abstract ) Protected Class Joint
	#tag Method, Flags = &h0
		Sub Constructor(def As Physics.JointDef)
		  #If DebugBuild
		    Assert(def.bodyA <> def.bodyB)
		  #EndIf
		  
		  localAnchorA = def.LocalAnchorA
		  localAnchorB = def.LocalAnchorB
		  
		  bodyA = def.BodyA
		  bodyB = def.BodyB
		  mCollideConnected = def.CollideConnected
		  IslandFlag = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 576865746865722074686520626F647920697320636F6E6E656374656420746F20746865206A6F696E742E
		Function ContainsBody(body As Physics.Body) As Boolean
		  /// Whether the body is connected to the joint.
		  
		  Return body Is BodyA Or body Is BodyB
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562636C61737365732073686F756C64206F76657272696465207468697320746F2068616E646C6520746865206465737472756374696F6E206F6620746865206A6F696E742E
		Sub Destroy()
		  /// Subclasses should override this to handle the destruction of the joint.
		  
		  Raise New UnsupportedOperationException("Subclasses should override this.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Destroy(joint As Physics.Joint)
		  joint.Destroy
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitVelocityConstraints(data As Physics.SolverData)
		  #Pragma Unused data
		  
		  Raise New UnsupportedOperationException("Subclasses should override this.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865206F7468657220626F6479207468616E2074686520617267756D656E7420696E20746865206A6F696E742E
		Function OtherBody(body As Physics.Body) As Physics.Body
		  /// Get the other body than the argument in the joint.
		  
		  #If DebugBuild
		    Assert(ContainsBody(body), "Body is not in the joint.")
		  #EndIf
		  
		  Return If(body Is BodyA, BodyB, BodyA)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865207265616374696F6E20666F726365206F6E20626F64793220617420746865206A6F696E7420616E63686F7220696E204E6577746F6E732E
		Function ReactionForce(invDt As Double) As VMaths.Vector2
		  /// Get the reaction force on body2 at the joint anchor in Newtons.
		  
		  #Pragma Unused invDt
		  
		  Raise New UnsupportedOperationException("This method should be overridden by subclasses.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47657420746865207265616374696F6E20746F72717565206F6E20626F64793220696E204E2A6D2E
		Function ReactionTorque(invDt As Double) As Double
		  /// Get the reaction torque on body2 in N*m.
		  
		  #Pragma Unused invDt
		  
		  Raise New UnsupportedOperationException("This method should be overridden by subclasses.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Render(debugDraw As Physics.DebugDraw)
		  #Pragma Warning "TODO: Need to implement"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662074686520706F736974696F6E206572726F7273206172652077697468696E20746F6C6572616E63652E20496E7465726E616C2E
		Function SolvePositionConstraints(data As Physics.SolverData) As Boolean
		  #Pragma Unused data
		  
		  Raise New UnsupportedOperationException("Subclasses should override this.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveVelocityConstraints(data As Physics.SolverData)
		  #Pragma Unused data
		  
		  Raise New UnsupportedOperationException("Subclasses should override this.")
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		The base joint class. Joints are used to constrain two bodies together in
		various fashions. Some joints also feature limits and motors.
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 4765742074686520616E63686F7220706F696E74206F6E2060426F6479416020696E20776F726C6420636F6F7264696E617465732E
		#tag Getter
			Get
			  Return BodyA.WorldPoint(LocalAnchorA)
			End Get
		#tag EndGetter
		AnchorA As VMaths.Vector2
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 4765742074686520616E63686F7220706F696E74206F6E2060426F6479426020696E20776F726C6420636F6F7264696E617465732E
		#tag Getter
			Get
			  // Get the anchor point on `BodyB` in world coordinates.
			  
			  Return BodyB.WorldPoint(LocalAnchorB)
			  
			End Get
		#tag EndGetter
		AnchorB As VMaths.Vector2
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		BodyA As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		BodyB As Physics.Body
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Note: modifying the collide connect flag won't work
			  // correctly because the flag is only checked when fixture AABBs begin to overlap.
			  
			  Return mCollideConnected
			End Get
		#tag EndGetter
		CollideConnected As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 53686F7274637574206D6574686F6420746F2064657465726D696E652069662065697468657220626F647920697320696E6163746976652E
		#tag Getter
			Get
			  Return BodyA.IsActive And BodyB.IsActive
			End Get
		#tag EndGetter
		IsActive As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		IslandFlag As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalAnchorA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		LocalAnchorB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCollideConnected As Boolean = False
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
	#tag EndViewBehavior
End Class
#tag EndClass

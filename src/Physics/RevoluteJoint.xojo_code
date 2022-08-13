#tag Class
Protected Class RevoluteJoint
Inherits Physics.Joint
	#tag Method, Flags = &h0
		Sub Constructor(def As Physics.RevoluteJointDef)
		  Super.Constructor(def)
		  
		  mImpulse = VMaths.Vector3.Zero
		  mRA = VMaths.Vector2.Zero
		  mRB = VMaths.Vector2.Zero
		  mLocalCenterA = VMaths.Vector2.Zero
		  mLocalCenterB = VMaths.Vector2.Zero
		  
		  mMass = VMaths.Matrix3.Zero
		  
		  LocalAnchorA.SetFrom(def.LocalAnchorA)
		  LocalAnchorB.SetFrom(def.LocalAnchorB)
		  mReferenceAngle = def.ReferenceAngle
		  
		  mLowerAngle = def.LowerAngle
		  mUpperAngle = def.UpperAngle
		  mMaxMotorTorque = def.MaxMotorTorque
		  mMotorSpeed = def.MotorSpeed
		  mEnableLimit = def.EnableLimit
		  mEnableMotor = def.EnableMotor
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A revolute joint constrains two bodies to share a common point while they
		are free to rotate about the point. The relative rotation about the shared
		point is the joint angle. You can limit the relative rotation with a joint
		limit that specifies a lower and upper angle. You can use a motor to drive
		the relative rotation about the shared point. A maximum motor torque is
		provided so that infinite forces are not generated.
		
		Point-to-point constraint
		C = p2 - p1
		Cdot = v2 - v1
		     = v2 + cross(w2, r2) - v1 - cross(w1, r1)
		J = [-I -r1_skew I r2_skew ]
		Identity used:
		w k % (rx i + ry j) = w * (-ry i + rx j)
		
		Motor constraint
		Cdot = w2 - w1
		J = [0 0 -1 0 0 1]
		K = invI1 + invI2
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mEnableLimit
			  
			End Get
		#tag EndGetter
		LimitEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLowerAngle
			End Get
		#tag EndGetter
		LowerLimit As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mMaxMotorTorque
			  
			End Get
		#tag EndGetter
		MaxMotorTorque As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEnableLimit As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnableMotor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImpulse As VMaths.Vector3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexA As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexB As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvIA As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvIB As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvMassA As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInvMassB As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLimitState As Physics.LimitState = Physics.LimitState.Inactive
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocalCenterB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLowerAngle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 456666656374697665206D61737320666F7220706F696E742D746F2D706F696E7420636F6E73747261696E742E
		Private mMass As VMaths.Matrix3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxMotorTorque As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMotorImpulse As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 456666656374697665206D61737320666F72206D6F746F722F6C696D697420616E67756C617220636F6E73747261696E742E
		Private mMotorMass As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMotorSpeed As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mEnableMotor
			End Get
		#tag EndGetter
		MotorEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mMotorSpeed
			  
			End Get
		#tag EndGetter
		MotorSpeed As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mRA As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRB As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReferenceAngle As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpperAngle As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mReferenceAngle
			  
			End Get
		#tag EndGetter
		ReferenceAngle As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mUpperAngle
			  
			End Get
		#tag EndGetter
		UpperLimit As Double
	#tag EndComputedProperty


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
		#tag ViewProperty
			Name="MotorEnabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxMotorTorque"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MotorSpeed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LimitEnabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReferenceAngle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LowerLimit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

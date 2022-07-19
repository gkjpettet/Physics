#tag Class
Protected Class World
	#tag Property, Flags = &h0
		Bodies() As Physics.Body
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
		ContactManager As Physics.ContactManager
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

	#tag Property, Flags = &h0
		mAllowSleep As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContinuousPhysics As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGravity As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F20636F6D70757465207468652074696D65207374657020726174696F20746F20737570706F72742061207661726961626C652074696D6520737465702E0A
		Private mInvDt0 As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Physics.Profile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStepComplete As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubStepping As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWarmStarting As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleDestroyListener As Physics.ParticleDestroyListener
	#tag EndProperty

	#tag Property, Flags = &h0
		ParticleSystem As Physics.ParticleSystem
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
	#tag EndViewBehavior
End Class
#tag EndClass

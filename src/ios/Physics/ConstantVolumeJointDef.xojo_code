#tag Class
Protected Class ConstantVolumeJointDef
Inherits Physics.JointDef
	#tag Method, Flags = &h0, Description = 41646473206120626F647920746F207468652067726F75702E
		Sub AddBody(body As Physics.Body)
		  /// Adds a body to the group.
		  
		  Bodies.Add(body)
		  If bodies.Count = 1 Then
		    BodyA = body
		  End If
		  
		  If bodies.Count = 2 Then
		    BodyB = body
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206120626F647920616E6420746865207072652D6D6164652064697374616E6365206A6F696E742E2053686F756C64206F6E6C79206265207573656420666F7220646573657269616C69736174696F6E2E
		Sub AddBodyAndJoint(argBody As Physics.Body, argJoint As Physics.Joint)
		  /// Adds a body and the pre-made distance joint. Should only be used for deserialisation.
		  
		  AddBody(argBody)
		  Joints.Add(argJoint)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Definition for a `ConstantVolumeJoint`, which connects a group a
		bodies together so they maintain a constant volume within them
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		Bodies() As Physics.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		DampingRatio As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		FrequencyHz As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Joints() As Physics.Joint
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
			Name="DampingRatio"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FrequencyHz"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

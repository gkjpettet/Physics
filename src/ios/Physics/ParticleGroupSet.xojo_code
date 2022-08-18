#tag Class
Protected Class ParticleGroupSet
	#tag Method, Flags = &h0, Description = 41646473206070676020746F2074686973207365742E2052657475726E7320605472756560206966206076616C75656020776173202A6E6F742A20696E2074686520736574206F72206046616C736560206966206974207761732028616E642074686520736574206973206E6F74206368616E676564292E
		Function Add(pg As Physics.ParticleGroup) As Boolean
		  /// Adds `pg` to this set. Returns `True` if `value` was *not* in the set or 
		  /// `False` if it was (and the set is not changed).
		  
		  If mParticleGroups.IndexOf(pg) = -1 Then
		    // Not in the set.
		    mParticleGroups.Add(pg)
		    Return True
		  Else
		    // Already in the set.
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520656C656D656E742061742060696E646578602E
		Function ElementAt(index As Integer) As Physics.ParticleGroup
		  /// Returns the element at `index`.
		  
		  Return mParticleGroups(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320607067602066726F6D20746865207365742E2052657475726E732060547275656020696620607067602077617320696E20746865207365742E204E6F20656666656374206966206070676020776173206E6F7420696E20746865207365742E
		Function Remove(pg As Physics.ParticleGroup) As Boolean
		  /// Removes `pg` from the set. Returns `True` if `pg` was in the set. 
		  /// No effect if `pg` was not in the set.
		  
		  Var index As Integer = mParticleGroups.IndexOf(pg)
		  
		  If index = -1 Then
		    // Not in the set.
		    Return False
		  Else
		    // In the set. Remove it.
		    mParticleGroups.RemoveAt(index)
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F7665732074686520656C656D656E742061742060696E646578602E
		Sub RemoveAt(index As Integer)
		  /// Removes the element at `index`.
		  
		  mParticleGroups.RemoveAt(index)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mParticleGroups.Count
			  
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mParticleGroups.LastIndex
			End Get
		#tag EndGetter
		LastIndex As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mParticleGroups() As Physics.ParticleGroup
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
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

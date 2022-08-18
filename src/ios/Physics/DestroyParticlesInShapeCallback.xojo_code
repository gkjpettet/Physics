#tag Class
Protected Class DestroyParticlesInShapeCallback
Implements Physics.ParticleQueryCallback
	#tag Method, Flags = &h0
		Sub Constructor(system As Physics.ParticleSystem, shape As Physics.Shape, xf As Physics.Transform, callDestructionListener As Boolean = False)
		  Self.System = system
		  Self.Shape = shape
		  Self.Xf = xf
		  Self.CallDestructionListener = callDestructionListener
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReportParticle(particle As Physics.Particle) As Boolean
		  // Part of the Physics.ParticleQueryCallback interface.
		  
		  If shape.TestPoint(xf, particle.Position) Then
		    Self.System.DestroyParticle(particle, CallDestructionListener)
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		CallDestructionListener As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Shape As Physics.Shape
	#tag EndProperty

	#tag Property, Flags = &h0
		System As Physics.ParticleSystem
	#tag EndProperty

	#tag Property, Flags = &h0
		Xf As Physics.Transform
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
			Name="CallDestructionListener"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

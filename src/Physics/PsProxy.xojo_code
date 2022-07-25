#tag Class
Protected Class PsProxy
	#tag Method, Flags = &h0
		Function CompareTo(o As Physics.PsProxy) As Integer
		  Return If((Tag - o.Tag) < 0, -1, If(o.Tag = Tag, 0, 1))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(particle As Physics.Particle)
		  Self.Particle = particle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Equals(obj As Physics.PsProxy) As Boolean
		  Return Tag = obj.Tag
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Used for detecting particle contacts.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Particle As Physics.Particle
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Integer = 0
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
			Name="Tag"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

#tag Class
Protected Class Collision
	#tag Method, Flags = &h0
		Sub Constructor()
		  mInput = New Physics.DistanceInput
		  mCache = New Physics.SimplexCache
		  mOutput = New Physics.DistanceOutput
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Functions used for computing contact points, distance queries, and TOI
		queries. 
		
		Collision methods are non-static for pooling speed, retrieve a
		collision object from the SingletonPool.
		
		
	#tag EndNote

	#tag Note, Name = Progress
		
		Up to (not including) TestOverlap().
	#tag EndNote


	#tag Property, Flags = &h0
		mCache As Physics.SimplexCache
	#tag EndProperty

	#tag Property, Flags = &h0
		mInput As Physics.DistanceInput
	#tag EndProperty

	#tag Property, Flags = &h0
		mOutput As Physics.DistanceOutput
	#tag EndProperty


	#tag Constant, Name = NullFeature, Type = Double, Dynamic = False, Default = \"&h3FFFFFFF", Scope = Public
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
			Name="mInput"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

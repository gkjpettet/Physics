#tag Interface
Protected Interface RaycastCallback
	#tag Method, Flags = &h0, Description = 43616C6C656420666F722065616368206669787475726520666F756E6420696E207468652071756572792E20596F7520636F6E74726F6C20686F77207468652072617920636173742070726F63656564732062792072657475726E696E67206120666C6F61743A0A52657475726E202D313A2069676E6F72652074686973206669787475726520616E6420636F6E74696E75650A2052657475726E20303A207465726D696E617465207468652072617920636173740A2052657475726E206672616374696F6E3A20636C6970207468652072617920746F207468697320706F696E740A2052657475726E20313A20646F6E277420636C6970207468652072617920616E6420636F6E74696E75650A206066697874757265602069732074686520666978747572652068697420627920746865207261792E0A2060706F696E74602069732074686520706F696E74206F6620696E697469616C20696E74657273656374696F6E2E0A2020606E6F726D616C6020697320746865206E6F726D616C20766563746F722061742074686520706F696E74206F6620696E74657273656374696F6E2E
		Function ReportFixture(fixture As Physics.Fixture, point As VMaths.Vector2, normal As VMaths.Vector2, fraction As Double) As Double
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Callback class for ray casts.
		See `World.`Raycast`.
		
		ReportFixture()
		---------------
		Called every time a fixture is found that is hit by a ray.
		
		If a ray is long enough there could be many fixtures that it intersects with, and this callback could be 
		called many times during one RayCast. Very importantly, this raycast does not detect fixtures in order of 
		nearest to furthest, it just gives them to you in any order. 
		
		The engine lets you decide how you want to deal with each fixture as it is encountered. This is where the 
		return value of the callback comes in. You will return a floating point value, which you can think of as 
		adjusting the length of the ray while the raycast is in progress:
		
		Return `-1` to completely ignore the current intersection
		Return a value from `0 - 1` to adjust the length of the ray, for example:
		  returning `0` says there is now no ray at all
		  returning `1` says that the ray length does not change
		  returning the `fraction` value makes the ray just long enough to hit the intersected fixture
		
		Here the fraction value refers to the 'fraction' parameter that is passed to the callback. 
		
		Remember the common cases:
		To find only the closest intersection:
		 - return the fraction value from the callback
		 - use the most recent intersection as the result
		
		To find all intersections along the ray:
		 - return 1 from the callback
		 - store the intersections in an array
		
		To simply find if the ray hits anything:
		 - if you get a callback, something was hit (but it may not be the closest)
		 - return 0 from the callback for efficiency
		
	#tag EndNote


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
	#tag EndViewBehavior
End Interface
#tag EndInterface

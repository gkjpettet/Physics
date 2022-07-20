#tag Interface
Protected Interface ParticleRaycastCallback
	#tag Method, Flags = &h0
		Function Fraction() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Index() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Normal() As VMaths.Vector2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Point() As VMaths.Vector2
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Called for each particle found in the query.
		See `RayCastCallback.ReportFixture` for more info.
		
	#tag EndNote


End Interface
#tag EndInterface

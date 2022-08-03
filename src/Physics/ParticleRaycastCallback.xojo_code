#tag Interface
Protected Interface ParticleRaycastCallback
	#tag Method, Flags = &h0
		Function ReportParticle(index As Integer, point As VMaths.Vector2, normal As VMaths.Vector2, fraction As Double) As Double
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Called for each particle found in the query.
		See `RayCastCallback.ReportFixture` for more info.
		
	#tag EndNote


End Interface
#tag EndInterface

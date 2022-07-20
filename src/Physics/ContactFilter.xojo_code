#tag Class
Protected Class ContactFilter
	#tag Method, Flags = &h0, Description = 52657475726E73205472756520696620636F6E746163742063616C63756C6174696F6E732073686F756C6420626520706572666F726D6564206265747765656E2074686573652074776F207368617065732E
		Function ShouldCollide(fixtureA As Physics.Fixture, fixtureB As Physics.Fixture) As Boolean
		  /// Returns True if contact calculations should be performed between these two
		  /// shapes.
		  ///
		  /// Warning: for performance reasons this is only called when the AABBs begin
		  /// to overlap.
		  
		  Var filterA As Physics.Filter = fixtureA.FilterData
		  Var filterB As Physics.Filter = fixtureB.FilterData
		  
		  If filterA.GroupIndex = filterB.GroupIndex And filterA.GroupIndex <> 0 Then
		    Return filterA.GroupIndex > 0
		  End If
		  
		  Return ((filterA.MaskBits And filterB.CategoryBits) <> 0) And _
		  ((filterA.CategoryBits & filterB.MaskBits) <> 0)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Implement this class to provide collision filtering. In other words, you can
		implement this class if you want finer control over contact creation.
		
	#tag EndNote


End Class
#tag EndClass

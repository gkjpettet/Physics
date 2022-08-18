#tag Class
Protected Class PolygonContact
Inherits Physics.Contact
	#tag Method, Flags = &h0
		Sub Constructor(fixtureA As Physics.Fixture, fixtureB As Physics.Fixture)
		  #If DebugBuild
		    Assert(fixtureA.Type = Physics.ShapeType.Polygon)
		    Assert(fixtureB.Type = Physics.ShapeType.Polygon)
		  #EndIf
		  
		  Super.Constructor(fixtureA, 0, fixtureB, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Evaluate(manifold As Physics.Manifold, xfA As Physics.Transform, xfB As Physics.Transform)
		  World.Collision.CollidePolygons( _
		  manifold, _
		  Physics.PolygonShape(fixtureA.Shape), _
		  xfA, _
		  Physics.PolygonShape(fixtureB.Shape), _
		  xfB)
		  
		End Sub
	#tag EndMethod


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
End Class
#tag EndClass

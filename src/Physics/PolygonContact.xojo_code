#tag Class
Protected Class PolygonContact
Inherits Physics.Contact
	#tag Method, Flags = &h0
		Sub Constructor(fixtureA As Physics.Fixture, fixtureBV As Physics.Fixture)
		  #Pragma Unused fixtureBV
		  
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


End Class
#tag EndClass

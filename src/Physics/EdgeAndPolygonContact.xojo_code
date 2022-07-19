#tag Class
Protected Class EdgeAndPolygonContact
Inherits Physics.Contact
	#tag Method, Flags = &h0
		Sub Constructor(fixtureA As Physics.Fixture, indexA As Integer, fixtureB As Physics.Fixture, indexB As Integer)
		  #If DebugBuild
		    Assert(fixtureA.Type = Physics.ShapeType.Edge)
		    Assert(fixtureB.Type = Physics.ShapeType.Polygon)
		  #EndIf
		  
		  Super.Constructor(fixtureA, indexA, fixtureB, indexB)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Evaluate(manifold As Physics.Manifold, xfA As Physics.Transform, xfB As Physics.Transform)
		  World.Collision.CollideEdgeAndPolygon( _
		  manifold, _
		  Physics.EdgeShape(fixtureA.Shape), _
		  xfA, _
		  Physics.PolygonShape(fixtureB.shape), _
		  xfB)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass

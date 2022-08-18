#tag Class
Protected Class CircleContact
Inherits Physics.Contact
	#tag Method, Flags = &h0
		Sub Constructor(fixtureA As Physics.Fixture, fixtureB As Physics.Fixture)
		  #If DebugBuild
		    Assert(fixtureA.Type = Physics.ShapeType.Circle)
		    Assert(fixtureB.Type = Physics.ShapeType.Circle)
		  #EndIf
		  
		  Super.Constructor(fixtureA, 0, fixtureB, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Evaluate(manifold As Physics.Manifold, xfA As Physics.Transform, xfB As Physics.Transform)
		  World.Collision.CollideCircles( _
		  manifold, _
		  Physics.CircleShape(fixtureA.Shape), _
		  xfA, _
		  Physics.CircleShape(fixtureB.Shape), _
		  xfB)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass

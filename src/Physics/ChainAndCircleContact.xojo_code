#tag Class
Protected Class ChainAndCircleContact
Inherits Physics.Contact
	#tag Method, Flags = &h0
		Sub Constructor(fixtureA As Physics.Fixture, indexA As Integer, fixtureB As Physics.Fixture, indexB As Integer)
		  #If DebugBuild
		    Assert(fixtureA.Type = Physics.ShapeType.Chain)
		    Assert(fixtureB.Type = Physics.ShapeType.Circle)
		  #EndIf
		  
		  Super.Constructor(fixtureA, indexA, fixtureB, indexB)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Evaluate(manifold As Physics.Manifold, xfA As Physics.Transform, xfB As Physics.Transform)
		  Var chain As Physics.ChainShape = Physics.ChainShape(fixtureA.Shape)
		  Var edge As Physics.EdgeShape = chain.ChildEdge(indexA)
		  World.Collision.CollideEdgeAndCircle(manifold, edge, xfA, _
		  Physics.CircleShape(fixtureB.Shape), xfB)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass

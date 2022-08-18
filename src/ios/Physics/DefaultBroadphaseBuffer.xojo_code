#tag Class
Protected Class DefaultBroadphaseBuffer
Implements Physics.Broadphase,Physics.TreeCallback
	#tag Method, Flags = &h0
		Sub Constructor(tree As Physics.BroadphaseStrategy)
		  mTree = tree
		  
		  mPairBuffer = New Physics.Pair2DSet
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateProxy(aabb As Physics.AABB, userData As Variant) As Integer
		  // Part of the Physics.Broadphase interface.
		  
		  Var proxyId As Integer = mTree.CreateProxy(aabb, userData)
		  mMoveBuffer.Add(proxyId)
		  
		  Return proxyId
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DestroyProxy(proxyID As Integer)
		  // Part of the Physics.Broadphase interface.
		  
		  Var index As Integer = mMoveBuffer.IndexOf(proxyID)
		  If index <> -1 Then mMoveBuffer.RemoveAt(index)
		  mTree.DestroyProxy(proxyId)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawTree(argDraw As Physics.DebugDraw)
		  mTree.DrawTree(argDraw)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FatAABB(proxyID As Integer) As Physics.AABB
		  // Part of the Physics.Broadphase interface.
		  
		  Return mTree.FatAABB(proxyId)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTreeBalance() As Integer
		  // Part of the Physics.Broadphase interface.
		  
		  Return mTree.GetMaxBalance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTreeHeight() As Integer
		  // Part of the Physics.Broadphase interface.
		  
		  Return mTree.GetHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTreeQuality() As Double
		  // Part of the Physics.Broadphase interface.
		  
		  Return mTree.GetAreaRatio
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUserData(proxyID As Integer) As Variant
		  // Part of the Physics.Broadphase interface.
		  
		  Return mTree.UserData(proxyId)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MoveProxy(proxyID As Integer, AABB As Physics.AABB, displacement As VMaths.Vector2)
		  // Part of the Physics.Broadphase interface.
		  
		  Var buffer As Boolean = mTree.MoveProxy(proxyId, aabb, displacement)
		  If buffer Then mMoveBuffer.Add(proxyId)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProxyCount() As Integer
		  // Part of the Physics.Broadphase interface.
		  
		  Return mMoveBuffer.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Query(callback As Physics.TreeCallback, aabb As Physics.AABB)
		  // Part of the Physics.Broadphase interface.
		  
		  mTree.Query(callback, aabb)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Raycast(callback As Physics.TreeRayCastCallback, input As RaycastInput)
		  // Part of the Physics.Broadphase interface.
		  
		  mTree.Raycast(callback, input)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestOverlap(proxyIDA As Integer, proxyIDB As Integer) As Boolean
		  // Part of the Physics.Broadphase interface.
		  
		  Var a As Physics.AABB = mTree.FatAABB(proxyIdA)
		  Var b As Physics.AABB = mTree.FatAABB(proxyIdB)
		  
		  If b.LowerBound.X - a.UpperBound.X > 0.0 Or _
		    b.LowerBound.Y - a.UpperBound.Y > 0.0 Then
		    Return False
		  End If
		  
		  If a.LowerBound.X - b.UpperBound.X > 0.0 Or _
		    a.LowerBound.Y - b.UpperBound.Y > 0.0 Then
		    Return False
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TouchProxy(proxyID As Integer)
		  // Part of the Physics.Broadphase interface.
		  
		  mMoveBuffer.Add(proxyId)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TreeCallback(proxyID As Integer) As Boolean
		  // Part of the Physics.TreeCallback interface.
		  
		  // A proxy cannot form a pair with itself.
		  If proxyId = mQueryProxyId Then Return True
		  
		  Call mPairBuffer.Add( _
		  New Physics.Pair2D( _
		  Min(proxyId, mQueryProxyId), _
		  Max(proxyId, mQueryProxyId)))
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdatePairs(callback As Physics.PairCallback)
		  // Part of the Physics.Broadphase interface.
		  
		  // Reset pair buffer.
		  mPairBuffer.Clear
		  
		  // Perform tree queries for all moving proxies.
		  For Each proxyId As Integer In mMoveBuffer
		    mQueryProxyId = proxyId
		    If proxyId = Physics.BroadPhaseNullProxy Then
		      Continue
		    End If
		    
		    // We have to query the tree with the fat AABB so that
		    // we don't fail to create a pair that may touch later.
		    Var fatAABB As Physics.AABB = mTree.FatAABB(proxyId)
		    
		    // Query tree, create pairs and add them pair buffer.
		    mTree.Query(Self, fatAABB)
		  Next proxyId
		  
		  // Reset move buffer.
		  mMoveBuffer.ResizeTo(-1)
		  
		  // Send the pairs back to the client.
		  Var iLimit As Integer = mPairBuffer.LastIndex
		  For i As Integer = 0 To iLimit
		    Var pair_ As Physics.Pair2D = mPairBuffer.ElementAt(i)
		    Var userDataA As Variant = mTree.UserData(pair_.ProxyIdA)
		    Var userDataB As Variant = mTree.UserData(pair_.ProxyIdB)
		    
		    callback.AddPair(userDataA, userDataB)
		  Next i
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMoveBuffer() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPairBuffer As Physics.Pair2DSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueryProxyId As Integer = Physics.BroadphaseNullProxy
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTree As Physics.BroadphaseStrategy
	#tag EndProperty


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

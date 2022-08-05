#tag Class
Protected Class DynamicTree
Implements Physics.BroadphaseStrategy
	#tag Method, Flags = &h0
		Function ComputeHeight() As Integer
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  #If DebugBuild
		    Assert(mRoot <> Nil)
		  #EndIf
		  
		  Return mComputeHeight(mRoot)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  For i As Integer = 0 To mNodes.LastIndex
		    mNodes(i) = New Physics.DynamicTreeNode(i)
		  Next i
		  
		  For i As Integer = 0 To DrawVecs.LastIndex
		    DrawVecs(i) = VMaths.Vector2.Zero
		  Next i
		  
		  For i As Integer = 0 To mNodeStack.LastIndex
		    mNodeStack(i) = New Physics.DynamicTreeNode(i)
		  Next i
		  
		  mR = VMaths.Vector2.Zero
		  mAABB = New Physics.AABB
		  mSubInput = New Physics.RaycastInput
		  
		  // Build a linked list for the free list.
		  For i As Integer = mNodeCapacity - 1 DownTo 0
		    mNodes(i) = New Physics.DynamicTreeNode(i)
		    mNodes(i).Parent = If((i = mNodeCapacity - 1), Nil, mNodes(i + 1))
		    mNodes(i).Height = -1
		  Next i
		  
		  For i As Integer = 0 To DrawVecs.LastIndex
		    drawVecs(i) = VMaths.Vector2.Zero
		  Next i
		  
		  mCombinedAABB = New Physics.AABB
		  mColor = Physics.Color3i.Zero
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateProxy(aabb As Physics.AABB, userData As Variant = Nil) As Integer
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  #If DebugBuild
		    Assert(aabb.IsValid)
		  #EndIf
		  
		  Var node As Physics.DynamicTreeNode = mAllocateNode
		  Var proxyId As Integer = node.ID
		  
		  // Fatten the AABB.
		  Var nodeAABB As Physics.AABB = node.AABB
		  nodeAABB.LowerBound.X = aabb.LowerBound.X - Physics.Settings.AABBExtension
		  nodeAABB.LowerBound.Y = aabb.LowerBound.Y - Physics.Settings.AABBExtension
		  nodeAABB.UpperBound.X = aabb.UpperBound.X + Physics.Settings.AABBExtension
		  nodeAABB.UpperBound.Y = aabb.UpperBound.Y + Physics.Settings.AABBExtension
		  node.UserData = userData
		  
		  mInsertLeaf(proxyId)
		  
		  Return proxyId
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DestroyProxy(proxyId As Integer)
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  #If DebugBuild
		    Assert(0 <= proxyId And proxyId < mNodeCapacity)
		  #EndIf
		  
		  Var node As Physics.DynamicTreeNode = mNodes(proxyId)
		  
		  #If DebugBuild
		    Assert(node.Child1 = Nil)
		  #EndIf
		  
		  mRemoveLeaf(node)
		  mFreeNode(node)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FatAABB(proxyId As Integer) As Physics.AABB
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  #If DebugBuild
		    Assert(0 <= proxyId And proxyId < mNodeCapacity)
		  #EndIf
		  
		  Return mNodes(proxyId).AABB
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAreaRatio() As Double
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  If mRoot = Nil Then
		    Return 0.0
		  End If
		  
		  Var rootArea As Double = mRoot.AABB.Perimeter
		  
		  Var totalArea As Double = 0.0
		  
		  Var iLimit As Integer = mNodeCapacity - 1
		  For i As Integer = 0 To iLimit
		    Var node As Physics.DynamicTreeNode = mNodes(i)
		    If node.Height < 0 Then
		      // Free node in pool.
		      Continue
		    End If
		    
		    totalArea = totalArea + node.AABB.Perimeter
		  Next i
		  
		  Return totalArea / rootArea
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeight() As Integer
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  If mRoot = Nil Then
		    Return 0
		  Else
		    Return mRoot.Height
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaxBalance() As Integer
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  Var maxBalance As Integer = 0
		  
		  Var iLimit As Integer = mNodeCapacity - 1
		  For i As Integer = 0 To iLimit
		    Var node As Physics.DynamicTreeNode = mNodes(i)
		    If node.Height <= 1 Then
		      Continue
		    End If
		    
		    #If DebugBuild
		      Assert(node.Child1 <> Nil)
		      Assert(node.Child2 <> Nil)
		    #EndIf
		    
		    Var balance As Integer = Abs((node.Child2.Height - node.Child1.Height))
		    maxBalance = Max(maxBalance, balance)
		  Next i
		  
		  Return maxBalance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mAllocateNode() As Physics.DynamicTreeNode
		  If mFreeList = NullNode Then
		    #If DebugBuild
		      Assert(mNodeCount = mNodeCapacity)
		    #EndIf
		    
		    Var iLimit As Integer = mNodeCapacity - 1
		    For i As Integer = 0 To iLimit
		      mNodes.Add(New Physics.DynamicTreeNode(mNodeCapacity + i))
		    Next i
		    
		    mNodeCapacity = mNodes.Count
		    
		    // Build a linked list for the free list.
		    Var i As Integer = mNodeCapacity - 1
		    While i >= mNodeCount
		      mNodes(i).Parent = If((i = mNodeCapacity - 1), Nil, mNodes(i + 1))
		      mNodes(i).Height = -1
		      i = i - 1
		    Wend
		    mFreeList = mNodeCount
		  End If
		  
		  Var nodeId As Integer = mFreeList
		  Var treeNode As Physics.DynamicTreeNode = mNodes(nodeId)
		  mFreeList = If(treeNode.Parent <> Nil, treeNode.Parent.ID, NullNode)
		  
		  treeNode.Parent = Nil
		  treeNode.Child1 = Nil
		  treeNode.Child2 = Nil
		  treeNode.Height = 0
		  treeNode.UserData = Nil
		  mNodeCount = mNodeCount + 1
		  
		  Return treeNode
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAssertMetricsValid(node As Physics.DynamicTreeNode = Nil)
		  If node = Nil Then
		    Return
		  End If
		  
		  Var child1 As Physics.DynamicTreeNode = node.Child1
		  Var child2 As Physics.DynamicTreeNode = node.Child2
		  
		  If node.Child1 = Nil Then
		    #If DebugBuild
		      Assert(child1 = Nil)
		      Assert(child2 = Nil)
		      Assert(node.Height = 0)
		    #EndIf
		    Return
		  End If
		  
		  #If DebugBuild
		    Assert(child1 <> Nil And 0 <= child1.ID And child1.ID < mNodeCapacity)
		    Assert(child2 <> Nil And 0 <= child2.ID And child2.ID < mNodeCapacity)
		  #EndIf
		  
		  Var height1 As Integer = child1.Height
		  Var height2 As Integer = child2.Height
		  Var height As Integer 
		  height = 1 + Max(height1, height2)
		  
		  #If DebugBuild
		    Assert(node.Height = height)
		  #EndIf
		  
		  Var aabb As New Physics.AABB
		  aabb.Combine2(child1.AABB, child2.AABB)
		  
		  #If DebugBuild
		    Assert(aabb.LowerBound = node.AABB.LowerBound)
		    Assert(aabb.UpperBound = node.AABB.UpperBound)
		  #EndIf
		  
		  mAssertMetricsValid(child1)
		  mAssertMetricsValid(child2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAssertStructureValid(node As Physics.DynamicTreeNode = Nil)
		  If node = Nil Then
		    Return
		  End If
		  
		  #If DebugBuild
		    Assert(node = mNodes(node.ID))
		  #EndIf
		  
		  If node = mRoot Then
		    #If DebugBuild
		      Assert(node.Parent = Nil)
		    #EndIf
		  End If
		  
		  Var child1 As Physics.DynamicTreeNode = node.Child1
		  Var child2 As Physics.DynamicTreeNode = node.Child2
		  
		  If node.Child1 = Nil Then
		    #If DebugBuild
		      Assert(child1 = Nil)
		      Assert(child2 = Nil)
		      Assert(node.Height = 0)
		    #EndIf
		    Return
		  End If
		  
		  #If DebugBuild
		    Assert(child1 <> Nil And 0 <= child1.ID And child1.ID < mNodeCapacity)
		    Assert(child2 <> Nil And 0 <= child2.ID And child2.ID < mNodeCapacity)
		    
		    Assert(child1.Parent = node)
		    Assert(child2.Parent = node)
		  #EndIf
		  
		  mAssertStructureValid(child1)
		  mAssertStructureValid(child2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506572666F726D2061206C656674206F7220726967687420726F746174696F6E206966206E6F6465204120697320696D62616C616E6365642E2052657475726E7320746865206E657720726F6F7420696E6465782E
		Private Function mBalance(iA As Physics.DynamicTreeNode) As Physics.DynamicTreeNode
		  /// Perform a left or right rotation if node A is imbalanced.
		  /// Returns the new root index.
		  
		  Var a As Physics.DynamicTreeNode = iA
		  If a.Child1 = Nil Or a.Height < 2 Then
		    Return iA
		  End If
		  
		  Var iB As Physics.DynamicTreeNode = a.Child1
		  Var iC As Physics.DynamicTreeNode = a.Child2
		  
		  #If DebugBuild
		    Assert(0 <= iB.ID And iB.ID < mNodeCapacity)
		    Assert(0 <= iC.ID And iC.ID < mNodeCapacity)
		  #EndIf
		  
		  Var b As Physics.DynamicTreeNode = iB
		  Var c As Physics.DynamicTreeNode = iC
		  
		  Var balance As Integer = c.Height - b.Height
		  
		  // Rotate C up.
		  If balance > 1 Then
		    Var iF_ As Physics.DynamicTreeNode = c.Child1
		    Var iG As Physics.DynamicTreeNode = c.Child2
		    Var f As Physics.DynamicTreeNode = iF_
		    Var g As Physics.DynamicTreeNode = iG
		    
		    #If DebugBuild
		      Assert(0 <= iF_.ID And iF_.ID < mNodeCapacity)
		      Assert(0 <= iG.ID And iG.ID < mNodeCapacity)
		    #EndIf
		    
		    // Swap A and C.
		    c.Child1 = iA
		    c.Parent = a.Parent
		    a.Parent = iC
		    
		    // A's old parent should point to C.
		    If c.Parent <> Nil Then
		      If c.Parent.Child1 = iA Then
		        c.Parent.Child1 = iC
		      Else
		        #If DebugBuild
		          Assert(c.Parent.Child2 = iA)
		        #EndIf
		        c.Parent.Child2 = iC
		      End If
		    Else
		      mRoot = iC
		    End If
		    
		    // Rotate.
		    If f.Height > g.Height Then
		      c.Child2 = iF_
		      a.Child2 = iG
		      g.Parent = iA
		      a.AABB.Combine2(b.AABB, g.AABB)
		      c.AABB.Combine2(a.AABB, f.AABB)
		      
		      a.Height = 1 + Max(b.Height, g.Height)
		      c.Height = 1 + Max(a.Height, f.Height)
		    Else
		      c.Child2 = iG
		      a.Child2 = iF_
		      f.Parent = iA
		      a.AABB.Combine2(b.AABB, f.AABB)
		      c.AABB.Combine2(a.AABB, g.AABB)
		      
		      a.Height = 1 + max(b.Height, f.Height)
		      c.Height = 1 + max(a.Height, g.Height)
		    End If
		    
		    Return iC
		  End If
		  
		  // Rotate B up.
		  If balance < -1 Then
		    Var iD As Physics.DynamicTreeNode = b.Child1
		    Var iE As Physics.DynamicTreeNode = b.Child2
		    Var d As Physics.DynamicTreeNode = iD
		    Var e As Physics.DynamicTreeNode = iE
		    
		    #If DebugBuild
		      Assert(0 <= iD.ID And iD.ID < mNodeCapacity)
		      Assert(0 <= iE.ID And iE.ID < mNodeCapacity)
		    #EndIf
		    
		    // Swap A and B.
		    b.Child1 = iA
		    b.Parent = a.Parent
		    a.Parent = iB
		    
		    // A's old parent should point to B.
		    If b.Parent <> Nil Then
		      If b.Parent.Child1 = iA Then
		        b.Parent.Child1 = iB
		      Else
		        #If DebugBuild
		          Assert(b.Parent.Child2 = iA)
		        #EndIf
		        b.Parent.Child2 = iB
		      End If
		    Else
		      mRoot = iB
		    End If
		    
		    // Rotate.
		    If d.Height > e.Height Then
		      b.Child2 = iD
		      a.Child1 = iE
		      e.Parent = iA
		      a.AABB.Combine2(c.AABB, e.AABB)
		      b.AABB.Combine2(a.AABB, d.AABB)
		      
		      a.Height = 1 + Max(c.Height, e.Height)
		      b.Height = 1 + Max(a.Height, d.Height)
		    Else
		      b.Child2 = iE
		      a.Child1 = iD
		      d.Parent = iA
		      a.AABB.Combine2(c.AABB, d.AABB)
		      b.AABB.Combine2(a.AABB, e.AABB)
		      
		      a.Height = 1 + Max(c.Height, d.Height)
		      b.Height = 1 + Max(a.Height, e.Height)
		    End If
		    
		    Return iB
		  End If
		  
		  Return iA
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mComputeHeight(node As Physics.DynamicTreeNode) As Integer
		  #If DebugBuild
		    Assert(0 <= node.ID And node.ID < mNodeCapacity)
		  #EndIf
		  
		  If node.Child1 = Nil Then
		    Return 0
		  End If
		  
		  Var height1 As Integer = mComputeHeight(node.Child1)
		  Var height2 As Integer = mComputeHeight(node.Child2)
		  
		  Return 1 + Max(height1, height2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732061206E6F646520746F2074686520706F6F6C2E
		Private Sub mFreeNode(node As Physics.DynamicTreeNode)
		  /// Returns a node to the pool.
		  
		  #If DebugBuild
		    Assert(0 < mNodeCount)
		  #EndIf
		  
		  node.Parent = If(mFreeList <> NullNode, mNodes(mFreeList), Nil)
		  node.Height = -1
		  mFreeList = node.ID
		  mNodeCount = mNodeCount - 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mInsertLeaf(leafIndex As Integer)
		  Var leaf As Physics.DynamicTreeNode = mNodes(leafIndex)
		  If mRoot = Nil Then
		    mRoot = leaf
		    mRoot.Parent = Nil
		    Return
		  End If
		  
		  // Find the best sibling.
		  Var leafAABB As Physics.AABB = leaf.AABB
		  Var index As Physics.DynamicTreeNode = mRoot
		  While index <> Nil And index.Child1 <> Nil
		    Var node As Physics.DynamicTreeNode = index
		    Var child1 As Physics.DynamicTreeNode = node.child1
		    Var child2 As Physics.DynamicTreeNode = node.child2
		    
		    Var area As Double = node.AABB.Perimeter
		    
		    mCombinedAABB.Combine2(node.AABB, leafAABB)
		    Var combinedArea As Double = mCombinedAABB.Perimeter
		    
		    // Cost of creating a new parent for this node and the new leaf.
		    Var cost As Double = 2.0 * combinedArea
		    
		    // Minimum cost of pushing the leaf further down the tree.
		    Var inheritanceCost As Double = 2.0 * (combinedArea - area)
		    
		    // Cost of descending into child1.
		    Var cost1 As Double
		    If child1.Child1 = Nil Then
		      mCombinedAABB.Combine2(leafAABB, child1.AABB)
		      cost1 = mCombinedAABB.Perimeter + inheritanceCost
		    Else
		      mCombinedAABB.Combine2(leafAABB, child1.AABB)
		      Var oldArea As Double = child1.AABB.Perimeter
		      Var newArea As Double = mCombinedAABB.Perimeter
		      cost1 = (newArea - oldArea) + inheritanceCost
		    End If
		    
		    // Cost of descending into child2.
		    Var cost2 As Double
		    If child2.Child1 = Nil Then
		      mCombinedAABB.Combine2(leafAABB, child2.AABB)
		      cost2 = mCombinedAABB.Perimeter + inheritanceCost
		    Else
		      mCombinedAABB.Combine2(leafAABB, child2.AABB)
		      Var oldArea As Double = child2.AABB.Perimeter
		      Var newArea As Double = mCombinedAABB.Perimeter
		      cost2 = newArea - oldArea + inheritanceCost
		    End If
		    
		    // Descend according to the minimum cost.
		    If cost < cost1 And cost < cost2 Then
		      Exit
		    End If
		    
		    // Descend.
		    If cost1 < cost2 Then
		      index = child1
		    Else
		      index = child2
		    End If
		  Wend
		  
		  Var sibling As Physics.DynamicTreeNode = index
		  Var oldParent As Physics.DynamicTreeNode = mNodes(sibling.ID).Parent
		  Var newParent As Physics.DynamicTreeNode = mAllocateNode
		  newParent.Parent = oldParent
		  newParent.UserData = Nil
		  newParent.AABB.Combine2(leafAABB, sibling.AABB)
		  newParent.Height = sibling.Height + 1
		  
		  If oldParent <> Nil Then
		    // The sibling was not the root.
		    If oldParent.Child1 = sibling Then
		      oldParent.Child1 = newParent
		    Else
		      oldParent.Child2 = newParent
		    End If
		    
		    newParent.Child1 = sibling
		    newParent.Child2 = leaf
		    sibling.Parent = newParent
		    leaf.Parent = newParent
		  Else
		    // The sibling was the root.
		    newParent.Child1 = sibling
		    newParent.Child2 = leaf
		    sibling.Parent = newParent
		    leaf.Parent = newParent
		    mRoot = newParent
		  End If
		  
		  // Walk back up the tree fixing heights and AABBs.
		  index = leaf.Parent
		  While index <> Nil
		    index = mBalance(index)
		    
		    #If DebugBuild
		      Assert(index.child1 <> Nil)
		      Assert(index.child2 <> Nil)
		    #EndIf
		    
		    Var child1 As Physics.DynamicTreeNode = index.Child1
		    Var child2 As Physics.DynamicTreeNode = index.Child2
		    
		    index.Height = 1 + Max(child1.Height, child2.Height)
		    index.AABB.Combine2(child1.AABB, child2.AABB)
		    
		    index = index.Parent
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveProxy(proxyId As Integer, aabb As Physics.AABB, displacement As VMaths.Vector2) As Boolean
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  #If DebugBuild
		    Assert(aabb.IsValid)
		    Assert(0 <= proxyId And proxyId < mNodeCapacity)
		  #EndIf
		  
		  Var node As Physics.DynamicTreeNode = mNodes(proxyId)
		  
		  #If DebugBuild
		    Assert(node.Child1 = Nil)
		  #EndIf
		  
		  Var nodeAABB As Physics.AABB = node.AABB
		  
		  If (nodeAABB.LowerBound.X <= aabb.LowerBound.X) And _
		    (nodeAABB.LowerBound.Y <= aabb.LowerBound.Y) And _
		    (aabb.UpperBound.X <= nodeAABB.UpperBound.X) And _
		    (aabb.UpperBound.Y <= nodeAABB.UpperBound.Y) Then
		    Return False
		  End If
		  
		  mRemoveLeaf(node)
		  
		  // Extend AABB.
		  Var lowerBound As VMaths.Vector2 = nodeAABB.LowerBound
		  Var upperBound As VMaths.Vector2 = nodeAABB.UpperBound
		  lowerBound.X = aabb.LowerBound.X - Physics.Settings.AABBExtension
		  lowerBound.Y = aabb.LowerBound.Y - Physics.Settings.AABBExtension
		  upperBound.X = aabb.UpperBound.X + Physics.Settings.AABBExtension
		  upperBound.Y = aabb.UpperBound.Y + Physics.Settings.AABBExtension
		  
		  // Predict AABB displacement.
		  Var dx As Double = displacement.X * Physics.Settings.AABBMultiplier
		  Var dy As Double = displacement.Y * Physics.Settings.AABBMultiplier
		  If dx < 0.0 Then
		    lowerBound.X = lowerBound.X + dx
		  Else
		    upperBound.X = upperBound.X + dx
		  End If
		  
		  If dy < 0.0 Then
		    lowerBound.Y = lowerBound.Y + dy
		  Else
		    upperBound.Y = upperBound.Y + dy
		  End If
		  
		  mInsertLeaf(proxyId)
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mRemoveLeaf(leaf As Physics.DynamicTreeNode)
		  If leaf = mRoot Then
		    mRoot = Nil
		    Return
		  End If
		  
		  Var parent As Physics.DynamicTreeNode = leaf.Parent
		  Var grandParent As Physics.DynamicTreeNode = _
		  If(parent = Nil, Nil, parent.Parent)
		  Var sibling As Physics.DynamicTreeNode
		  
		  If parent <> Nil And parent.Child1 = leaf Then
		    sibling = If(parent = Nil, Nil, parent.Child2)
		  Else
		    sibling = If(parent = Nil, Nil, parent.Child1)
		  End If
		  
		  If grandParent <> Nil Then
		    // Destroy parent and connect sibling to grandParent.
		    If grandParent.Child1 = parent Then
		      grandParent.Child1 = sibling
		    Else
		      grandParent.Child2 = sibling
		    End If
		    If sibling <> Nil Then
		      sibling.Parent = grandParent
		    End If
		    mFreeNode(parent)
		    
		    // Adjust ancestor bounds.
		    Var index As Physics.DynamicTreeNode = grandParent
		    While index <> Nil
		      index = mBalance(index)
		      
		      Var child1 As Physics.DynamicTreeNode = index.Child1
		      Var child2 As Physics.DynamicTreeNode = index.child2
		      
		      index.AABB.Combine2(child1.AABB, child2.AABB)
		      index.Height = 1 + Max(child1.Height, child2.Height)
		      
		      index = index.Parent
		    Wend
		  Else
		    mRoot = sibling
		    If sibling <> Nil Then
		      sibling.Parent = Nil
		    End If
		    mFreeNode(parent)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Query(callback As Physics.TreeCallback, aabb As Physics.AABB)
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  #If DebugBuild
		    Assert(aabb.IsValid)
		  #EndIf
		  
		  nodeStackIndex = 0
		  mNodeStack(nodeStackIndex) = mRoot
		  NodeStackIndex = NodeStackIndex + 1
		  
		  While nodeStackIndex > 0
		    NodeStackIndex = NodeStackIndex - 1
		    Var node As Physics.DynamicTreeNode = mNodeStack(nodeStackIndex)
		    If node = Nil Then Continue
		    
		    If AABB.TestOverlap(node.AABB, aabb) Then
		      If node.Child1 = Nil Then
		        Var proceed As Boolean = callback.TreeCallback(node.ID)
		        If Not proceed Then
		          Return
		        End If
		      Else
		        If mNodeStack.Count - nodeStackIndex - 2 <= 0 Then
		          Var previousSize As Integer = mNodeStack.Count
		          Var iLimit As Integer = previousSize - 1
		          For i As Integer = 0 To iLimit
		            mNodeStack.Add(New Physics.DynamicTreeNode(previousSize + i))
		          Next i
		        End If
		        
		        mNodeStack(NodeStackIndex) = node.Child1
		        NodeStackIndex = NodeStackIndex + 1
		        mNodeStack(NodeStackIndex) = node.Child2
		        NodeStackIndex = NodeStackIndex + 1
		      End If
		    End If
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Raycast(callback As Physics.TreeRayCastCallback, input As Physics.RaycastInput)
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  Var p1 As VMaths.Vector2 = input.P1
		  Var p2 As VMaths.Vector2 = input.P2
		  Var p1x As Double = p1.X
		  Var p2x As Double = p2.X
		  Var p1y As Double = p1.Y
		  Var p2y As Double = p2.Y
		  Var vx, vy, rx, ry, absVx, absVy, cx, cy, hx, hy, tempX, tempY As Double
		  mR.X = p2x - p1x
		  mR.Y = p2y - p1y
		  
		  #If DebugBuild
		    Assert((mR.X * mR.X + mR.Y * mR.Y) > 0.0)
		  #EndIf
		  
		  mR.Normalize
		  rx = mR.X
		  ry = mR.Y
		  
		  // v is perpendicular to the segment.
		  vx = -1.0 * ry
		  vy = 1.0 * rx
		  absVx = Abs(vx)
		  absVy = Abs(vy)
		  
		  // Separating axis for segment (Gino, p80).
		  // |dot(v, p1 - c)| > dot(|v|, h)
		  
		  Var maxFraction As Double = input.MaxFraction
		  
		  // Build a bounding box for the segment.
		  Var segAABB As Physics.AABB = mAABB
		  tempX = (p2x - p1x) * maxFraction + p1x
		  tempY = (p2y - p1y) * maxFraction + p1y
		  segAABB.LowerBound.X = Min(p1x, tempX)
		  segAABB.LowerBound.Y = Min(p1y, tempY)
		  segAABB.UpperBound.X = Max(p1x, tempX)
		  segAABB.UpperBound.Y = Max(p1y, tempY)
		  
		  nodeStackIndex = 0
		  mNodeStack(NodeStackIndex) = mRoot
		  NodeStackIndex = NodeStackIndex + 1
		  While NodeStackIndex > 0
		    NodeStackIndex = NodeStackIndex - 1
		    Var node As Physics.DynamicTreeNode = mNodeStack(NodeStackIndex)
		    If node = Nil Then
		      Continue
		    End If
		    
		    Var nodeAABB As Physics.AABB = node.AABB
		    If Not Physics.AABB.TestOverlap(nodeAABB, segAABB) Then
		      Continue
		    End If
		    
		    // Separating axis for segment (Gino, p80).
		    // |dot(v, p1 - c)| > dot(|v|, h)
		    cx = (nodeAABB.LowerBound.X + nodeAABB.UpperBound.X) * 0.5
		    cy = (nodeAABB.LowerBound.Y + nodeAABB.UpperBound.Y) * 0.5
		    hx = (nodeAABB.UpperBound.X - nodeAABB.LowerBound.X) * 0.5
		    hy = (nodeAABB.UpperBound.Y - nodeAABB.LowerBound.Y) * 0.5
		    tempX = p1x - cx
		    tempY = p1y - cy
		    Var separation As Double = _
		    Abs(vx * tempX + vy * tempY) - (absVx * hx + absVy * hy)
		    If separation > 0.0 Then
		      Continue
		    End If
		    
		    If node.Child1 = Nil Then
		      mSubInput.P1.X = p1x
		      mSubInput.P1.Y = p1y
		      mSubInput.P2.X = p2x
		      mSubInput.P2.Y = p2y
		      mSubInput.MaxFraction = maxFraction
		      
		      Var value As Double = callback.RaycastCallback(mSubInput, node.ID)
		      
		      If value = 0.0 Then
		        // The client has terminated the ray cast.
		        Return
		      End If
		      
		      If value > 0.0 Then
		        // Update segment bounding box.
		        maxFraction = value
		        tempX = (p2x - p1x) * maxFraction + p1x
		        tempY = (p2y - p1y) * maxFraction + p1y
		        segAABB.LowerBound.X = Min(p1x, tempX)
		        segAABB.LowerBound.Y = Min(p1y, tempY)
		        segAABB.UpperBound.X = Max(p1x, tempX)
		        segAABB.UpperBound.Y = Max(p1y, tempY)
		      End If
		    Else
		      If mNodeStack.Count - NodeStackIndex - 2 <= 0 Then
		        Var previousSize As Integer = mNodeStack.Count
		        
		        Var iLimit As Integer = previousSize - 1
		        For i As Integer = 0 To iLimit
		          mNodeStack.Add(New Physics.DynamicTreeNode(previousSize + i))
		        Next i
		        
		      End If
		      mNodeStack(NodeStackIndex) = node.Child1
		      NodeStackIndex = NodeStackIndex + 1
		      mNodeStack(NodeStackIndex) = node.Child2
		      NodeStackIndex = NodeStackIndex + 1
		    End If
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RebuildBottomUp()
		  Var nodes() As Integer
		  nodes.ResizeTo(mNodeCount - 1)
		  Var count As Integer = 0
		  
		  // Build array of leaves. Free the rest.
		  Var iLimit As Integer = mNodeCapacity - 1
		  For i As Integer = 0 To iLimit
		    If mNodes(i).Height < 0 Then
		      // Free node in pool.
		      Continue
		    End If
		    
		    Var node As Physics.DynamicTreeNode = mNodes(i)
		    If node.Child1 = Nil Then
		      node.Parent = Nil
		      nodes(count) = i
		      count = count + 1
		    Else
		      mFreeNode(node)
		    End If
		  Next i
		  
		  Var b As New Physics.AABB
		  While count > 1
		    Var minCost As Double = Maths.DoubleMaxFinite
		    Var iMin As Integer = -1
		    Var jMin As Integer = -1
		    
		    Var iLimit2 As Integer = count - 1
		    For i As Integer = 0 To iLimit2
		      Var aabbi As Physics.AABB = mNodes(nodes(i)).AABB
		      
		      Var jLimit As Integer = count - 1
		      For j As Integer = i + 1 To jLimit
		        Var aabbj As Physics.AABB = mNodes(nodes(j)).AABB
		        b.Combine2(aabbi, aabbj)
		        Var cost As Double = b.Perimeter
		        If cost < minCost Then
		          iMin = i
		          jMin = j
		          minCost = cost
		        End If
		      Next j
		    Next i
		    
		    Var index1 As Integer = nodes(iMin)
		    Var index2 As Integer = nodes(jMin)
		    Var child1 As Physics.DynamicTreeNode = mNodes(index1)
		    Var child2 As Physics.DynamicTreeNode = mNodes(index2)
		    
		    Var parent As Physics.DynamicTreeNode = mAllocateNode
		    parent.Child1 = child1
		    parent.Child2 = child2
		    parent.Height = 1 + Max(child1.Height, child2.Height)
		    parent.AABB.Combine2(child1.AABB, child2.AABB)
		    parent.Parent = Nil
		    
		    child1.Parent = parent
		    child2.Parent = parent
		    
		    nodes(jMin) = nodes(count - 1)
		    nodes(iMin) = parent.ID
		    count = count - 1
		  Wend
		  
		  mRoot = mNodes(nodes(0))
		  
		  Validate
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserData(proxyId As Integer) As Variant
		  // Part of the Physics.BroadphaseStrategy interface.
		  
		  #If DebugBuild
		    Assert(0 <= proxyId And proxyId < mNodeCapacity)
		  #EndIf
		  
		  Return mNodes(proxyId).UserData
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate()
		  #If DebugBuild
		    Assert(mRoot <> Nil)
		    mAssertStructureValid(mRoot)
		    mAssertMetricsValid(mRoot)
		  #EndIf
		  
		  Var freeCount As Integer = 0
		  Var freeNode As Physics.DynamicTreeNode = _
		  If(mFreeList <> nullNode, mNodes(mFreeList), Nil)
		  
		  While freeNode <> Nil
		    #If DebugBuild
		      Assert(0 <= freeNode.ID And freeNode.ID < mNodeCapacity)
		      Assert(freeNode = mNodes(freeNode.ID))
		    #EndIf
		    freeNode = freeNode.Parent
		    freeCount = freeCount + 1
		  Wend
		  
		  #If DebugBuild
		    Assert(GetHeight = ComputeHeight)
		    Assert(mNodeCount + freeCount = mNodeCapacity)
		  #EndIf
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A dynamic tree arranges data in a binary tree to accelerate queries such as
		volume queries and ray casts. Leaves are proxies with an AABB. In the tree
		we expand the proxy AABB by _fatAABBFactor so that the proxy AABB is bigger
		than the client object. This allows the client object to move by small
		amounts without triggering a tree update.
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		DrawVecs(3) As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAABB As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mColor As Physics.Color3i
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCombinedAABB As Physics.AABB
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFreeList As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNodeCapacity As Integer = 16
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNodeCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNodes(15) As Physics.DynamicTreeNode
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNodeStack(19) As Physics.DynamicTreeNode
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mR As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRoot As Physics.DynamicTreeNode
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubInput As Physics.RaycastInput
	#tag EndProperty

	#tag Property, Flags = &h0
		NodeStackIndex As Integer = 0
	#tag EndProperty


	#tag Constant, Name = MaxStackSize, Type = Double, Dynamic = False, Default = \"64", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NullNode, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


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
		#tag ViewProperty
			Name="mRoot"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

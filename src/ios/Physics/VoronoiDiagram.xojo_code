#tag Class
Protected Class VoronoiDiagram
	#tag Method, Flags = &h0
		Sub AddGenerator(center As VMaths.Vector2, particle As Physics.Particle)
		  Generators.Add(New Physics.VoronoiGenerator(center, particle))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mLower = VMaths.Vector2.Zero
		  mUpper = VMaths.Vector2.Zero
		  mQueue = New Physics.VoronoiDiagramTaskListQueue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Generate(radius As Double)
		  If Generators.Count = 0 Then
		    Return
		  End If
		  
		  mDiagram.RemoveAll
		  mQueue.Clear
		  
		  Var inverseRadius As Double = 1 / radius
		  Var firstGenerator As Physics.VoronoiGenerator = generators(0)
		  mLower.SetFrom(firstGenerator.Center)
		  mUpper.SetFrom(firstGenerator.Center)
		  For Each g As Physics.VoronoiGenerator In Generators
		    VMaths.Vector2.Minimum(mLower, g.Center, mLower)
		    VMaths.Vector2.Maximum(mUpper, g.Center, mUpper)
		  Next g
		  mCountX = 1 + (inverseRadius * (mUpper.X - mLower.X))
		  mCountY = 1 + (inverseRadius * (mUpper.Y - mLower.Y))
		  For Each g As Physics.VoronoiGenerator In Generators
		    Var tmp As VMaths.Vector2 = g.Center - mLower
		    tmp.Scale(inverseRadius)
		    g.center.setFrom(tmp)
		    Var x As Integer = Max(0, Min(g.Center.X, mCountX - 1))
		    Var y As Integer = Max(0, Min(g.Center.Y, mCountY - 1))
		    mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y, x + y * mCountX, g))
		  Next g
		  While mQueue.IsNotEmpty
		    Var front As Physics.VoronoiDiagramTask = mQueue.RemoveFirst
		    Var x As Integer = front.X
		    Var y As Integer = front.Y
		    Var i As Integer = front.I
		    Var g As Physics.VoronoiGenerator = front.Generator
		    If mDiagram.HasKey(i) Then
		      mDiagram.Value(i) = g
		      If x > 0 Then
		        mQueue.AddFirst(New Physics.VoronoiDiagramTask(x - 1, y, i - 1, g))
		      End If
		      If y > 0 Then
		        mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y - 1, i - mCountX, g))
		      End If
		      If x < mCountX - 1 Then
		        mQueue.AddFirst(New Physics.VoronoiDiagramTask(x + 1, y, i + 1, g))
		      End If
		      If y < mCountY - 1 Then
		        mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y + 1, i + mCountX, g))
		      End If
		    End If
		  Wend
		  Var maxIteration As Integer = mCountX + mCountY
		  Var iterationLimit As Integer = maxIteration - 1
		  For iteration As Integer = 0 To iterationLimit
		    Var yLimit As Integer = mCountY - 1
		    For y As Integer = 0 To yLimit
		      Var xLimit As Integer = mCountX - 2
		      For x As Integer = 0 To xLimit
		        Var i As Integer = x + y * mCountX
		        Var a As Physics.VoronoiGenerator = mDiagram.Value(i)
		        Var b As Physics.VoronoiGenerator = mDiagram.Value(i + 1)
		        If a <> b Then
		          mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y, i, b))
		          mQueue.AddFirst(New Physics.VoronoiDiagramTask(x + 1, y, i + 1, a))
		        End If
		      Next x
		    Next y
		    Var yLimit2 As Integer = mCountY - 2
		    For y As Integer = 0 To yLimit2
		      Var xLimit2 As Integer = mCountX - 1
		      For x As Integer = 0 To xLimit2
		        Var i As Integer = x + y * mCountX
		        Var a As Physics.VoronoiGenerator = mDiagram.Value(i)
		        Var b As Physics.VoronoiGenerator = mDiagram.Value(i + mCountX)
		        If a <> b Then
		          mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y, i, b))
		          mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y + 1, i + mCountX, a))
		        End If
		      Next x
		    Next y
		    Var updated As Boolean = False
		    While mQueue.IsNotEmpty
		      Var front As Physics.VoronoiDiagramTask = mQueue.RemoveFirst
		      Var x As Integer = front.X
		      Var y As Integer = front.Y
		      Var i As Integer = front.I
		      Var k As Physics.VoronoiGenerator = front.Generator
		      Var a As Physics.VoronoiGenerator = mDiagram.Value(i)
		      Var b As Physics.VoronoiGenerator = k
		      If a <> b Then
		        Var ax As Double = a.Center.X - x
		        Var ay As Double = a.Center.Y - y
		        Var bx As Double = b.Center.X - x
		        Var by As Double = b.Center.Y - y
		        Var a2 As Double = ax * ax + ay * ay
		        Var b2 As Double = bx * bx + by * by
		        If a2 > b2 Then
		          mDiagram.Value(i) = b
		          If x > 0 Then
		            mQueue.AddFirst(New Physics.VoronoiDiagramTask(x - 1, y, i - 1, b))
		          End If
		          If y > 0 Then 
		            mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y - 1, i - mCountX, b))
		          End If
		          If x < mCountX - 1 Then
		            mQueue.AddFirst(New Physics.VoronoiDiagramTask(x + 1, y, i + 1, b))
		          End If
		          If y < mCountY - 1 Then
		            mQueue.AddFirst(New Physics.VoronoiDiagramTask(x, y + 1, i + mCountX, b))
		          End If
		          updated = True
		        End If
		      End If
		    Wend
		    If Not updated Then
		      Exit
		    End If
		  Next iteration
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Nodes(callback As Physics.VoronoiDiagramCallback)
		  Var yLimit As Integer = mCountY - 2
		  For y As Integer = 0 To yLimit
		    Var xLimit As Integer = mCountX - 2
		    For x As Integer = 0 To xLimit
		      Var i As integer = x + y * mCountX
		      Var a As Physics.VoronoiGenerator = mDiagram.Value(i)
		      Var b As Physics.VoronoiGenerator = mDiagram.Value(i + 1)
		      Var c As Physics.VoronoiGenerator = mDiagram.Value(i + mCountX)
		      Var d As Physics.VoronoiGenerator = mDiagram.Value(i + 1 + mCountX)
		      If b <> c Then
		        If a <> b And a <> c Then
		          callback.Call_(a.Particle, b.Particle, c.Particle)
		        End If
		        If d <> b And d <> c Then
		          callback.Call_(b.Particle, d.Particle, c.Particle)
		        End If
		      End If
		    Next x
		  Next y
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Generators() As Physics.VoronoiGenerator
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCountX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCountY As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4B6579203D20496E74656765722C2056616C7565203D20506879736963732E566F726F6E6F6947656E657261746F722E
		Private mDiagram As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLower As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueue As Physics.VoronoiDiagramTaskListQueue
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpper As VMaths.Vector2
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

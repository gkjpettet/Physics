#tag Class
Protected Class VoronoiDiagramTaskListQueue
	#tag Method, Flags = &h0, Description = 4164647320606974656D602061742074686520656E64206F66207468652071756575652E
		Sub Add(item As Physics.VoronoiDiagramTask)
		  /// Adds `item` at the end of the queue.
		  
		  mItems.Add(item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320616C6C20656C656D656E7473206F6620606974656D73602061742074686520656E64206F66207468652071756575652E20546865206C656E677468206F662074686520717565756520697320657874656E64656420627920746865206C656E67746820606974656D73602E
		Sub AddAll(items() As Physics.VoronoiDiagramTask)
		  /// Adds all elements of `items` at the end of the queue. 
		  /// The length of the queue is extended by the length `items`.
		  
		  For Each item As Physics.VoronoiDiagramTask In items
		    mItems.Add(item)
		  Next item
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320606974656D602061742074686520626567696E6E696E67206F66207468652071756575652E
		Sub AddFirst(item As Physics.VoronoiDiagramTask)
		  /// Adds `item` at the beginning of the queue.
		  
		  mItems.AddAt(0, item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320606974656D602061742074686520656E64206F66207468652071756575652E
		Sub AddLast(item As Physics.VoronoiDiagramTask)
		  /// Adds `item` at the end of the queue.
		  
		  mItems.Add(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C20656C656D656E747320696E207468652071756575652E205468652073697A65206F6620746865207175657565206265636F6D6573207A65726F2E
		Sub Clear()
		  /// Removes all elements in the queue. The size of the queue becomes zero.
		  
		  mItems.ResizeTo(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520656C656D656E742061742060696E646578602E
		Function ElementAt(index As Integer) As Physics.VoronoiDiagramTask
		  /// Returns the element at `index`.
		  
		  Return mItems(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616E642072657475726E732074686520666972737420656C656D656E74206F6620746869732071756575652E
		Function RemoveFirst() As Physics.VoronoiDiagramTask
		  /// Removes and returns the first element of this queue.
		  
		  Var item As Physics.VoronoiDiagramTask = mItems(0)
		  mItems.RemoveAt(0)
		  Return item
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616E642072657475726E7320746865206C61737420656C656D656E74206F6620746869732071756575652E
		Function RemoveLast() As Physics.VoronoiDiagramTask
		  /// Removes and returns the last element of this queue.
		  
		  Return mItems.Pop
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mItems(0)
			End Get
		#tag EndGetter
		First As Physics.VoronoiDiagramTask
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mItems.Count = 0
			End Get
		#tag EndGetter
		IsEmpty As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mItems.Count > 0
			End Get
		#tag EndGetter
		IsNotEmpty As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mItems(mItems.LastIndex)
			  
			End Get
		#tag EndGetter
		Last As Physics.VoronoiDiagramTask
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mItems() As Physics.VoronoiDiagramTask
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
		#tag ViewProperty
			Name="mItems()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

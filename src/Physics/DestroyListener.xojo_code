#tag Interface
Protected Interface DestroyListener
	#tag Method, Flags = &h0, Description = 43616C6C6564207768656E20616E7920666978747572652069732061626F757420746F2062652064657374726F7965642064756520746F20746865206465737472756374696F6E206F662069747320706172656E7420626F64792E
		Sub OnDestroyFixture(fixture As Physics.Fixture)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C6564207768656E20616E79206A6F696E742069732061626F757420746F2062652064657374726F7965642064756520746F20746865206465737472756374696F6E206F66206F6E65206F662069747320617474616368656420626F646965732E
		Sub OnDestroyJoint(joint As Physics.Joint)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Joints and fixtures are destroyed when their associated
		body is destroyed. Implement this listener so that you
		may remove references to these joints and shapes.
		
	#tag EndNote


End Interface
#tag EndInterface

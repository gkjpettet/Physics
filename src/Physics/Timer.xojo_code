#tag Class
Protected Class Timer
	#tag Method, Flags = &h0
		Sub Constructor()
		  mStopwatch = New Core.StopWatch
		  mStopwatch.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMilliseconds() As Double
		  Return mStopwatch.ElapsedMilliseconds
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  mStopwatch.Reset
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		mStopwatch As Core.StopWatch
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass

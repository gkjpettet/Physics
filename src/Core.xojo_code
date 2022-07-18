#tag Module
Protected Module Core
	#tag Method, Flags = &h0
		Sub Assert(condition As Boolean, message As String)
		  /// If `condition` is False then an `UnsupportedOperation` is raised. 
		  /// Only executes in debug mode.
		  
		  #If DebugBuild
		    If Not condition Then
		      Raise New UnsupportedOperationException("Failed assertion: " + message)
		    End If
		  #EndIf
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Contains classes found in the Dart core library, not provided in the Xojo framework.
		
	#tag EndNote


End Module
#tag EndModule

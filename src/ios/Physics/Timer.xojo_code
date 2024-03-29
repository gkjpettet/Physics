#tag Class
Protected Class Timer
	#tag Method, Flags = &h0, Description = 496620607374617274496D6D6564696174656C79602069732054727565207468656E207468652073746F7077617463682077696C6C2073746172742075706F6E20696E7374616E74696174696F6E2E
		Sub Constructor(startImmediately As Boolean = True)
		  /// If `startImmediately` is True then the stopwatch will start upon instantiation.
		  
		  If startImmediately Then Start
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4120726561642D6F6E6C792044617465496E74657276616C20726570726573656E74696E672074686520746F74616C20656C61707365642074696D65206D65617375726564206279207468652063757272656E7420696E7374616E63652E
		Function Elapsed() As DateInterval
		  /// A read-only DateInterval representing the total elapsed time measured by
		  /// the current instance.
		  
		  If mStart = Nil Then Return New DateInterval
		  
		  If mIsRunning Then
		    Return DateTime.Now - mStart
		  Else
		    Return mEnd - mStart
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ElapsedAsString() As String
		  /// Returns a string representation of the elapsed interval.
		  
		  Var di As DateInterval = Elapsed
		  
		  If di = Nil Then Return "Nil"
		  
		  Var s As String
		  
		  If di.Years > 0 Then
		    s = di.Years.ToString + " year" + If(di.Years = 1, "", "s") + ", "
		  End If
		  
		  If di.Months > 0 Then
		    s = s + di.Months.ToString + " month" + If(di.Months = 1, "", "s") + ", "
		  End If
		  
		  If di.Days > 0 Then
		    s = s + di.Days.ToString + " day" + If(di.Days = 1, "", "s") + ", "
		  End If
		  
		  If di.Minutes > 0 Then
		    s = s + di.Minutes.ToString + " minute" + If(di.Minutes = 1, "", "s") + ", "
		  End If
		  
		  If di.Seconds > 0 Then
		    s = s + di.Seconds.ToString + " second" + If(di.Seconds = 1, "", "s") + ", "
		  End If
		  
		  If di.Nanoseconds > 0 Then
		    Var ms As Integer = di.Nanoseconds / 1000000
		    s = s + ms.ToString + " ms"
		  End If
		  
		  Return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520746F74616C20656C61707365642074696D65206D65617375726564206279207468652063757272656E7420696E7374616E63652C20696E206D696C6C697365636F6E64732E
		Function ElapsedMilliseconds() As Integer
		  /// The total elapsed time measured by the current instance, in milliseconds.
		  /// 
		  /// If the stopwatch has been running for > 28 days then an 
		  /// `UnsupportedOperationException` is raised.
		  
		  Var di As DateInterval = Elapsed
		  
		  // Validate.
		  If di.Months > 0 Or di.Years > 0 Then
		    Raise New _
		    UnsupportedOperationException("The stopwatch has been running too long.")
		  End If
		  
		  Return (di.Days * MS_IN_DAY) + (di.Hours * MS_IN_HOUR) + _
		  (di.Minutes * MS_IN_MIN) + (di.Seconds * MS_IN_SEC) + _
		  (di.Nanoseconds / NS_IN_MS)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520746F74616C20656C61707365642074696D65206D65617375726564206279207468652063757272656E7420696E7374616E63652C20696E207365636F6E64732E
		Function ElapsedSeconds() As Integer
		  /// The total elapsed time measured by the current instance, in seconds.
		  /// 
		  /// If the stopwatch has been running for > 28 days then an 
		  /// `UnsupportedOperationException` is raised.
		  
		  Var di As DateInterval = Elapsed
		  
		  // Validate.
		  If di.Months > 0 Or di.Years > 0 Then
		    Raise New _
		    UnsupportedOperationException("The stopwatch has been running too long.")
		  End If
		  
		  Return (di.Days * SECS_IN_DAY) + (di.Hours * SECS_IN_HOUR) + _
		  (di.Minutes * 60) + di.Seconds
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520746F74616C20656C61707365642074696D65206D65617375726564206279207468652063757272656E7420696E7374616E63652C20696E207469636B732E
		Function ElapsedTicks() As Integer
		  /// The total elapsed time measured by the current instance, in ticks.
		  /// 
		  /// If the stopwatch has been running for > 28 days then an 
		  /// `UnsupportedOperationException` is raised.
		  
		  Var di As DateInterval = Elapsed
		  
		  // Validate.
		  If di.Months > 0 Or di.Years > 0 Then
		    Raise New _
		    UnsupportedOperationException("The stopwatch has been running too long.")
		  End If
		  
		  Return (di.Days * TICKS_IN_DAY) + (di.Hours * TICKS_IN_HOUR) + _
		  (di.Minutes * TICKS_IN_MIN) + (di.Seconds * TICKS_IN_SEC) + _
		  (di.Nanoseconds / NS_IN_TICK)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265736574732074686520656C617073656420636F756E7420746F207A65726F2E20446F6573206E6F742073746F70206F72207374617274207468652073746F7077617463682E
		Sub Reset()
		  /// Resets the elapsed count to zero.
		  /// Does not stop or start the stopwatch.
		  
		  mStart = DateTime.Now
		  mEnd = DateTime.Now
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 426567696E732074696D696E672E
		Sub Start()
		  /// Begins timing.
		  
		  Reset
		  mIsRunning = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53746F70732074696D696E672E
		Sub Stop()
		  /// Stops timing.
		  
		  If mIsRunning Then
		    mIsRunning = False
		    mEnd = DateTime.Now
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		A class for measuring elapsed time.
		
	#tag EndNote

	#tag Note, Name = Example
		```xojo
		Var watch As New StopWatch
		watch.Start
		// Do something that you want to time...
		watch.Stop
		
		// Easy access to watch properties:
		Var ms As Double = watch.ElapsedMilliseconds
		Var t As Double = watch.ElapsedTicks
		Var di As DateInterval = watch.Elapsed
		
		// StopWatch will even format the interval into a string:
		Var s As String = watch.ElapsedAsString // E.g "4 minutes, 3 seconds, 89 ms"
		
		// Query if the stopwatch is running:
		If watch.IsRunning Then
		  // Do something
		End If
		
		// You can call `ElapsedTicks`, etc whilst the stopwatch is running too.
		```
		
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 54727565206966207468652073746F7077617463682069732063757272656E746C792072756E6E696E672E
		#tag Getter
			Get
			  Return mIsRunning
			  
			End Get
		#tag EndGetter
		IsRunning As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865206578616374206D6F6D656E74207468652073746F70776174636820656E6465642E
		Private mEnd As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060497352756E6E696E676020636F6D70757465642070726F70657274792E
		Private mIsRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206578616374206D6F6D656E74207468652073746F70776174636820737461727465642072756E6E696E672E
		Private mStart As DateTime
	#tag EndProperty


	#tag Constant, Name = MS_IN_DAY, Type = Double, Dynamic = False, Default = \"86400000", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320696E2061206461792E
	#tag EndConstant

	#tag Constant, Name = MS_IN_HOUR, Type = Double, Dynamic = False, Default = \"3.6e+6", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320696E20616E20686F75722E
	#tag EndConstant

	#tag Constant, Name = MS_IN_MIN, Type = Double, Dynamic = False, Default = \"60000", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320696E2061206D696E7574652E
	#tag EndConstant

	#tag Constant, Name = MS_IN_SEC, Type = Double, Dynamic = False, Default = \"1000", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320696E2061207365636F6E642E
	#tag EndConstant

	#tag Constant, Name = MS_IN_WEEK, Type = Double, Dynamic = False, Default = \"604800000", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320696E2061207765656B2E
	#tag EndConstant

	#tag Constant, Name = NS_IN_MS, Type = Double, Dynamic = False, Default = \"1000000", Scope = Private, Description = 546865206E756D626572206F66206E616E6F7365636F6E647320696E2061206D696C6C697365636F6E642E
	#tag EndConstant

	#tag Constant, Name = NS_IN_TICK, Type = Double, Dynamic = False, Default = \"16666666.67", Scope = Private, Description = 546865206E756D626572206F66206E616E6F7365636F6E647320696E2061207469636B2E
	#tag EndConstant

	#tag Constant, Name = SECS_IN_DAY, Type = Double, Dynamic = False, Default = \"86400", Scope = Private, Description = 546865206E756D626572206F66207365636F6E647320696E2061206461792E
	#tag EndConstant

	#tag Constant, Name = SECS_IN_HOUR, Type = Double, Dynamic = False, Default = \"3600", Scope = Private, Description = 546865206E756D626572206F66207365636F6E647320696E20616E20686F75722E
	#tag EndConstant

	#tag Constant, Name = TICKS_IN_DAY, Type = Double, Dynamic = False, Default = \"5184000", Scope = Private, Description = 546865206E756D626572206F66207469636B7320696E2061206461792E
	#tag EndConstant

	#tag Constant, Name = TICKS_IN_HOUR, Type = Double, Dynamic = False, Default = \"216000", Scope = Private, Description = 546865206E756D626572206F66207469636B7320696E20616E20686F75722E
	#tag EndConstant

	#tag Constant, Name = TICKS_IN_MIN, Type = Double, Dynamic = False, Default = \"3600", Scope = Private, Description = 546865206E756D626572206F66207469636B7320696E2061206D696E7574652E
	#tag EndConstant

	#tag Constant, Name = TICKS_IN_SEC, Type = Double, Dynamic = False, Default = \"60", Scope = Private, Description = 546865206E756D626572206F66207469636B7320696E2061207365636F6E642E
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
			Name="IsRunning"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

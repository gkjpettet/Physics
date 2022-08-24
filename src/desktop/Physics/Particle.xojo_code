#tag Class
Protected Class Particle
	#tag Method, Flags = &h0
		Function Clone() As Physics.Particle
		  Var p As New Physics.Particle(system, group)
		  p.Flags = Flags
		  p.Position.SetFrom(Position)
		  p.Velocity.SetFrom(Velocity)
		  p.Depth = Depth
		  p.Colour = Self.Colour
		  p.UserData = UserData
		  
		  Return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(system As Physics.ParticleSystem, group As Physics.ParticleGroup = Nil, lifespan As Double = 1)
		  position = VMaths.Vector2.Zero
		  Velocity = VMaths.Vector2.Zero
		  AccumulationVector = VMaths.Vector2.Zero
		  
		  Self.System = system
		  Self.Group = If(group = Nil, New Physics.ParticleGroup(system), group)
		  
		  // `lifespan` is how long this particle will live in seconds.
		  Self.Lifespan = lifespan
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C656420617420746865207374617274206F6620605061727469636C6553797374656D2E536F6C76652829602E20557064617465732074686520616765206F662074686973207061727469636C652062792060647460207365636F6E64732E
		Sub PreSolve(dt As Double)
		  /// Called at the start of `ParticleSystem.Solve()`. Updates the age of this particle by `dt` seconds.
		  
		  mAge = mAge + dt
		  
		  // Has this particle surpassed its lifespan?
		  If mAge > Lifespan Then
		    // This particle should be removed. Set it to be a zombie.
		    Self.Flags = Self.Flags Or Physics.ParticleType.ZombieParticle
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Specifies the type of particle. A particle may be more than one type.
		Multiple types are chained by logical sums, for example:
		pd.flags = ParticleType.elasticParticle | ParticleType.viscousParticle.
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		Accumulation As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		AccumulationVector As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0
		Colour As Color = Color.Black
	#tag EndProperty

	#tag Property, Flags = &h0
		Depth As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Flags As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652067726F757020776869636820746865207061727469636C652062656C6F6E677320746F2E
		Group As Physics.ParticleGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652064657369726564206C6966657370616E206F6620746865207061727469636C6520696E207365636F6E64732E
		Lifespan As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C2074696D657220646566696E696E6720686F77206C6F6E67207468697320605061727469636C65602077696C6C206C6976652E2053746F72657320686F77206D616E79207365636F6E6473206861766520656C61707365642073696E63652074686973207061727469636C652077617320637265617465642E20546865207061727469636C652077696C6C206265206D61726B656420666F722072656D6F76616C207768656E20606D416765203E204C6966657370616E602E
		Private mAge As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520776F726C6420706F736974696F6E206F6620746865207061727469636C652E
		Position As VMaths.Vector2
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865205061727469636C6553797374656D20776869636820746865207061727469636C652062656C6F6E677320746F2E
		System As Physics.ParticleSystem
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 557365207468697320746F2073746F7265206170706C69636174696F6E2D73706563696669632020626F647920646174612E
		UserData As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E6561722076656C6F63697479206F6620746865207061727469636C6520696E20776F726C6420636F6F7264696E617465732E
		Velocity As VMaths.Vector2
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
			Name="Flags"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Accumulation"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Depth"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Colour"
			Visible=false
			Group="Behavior"
			InitialValue="Color.Black"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

#tag Class
Protected Class RevoluteJoint
Inherits Physics.Joint
	#tag Note, Name = About
		A revolute joint constrains two bodies to share a common point while they
		are free to rotate about the point. The relative rotation about the shared
		point is the joint angle. You can limit the relative rotation with a joint
		limit that specifies a lower and upper angle. You can use a motor to drive
		the relative rotation about the shared point. A maximum motor torque is
		provided so that infinite forces are not generated.
		
		Point-to-point constraint
		C = p2 - p1
		Cdot = v2 - v1
		     = v2 + cross(w2, r2) - v1 - cross(w1, r1)
		J = [-I -r1_skew I r2_skew ]
		Identity used:
		w k % (rx i + ry j) = w * (-ry i + rx j)
		
		Motor constraint
		Cdot = w2 - w1
		J = [0 0 -1 0 0 1]
		K = invI1 + invI2
		
		
	#tag EndNote


End Class
#tag EndClass

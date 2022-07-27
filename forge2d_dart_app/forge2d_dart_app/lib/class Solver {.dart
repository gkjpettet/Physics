class Solver {
  void solveVelocityConstraints() {
    for (final contact in _contacts) {
      final vc = contact.velocityConstraint;
      final indexA = vc.indexA
      final indexB = vc.indexB;
      final mA = vc.invMassA;
      final mB = vc.invMassB;
      final iA = vc.invIA;
      final iB = vc.invIB;
      final pointCount = vc.pointCount;
      
      final vA = _velocities[indexA].v;
      var wA = _velocities[indexA].w;
      final vB = _velocities[indexB].v;
      var wB = _velocities[indexB].w;
      
      final normal = vc.normal;
      final normalX = normal.x;
      final normalY = normal.y;
      final tangentX = 1.0 * vc.normal.y;
      final tangentY = -1.0 * vc.normal.x;
      final friction = vc.friction;

assert(pointCount == 1 || pointCount == 2);

// Solve tangent constraints
for (var j = 0; j < pointCount; ++j) {
final vcp = vc.points[j];
final a = vcp.rA;
final dvx = -wB * vcp.rB.y + vB.x - vA.x + wA * a.y;
final dvy = wB * vcp.rB.x + vB.y - vA.y - wA * a.x;

// Compute tangent force
final vt = dvx * tangentX + dvy * tangentY - vc.tangentSpeed;
var lambda = vcp.tangentMass * (-vt);

// Clamp the accumulated force
final maxFriction = (friction * vcp.normalImpulse).abs();
final newImpulse =
(vcp.tangentImpulse + lambda).clamp(-maxFriction, maxFriction);
lambda = newImpulse - vcp.tangentImpulse;
vcp.tangentImpulse = newImpulse;

// Apply contact impulse
// Vec2 P = lambda * tangent;

final pX = tangentX * lambda;
final pY = tangentY * lambda;

// vA -= invMassA * P;
vA.x -= pX * mA;
vA.y -= pY * mA;
wA -= iA * (vcp.rA.x * pY - vcp.rA.y * pX);

// vB += invMassB * P;
vB.x += pX * mB;
vB.y += pY * mB;
wB += iB * (vcp.rB.x * pY - vcp.rB.y * pX);
}

// Solve normal constraints
if (vc.pointCount == 1) {
final vcp = vc.points[0];

// Relative velocity at contact
// Vec2 dv = vB + Cross(wB, vcp.rB) - vA - Cross(wA, vcp.rA);

final dvx = -wB * vcp.rB.y + vB.x - vA.x + wA * vcp.rA.y;
final dvy = wB * vcp.rB.x + vB.y - vA.y - wA * vcp.rA.x;

// Compute normal impulse
final vn = dvx * normalX + dvy * normalY;
var lambda = -vcp.normalMass * (vn - vcp.velocityBias);

// Clamp the accumulated impulse
final a = vcp.normalImpulse + lambda;
final newImpulse = a > 0.0 ? a : 0.0;
lambda = newImpulse - vcp.normalImpulse;
vcp.normalImpulse = newImpulse;

// Apply contact impulse
final pX = normalX * lambda;
final pY = normalY * lambda;

vA.x -= pX * mA;
vA.y -= pY * mA;
wA -= iA * (vcp.rA.x * pY - vcp.rA.y * pX);

// vB += invMassB * P;
vB.x += pX * mB;
vB.y += pY * mB;
wB += iB * (vcp.rB.x * pY - vcp.rB.y * pX);
} else {
// Block solver developed in collaboration with Dirk Gregorius
// (back in 01/07 on Box2D_Lite).
// Build the mini LCP for this contact patch
//
// vn = A * x + b, vn >= 0, , vn >= 0, x >= 0 and vn_i * x_i = 0
// with i = 1..2
//
// A = J * W * JT and J = ( -n, -r1 x n, n, r2 x n )
// b = vn_0 - velocityBias
//
// The system is solved using the "Total enumeration method" (s. Murty).
// The complementary constraint vn_i * x_i
// implies that we must have in any solution either vn_i = 0 or x_i = 0.
// So for the 2D contact problem the cases
// vn1 = 0 and vn2 = 0, x1 = 0 and x2 = 0, x1 = 0 and vn2 = 0, x2 = 0
// and vn1 = 0 need to be tested.
// The first valid solution that satisfies the problem is chosen.
//
// In order to account of the accumulated impulse 'a'
// (because of the iterative nature of the solver which only requires
// that the accumulated impulse is clamped and not the incremental
// impulse) we change the impulse variable (x_i).
//
// Substitute:
//
// x = a + d
//
// a := old total impulse
// x := new total impulse
// d := incremental impulse
//
// For the current iteration we extend the formula for the incremental
// impulse to compute the new total impulse:
//
// vn = A * d + b
// = A * (x - a) + b
// = A * x + b - A * a
// = A * x + b'
// b' = b - A * a;

final cp1 = vc.points[0];
final cp2 = vc.points[1];
final cp1rA = cp1.rA;
final cp1rB = cp1.rB;
final cp2rA = cp2.rA;
final cp2rB = cp2.rB;
final ax = cp1.normalImpulse;
final ay = cp2.normalImpulse;

assert(ax >= 0.0 && ay >= 0.0);
// Relative velocity at contact
// Vec2 dv1 = vB + Cross(wB, cp1.rB) - vA - Cross(wA, cp1.rA);
final dv1x = -wB * cp1rB.y + vB.x - vA.x + wA * cp1rA.y;
final dv1y = wB * cp1rB.x + vB.y - vA.y - wA * cp1rA.x;

// Vec2 dv2 = vB + Cross(wB, cp2.rB) - vA - Cross(wA, cp2.rA);
final dv2x = -wB * cp2rB.y + vB.x - vA.x + wA * cp2rA.y;
final dv2y = wB * cp2rB.x + vB.y - vA.y - wA * cp2rA.x;

// Compute normal velocity
var vn1 = dv1x * normalX + dv1y * normalY;
var vn2 = dv2x * normalX + dv2y * normalY;

var bx = vn1 - cp1.velocityBias;
var by = vn2 - cp2.velocityBias;

// Compute b'
final r = vc.K;
bx -= r.entry(0, 0) * ax + r.entry(0, 1) * ay;
by -= r.entry(1, 0) * ax + r.entry(1, 1) * ay;

// final double k_errorTol = 1e-3f;
// B2_NOT_USED(k_errorTol);
for (;;) {
//
// Case 1: vn = 0
//
// 0 = A * x' + b'
//
// Solve for x':
//
// x' = - inv(A) * b'
//
// Vec2 x = - Mul(c.normalMass, b);
final r1 = vc.normalMass;
var xx = r1.entry(0, 0) * bx + r1.entry(0, 1) * by;
var xy = r1.entry(1, 0) * bx + r1.entry(1, 1) * by;
xx *= -1;
xy *= -1;

if (xx >= 0.0 && xy >= 0.0) {
// Get the incremental impulse
final dx = xx - ax;
final dy = xy - ay;

// Apply incremental impulse
final p1x = dx * normalX;
final p1y = dx * normalY;
final p2x = dy * normalX;
final p2y = dy * normalY;

/*
* vA -= invMassA * (P1 + P2); wA -= invIA * (Cross(cp1.rA, P1) +
*       Cross(cp2.rA, P2));
*
* vB += invMassB * (P1 + P2); wB += invIB * (Cross(cp1.rB, P1) +
*       Cross(cp2.rB, P2));
*/

vA.x -= mA * (p1x + p2x);
vA.y -= mA * (p1y + p2y);
vB.x += mB * (p1x + p2x);
vB.y += mB * (p1y + p2y);

wA -= iA *
(cp1rA.x * p1y -
cp1rA.y * p1x +
(cp2rA.x * p2y - cp2rA.y * p2x));
wB += iB *
(cp1rB.x * p1y -
cp1rB.y * p1x +
(cp2rB.x * p2y - cp2rB.y * p2x));

// Accumulate
cp1.normalImpulse = xx;
cp2.normalImpulse = xy;

// Postconditions
// dv1 = vB + Cross(wB, cp1.rB) - vA - Cross(wA, cp1.rA);
// dv2 = vB + Cross(wB, cp2.rB) - vA - Cross(wA, cp2.rA);
//
// Compute normal velocity
// vn1 = Dot(dv1, normal); vn2 = Dot(dv2, normal);
if (debugSolver) {
// Postconditions
final dv1 = vB + _crossDoubleVector2(wB, cp1rB)
..sub(vA)
..sub(_crossDoubleVector2(wA, cp1rA));
final dv2 = vB + _crossDoubleVector2(wB, cp2rB)
..sub(vA)
..sub(_crossDoubleVector2(wA, cp2rA));
// Compute normal velocity
vn1 = dv1.dot(normal);
vn2 = dv2.dot(normal);

assert((vn1 - cp1.velocityBias).abs() < errorTol);
assert((vn2 - cp2.velocityBias).abs() < errorTol);
}
break;
}

//
// Case 2: vn1 = 0 and x2 = 0
//
// 0 = a11 * x1' + a12 * 0 + b1'
// vn2 = a21 * x1' + a22 * 0 + '
//
xx = -cp1.normalMass * bx;
xy = 0.0;
vn1 = 0.0;
vn2 = vc.K.entry(1, 0) * xx + by;

if (xx >= 0.0 && vn2 >= 0.0) {
// Get the incremental impulse
final dx = xx - ax;
final dy = xy - ay;

// Apply incremental impulse
final p1x = normalX * dx;
final p1y = normalY * dx;
final p2x = normalX * dy;
final p2y = normalY * dy;

// Vec2 P1 = d.x * normal;
// Vec2 P2 = d.y * normal;
// vA -= invMassA * (P1 + P2); wA -=
// invIA * (Cross(cp1.rA, P1) + Cross(cp2.rA, P2));
//
// vB += invMassB * (P1 + P2);
// wB += invIB * (Cross(cp1.rB, P1) + Cross(cp2.rB, P2));
vA.x -= mA * (p1x + p2x);
vA.y -= mA * (p1y + p2y);
vB.x += mB * (p1x + p2x);
vB.y += mB * (p1y + p2y);

wA -= iA *
(cp1rA.x * p1y -
cp1rA.y * p1x +
(cp2rA.x * p2y - cp2rA.y * p2x));
wB += iB *
(cp1rB.x * p1y -
cp1rB.y * p1x +
(cp2rB.x * p2y - cp2rB.y * p2x));

// Accumulate
cp1.normalImpulse = xx;
cp2.normalImpulse = xy;

/*
* #if B2_DEBUG_SOLVER == 1 // Postconditions dv1 = vB + Cross(wB, cp1.rB) - vA -
* Cross(wA, cp1.rA);
*
* // Compute normal velocity vn1 = Dot(dv1, normal);
*
* assert(Abs(vn1 - cp1.velocityBias) < k_errorTol); #endif
*/
if (debugSolver) {
// Postconditions
final dv1 = vB + _crossDoubleVector2(wB, cp1rB)
..sub(vA)
..sub(_crossDoubleVector2(wA, cp1rA));
// Compute normal velocity
vn1 = dv1.dot(normal);

assert((vn1 - cp1.velocityBias).abs() < errorTol);
}
break;
}

//
// Case 3: wB = 0 and x1 = 0
//
// vn1 = a11 * 0 + a12 * x2' + b1'
// 0 = a21 * 0 + a22 * x2' + '
//
xx = 0.0;
xy = -cp2.normalMass * by;
vn1 = vc.K.entry(0, 1) * xy + bx;
vn2 = 0.0;

if (xy >= 0.0 && vn1 >= 0.0) {
// Resubstitute for the incremental impulse
final dx = xx - ax;
final dy = xy - ay;

// Apply incremental impulse
//
// Vec2 P1 = d.x * normal;
// Vec2 P2 = d.y * normal;
// vA -= invMassA * (P1 + P2); wA -=
//   invIA * (Cross(cp1.rA, P1) + Cross(cp2.rA, P2));
//
// vB += invMassB * (P1 + P2);
//  wB += invIB * (Cross(cp1.rB, P1) + Cross(cp2.rB, P2));
final p1x = normalX * dx;
final p1y = normalY * dx;
final p2x = normalX * dy;
final p2y = normalY * dy;

vA.x -= mA * (p1x + p2x);
vA.y -= mA * (p1y + p2y);
vB.x += mB * (p1x + p2x);
vB.y += mB * (p1y + p2y);

wA -= iA *
(cp1rA.x * p1y -
cp1rA.y * p1x +
(cp2rA.x * p2y - cp2rA.y * p2x));
wB += iB *
(cp1rB.x * p1y -
cp1rB.y * p1x +
(cp2rB.x * p2y - cp2rB.y * p2x));

// Accumulate
cp1.normalImpulse = xx;
cp2.normalImpulse = xy;

/*
* #if B2_DEBUG_SOLVER == 1 // Postconditions dv2 = vB + Cross(wB, cp2.rB) - vA -
* Cross(wA, cp2.rA);
*
* // Compute normal velocity vn2 = Dot(dv2, normal);
*
* assert(Abs(vn2 - cp2.velocityBias) < k_errorTol); #endif
*/
if (debugSolver) {
// Postconditions
final dv2 = vB + _crossDoubleVector2(wB, cp2rB)
..sub(vA)
..sub(_crossDoubleVector2(wA, cp2rA));
// Compute normal velocity
vn2 = dv2.dot(normal);

assert((vn2 - cp2.velocityBias).abs() < errorTol);
}
break;
}

//
// Case 4: x1 = 0 and x2 = 0
//
// vn1 = b1
// vn2 = ;
xx = 0.0;
xy = 0.0;
vn1 = bx;
vn2 = by;

if (vn1 >= 0.0 && vn2 >= 0.0) {
// Resubstitute for the incremental impulse
final dx = xx - ax;
final dy = xy - ay;

// Apply incremental impulse
// Vec2 P1 = d.x * normal;
// Vec2 P2 = d.y * normal;
// vA -= invMassA * (P1 + P2); wA -=
//   invIA * (Cross(cp1.rA, P1) + Cross(cp2.rA, P2));
//
// vB += invMassB * (P1 + P2);
// wB += invIB * (Cross(cp1.rB, P1) + Cross(cp2.rB, P2));
final p1x = normalX * dx;
final p1y = normalY * dx;
final p2x = normalX * dy;
final p2y = normalY * dy;

vA.x -= mA * (p1x + p2x);
vA.y -= mA * (p1y + p2y);
vB.x += mB * (p1x + p2x);
vB.y += mB * (p1y + p2y);

wA -= iA *
(cp1rA.x * p1y -
cp1rA.y * p1x +
(cp2rA.x * p2y - cp2rA.y * p2x));
wB += iB *
(cp1rB.x * p1y -
cp1rB.y * p1x +
(cp2rB.x * p2y - cp2rB.y * p2x));

// Accumulate
cp1.normalImpulse = xx;
cp2.normalImpulse = xy;

break;
}

// No solution, give up.
// This is hit sometimes, but it doesn't seem to matter.
break;
}
}

_velocities[indexA].w = wA;
_velocities[indexB].w = wB;
}
}
}
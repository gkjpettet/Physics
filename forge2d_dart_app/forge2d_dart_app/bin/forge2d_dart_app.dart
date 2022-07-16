import 'package:forge2d_dart_app/forge2d_dart_app.dart' as forge2d_dart_app;
import 'package:vector_math/vector_math_64.dart';
import 'dart:math' as math;

void main(List<String> arguments) {
  final rot = Matrix2.rotation(math.pi / 4);
  final input = Vector2(0.234245234259, 0.890723489233);

  final expected = Vector2(
      rot.entry(0, 0) * input.x + rot.entry(0, 1) * input.y, rot.entry(1, 0) * input.x + rot.entry(1, 1) * input.y);

  final transExpected = Vector2(
      rot.entry(0, 0) * input.x + rot.entry(1, 0) * input.y, rot.entry(0, 1) * input.x + rot.entry(1, 1) * input.y);

  var result1 = rot.transformed(input);
  var result2 = rot.transposed().transformed(input);

  print(result1);
  print(expected);

  print(result2);
  print(transExpected);
}

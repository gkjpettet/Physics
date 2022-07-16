import 'package:forge2d_dart_app/forge2d_dart_app.dart' as forge2d_dart_app;
import 'package:vector_math/vector_math_64.dart';

void main(List<String> arguments) {
  var v1 = Vector2(1.1, 2.9);
  var v2 = Vector2(3, -4);
  var v3 = Vector2(5.5, 6.7);

  v1.roundToZero();
  v2.roundToZero();
  v3.roundToZero();

  print(v1);
  print(v2);
  print(v3);
}

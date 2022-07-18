import 'package:forge2d/forge2d.dart';

const int pyramidSize = 40;

final World world = World(Vector2(0.0, -10.0));

void main(List<String> arguments) {
  var a = 0x0002;
  var a2 = ~a;

  print(a);
  print(a2);
}

class MyClass {
  final String name;
  int proxyId = 0;

  MyClass(this.name);
}

import 'package:forge2d/forge2d.dart';

const int pyramidSize = 40;

final World world = World(Vector2(0.0, -10.0));

void main(List<String> arguments) {
  List<MyClass> list = [];

  list.add(MyClass('Garry')..proxyId = 50);
  var b = 10;
}

class MyClass {
  final String name;
  int proxyId = 0;

  MyClass(this.name);
}

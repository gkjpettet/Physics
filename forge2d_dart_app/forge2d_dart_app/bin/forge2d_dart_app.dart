import 'package:forge2d/forge2d.dart';

const int pyramidSize = 40;

final World world = World(Vector2(0.0, -10.0));

void main(List<String> arguments) {
  print("Hi");

  var c1 = MyClass(10, 20, 30);
  var c2 = MyClass(50, 60, 70, a: 80);
  var b = 10;
}

class MyClass {
  int r = 1;
  int g = 2;
  int b = 3;
  double a = 1.0;

  MyClass(this.r, this.g, this.b, {this.a = 2.0});
}

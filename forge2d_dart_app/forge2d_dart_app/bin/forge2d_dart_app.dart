import 'package:forge2d/forge2d.dart';

const int pyramidSize = 40;

final World world = World(Vector2(0.0, -10.0));

void main(List<String> arguments) {
  print('create c1');
  var c1 = MyClass();
  print("create c2");
  var c2 = MyClass();

  var n1 = c1.normal;
  n1.x = 10;
  print('n1: $n1');
  print('c1.normal ${c1.normal}');
}

class MyClass {
  final GVec normal = GVec.zero();
}

class GVec {
  double x = 1.0;
  double y = 2.0;

  GVec(this.x, this.y);

  GVec.zero() {
    print('.zero called');
    x = 0;
    y = 0;
  }

  @override
  String toString() {
    return '$x,$y';
  }
}

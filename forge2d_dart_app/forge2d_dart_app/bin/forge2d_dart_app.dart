import 'package:forge2d/forge2d.dart';

const int pyramidSize = 40;

final World world = World(Vector2(0.0, -10.0));

void main(List<String> arguments) {
  var list = ['a', 'b', 'c', 'd'];

  list.forEach(show);
}

void show(String s) {
  print(s);
}

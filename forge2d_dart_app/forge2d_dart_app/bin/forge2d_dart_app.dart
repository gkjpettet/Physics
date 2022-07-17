import 'package:forge2d/forge2d.dart';

const int pyramidSize = 40;

final World world = World(Vector2(0.0, -10.0));

void main(List<String> arguments) {
  print("Hi");
}

void initialise() {
  final bd = BodyDef();
  final ground = world.createBody(bd);

  final groundShape = EdgeShape()..set(Vector2(-40.0, -30.0), Vector2(40.0, -30.0));
  ground.createFixtureFromShape(groundShape);

  // add boxes
  const boxSize = .5;
  final shape = PolygonShape()..setAsBoxXY(boxSize, boxSize);

  final x = Vector2(-7.0, 0.75);
  final y = Vector2.zero();
  final deltaX = Vector2(0.5625, 1.0);
  final deltaY = Vector2(1.125, 0.0);

  for (var i = 0; i < pyramidSize; ++i) {
    y.setFrom(x);

    for (var j = i; j < pyramidSize; ++j) {
      final bd = BodyDef()
        ..type = BodyType.dynamic
        ..position.setFrom(y);
      world.createBody(bd).createFixtureFromShape(shape, 5.0);
      y.add(deltaY);
    }

    x.add(deltaX);
  }
}

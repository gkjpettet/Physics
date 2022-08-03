import 'package:forge2d/forge2d.dart';
import 'package:test/expect.dart';
//import 'dart:math';

//import 'package:vector_math/vector_math.dart';

const int xTruncBits = 12;
const int yTruncBits = 12;
const int tagBits = 8 * 4 - 1 /* sizeof(int) */;
const int yOffset = 1 << (yTruncBits - 1);
const int yShift = tagBits - yTruncBits;
const int xShift = tagBits - yTruncBits - xTruncBits;
const int xScale = 1 << xShift;
const int xOffset = xScale * (1 << (xTruncBits - 1));
const int xMask = (1 << xTruncBits) - 1;
const int yMask = (1 << yTruncBits) - 1;

void main(List<String> arguments) {
  var a = ['a', 'b', 'c'];
  var b = ['d', 'e', 'f'];

  var c = a + b;
  print(c);
}

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
  var a = computeRelativeTag(1, 2, 3);
  var b = computeRelativeTag(55, 98, 3);

  print(a);
  print(b);
}

int computeTag(double x, double y) {
  return ((y + yOffset).toInt() << yShift) + ((xScale * x).toInt() + xOffset);
}

int computeRelativeTag(int tag, int x, int y) {
  return tag + (y << yShift) + (x << xShift);
}

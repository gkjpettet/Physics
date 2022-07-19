import 'package:forge2d/forge2d.dart';
import 'dart:typed_data';

void main(List<String> arguments) {
  var c1 = Class1('Garry');
  var c2 = Class2('Fi');

  var i = 10;
}

class Class1 {
  final String name;

  Class1(this.name) {}
}

class Class2 extends Class1 {
  Class2(super.name) {}
}

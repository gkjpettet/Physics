import 'package:forge2d/forge2d.dart';
import 'dart:typed_data';

void main(List<String> arguments) {
  print(-3 << 1);
  print(9 << 2);
  print(10 << 3);
}

class MyClass {
  final Int8List _data = Int8List(4);

  set indexA(int v) {
    _data[0] = v;
  }

  set indexB(int v) {
    _data[1] = v;
  }

  int get indexA => _data[0];
  int get indexB => _data[1];
}

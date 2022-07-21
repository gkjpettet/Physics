import 'package:forge2d/forge2d.dart';
import 'dart:math';

void main(List<String> arguments) {
  final list1 = <int>[1, 2, 3, 4];
  final list2 = <int>[5, 6, 7, 8, 9];
  list1.setRange(1, 3, list2, 3);
  print('list1:$list1'); // [1,8,9,4]

  final list3 = <int>[1, 2, 3, 4];
  final list4 = <int>[5, 6, 7, 8, 9];
  list3.setRange(0, 0, list4);
  print('list3: $list3'); // [1,2,3,4]

  final list5 = <int>[1, 2, 3, 4];
  final list6 = <int>[5, 6, 7, 8, 9];
  list5.setRange(0, 2, list6, 2);
  print('list5: $list5'); // [7,8,3,4]

  final list7 = <int>[1, 2, 3, 4];
  final list8 = <int>[5, 6, 7, 8, 9];
  list7.setRange(0, 2, list8, 2);
  print('list7: $list7'); // [7,8,3,4]

  final list9 = <int>[1, 2, 3, 4];
  list9.setRange(1, 2, list9);
  print('list9: $list9'); // [1,1,4,3]

  final list10 = <int>[1, 2, 3, 4];
  final list11 = <int>[5, 6, 7, 8, 9];
  list10.setRange(1, 1, list11);
  print('list10: $list10'); // [1,2,3,4]
}

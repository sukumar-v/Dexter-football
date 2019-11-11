import 'package:flutter/foundation.dart';

class League {
  const League({@required this.title, @required this.clubs});

  final List<String> clubs;
  final String title;
}

import 'package:flutter/material.dart';

class Player {
  const Player({
    @required this.name,
    @required this.number,
    this.teams = const [],
    @required this.position,
    @required this.image,
    @required this.color,
  });

  final Color color;
  final String image;
  final String name;
  final String number;
  final List<String> teams;
  final String position;
}

import 'package:flutter/material.dart';

class PlayerTeam extends StatelessWidget {
  const PlayerTeam(this.label, {Key key, this.large = false}) : super(key: key);

  final String label;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: large ? 10 : 3,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: large ? 2 : 5,
          vertical: large ? 2 : 5,
        ),
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Image.asset(
          label,
          scale: large ? 1 : 8,
          height: large ? 50 : 15,
          // color: Colors.white,
        ),
      ),
    );
  }
}
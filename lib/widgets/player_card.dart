import 'package:flutter/material.dart';
import 'package:dexter/models/player.dart';
import 'package:dexter/widgets/player_position.dart';
import 'package:dexter/widgets/player_team.dart';

String capitalizeFirstChar(String text) {
  if (text == null || text.length <= 1) {
    return text.toUpperCase();
  }

  return text[0].toUpperCase() + text.substring(1);
}

class PlayerCard extends StatelessWidget {
  const PlayerCard(
    this.player, {
    @required this.index,
    Key key,
    this.onPress,
  }) : super(key: key);

  final int index;
  final Function onPress;
  final Player player;

  List<Widget> _buildTeams() {
    final widgetTeams = player.teams
        .map(
          (team) => Hero(
            tag: player.name + "-" + team,
            child: PlayerTeam(team),
          ),
        )
        .expand((item) => [item, SizedBox(height: 6)]);
        // print("look here -- > " + player.teams[0]);

    return widgetTeams.take(widgetTeams.length - 1).toList();
  }

  Widget _buildPosition() {  
    
    return PlayerPosition(player.position);
  }

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 28.0, right: 16.0, bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: player.name,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 14,
                    height: 0.7,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ..._buildTeams(),
            ]),
            SizedBox(height: 10),
            _buildPosition()
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDecorations(double itemHeight) {
    return [
      Positioned(
        bottom: -itemHeight * 0.136,
        right: -itemHeight * 0.034,
        child: Image.asset(
          player.teams[0],
          width: itemHeight * 0.754,
          height: itemHeight * 0.754,
          color: Colors.white.withOpacity(0.14),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 4,
        child: Hero(
          tag: player.image,
          child: Image.asset(
            player.image,
            fit: BoxFit.contain,
            width: itemHeight * 0.6,
            height: itemHeight * 0.6,
            alignment: Alignment.bottomRight,
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 14,
        child: Text(
          "#${player.number}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.12),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: player.color.withOpacity(0.12),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: player.color,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildCardContent(),
                    ..._buildDecorations(itemHeight),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

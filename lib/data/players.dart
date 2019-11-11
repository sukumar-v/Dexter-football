import 'package:dexter/configs/AppColors.dart';
import 'package:dexter/models/player.dart';
import 'package:flutter/material.dart';

const List<Player> players = [
  Player(
    name: "Lionel Messi",
    number: "10",
    teams: const ["assets/images/teams/barcelona.png", "assets/images/teams/argentina.png"],
    position: "Forward",
    image: "assets/images/headshots/lionel-messi.png",
    color: AppColors.red,
  ),
  Player(
    name: "Cristiano Ronaldo",
    number: "07",
    teams: const ["assets/images/teams/juventus.png", "assets/images/teams/portugal.png"],
    position: "Forward",
    image: "assets/images/headshots/cristiano-ronaldo.png",
    color: Colors.grey,
  ),
];

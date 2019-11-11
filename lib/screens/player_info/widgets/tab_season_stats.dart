import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dexter/configs/AppColors.dart';
import 'package:dexter/widgets/progress.dart';
import 'package:provider/provider.dart';

class Stat extends StatelessWidget {
  const Stat({
    Key key,
    @required this.label,
    @required this.value,
    @required this.progress,
  }) : super(key: key);

  final String label;
  final double progress;
  final String value;

  @override
  Widget build(BuildContext context) {
    final Animation animation = Provider.of<Animation>(context);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("$value"),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) => ProgressBar(
              progress: animation.value * progress,
              color: progress < 0.5 ? AppColors.red : AppColors.teal,
            ),
          ),
        ),
      ],
    );
  }
}

class AdditionalStat extends StatelessWidget {
  const AdditionalStat({
    Key key,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Text(
            label,
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("$value"),
        ),
      ],
    );
  }
}

class PlayerSeasonStats extends StatefulWidget {
  const PlayerSeasonStats({Key key}) : super(key: key);

  @override
  _PlayerBaseStatsState createState() => _PlayerBaseStatsState();
}

class _PlayerBaseStatsState extends State<PlayerSeasonStats>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  final List<Stat> _stats = [
    Stat(label: "Shot Accuracy", value: "77", progress: 77 / 100),
    Stat(label: "Pass Accuracy", value: "82", progress: 82 / 100),
    Stat(label: "Cross Accuracy", value: "0", progress: 0 / 100),
    Stat(label: "Tackles Won", value: "25", progress: 25 / 100),
    Stat(label: "Duels Won", value: "57", progress: 57 / 100),
    Stat(label: "Aerial Duels Won", value: "75", progress: 75 / 100),
  ];

  final List<AdditionalStat> _attackStats = [
    AdditionalStat(label: "Goals", value: "8"),
    AdditionalStat(label: "Minutes/goal", value: "67.5"),
    AdditionalStat(label: "Shot accuracy", value: "77%"),
    AdditionalStat(label: "Right foot goals", value: "0"),
    AdditionalStat(label: "Right foot goals", value: "8"),
    AdditionalStat(label: "Headed goals", value: "0"),
    AdditionalStat(label: "Goals-inside the box", value: "4"),
    AdditionalStat(label: "Goals-outside the box", value: "4"),
    AdditionalStat(label: "Other goals", value: "0"),
    AdditionalStat(label: "Successful dribbles", value: "30"),
    AdditionalStat(label: "offsides", value: "3"),
  ];

  final List<AdditionalStat> _defenseStats = [
    AdditionalStat(label: "Shot Accuracy", value: "77"),
    AdditionalStat(label: "Pass Accuracy", value: "82"),
    AdditionalStat(label: "Cross Accuracy", value: "0"),
    AdditionalStat(label: "Tackles Won", value: "25"),
    AdditionalStat(label: "Duels Won", value: "57"),
    AdditionalStat(label: "Aerial Duels Won", value: "75"),
  ];

  final List<AdditionalStat> _distributionStats = [
    AdditionalStat(label: "Shot Accuracy", value: "77"),
    AdditionalStat(label: "Pass Accuracy", value: "82"),
    AdditionalStat(label: "Cross Accuracy", value: "0"),
    AdditionalStat(label: "Tackles Won", value: "25"),
    AdditionalStat(label: "Duels Won", value: "57"),
    AdditionalStat(label: "Aerial Duels Won", value: "75"),
  ];

  final List<AdditionalStat> _disciplineStats = [
    AdditionalStat(label: "Shot Accuracy", value: "77"),
    AdditionalStat(label: "Pass Accuracy", value: "82"),
    AdditionalStat(label: "Cross Accuracy", value: "0"),
    AdditionalStat(label: "Tackles Won", value: "25"),
    AdditionalStat(label: "Duels Won", value: "57"),
    AdditionalStat(label: "Aerial Duels Won", value: "75"),
  ];

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  Widget _buildDivider() {
    return Column(
      children: <Widget>[
        SizedBox(height: 7),
        Divider(),
        SizedBox(height: 7),
      ],
    );
  }

  Widget _buildStatSection(String text, List<AdditionalStat> additionalStat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style:
              TextStyle(fontSize: 16, height: 0.8, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 22),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  offset: Offset(0, 8),
                  blurRadius: 23,
                ),
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ...additionalStat
                      .expand((stat) => [stat, _buildDivider()]),
                ])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardController = Provider.of<AnimationController>(context);
    return ListenableProvider<Animation>(
        builder: (context) => _animation,
        child: AnimatedBuilder(
          animation: cardController,
          child: Column(
            children: <Widget>[
              ..._stats.expand((stat) => [stat, SizedBox(height: 14)]),
              SizedBox(height: 27),
              _buildStatSection("Attack", _attackStats),
              SizedBox(height: 27),
              _buildStatSection("Defense", _defenseStats),
              SizedBox(height: 27),
              _buildStatSection("Distribution", _distributionStats),
              SizedBox(height: 27),
              _buildStatSection("Discipline", _disciplineStats),
              SizedBox(height: 27),
            ],
          ),
          builder: (context, child) {
            final scrollable = cardController.value.floor() == 1;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
              physics: scrollable
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              child: child,
            );
          },
        ));
  }
}

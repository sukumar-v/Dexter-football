import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dexter/configs/AppColors.dart';
import 'package:dexter/screens/player_info/widgets/tab_about.dart';
import 'package:dexter/screens/player_info/widgets/tab_season_stats.dart';
import 'package:dexter/screens/player_info/widgets/tab_prediction.dart';
import 'package:provider/provider.dart';

class TabData {
  final String label;
  final Widget child;

  TabData(this.label, this.child);
}

class PlayerTabInfo extends StatelessWidget {
  final List<TabData> _tabs = [
    TabData("About", PlayerAbout()),
    TabData("Season Stats", PlayerSeasonStats()),
    TabData("Predictions", PlayerPrediction()),
    TabData("News", Container(color: Colors.orange)),
  ];

  Widget _buildTabBar() {
    return TabBar(
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.grey,
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorColor: AppColors.indigo,
      tabs: _tabs.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
        children: _tabs.map((tab) => tab.child).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scrollController = Provider.of<AnimationController>(context);

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AnimatedBuilder(
              animation: scrollController,
              builder: (context, _) => SizedBox(height: (1 - scrollController.value) * 16 + 6),
            ),
            _buildTabBar(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }
}

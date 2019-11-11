import 'package:dexter/data/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dexter/screens/playerdex/widgets/league_modal.dart';
import 'package:dexter/screens/playerdex/widgets/search_modal.dart';
import 'package:dexter/widgets/fab.dart';
import 'package:dexter/widgets/dex_container.dart';
import 'package:dexter/widgets/player_card.dart';

class Playerdex extends StatefulWidget {
  @override
  _PlayerdexState createState() => _PlayerdexState();
}

class _PlayerdexState extends State<Playerdex> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _controller);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchBottomModal(),
    );
  }

  void _showLeagueModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => LeagueModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DexContainer(
            appBar: true,
            children: <Widget>[
              SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(
                  "Players",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
                  itemCount: players.length,
                  itemBuilder: (context, index) => PlayerCard(
                    players[index],
                    index: index,
                    onPress: () {
                      Navigator.of(context).pushNamed("/player-info");
                    },
                  ),
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return IgnorePointer(
                ignoring: _animation.value == 0,
                child: InkWell(
                  onTap: () {
                    _controller.reverse();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(_animation.value * 0.5),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Favourite Player",
            Icons.favorite,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "All Positions",
            Icons.account_balance,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "All Leagues",
            Icons.filter_vintage,
            onPress: () {
              _controller.reverse();
              _showLeagueModal();
            },
          ),
          FabItem(
            "All Clubs",
            Icons.flash_on,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "Search",
            Icons.search,
            onPress: () {
              _controller.reverse();
              _showSearchModal();
            },
          ),
        ],
        animation: _animation,
        onPress: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
      ),
    );
  }
}

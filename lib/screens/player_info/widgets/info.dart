import 'package:dexter/widgets/player_team.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dexter/widgets/animated_fade.dart';
import 'package:dexter/widgets/animated_rotation.dart';
import 'package:dexter/widgets/animated_slide.dart';
import 'package:dexter/widgets/player_position.dart';
import 'package:provider/provider.dart';

import 'decoration_box.dart';

class PlayerOverallInfo extends StatefulWidget {
  @override
  _PlayerOverallInfoState createState() => _PlayerOverallInfoState();
}

class _PlayerOverallInfoState extends State<PlayerOverallInfo>
    with TickerProviderStateMixin {
  static const double _appBarHorizontalPadding = 28.0;
  static const double _appBarTopPadding = 60.0;
  static const double _appBarBottomPadding = 22.0;

  int _currentPage = 0;
  PageController _pageController;
  AnimationController _slideController;
  AnimationController _rotateController;
  GlobalKey _currentTextKey = GlobalKey();
  GlobalKey _targetTextKey = GlobalKey();

  double textDiffTop = 0.0;
  double textDiffLeft = 0.0;

  @override
  void initState() {
    _slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 360));
    _slideController.forward();

    _rotateController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _rotateController.repeat();

    _pageController = PageController(viewportFraction: 0.6);
    _pageController.addListener(() {
      int next = _pageController.page.round();

      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox targetTextBox =
          _targetTextKey.currentContext.findRenderObject();
      final Offset targetTextPosition =
          targetTextBox.localToGlobal(Offset.zero);

      final RenderBox currentTextBox =
          _currentTextKey.currentContext.findRenderObject();
      final Offset currentTextPosition =
          currentTextBox.localToGlobal(Offset.zero);

      textDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
      textDiffTop = targetTextPosition.dy - currentTextPosition.dy;
    });

    super.initState();
  }

  @override
  dispose() {
    _slideController.dispose();
    _rotateController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(
        left: _appBarHorizontalPadding,
        right: _appBarHorizontalPadding,
        top: _appBarTopPadding,
        bottom: _appBarBottomPadding,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: Icon(Icons.arrow_back, color: Colors.white),
                onTap: Navigator.of(context).pop,
              ),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.compare_arrows, color: Colors.white),
                    SizedBox(width: 15),
                    Icon(Icons.favorite_border, color: Colors.white),
                  ]),
            ],
          ),
          // This widget just sit here for easily calculate the new position of
          // the player name when the card scroll up
          Opacity(
            opacity: 0.0,
            child: Text(
              "Lionel Messi",
              key: _targetTextKey,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerName() {
    final cardScrollController = Provider.of<AnimationController>(context);
    final fadeAnimation =
        Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: cardScrollController,
            builder: (context, child) {
              final double value = cardScrollController.value ?? 0.0;

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: Hero(
                  tag: "Lionel Messi",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "Lionel Messi",
                      key: _currentTextKey,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 36 - (36 - 22) * value,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedFade(
            animation: fadeAnimation,
            child: AnimatedSlide(
              animation: _slideController,
              child: Hero(
                tag: "#10",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "#10",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerTeams() {
    final cardScrollController = Provider.of<AnimationController>(context);
    final fadeAnimation =
        Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    return AnimatedFade(
      animation: fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "Lionel Messi-barcelona.png",
                  child: PlayerTeam("assets/images/teams/barcelona.png",
                      large: true),
                ),
                SizedBox(width: 0),
                Hero(
                  tag: "Lionel Messi-argentina.png",
                  child: PlayerTeam("assets/images/teams/argentina.png",
                      large: true),
                ),
              ],
            ),
            AnimatedSlide(
                animation: _slideController,
                child: PlayerPosition("Forward", large: true)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerSlider(BuildContext context) {
    final cardScrollController = Provider.of<AnimationController>(context);
    final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: cardScrollController,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedFade(
      animation: fadeAnimation,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: screenHeight * 0.24,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedRotation(
                animation: _rotateController,
                child: Image.asset(
                  "assets/icons/football1.png",
                  width: screenHeight * 0.24,
                  height: screenHeight * 0.24,
                  color: Colors.white.withOpacity(0.14),
                ),
              ),
            ),
            PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (context, index) => Hero(
                tag: index == 0
                    ? "assets/images/headshots/lionel-messi.png"
                    : "",
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeOutQuint,
                  padding: EdgeInsets.only(
                    top: _currentPage == index ? 0 : screenHeight * 0.04,
                    bottom: _currentPage == index ? 0 : screenHeight * 0.04,
                  ),
                  child: Image.asset(
                    "assets/images/headshots/lionel-messi.png",
                    width: screenHeight * 0.28,
                    height: screenHeight * 0.28,
                    alignment: Alignment.bottomCenter,
                    color: _currentPage == index ? null : Color(0xFF28A889),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardScrollController = Provider.of<AnimationController>(context);
    final dottedAnimation =
        Tween(begin: 1.0, end: 0.0).animate(cardScrollController);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final dexSize = screenWidth * 0.448;

    final dexTop =
        -(dexSize / 2 - (IconTheme.of(context).size / 2 + _appBarTopPadding));
    final dexRight = -(dexSize / 2 -
        (IconTheme.of(context).size / 2 + _appBarHorizontalPadding));

    return Stack(
      children: [
        Positioned(
          top: dexTop,
          right: dexRight,
          child: AnimatedFade(
            animation: cardScrollController,
            child: AnimatedRotation(
              animation: _rotateController,
              child: Image.asset(
                "assets/icons/football1.png",
                width: dexSize,
                height: dexSize,
                color: Colors.white.withOpacity(0.26),
              ),
            ),
          ),
        ),
        Positioned(
          top: -screenHeight * 0.055,
          left: -screenHeight * 0.055,
          child: DecorationBox(),
        ),
        Positioned(
          top: 4,
          left: screenHeight * 0.3,
          child: AnimatedFade(
            animation: dottedAnimation,
            child: Image.asset(
              "assets/images/dotted.png",
              width: screenHeight * 0.07,
              height: screenHeight * 0.07 * 0.54,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            _buildAppBar(),
            SizedBox(height: 9),
            _buildPlayerName(),
            SizedBox(height: 9),
            _buildPlayerTeams(),
            SizedBox(height: 25),
            _buildPlayerSlider(context),
          ],
        ),
      ],
    );
  }
}

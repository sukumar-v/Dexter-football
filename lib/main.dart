import 'package:dexter/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dexter/screens/home/home.dart';
import 'package:dexter/screens/playerdex/playerdex.dart';
import 'package:dexter/screens/player_info/player_info.dart';
import 'package:dexter/widgets/fade_page_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      onGenerateRoute: _getRoute,
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        // if(snapshot.connectionState == ConnectionState.waiting)
        //   return SplashPage();
        if (!snapshot.hasData || snapshot.data == null) return Login();
        return Home();
      },
    );
  }
}

Route _getRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return FadeRoute(page: MainScreen());

    case '/playerdex':
      return FadeRoute(page: Playerdex());

    case '/player-info':
      return FadeRoute(page: PlayerInfo());

    default:
      return null;
  }
}

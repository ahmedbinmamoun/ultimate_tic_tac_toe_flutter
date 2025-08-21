import 'package:flutter/material.dart';
import 'package:ultimate_tic_tac_toe_flutter/screens/game_screen.dart';
import 'package:ultimate_tic_tac_toe_flutter/screens/home_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue.shade100,
      ),
      routes: {
        HomeScreen.routName: (context) => HomeScreen(),
        GameScreen.routName: (context) => GameScreen(),
      },
      initialRoute: HomeScreen.routName,
    );
  }
}

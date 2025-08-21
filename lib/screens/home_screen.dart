import 'package:flutter/material.dart';
import 'package:ultimate_tic_tac_toe_flutter/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ultimate Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, GameScreen.routName, arguments: {'mode': 'friend'});
              },
              child: Text('Play with Friend'),
            ),
            ElevatedButton(
              onPressed: () {
                _showComputerLevelDialog(context);
              },
              child: Text('Play with Computer'),
            ),
          ],
        ),
      ),
    );
  }

  void _showComputerLevelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Computer Level'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Easy'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, GameScreen.routName, arguments: {'mode': 'computer', 'level': 'easy'});
                },
              ),
              ListTile(
                title: Text('Medium'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, GameScreen.routName, arguments: {'mode': 'computer', 'level': 'medium'});
                },
              ),
              ListTile(
                title: Text('Hard'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, GameScreen.routName, arguments: {'mode': 'computer', 'level': 'hard'});
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
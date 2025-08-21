import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_tic_tac_toe_flutter/screens/game_screen.dart';
import 'package:ultimate_tic_tac_toe_flutter/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen has a title and a button to start the game', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    expect(find.text('Ultimate Tic Tac Toe'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('GameScreen displays the game board', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(PlayerIndicator), findsOneWidget);
  });

  testWidgets('PlayerIndicator shows current player', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GameScreen()));

    expect(find.text('Current Player: X'), findsOneWidget);
  });
}
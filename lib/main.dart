import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/my_game.dart';

void main() {
  // runApp(const MyApp());
  final game = MyGame();
  runApp(
    GameWidget(
      game: game,
      backgroundBuilder: (context) {
        return Container(color: const Color.fromARGB(255, 0, 130, 129));
      },
    ),
  );
}

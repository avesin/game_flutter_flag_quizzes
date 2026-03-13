import 'package:flags_game/game/data/flags_data.dart';
import 'package:flame/components.dart';
import 'package:flags_game/game/components/keypad.dart';
import 'package:flutter/widgets.dart';

class GameUI extends PositionComponent with HasGameReference {
  final Flag flag;

  GameUI({required this.flag}) : super();

  @override
  Future<void> onLoad() async {
    final textInput = TextComponent(
      text: "",
      anchor: Anchor.center,
      position: Vector2(game.size.x / 2, game.size.y - 600),
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Pixel',
          fontSize: 35,
          color: Color.fromARGB(0, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    add(textInput);

    String answer = flag.correctAnswer.en.toUpperCase();
    const spacing = 30.0;
    final totalWidth = answer.length * spacing;
    final startX = ((game.size.x - totalWidth) / 2) + 10;
    List<TextComponent> textComponents = [];
    for (int i = 0; i < answer.length; i++) {
      var textComponent = TextComponent(
        text: "",
        anchor: Anchor.center,
        position: Vector2(startX + i * spacing, game.size.y - 450),
        textRenderer: TextPaint(
          style: TextStyle(
            fontFamily: 'Pixel',
            fontSize: 35 - (answer.length > 10 ? (answer.length - 9) : 0),
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );
      textComponents.add(textComponent);
      add(textComponent);
    }

    void updateLetters() {
      String input = textInput.text.toUpperCase();
      debugPrint("Jawabannya adalah input:: $input");
      List<bool> result = flag.isSimilar(input);
      for (int i = 0; i < textComponents.length; i++) {
        if (i < input.length) {
          textComponents[i].text = input[i];
          textComponents[i].textRenderer = TextPaint(
            style: TextStyle(
              fontFamily: 'Pixel',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: result[i]
                  ? const Color(0xFF00FF00)
                  : const Color(0xFFFF0000),
            ),
          );
        } else {
          textComponents[i].text = "";
        }
      }
    }

    add(
      Keypad(
        onKeyPressed: (p0) {
          var currentText = textInput.text;
          if (currentText != answer || p0 == "<-") {
            if (p0 == "<-") {
              if (currentText.isNotEmpty) {
                textInput.text = currentText.substring(
                  0,
                  currentText.length - 1,
                );
              }
            } else {
              textInput.text = currentText + p0;
            }
            updateLetters();
          } else {
            debugPrint("Selamat Kamu benar");
          }
        },
      ),
    );
  }
}

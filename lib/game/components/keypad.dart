import 'package:flags_game/game/components/keybutton.dart';
import 'package:flame/components.dart';

class Keypad extends PositionComponent with HasGameReference {
  final Function(String) onKeyPressed;
  Keypad({required this.onKeyPressed});

  final keys = [
    'Keys/A-Key.png',
    'Keys/B-Key.png',
    'Keys/C-Key.png',
    'Keys/D-Key.png',
    'Keys/E-Key.png',
    'Keys/F-Key.png',
    'Keys/G-Key.png',
    'Keys/H-Key.png',
    'Keys/I-Key.png',
    'Keys/J-Key.png',
    'Keys/K-Key.png',
    'Keys/L-Key.png',
    'Keys/M-Key.png',
    'Keys/N-Key.png',
    'Keys/O-Key.png',
    'Keys/P-Key.png',
    'Keys/Q-Key.png',
    'Keys/R-Key.png',
    'Keys/S-Key.png',
    'Keys/T-Key.png',
    'Keys/U-Key.png',
    'Keys/V-Key.png',
    'Keys/W-Key.png',
    'Keys/X-Key.png',
    'Keys/Y-Key.png',
    'Keys/Z-Key.png',
    'Keys/Space-Key.png',
    'Keys/Blank-Lg-Key.png',
  ];

  final values = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    ' ',
    "<-",
  ];

  @override
  Future<void> onLoad() async {
    const keySize = 32.0;
    const spacing = 32;
    const cols = 6;

    final totalWidth = cols * keySize + (cols - 1) * spacing;

    // center horizontal
    final startX = (game.size.x - totalWidth) / 3.5;

    // bottom screen
    final startY = game.size.y - 360;

    for (int i = 0; i < keys.length; i++) {
      final row = i ~/ cols;
      final col = i % cols;

      final isSpace = keys[i].contains("Space");
      final isBlankLg = keys[i].contains("Blank-Lg");

      add(
        KeyButton(
          imagePath: keys[i],
          label: isBlankLg ? "⌫" : null,
          value: values[i],
          position: Vector2(
            startX + (col + (isBlankLg ? 1 : 0)) * (keySize + spacing),
            startY + row * (keySize + spacing),
          ),
          sizee: isSpace
              ? Vector2(keySize * 2, keySize)
              : isBlankLg
              ? Vector2(keySize * 2, keySize)
              : Vector2.all(keySize),
          onPressed: (value) => {onKeyPressed(value)},
        ),
      );
    }
  }
}

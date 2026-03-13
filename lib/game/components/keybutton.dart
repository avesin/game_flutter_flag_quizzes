import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text.dart';
import 'package:flutter/widgets.dart';

class KeyButton extends SpriteComponent with TapCallbacks, HasGameReference {
  final String imagePath;
  late Vector2? sizee = null;
  late String? label = null;
  late Sprite normalSprite;
  late Sprite pressedSprite;
  final Function(String) onPressed;
  final String value;

  KeyButton({
    required this.imagePath,
    required Vector2 position,
    required this.onPressed,
    required this.value,
    this.label,
    this.sizee,
  }) : super(position: position, size: (sizee ?? Vector2(32, 32)) * 2);

  @override
  Future<void> onLoad() async {
    final image = await game.images.load(imagePath);
    final sheet = SpriteSheet(image: image, srcSize: sizee ?? Vector2(32, 32));
    // kiri = normal
    normalSprite = sheet.getSprite(0, 0);
    // kanan = pressed
    pressedSprite = sheet.getSprite(0, 1);
    sprite = normalSprite;

    if (label != null) {
      final text = TextComponent(
        text: label!,
        anchor: Anchor.center,
        position: size / 2,
        textRenderer: TextPaint(
          style: TextStyle(
            fontFamily: 'Pixel',
            color: Color(0xFFFFFFFF),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      add(text);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    sprite = pressedSprite;
  }

  @override
  void onTapUp(TapUpEvent event) {
    sprite = normalSprite;

    onPressed(value);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    sprite = normalSprite;
  }
}

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

class KeyButtonLong extends SpriteComponent
    with TapCallbacks, HasGameReference {
  final String imagePath;

  late Sprite normalSprite;
  late Sprite pressedSprite;

  KeyButtonLong({required this.imagePath, required Vector2 position})
    : super(position: position, size: Vector2.all(64));

  @override
  Future<void> onLoad() async {
    final image = await game.images.load(imagePath);

    final sheet = SpriteSheet(image: image, srcSize: Vector2(64, 32));

    // kiri = normal
    normalSprite = sheet.getSprite(0, 0);

    // kanan = pressed
    pressedSprite = sheet.getSprite(0, 1);

    sprite = normalSprite;
  }

  @override
  void onTapDown(TapDownEvent event) {
    sprite = pressedSprite;
  }

  @override
  void onTapUp(TapUpEvent event) {
    sprite = normalSprite;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    sprite = normalSprite;
  }
}

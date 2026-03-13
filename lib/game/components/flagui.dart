import 'package:flame/components.dart';

class FlagUI extends SpriteAnimationComponent with HasGameReference {
  final String path;
  FlagUI(this.path)
    : super(size: Vector2(192, 136), position: Vector2(100, 100));

  @override
  Future<void> onLoad() async {
    final image = await game.images.load(path);

    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 16,
        stepTime: 0.08,
        textureSize: Vector2(192, 136),
        amountPerRow: 4,
      ),
    );
  }
}

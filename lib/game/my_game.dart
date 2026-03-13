import 'package:flags_game/game/components/flagui.dart';
import 'package:flags_game/game/components/gameui.dart';
import 'package:flags_game/game/data/flags_data.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    final randomFlag = flags.random();
    add(FlagUI(randomFlag.imagePath));
    add(GameUI(flag: randomFlag));
  }
}

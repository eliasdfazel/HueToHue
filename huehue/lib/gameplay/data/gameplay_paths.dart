/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/9/23, 7:28 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

class GameplayPaths {

  static const String backgroundMusic = "background_music.mp3";

  static const String pointsSound = "points_sound.wav";
  static const String levelsSound = "levels_sound.wav";

  static const String transitionsSound = "transitions_sound.wav";

  static const String gameOverSound = "game_over_sound.wav";

  String allLevelPath() {

    return "/HueToHue/Gameplay/Levels";
  }

  String levelPath(int currentLevel) {

    return "/HueToHue/Gameplay/Levels/${currentLevel.toString()}";
  }

  String soundsPath() {

    return "/HueToHue/Gameplay/Assets/Sounds";
  }

}
/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/9/23, 4:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

class GameplayPaths {

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
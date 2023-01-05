/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/5/23, 7:23 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

String allLevelPath() {

  return "/HueToHue/Gameplay/Levels";
}

String levelPath(int currentLevel) {

  return "/HueToHue/Gameplay/Levels/${currentLevel.toString()}";
}
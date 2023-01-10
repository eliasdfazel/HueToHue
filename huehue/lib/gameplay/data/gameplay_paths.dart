/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/10/23, 4:05 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class GameplayPaths {

  static const String backgroundMusic = "background_music";

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

  Future<String> prepareBackgroundMusicPath() async {

    String backgroundMusicPath = "${soundsPath()}/${backgroundMusic}_0.mp3";

    Directory allSoundsDirectory = Directory(soundsPath());

    if (allSoundsDirectory.existsSync()) {

      List<FileSystemEntity> allSoundsFiles = allSoundsDirectory.listSync(recursive: true);
      backgroundMusicPath = allSoundsFiles[Random().nextInt(allSoundsFiles.length - 1)].path;

    }

    debugPrint("Background Music To Play: ${backgroundMusicPath}");
    return backgroundMusicPath;
  }

}
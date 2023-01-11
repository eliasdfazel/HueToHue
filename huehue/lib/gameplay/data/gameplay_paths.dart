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
import 'package:path_provider/path_provider.dart';

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

    final assetsDirectory = await getApplicationSupportDirectory();

    String backgroundMusicPath = "$assetsDirectory/${soundsPath()}/${backgroundMusic}_0.mp3";

    Directory allSoundsDirectory = Directory("${assetsDirectory.path}/${soundsPath()}");

    if (allSoundsDirectory.existsSync()) {

      List<FileSystemEntity> allSoundsFiles = allSoundsDirectory.listSync(recursive: true);

      List<FileSystemEntity> allBackgroundMusics = [];

      for (var aSoundFile in allSoundsFiles) {

        if (aSoundFile.path.contains(backgroundMusic)) {

          allBackgroundMusics.add(aSoundFile);

        }

      }

      backgroundMusicPath = allBackgroundMusics[Random().nextInt(allBackgroundMusics.length)].path;

    }

    debugPrint("Background Music To Play: $backgroundMusicPath");
    return backgroundMusicPath;
  }

}
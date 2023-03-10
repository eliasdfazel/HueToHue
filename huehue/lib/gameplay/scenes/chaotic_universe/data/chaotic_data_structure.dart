/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/15/23, 4:24 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/resources/colors_resources.dart';

class ChaoticDataStructure {

  static const int platinumLuck = 30;
  static const int goldLuck = 60;
  static const int palladiumLuck = 90;

  final int _maximumLayerCount = 7;
  final int _minimumLayerCount = 2;

  final int _minimumAnimationDuration = 3333;
  final int _maximumAnimationDuration = 1333;

  Random random = Random();

  int gradientLayerCount = 2;

  double gradientColorRotation = 137.0;

  List<double> gradientAngles = [137.0, 90.0, 45.0, 0.0, 315.0];

  int gradientAnimationDuration = 3333;

  List<Color> allLevelColors = [ColorsResources.primaryColor, ColorsResources.cyan, ColorsResources.applicationDarkGeeksEmpire];

  Future<void> initializeChaoticData(PreferencesIO preferencesIO) async {

    gradientLayerCount = _minimumLayerCount + random.nextInt(_maximumLayerCount - _minimumLayerCount);

    gradientAnimationDuration = _maximumAnimationDuration + random.nextInt(_minimumAnimationDuration - _maximumAnimationDuration);

    allLevelColors.clear();

    for (int i = 0; i < gradientLayerCount; i++) {

      int redElement = random.nextInt(255);
      int greenElement = random.nextInt(255);
      int blueElement = random.nextInt(255);

      allLevelColors.add(Color.fromARGB(255, redElement, greenElement, blueElement));

    }


    var iqScore = await preferencesIO.retrieveIQ();

    if (iqScore >= 99) {

      gradientColorRotation = gradientAngles[random.nextInt(gradientAngles.length)];

    }

    debugPrint("Gradient Layer Count: $gradientLayerCount - Gradient Animation Duration: $gradientAnimationDuration - All Colors: $allLevelColors");
  }

  /// All Colors
  List<Color> allColors() {

    return allLevelColors;
  }

  /// Gradient Color Change Duration
  int gradientDuration() {


    return gradientAnimationDuration;
  }

  /// Number Of Layers For Gradient
  int gradientLayersCount() {

    return gradientLayerCount;
  }

  /// Angle To Rotate Gradient Colors
  double gradientRotation() {

    return gradientColorRotation;
  }

}
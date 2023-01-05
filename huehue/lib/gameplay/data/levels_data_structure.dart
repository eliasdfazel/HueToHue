/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/5/23, 7:30 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LevelsDataStructure {

  static const String allColorsName = "allColors";

  static const String gradientDurationName = "gradientDuration";
  static const String gradientLayersName = "gradientLayers";

  static const String levelTimerName = "levelTimer";

  Map<String, dynamic> levelsDocumentData = <String, dynamic>{};

  LevelsDataStructure(DocumentSnapshot levelsDocument) {

    levelsDocumentData = levelsDocument.data() as Map<String, dynamic>;

  }

  /// All Colors
  List<Color> allColors() {

    List<Color> allLevelColors = [];

    for (int element in (levelsDocumentData[LevelsDataStructure.allColorsName] as List<dynamic>)) {

      allLevelColors.add(Color(element));

    }

    return allLevelColors;
  }

  /// Gradient Color Change Duration
  int gradientDuration() {

    return levelsDocumentData[LevelsDataStructure.gradientDurationName];
  }
  /// Number Of Layers For Gradient
  int gradientLayers() {

    return levelsDocumentData[LevelsDataStructure.gradientLayersName];
  }

  /// Timer for Each Level
  int levelTimer() {

    return levelsDocumentData[LevelsDataStructure.levelTimerName];
  }



}
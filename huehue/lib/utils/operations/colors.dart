/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/4/23, 5:38 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:math';

import 'package:flutter/material.dart';

class ColorsUtils {

  Color randomColor(List<Color> allColors) {

    return allColors[Random().nextInt(allColors.length)];
  }

  bool gradientSimilarity(List<Color> colorListOne, List<Color> colorListTwo, {int similarityOffset = 37}) {

    bool similarityResult = false;

    if (colorListOne.isNotEmpty && colorListTwo.isNotEmpty) {

      if (colorListOne.length == colorListTwo.length) {

        for (int colorIndex = 0; colorIndex < colorListOne.length; colorIndex++) {

          similarityResult = colorsSimilarity(colorListOne[colorIndex], colorListTwo[colorIndex], similarityOffset: similarityOffset);

        }

      }

    }

    return similarityResult;
  }

  /// Check If Two Colors Are Similar By An Offset 0 - 255
  /// 0 - Completely Similar
  /// 255 - Not Similar At All
  /// Default Offset is 37
  bool colorsSimilarity(Color colorOne, Color colorTwo, {int similarityOffset = 37}) {

    bool similarityResult = false;

    if ((colorOne.red - colorTwo.red).abs() <= similarityOffset
        && (colorOne.green - colorTwo.green).abs() <= similarityOffset
        && (colorOne.blue - colorTwo.blue).abs() <= similarityOffset) {

      similarityResult = true;

    }

    return similarityResult;
  }

  List<Color> prepareBlobGradient(List<Color> allColors, int gradientLayerCount) {

    List<Color> blobColors = [];

    int randomLayer = Random().nextInt(gradientLayerCount);

    Color startingSection = randomColor(allColors);

    for (int i = 0; i < randomLayer; i++) {

      blobColors.add(startingSection);

    }

    Color endingSection = randomColor(allColors);

    for (int i = randomLayer; i < gradientLayerCount; i++) {

      blobColors.add(endingSection);

    }

    return blobColors;
  }

}
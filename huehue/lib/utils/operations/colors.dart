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

Color randomColor(List<Color> allColors) {

  return allColors[Random().nextInt(allColors.length)];
}
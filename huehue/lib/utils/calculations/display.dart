/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/5/22, 11:04 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:ui';

import 'package:flutter/material.dart';

double displayLogicalWidth(BuildContext context) {

  return  MediaQuery.of(context).size.width;
}

double displayWidth() {

  return  window.physicalSize.width;
}

double displayHeight() {

  return window.physicalSize.height;
}

double safeAreaHeight(BuildContext context) {

  var padding = MediaQuery.of(context).padding;

  return displayHeight() - padding.top - padding.bottom;
}

double statusBarHeight(BuildContext context) {

  return MediaQuery.of(context).viewPadding.top;
}

/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/9/22, 6:12 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';

void changeColor(Color statusBarColor, Color navigationBarColor) {

  StatusBarControl.setColor(statusBarColor, animated: true);

  StatusBarControl.setNavigationBarColor(navigationBarColor, animated: true);

}
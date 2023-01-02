/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/2/23, 4:17 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:huehue/entry_configurations.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
        backgroundColor: ColorsResources.primaryColorDarkest,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeTransitionBuilder(),
          TargetPlatform.iOS: FadeTransitionBuilder(),
        }),
      ),
      home: const EntryConfigurations()
  ));

}
/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/4/23, 3:56 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/cupertino.dart';
import 'package:huehue/preferences/PreferencesKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesIO {

  final Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  Future<String> retrieveCurrentLevel() async {

    String currentLevel = "1";

    sharedPreferences.then((value) => {

      currentLevel = value.getString(PreferencesKeys.currentLevel) ?? "1"

    });

    return currentLevel;
  }

  Future storeCurrentLevel(String currentLevel) async {

    sharedPreferences.then((value) => {

      value.setString(PreferencesKeys.currentLevel, currentLevel).then((value) => {
        debugPrint("Current Level Stored Successfully: ${value}")
      })

    });

  }

  Future<bool> retrieveContinuously() async {

    bool continuously = false;

    sharedPreferences.then((value) => {

      continuously = value.getBool(PreferencesKeys.continuously) ?? false

    });

    return continuously;
  }

  Future storeContinuously(bool continuously) async {

    sharedPreferences.then((value) => {

      value.setBool(PreferencesKeys.continuously, continuously).then((value) => {
        debugPrint("Continuously Stored Successfully: ${value}")
      })

    });

  }

}
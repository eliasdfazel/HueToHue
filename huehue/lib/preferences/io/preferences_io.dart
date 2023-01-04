/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/4/23, 4:06 AM
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

    String currentLevel = (await sharedPreferences).getString(PreferencesKeys.currentLevel) ?? "1";

    return currentLevel;
  }

  Future storeCurrentLevel(String currentLevel) async {

    sharedPreferences.then((value) async => {

      await value.setString(PreferencesKeys.currentLevel, currentLevel).then((value) => {
        debugPrint("Current Level Stored Successfully: $currentLevel")
      })

    });

  }

  Future<bool> retrieveContinuously() async {

    bool continuously = (await sharedPreferences).getBool(PreferencesKeys.continuously) ?? false;

    return continuously;
  }

  Future storeContinuously(bool continuously) async {

    sharedPreferences.then((value) async => {

      await value.setBool(PreferencesKeys.continuously, continuously).then((value) => {
        debugPrint("Continuously Stored Successfully: $continuously")
      })

    });

  }

}
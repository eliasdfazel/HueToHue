/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/4/23, 2:33 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

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

      value.setString(PreferencesKeys.currentLevel, currentLevel)

    });

  }

}
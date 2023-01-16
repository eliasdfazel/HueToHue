/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/23, 7:48 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/cupertino.dart';
import 'package:huehue/preferences/data/PreferencesKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesIO {

  final Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  Future<int> retrieveCurrentLevel() async {

    int currentLevel = (await sharedPreferences).getInt(PreferencesKeys.currentLevel) ?? 1;

    return currentLevel;
  }

  Future storeCurrentLevel(int currentLevel) async {

    sharedPreferences.then((value) async => {

      await value.setInt(PreferencesKeys.currentLevel, currentLevel).then((value) => {
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

  Future<bool> retrieveSounds() async {

    bool sounds = (await sharedPreferences).getBool(PreferencesKeys.sounds) ?? true;

    return sounds;
  }

  Future storeSounds(bool sounds) async {

    sharedPreferences.then((value) async => {

      await value.setBool(PreferencesKeys.sounds, sounds).then((value) => {
        debugPrint("Continuously Stored Successfully: $sounds")
      })

    });

  }

  Future<int> retrieveLastLuck() async {

    int currentLevel = (await sharedPreferences).getInt(PreferencesKeys.lastLuck) ?? 1;

    return currentLevel;
  }

  Future storeLastLuck(int lastLuck) async {

    sharedPreferences.then((value) async => {

      await value.setInt(PreferencesKeys.lastLuck, lastLuck).then((value) => {
        debugPrint("Last Luck Stored Successfully: $lastLuck")
      })

    });

  }

}
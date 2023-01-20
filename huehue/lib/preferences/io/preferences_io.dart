/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/18/23, 2:48 AM
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

    int currentLevel = (await sharedPreferences).getInt(PreferencesKeys.lastLuck) ?? 2;

    return currentLevel;
  }

  Future storeLastLuck(int lastLuck) async {

    sharedPreferences.then((value) async => {

      await value.setInt(PreferencesKeys.lastLuck, lastLuck).then((value) => {
        debugPrint("Last Luck Stored Successfully: $lastLuck")
      })

    });

  }

  Future<double> retrieveLevelsUpdateTime() async {

    double levelsUpdateTime = (await sharedPreferences).getDouble(PreferencesKeys.levelsUpdateTime) ?? 0;

    return levelsUpdateTime;
  }

  Future storeLevelsUpdateTime(double levelsUpdateTime) async {

    sharedPreferences.then((value) async => {

      await value.setDouble(PreferencesKeys.levelsUpdateTime, levelsUpdateTime).then((value) => {
        debugPrint("Levels Update Time Stored Successfully: $levelsUpdateTime")
      })

    });

  }

  Future<double> retrieveIQ() async {

    double scoreIQ = (await sharedPreferences).getDouble(PreferencesKeys.scoreIQ) ?? 50;

    return scoreIQ;
  }

  Future storeIQ(double scoreIQ) async {

    sharedPreferences.then((value) async => {

      await value.setDouble(PreferencesKeys.scoreIQ, scoreIQ).then((value) => {
        debugPrint("Score IQ Stored Successfully: $scoreIQ")
      })

    });

  }

  Future<double> retrieveColorOffset() async {

    double scoreIQ = (await sharedPreferences).getDouble(PreferencesKeys.colorOffset) ?? 37;

    return scoreIQ;
  }

  Future storeColorOffset(double colorOffset) async {

    sharedPreferences.then((value) async => {

      await value.setDouble(PreferencesKeys.colorOffset, colorOffset).then((value) => {
        debugPrint("Color Offset Stored Successfully: $colorOffset")
      })

    });

  }

  Future calculateColorOffset(double scoreIQ) async {

    // IQ: 50 - 150
    // Offset: 0 - 100



  }

}
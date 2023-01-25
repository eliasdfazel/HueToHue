/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/8/23, 3:36 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class SyncDataStructure {

  static const String syncTimestampName = "syncTimestamp";

  static const String currentLevelName = "currentLevel";
  static const String iqScoreName = "scoreIQ";

  Map<String, dynamic> syncDocumentData = <String, dynamic>{};

  SyncDataStructure(DocumentSnapshot documentSnapshot) {

    syncDocumentData = documentSnapshot.data() as Map<String, dynamic>;

  }

  int syncTimestamp() {

    return syncDocumentData[SyncDataStructure.syncTimestampName];
  }

  /// Synced Level
  int currentLevel() {

    return syncDocumentData[SyncDataStructure.currentLevelName];
  }

  /// Player IQ
  int scoreIQ() {

    return syncDocumentData[SyncDataStructure.iqScoreName];
  }

}

Map<String, int> mappedSyncedData(int currentLevel, int scoreIQ) {

  return {
    SyncDataStructure.syncTimestampName: DateTime.now().millisecondsSinceEpoch,
    SyncDataStructure.currentLevelName: currentLevel,
    SyncDataStructure.iqScoreName: scoreIQ
  };
}
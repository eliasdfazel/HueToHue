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

  Map<String, dynamic> SyncDocumentData = <String, dynamic>{};

  SyncDataStructure(DocumentSnapshot documentSnapshot) {

    SyncDocumentData = documentSnapshot.data() as Map<String, dynamic>;

  }

  int syncTimestamp() {

    return SyncDocumentData[SyncDataStructure.syncTimestampName];
  }

  /// Synced Level
  int currentLevel() {

    return SyncDocumentData[SyncDataStructure.currentLevelName];
  }

}

Map<String, int> mappedSyncedData(int currentLevel) {

  return {
    SyncDataStructure.syncTimestampName: DateTime.now().millisecondsSinceEpoch,
    SyncDataStructure.currentLevelName: currentLevel
  };
}
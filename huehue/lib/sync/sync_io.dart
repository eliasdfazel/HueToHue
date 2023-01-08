/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/8/23, 3:35 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/sync/data/sync_data_structure.dart';
import 'package:huehue/sync/data/sync_path.dart';

abstract class SynchronizationStatus {
  void syncCompleted(int syncedCurrentLevel);
  void syncError();
}

class SyncIO {

  void startSyncingProcess(PreferencesIO preferencesIO, String uniqueId, SynchronizationStatus syncInterface) async {

    int offlineCurrentLevel = await preferencesIO.retrieveCurrentLevel();

    FirebaseFirestore.instance.doc(syncedDataPath(uniqueId))
        .get(const GetOptions(source: Source.server)).then((value) => {

          if (value.exists) {

            Future.delayed(Duration.zero, () async {

              SyncDataStructure syncDataStructure = SyncDataStructure(value);

              if (syncDataStructure.currentLevel() > offlineCurrentLevel) {

                preferencesIO.storeCurrentLevel(syncDataStructure.currentLevel());

                syncInterface.syncCompleted(syncDataStructure.currentLevel());

              } else {

                final syncedData = mappedSyncedData(offlineCurrentLevel);

                await FirebaseFirestore.instance.doc(syncedDataPath(uniqueId)).set(syncedData);

                syncInterface.syncCompleted(offlineCurrentLevel);

              }

            })

          } else {

            Future.delayed(Duration.zero, () async {

              final syncedData = mappedSyncedData(offlineCurrentLevel);

              await FirebaseFirestore.instance.doc(syncedDataPath(uniqueId)).set(syncedData);

              syncInterface.syncCompleted(offlineCurrentLevel);

            })

          }

        });

  }

}
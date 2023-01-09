/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/9/23, 4:58 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:huehue/gameplay/data/gameplay_paths.dart';
import 'package:path_provider/path_provider.dart';

class AssetsIO {

  GameplayPaths gameplayPaths = GameplayPaths();

  void retrieveAllSounds() async {

    final soundsAssetsPath = FirebaseStorage.instance.ref(gameplayPaths.soundsPath());

    final assetsDirectory = await getApplicationSupportDirectory();

    soundsAssetsPath.listAll().then((listResult) => {

      Future(() {
        Directory("${assetsDirectory.path}/${gameplayPaths.soundsPath()}").createSync(recursive: true);

        for (var storageReference in listResult.items) {

          final filePath = "${assetsDirectory.path}/${gameplayPaths.soundsPath()}/${storageReference.name}";
          final file = File(filePath);

          if (!file.existsSync()) {
            file.existsSync();

            final downloadTask = storageReference.writeToFile(file);
            downloadTask.snapshotEvents.listen((taskSnapshot) {
              switch (taskSnapshot.state) {
                case TaskState.running:
                  debugPrint("${storageReference.name}: Downloading... ${taskSnapshot.bytesTransferred}");
                  break;
                case TaskState.paused:
                  break;
                case TaskState.success:
                  debugPrint("${storageReference.name} Downloaded Successfully!");
                  break;
                case TaskState.canceled:
                  debugPrint("Canceled | ${taskSnapshot.metadata}");

                  file.delete();

                  break;
                case TaskState.error:
                  debugPrint("Error Occurred | ${taskSnapshot.metadata}");

                  file.delete();

                  break;
              }
            });

          } else {
            debugPrint("File: ${storageReference.name} Already Exists!");
          }

        }

      })

    });

  }

}
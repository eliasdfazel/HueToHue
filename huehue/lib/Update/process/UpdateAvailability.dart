/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/27/24, 12:19 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:app_version_update/app_version_update.dart';

class UpdateAvailability {

  Future<(bool, String)> check() async {

    bool updateReady = (await AppVersionUpdate.checkForUpdates()).canUpdate ?? false;

    String updateLink = (await AppVersionUpdate.checkForUpdates()).storeUrl ?? '';


    return (updateReady, updateLink);
  }

}
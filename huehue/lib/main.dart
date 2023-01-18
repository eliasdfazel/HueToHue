/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/7/23, 8:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:huehue/entry_configurations.dart';
import 'package:huehue/firebase_options.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  debugPrint("Hue To Hue Message: ${remoteMessage.data}");
}

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => {

    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
          backgroundColor: ColorsResources.primaryColorDarkest,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: FadeTransitionBuilder(),
            TargetPlatform.iOS: FadeTransitionBuilder(),
          }),
        ),
        home: const EntryConfigurations()
    ))

  });

}
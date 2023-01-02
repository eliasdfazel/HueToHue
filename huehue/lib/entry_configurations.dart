/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/2/23, 4:19 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';

class EntryConfigurations extends StatefulWidget {

  const EntryConfigurations({super.key});

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}

class _EntryConfigurationsState extends State<EntryConfigurations> with SingleTickerProviderStateMixin  {

  Widget placeholder = Container();

  @override
  void initState() {
    super.initState();

    placeholder = glowingSplashScreen();

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 159), () {

      FlutterNativeSplash.remove();

    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringsResources.applicationName(),
        color: ColorsResources.primaryColor,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
          backgroundColor: ColorsResources.black,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          }),
        ),
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            extendBody: true,
            backgroundColor: ColorsResources.black,
            body: ClipRRect(
                borderRadius: BorderRadius.circular(37),
                child: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: placeholder
                )
            )
        )
    );
  }

  Widget glowingSplashScreen() {

    return InnerShadow(
        shadows: [
          Shadow(
              color: ColorsResources.primaryColorLighter.withOpacity(0.37),
              blurRadius: 37,
              offset: const Offset(0, 0)
          )
        ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(37),
            border: Border.all(
              color: ColorsResources.primaryColorLighter,
              width: 1,
              strokeAlign: StrokeAlign.center
            ),
            color: ColorsResources.primaryColorDarkest,
          ),
          child: const Center(
            child: SizedBox(
                height: 333,
                width: 333,
                child: Image(
                  image: AssetImage("logo.png"),
                )
            ),
          ),
        )
    );
  }

}

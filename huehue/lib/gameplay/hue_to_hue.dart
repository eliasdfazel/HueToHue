/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/2/23, 4:20 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/operations/numbers.dart';

class HueToHue extends StatefulWidget {

  const HueToHue({super.key});

  @override
  State<HueToHue> createState() => _HueToHueState();
}

class _HueToHueState extends State<HueToHue> with TickerProviderStateMixin  {

  List<Color> allColors = [
    ColorsResources.lightestCyan,
    ColorsResources.gameGeeksEmpire,
    ColorsResources.blue,
    ColorsResources.grayLight,
    ColorsResources.green,
    ColorsResources.applicationGeeksEmpire,
    ColorsResources.black,
    ColorsResources.orange,
    ColorsResources.pink,
    ColorsResources.yellow,
  ];

  double gradientLayersCount = 3;

  List<Color> gradientColors = [];

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    for (int i = 0; i < gradientLayersCount; i++) {
      gradientColors.add(ColorsResources.applicationGeeksEmpire);
    }

    Future.delayed(const Duration(milliseconds: 1357), () {

      animateColor(999, ColorsResources.dark, ColorsResources.winterColor);

    });

  }

  void animateColor(int animationDuration, Color beginColor, Color endColor) {
    debugPrint("Animate Colors Invoke");

    int gradientIndex = 0;

    AnimationController animationController = AnimationController(vsync: this);

    animationController.duration = Duration(milliseconds: animationDuration);

    Color previousColor = endColor;

    Animation<Color?> animationColor = ColorTween(begin: beginColor, end: endColor).animate(animationController);

    animationController.forward();

    animationColor..addListener(() {

      for (int index = 0; index < gradientLayersCount; index++) {

        if (gradientIndex == 0) {

        }

        gradientColors[gradientIndex] = animationColor.value ?? ColorsResources.black;

        if (index < gradientIndex) {

          gradientColors[index] = previousColor;

        } else if (index > gradientIndex) {

          gradientColors[index] = beginColor;

        }

      }

      setState(() {

        gradientColors;

      });

    })..addStatusListener((status) {

      switch (status) {
        case AnimationStatus.completed: {
          debugPrint("Animation Status Completed: ${gradientIndex}");

          gradientIndex++;

          if (gradientIndex == gradientLayersCount) {
            debugPrint("Animation Status Restart");

            animateColor(animationDuration, endColor, allColors[Random().nextInt(allColors.length)]);

          } else {

            animationController.reset();
            animationController.forward();

          }

          break;
        }
        case AnimationStatus.dismissed:
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(37),
            child: MaterialApp(
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
                    backgroundColor: ColorsResources.yellow,
                    body: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: InkWell(
                          onTap: () {



                          },
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: List.generate(gradientColors.length, (index) => gradientColors[index]),
                                    transform: GradientRotation(degreeToRadian(137))
                                )
                            ),
                            child: Stack(
                              children: [

                              ],
                            ),
                          ),
                        )
                    )
                )
            )
        )
    );
  }

}

/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/4/23, 10:10 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/operations/colors.dart';
import 'package:huehue/utils/operations/numbers.dart';
import 'package:huehue/utils/ui/system_bars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:widget_mask/widget_mask.dart';

class HueToHue extends StatefulWidget {

  const HueToHue({super.key});

  @override
  State<HueToHue> createState() => _HueToHueState();
}

class _HueToHueState extends State<HueToHue> with TickerProviderStateMixin  {

  /* Start - Server */
  List<Color> allColors = [

  ];

  List<String> allShapes = [

  ];

  double gradientLayersCount = 2;

  int animationDuration = 9999;
  /* End - Server */

  PreferencesIO preferencesIO = PreferencesIO();

  List<Color> gradientColors = [];

  Widget gameplayPlaceholder = Center(
    child: Container(
        height: 333,
        width: 333,
        alignment: Alignment.center,
        child: LoadingAnimationWidget.discreteCircle(
            color: ColorsResources.premiumLight,
            secondRingColor: ColorsResources.primaryColorLighter,
            thirdRingColor: ColorsResources.cyan,
            size: 73
        )
    )
  );

  int levels = 0;
  double levelsOpacity = 0.0;

  int points = 0;
  double pointsOpacity = 0.0;

  late AnimationController animationController;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

    return true;
  }

  @override
  void dispose() {

    animationController.dispose();

    super.dispose();
  }

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    initializeGameplay();

    initializeGameInformation();

    retrieveGameData();

    BackButtonInterceptor.add(aInterceptor);

  }

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
        borderRadius: BorderRadius.circular(37),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.primaryColorDarkest,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColorDarkest),
              backgroundColor: ColorsResources.primaryColorDarkest,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: FadeTransitionBuilder(),
                TargetPlatform.iOS: FadeTransitionBuilder(),
              }),
            ),
            home: Scaffold(
                resizeToAvoidBottomInset: true,
                extendBody: true,
                backgroundColor: ColorsResources.primaryColorDarkest,
                body: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
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

                            /* Start - Gameplay Control */
                            Material(
                              shadowColor: Colors.transparent,
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: ColorsResources.primaryColor,
                                splashFactory: InkRipple.splashFactory,
                                onTap: () {
                                  debugPrint("Gameplay Clicked");

                                },
                              ),
                            ),
                            /* End - Gameplay Control */

                            gameplayPlaceholder,

                            /* Start - Level */
                            Positioned(
                                bottom: 37,
                                right: 37,
                                child: AnimatedOpacity(
                                    opacity: levelsOpacity,
                                    duration: const Duration(milliseconds: 1357),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: ColorsResources.black.withOpacity(0.73),
                                                  blurRadius: 19
                                              )
                                            ]
                                        ),
                                        child: const WidgetMask(
                                            blendMode: BlendMode.srcATop,
                                            childSaveLayer: true,
                                            mask: ColoredBox(
                                                color: ColorsResources.primaryColorDarkest
                                            ),
                                            child: Image(
                                              image: AssetImage("squircle.png"),
                                              height: 73,
                                              width: 73,
                                            )
                                        )
                                    )
                                )
                            ),
                            Positioned(
                                bottom: 37,
                                right: 37,
                                child: AnimatedOpacity(
                                    opacity: levelsOpacity,
                                    duration: const Duration(milliseconds: 1357),
                                    child: WidgetMask(
                                      blendMode: BlendMode.srcIn,
                                      childSaveLayer: true,
                                      mask: Material(
                                          shadowColor: Colors.transparent,
                                          color: Colors.transparent,
                                          child: InkWell(
                                              splashColor: ColorsResources.primaryColor,
                                              splashFactory: InkRipple.splashFactory,
                                              onTap: () {



                                              },
                                              child: SizedBox(
                                                  height: 73,
                                                  width: 73,
                                                  child: Center(
                                                      child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                          child: Text(
                                                            levels.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: ColorsResources.premiumLight,
                                                                fontSize: 31,
                                                                fontFamily: "Electric",
                                                                shadows: [
                                                                  Shadow(
                                                                      color: ColorsResources.white.withOpacity(0.19),
                                                                      blurRadius: 7,
                                                                      offset: const Offset(0, 3)
                                                                  )
                                                                ]
                                                            ),
                                                          )
                                                      )
                                                  )
                                              )
                                          )
                                      ),
                                      child: const Image(
                                        image: AssetImage("squircle.png"),
                                        height: 73,
                                        width: 73,
                                      ),
                                    )
                                )
                            ),
                            Positioned(
                                bottom: 119,
                                right: 37,
                                child: AnimatedOpacity(
                                    opacity: levelsOpacity,
                                    duration: const Duration(milliseconds: 1357),
                                    child: SizedBox(
                                        width: 73,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: ColorsResources.black.withOpacity(0.51),
                                                      blurRadius: 13,
                                                      offset: const Offset(0, 3)
                                                  )
                                                ]
                                            ),
                                            child: const Image(
                                              image: AssetImage("level_indicator_bottom.png"),
                                              fit: BoxFit.contain,
                                            )
                                        )
                                    )
                                )
                            ),
                            /* End - Level */

                            /* Start - Point */
                            Positioned(
                                top: 37,
                                left: 37,
                                child: AnimatedOpacity(
                                    opacity: pointsOpacity,
                                    duration: const Duration(milliseconds: 1357),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: ColorsResources.black.withOpacity(0.73),
                                                  blurRadius: 19
                                              )
                                            ]
                                        ),
                                        child: const WidgetMask(
                                            blendMode: BlendMode.srcATop,
                                            childSaveLayer: true,
                                            mask: ColoredBox(
                                                color: ColorsResources.primaryColorDarkest
                                            ),
                                            child: Image(
                                              image: AssetImage("squircle.png"),
                                              height: 73,
                                              width: 73,
                                            )
                                        )
                                    )
                                )
                            ),
                            Positioned(
                                top: 37,
                                left: 37,
                                child: AnimatedOpacity(
                                    opacity: pointsOpacity,
                                    duration: const Duration(milliseconds: 1357),
                                    child: WidgetMask(
                                      blendMode: BlendMode.srcIn,
                                      childSaveLayer: true,
                                      mask: Material(
                                          shadowColor: Colors.transparent,
                                          color: Colors.transparent,
                                          child: InkWell(
                                              splashColor: ColorsResources.primaryColor,
                                              splashFactory: InkRipple.splashFactory,
                                              onTap: () {



                                              },
                                              child: SizedBox(
                                                  height: 73,
                                                  width: 73,
                                                  child: Center(
                                                      child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                          child: Text(
                                                            points.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: ColorsResources.premiumLight,
                                                                fontSize: 31,
                                                                fontFamily: "Electric",
                                                                shadows: [
                                                                  Shadow(
                                                                      color: ColorsResources.white.withOpacity(0.19),
                                                                      blurRadius: 7,
                                                                      offset: const Offset(0, 3)
                                                                  )
                                                                ]
                                                            ),
                                                          )
                                                      )
                                                  )
                                              )
                                          )
                                      ),
                                      child: const Image(
                                        image: AssetImage("squircle.png"),
                                        height: 73,
                                        width: 73,
                                      ),
                                    )
                                )
                            ),
                            Positioned(
                                top: 119,
                                left: 37,
                                child: AnimatedOpacity(
                                    opacity: pointsOpacity,
                                    duration: const Duration(milliseconds: 1357),
                                    child: SizedBox(
                                        width: 73,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: ColorsResources.black.withOpacity(0.51),
                                                      blurRadius: 13,
                                                      offset: const Offset(0, 3)
                                                  )
                                                ]
                                            ),
                                            child: const Image(
                                              image: AssetImage("point_indicator.png"),
                                              fit: BoxFit.contain,
                                            )
                                        )
                                    )
                                )
                            ),
                            /* End - Point */

                          ],
                        )
                    )
                )
            )
        )
    );
  }

  void animateColor(int animationDuration, Color beginColor, Color endColor) {
    debugPrint("Animate Colors Invoke");

    animationController = AnimationController(vsync: this);

    int gradientIndex = 0;

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

            animateColor(animationDuration, endColor, randomColor(allColors));

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

  void initializeGameplay() {

    for (int i = 0; i < gradientLayersCount; i++) {
      gradientColors.add(ColorsResources.primaryColorDarkest);
    }

  }

  void initializeGameInformation() async {

    preferencesIO.retrieveContinuously().then((value) => {

      if (value) {

        preferencesIO.retrieveCurrentLevel().then((currentLevel) => {

          setState(() {

            levels = currentLevel;
            levelsOpacity = 1.0;

          })

        })

      }

    });

    setState(() {

      pointsOpacity = 1.0;

    });

  }

  void retrieveGameData() {


    // after getting data

    //setup counter then


  }

  void startGameProcess() {

    Future.delayed(const Duration(milliseconds: 1111), () {

      animateColor(animationDuration, randomColor(allColors), randomColor(allColors));

    });

  }

}
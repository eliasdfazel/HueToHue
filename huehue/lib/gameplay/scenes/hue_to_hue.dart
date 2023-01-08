/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/8/23, 6:21 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huehue/gameplay/data/gameplay_paths.dart';
import 'package:huehue/gameplay/data/levels_data_structure.dart';
import 'package:huehue/gameplay/scenes/elements/GameStatues.dart';
import 'package:huehue/gameplay/scenes/elements/gradients_shapes.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/operations/colors.dart';
import 'package:huehue/utils/operations/numbers.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:widget_mask/widget_mask.dart';

class HueToHue extends StatefulWidget {

  int maximumLevels = 7;

  HueToHue({super.key, required this.maximumLevels});

  @override
  State<HueToHue> createState() => _HueToHueState();
}

class _HueToHueState extends State<HueToHue> with TickerProviderStateMixin, GameStatuesListener {

  Future gameplayTimer = Future(() {

  });

  PreferencesIO preferencesIO = PreferencesIO();

  GradientsShapes gradientsShapes = GradientsShapes(levelsDataStructure: null);

  LevelsDataStructure? levelsDataStructure;

  List<Color> gradientColors = [ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest];

  List<Color> allLevelColors = [];

  double gameplayWaitingOpacity = 1.0;

  int currentLevels = 1;
  double levelsOpacity = 0.0;

  int currentPoints = 0;
  double pointsOpacity = 0.0;

  AnimationController? animationController;

  bool gameContinuously = false;

  GameStatues gameStatues = GameStatues();
  Widget gameStatuesPlaceholder = Container();

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

    return true;
  }

  @override
  void dispose() {

    animationController?.dispose();

    super.dispose();
  }

  @override
  void initState() {
    FirebaseAnalytics.instance.logEvent(name: "Hue To Hue");

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    retrieveGameData(currentLevels);

    initializeGameInformation();

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

                                  if (gradientsShapes.randomShapedColor.isNotEmpty) {
                                    debugPrint("Gameplay Colors: ${gradientColors} ||| Shaped Colors: ${gradientsShapes.randomShapedColor}");

                                    processPlayAction(gradientColors, gradientsShapes.randomShapedColor);

                                  }

                                },
                              ),
                            ),
                            /* End - Gameplay Control */

                            Positioned(
                                top: 73,
                                right: 37,
                                left: 37,
                                child: gradientsShapes
                            ),

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
                                                            currentLevels.toString(),
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
                                                      offset: const Offset(0, -3)
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
                                                            currentPoints.toString(),
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

                            AnimatedOpacity(
                              opacity: gameplayWaitingOpacity,
                              duration: Duration.zero,
                              child: Center(
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
                              )
                            ),

                            gameStatuesPlaceholder

                          ]
                      )
                    )
                )
            )
        )
    );
  }

  @override
  void startNextPlay() {
    debugPrint("Start Next Level");

    currentPoints = 0;

    retrieveGameData(currentLevels + 1);

    setState(() {

      gameStatuesPlaceholder = Container();

    });

  }

  @override
  void retryPlay() {
    debugPrint("Retry Current Level");

    retrieveGameData(currentLevels);

    setState(() {

      gameStatuesPlaceholder = Container();

    });

  }

  void initializeGameInformation() async {

    preferencesIO.retrieveContinuously().then((value) => {

      Future.delayed(Duration.zero, () {

        gameContinuously = value;

        if (value) {

          preferencesIO.retrieveCurrentLevel().then((currentLevel) => {

            setState(() {

              currentLevels = 1;
              levelsOpacity = 1.0;

            })

          });

        }

      })

    });

    setState(() {

      currentPoints = 0;
      pointsOpacity = 1.0;

    });

  }

  void retrieveGameData(int currentLevels) {

    GetOptions getOptions = const GetOptions(source: Source.cache);

    FirebaseFirestore.instance
      .doc(levelPath(currentLevels))
      .get(getOptions).then((DocumentSnapshot documentSnapshot) => {

        if (documentSnapshot.exists) {

          Future.delayed(Duration.zero, () {
            debugPrint("Data Retrieved | ${documentSnapshot.data()}");

            levelsDataStructure = LevelsDataStructure(documentSnapshot);

            initializeGameplay(levelsDataStructure!.gradientDuration(), levelsDataStructure!.gradientLayers(), levelsDataStructure!.allColors());

            startTimer(levelsDataStructure!.levelTimer());

          })

        } else {
          debugPrint("Error | ${levelPath(currentLevels)}")
        }

      });

    FirebaseFirestore.instance
        .doc(levelPath(currentLevels + 1))
        .get(const GetOptions(source: Source.serverAndCache));

  }

  void initializeGameplay(int animationDuration, int gradientLayersCount, List<Color> allColors) {

    gradientColors.clear();

    allLevelColors.clear();

    allLevelColors.addAll(allColors);

    for (int i = 0; i < gradientLayersCount; i++) {
      gradientColors.add(ColorsResources.primaryColorDarkest);
    }

    setState(() {

      gradientColors;

      levelsDataStructure;

      gameplayWaitingOpacity = 0;

      gradientsShapes = GradientsShapes(levelsDataStructure: levelsDataStructure);

    });

    startGameProcess(animationDuration, gradientLayersCount, allColors);

  }

  void startGameProcess(int animationDuration, int gradientLayersCount, List<Color> allColors) {

    Future.delayed(const Duration(milliseconds: 1111), () {

      animateColor(animationDuration, gradientLayersCount, allColors, randomColor(allColors), randomColor(allColors));

    });

  }

  void animateColor(int animationDuration, int gradientLayersCount, List<Color> allColors ,Color beginColor, Color endColor) {
    debugPrint("Animate Colors Invoke");

    animationController = AnimationController(vsync: this);

    int gradientIndex = 0;

    animationController!.duration = Duration(milliseconds: animationDuration);

    Color previousColor = endColor;

    Animation<Color?> animationColor = ColorTween(begin: beginColor, end: endColor).animate(animationController!);

    animationController!.forward();

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

            animateColor(animationDuration, gradientLayersCount, allColors, endColor, randomColor(allColors));

          } else {

            animationController!.reset();
            animationController!.forward();

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

  void processPlayAction(List<Color> gameplayGradientColors, List<Color> shapedGradientColor) async {

    bool testingMode = kDebugMode;

    setState(() {

      pointsOpacity = 0.37;
      levelsOpacity = 0.37;

    });

    if (listEquals(gameplayGradientColors, shapedGradientColor) || testingMode) {
      debugPrint("Player Wins!");

      setState(() {

        pointsOpacity = 1.0;

        currentPoints += 1;

        gradientsShapes = GradientsShapes(levelsDataStructure: levelsDataStructure);

        if (currentPoints == 8) {
          debugPrint("Player Wins!");

          if (gameContinuously) {

            levelsOpacity = 1.0;

            currentLevels += 1;

            if (currentLevels > widget.maximumLevels) {
              debugPrint("Player Won & Finished The Game!");


            } else {

              retrieveGameData(currentLevels);

              preferencesIO.storeCurrentLevel(currentLevels);

            }

          } else {

            setState(() {

              gameStatuesPlaceholder = gameStatues.gameWinScene(this);

            });

            animationController?.stop();

          }

        }

      });


    } else {
      debugPrint("Player Loses!");



    }

  }

  void startTimer(int levelTimer) {

    int defaultTimeout = kDebugMode ? 13000 : levelTimer;

    gameplayTimer = Future.delayed(Duration(milliseconds: defaultTimeout), () {
      debugPrint("Level Timed Out!");

      if (currentPoints < 7) {

        setState(() {

          gameStatuesPlaceholder = gameStatues.gameOverScene(this);

        });

        animationController?.stop();

      } else {



      }

    });

  }

}
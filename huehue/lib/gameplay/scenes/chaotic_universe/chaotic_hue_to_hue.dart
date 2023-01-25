/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/23, 7:48 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';
import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';
import 'package:huehue/dashboard/dashboard_interface.dart';
import 'package:huehue/gameplay/scenes/chaotic_universe/data/chaotic_data_structure.dart';
import 'package:huehue/gameplay/scenes/chaotic_universe/elements/gradients_blobs.dart';
import 'package:huehue/gameplay/scenes/ordered_universe/data/gameplay_paths.dart';
import 'package:huehue/gameplay/scenes/ordered_universe/elements/game_statues.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/operations/colors.dart';
import 'package:huehue/utils/operations/lifecycler.dart';
import 'package:huehue/utils/operations/numbers.dart';
import 'package:huehue/utils/ui/elements/wavy_counter.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widget_mask/widget_mask.dart';

class ChaoticHueToHue extends StatefulWidget {

  const ChaoticHueToHue({super.key});

  @override
  State<ChaoticHueToHue> createState() => _ChaoticHueToHueState();
}

class _ChaoticHueToHueState extends State<ChaoticHueToHue> with TickerProviderStateMixin, GameStatuesListener {

  Timer? gameplayTimer;

  Directory? assetsDirectory;

  final AudioPlayer pointsSound = AudioPlayer();

  final AudioPlayer transitionsSound = AudioPlayer();

  final double gameplayVolume = 0.13;

  GameplayPaths gameplayPaths = GameplayPaths();

  PreferencesIO preferencesIO = PreferencesIO();

  ChaoticGradientsShapes chaoticGradientsShapes = ChaoticGradientsShapes(chaoticDataStructure: null, gradientRotation: 137);

  ChaoticDataStructure? chaoticDataStructure;

  ColorsUtils colorsUtils = ColorsUtils();

  List<Color> gradientColors = [ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest];

  List<Color> allChaoticColors = [];

  double gameplayWaitingOpacity = 1.0;

  double luckOpacity = 1.0;

  int currentPoints = 0;
  double pointsOpacity = 0.0;

  int colorOffset = 37;

  AnimationController? animationController;

  bool gameSoundsOn = false;
  bool gameContinuously = false;

  GameStatues gameStatues = GameStatues();
  Widget gameStatuesPlaceholder = Container();

  late WavyCounter wavyLuckCounter;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    decreaseVolume();

    navigatePop(context);

    return true;
  }

  @override
  void dispose() {

    animationController?.dispose();

    gameplayTimer?.cancel();

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {
    FirebaseAnalytics.instance.logEvent(name: "HueToHue");

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    prepareChaoticGameData();

    initializeGameInformation();

    increaseVolume();

    initializeSounds();

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          debugPrint("Lifecycle Gameplay Resumed");

          prepareChaoticGameData();

        }), suspendingCallBack: () async => setState(() {
          debugPrint("Lifecycle Gameplay Suspended");

          gameplayTimer?.cancel();

        }))
    );

    wavyLuckCounter = WavyCounter(
        vsync: this,
        initialCounter: 2,
        blend: BlendMode.difference,
        initialColors: [
          ColorsResources.cyan,
          ColorsResources.red,
          ColorsResources.blue,
        ]);

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

                                    if (chaoticGradientsShapes.randomShapedColor.isNotEmpty) {
                                      debugPrint("Gameplay Colors: ${gradientColors} ||| Shaped Colors: ${chaoticGradientsShapes.randomShapedColor}");

                                      processPlayAction(gradientColors, chaoticGradientsShapes.randomShapedColor, );

                                    }

                                  },
                                ),
                              ),
                              /* End - Gameplay Control */

                              Positioned(
                                  top: 73,
                                  right: 37,
                                  left: 37,
                                  child: chaoticGradientsShapes
                              ),

                              /* Start - Luck */
                              Positioned(
                                  bottom: 37,
                                  right: 37,
                                  child: AnimatedOpacity(
                                      opacity: luckOpacity,
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
                                      opacity: luckOpacity,
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
                                                child: const SizedBox(
                                                    height: 73,
                                                    width: 73
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
                                  bottom: 37,
                                  right: 37,
                                  child: AnimatedOpacity(
                                      opacity: luckOpacity,
                                      duration: const Duration(milliseconds: 1357),
                                      child: SizedBox(
                                          height: 73,
                                          width: 73,
                                          child: Center(
                                              child: wavyLuckCounter.build(context)
                                          )
                                      )
                                  )
                              ),
                              Positioned(
                                  bottom: 119,
                                  right: 37,
                                  child: AnimatedOpacity(
                                      opacity: luckOpacity,
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
                                                image: AssetImage("luck_indicator.png"),
                                                fit: BoxFit.contain,
                                              )
                                          )
                                      )
                                  )
                              ),
                              /* End - Luck */

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
                                                child: const SizedBox(
                                                    height: 73,
                                                    width: 73
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
                                  top: 37,
                                  left: 37,
                                  child: AnimatedOpacity(
                                      opacity: pointsOpacity,
                                      duration: const Duration(milliseconds: 1357),
                                      child: SizedBox(
                                          height: 73,
                                          width: 73,
                                          child: Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child: AnimatedSwitcher(
                                                      duration: const Duration(milliseconds: 333),
                                                      transitionBuilder: (Widget child, Animation<double> animation) {

                                                        return FadeTransition(opacity: animation, child: child);
                                                      },
                                                      child: Text(
                                                        currentPoints.toString(),
                                                        key: ValueKey<int>(currentPoints),
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
  void chaoticFinished() {

    playTransitionsSound();

    animationController?.stop();
    animationController?.dispose();

    prepareChaoticGameData();

  }

  void initializeGameInformation() async {

    preferencesIO.retrieveColorOffset().then((value) => {

      setState(() {

        colorOffset = value.toInt();

      })

    });

    setState(() {

      currentPoints = 0;
      pointsOpacity = 1.0;

    });

  }

  void prepareChaoticGameData() {
    debugPrint("Preparing Chaotic Game Data");

    chaoticDataStructure = ChaoticDataStructure(preferencesIO);

    initializeGameplay(chaoticDataStructure!.gradientDuration(), chaoticDataStructure!.gradientLayersCount(), chaoticDataStructure!.allColors(), chaoticDataStructure!.gradientRotation());

  }

  void initializeGameplay(int animationDuration, int gradientLayersCount, List<Color> allColors, double gradientRotation) {

    gradientColors.clear();

    allChaoticColors.clear();

    allChaoticColors.addAll(allColors);

    for (int i = 0; i < gradientLayersCount; i++) {
      gradientColors.add(ColorsResources.primaryColorDarkest);
    }

    setState(() {

      gradientColors;

      chaoticDataStructure;

      gameplayWaitingOpacity = 0;

      chaoticGradientsShapes = ChaoticGradientsShapes(chaoticDataStructure: chaoticDataStructure, gradientRotation: gradientRotation);

    });

    startGameProcess(animationDuration, gradientLayersCount, allColors);

  }

  void startGameProcess(int animationDuration, int gradientLayersCount, List<Color> allColors) {

    Future.delayed(const Duration(milliseconds: 1111), () {

      animateColor(animationDuration, gradientLayersCount, allColors, colorsUtils.randomColor(allColors), colorsUtils.randomColor(allColors));

    });

  }

  void animateColor(int animationDuration, int gradientLayersCount, List<Color> allColors ,Color beginColor, Color endColor) {
    debugPrint("Animate Colors Invoke");

    animationController = AnimationController(vsync: this);

    int gradientIndex = 0;

    if (kDebugMode) {

      animationDuration = 1777;

    }

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

            animateColor(animationDuration, gradientLayersCount, allColors, endColor, colorsUtils.randomColor(allColors));

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

      luckOpacity = 0.37;

    });

    if (colorsUtils.gradientSimilarity(gameplayGradientColors, shapedGradientColor, similarityOffset: colorOffset) || testingMode) {
      debugPrint("Player Wins!");

      playPointsSound();

      wavyLuckCounter.incrementCounter();

      setState(() {

        pointsOpacity = 1.0;

        currentPoints += 1;

        chaoticGradientsShapes = ChaoticGradientsShapes(chaoticDataStructure: chaoticDataStructure, gradientRotation: chaoticDataStructure!.gradientRotation());

      });

      if (currentPoints % 7 == 0) {

        playTransitionsSound();

        animationController?.stop();
        animationController?.dispose();

        prepareChaoticGameData();

      }

      gameAchievements(currentPoints);

      preferencesIO.storeLastLuck(currentPoints);

    } else {
      debugPrint("Player Loses!");
    }

  }

  void initializeSounds() async {

    preferencesIO.retrieveSounds().then((value) => {

      Future(() async {
        gameSoundsOn = value;

        if (value) {

          assetsDirectory = await getApplicationSupportDirectory();

          /* Start - Points */
          final pointsSoundPath = "${assetsDirectory!.path}/${gameplayPaths.soundsPath()}/${GameplayPaths.pointsSound}";

          if (File(pointsSoundPath).existsSync()) {

            await pointsSound.setFilePath(pointsSoundPath);

            pointsSound.setVolume(gameplayVolume);

          }
          /* End - Points */

          /* Start - Transitions */
          final transitionsSoundPath = "${assetsDirectory!.path}/${gameplayPaths.soundsPath()}/${GameplayPaths.transitionsSound}";

          if (File(transitionsSoundPath).existsSync()) {

            await transitionsSound.setFilePath(transitionsSoundPath);

            transitionsSound.setVolume(gameplayVolume);

          }
          /* End - Transitions */

        }

      })

    });

  }

  void playPointsSound() async {

    if (gameSoundsOn) {

      pointsSound.setLoopMode(LoopMode.off);
      await pointsSound.play();

      await pointsSound.stop();
      pointsSound.setFilePath("${assetsDirectory!.path}/${gameplayPaths.soundsPath()}/${GameplayPaths.pointsSound}");

    }

  }

  void playTransitionsSound() async {

    if (gameSoundsOn) {

      transitionsSound.setLoopMode(LoopMode.off);
      await transitionsSound.play();

      await transitionsSound.stop();
      transitionsSound.setFilePath("${assetsDirectory!.path}/${gameplayPaths.soundsPath()}/${GameplayPaths.transitionsSound}");

    }

  }

  void increaseVolume() async {

    for (double i = gameplayVolume; i <= 100; i++) {

      await Future.delayed(const Duration(milliseconds: 13));

      DashboardInterfaceState.backgroundAudioPlayer.setVolume(i / 100);

    }

  }

  void decreaseVolume() async {

    for (double i = 100; i >= gameplayVolume; i--) {

      await Future.delayed(const Duration(milliseconds: 13));

      DashboardInterfaceState.backgroundAudioPlayer.setVolume(i / 100);

    }

  }

  void gameAchievements(int currentPoints) {

    GamesServices.getPlayerScore(androidLeaderboardID: StringsResources.gameLeaderboardLuckiestHumans(), iOSLeaderboardID: StringsResources.gameLeaderboardLuckiestHumans()).then((value) => {

      Future.delayed(Duration.zero, () {

        int earnedPoint = value ?? 1;

        GamesServices.submitScore(
            score: Score(
                androidLeaderboardID: StringsResources.gameLeaderboardLuckiestHumans(),
                iOSLeaderboardID: StringsResources.gameLeaderboardLuckiestHumans(),
                value: earnedPoint + currentPoints
            )
        );

      })

    });

    GamesServices.increment(
        achievement: Achievement(
          androidID: StringsResources.gameAchievementLucky(),
          iOSID: StringsResources.gameAchievementLucky()
        )
    );

    switch (currentPoints) {
      case ChaoticDataStructure.platinumLuck:  {

        GamesServices.unlock(
            achievement: Achievement(
                androidID: StringsResources.gameAchievementPlatinumLuck(),
                iOSID: StringsResources.gameAchievementPlatinumLuck(),
                percentComplete: 100
            )
        );

        break;
      }
      case ChaoticDataStructure.goldLuck:  {

        GamesServices.unlock(
            achievement: Achievement(
                androidID: StringsResources.gameAchievementGoldLuck(),
                iOSID: StringsResources.gameAchievementGoldLuck(),
                percentComplete: 100
            )
        );

        break;
      }
      case ChaoticDataStructure.palladiumLuck:  {

        GamesServices.unlock(
            achievement: Achievement(
                androidID: StringsResources.gameAchievementGoldLuck(),
                iOSID: StringsResources.gameAchievementGoldLuck(),
                percentComplete: 100
            )
        );

        break;
      }
    }

    if (currentPoints == 99) {

      setState(() {

        gameStatuesPlaceholder = gameStatues.gameWinScene(this);

      });

      animationController?.stop();

    }

  }

}
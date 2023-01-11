/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/11/23, 7:09 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:games_services/games_services.dart';
import 'package:huehue/gameplay/assets/assets_io.dart';
import 'package:huehue/gameplay/data/gameplay_paths.dart';
import 'package:huehue/gameplay/scenes//hue_to_hue.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/preferences/preferences_interface.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/sync/sync_io.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/operations/lifecycler.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({super.key});

  @override
  State<DashboardInterface> createState() => DashboardInterfaceState();
}

class DashboardInterfaceState extends State<DashboardInterface> with SynchronizationStatus, AssetsStatus {

  static final backgroundAudioPlayer = AudioPlayer();

  GameplayPaths gameplayPaths = GameplayPaths();

  AssetsIO assetsIO = AssetsIO();

  SyncIO syncIO = SyncIO();

  int maximumLevels = 7;

  PreferencesIO preferencesIO = PreferencesIO();

  String currentLevel = "0";

  double playButtonOpacity = 0.0;

  Widget waitingAnimationPlaceholder = Container();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    if (!kDebugMode) {
      GamesServices.signIn();
    }

    retrievePreferences();

    cacheGameplayData();

    syncCheckpoint();

    assetsIO.retrieveAllSounds(this);

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          debugPrint("Lifecycle Dashboard Resumed");

          backgroundAudioPlayer.play();

        }), suspendingCallBack: () async => setState(() {
          debugPrint("Lifecycle Dashboard Suspended");

          backgroundAudioPlayer.pause();

        }))
    );

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringsResources.applicationName(),
        color: ColorsResources.primaryColor,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
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
            body: ClipRRect(
                borderRadius: BorderRadius.circular(37),
                child: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(37),
                        // color: ColorsResources.primaryColorDarkest,
                      ),
                      child: Stack(
                        children: [

                          /* Start - Decoration */
                          /* Start - Glow */
                          InnerShadow(
                              shadows: [
                                Shadow(
                                    color: ColorsResources.primaryColorLighter.withOpacity(0.37),
                                    blurRadius: 1,
                                    offset: const Offset(0, 0)
                                )
                              ],
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(37),
                                      border: Border.all(
                                          color: ColorsResources.primaryColorLighter.withOpacity(0.37),
                                          width: 1.3,
                                          strokeAlign: StrokeAlign.inside
                                      ),
                                      color: ColorsResources.primaryColorDarkest
                                  )
                              )
                          ),
                          /* End - Glow */

                          /* Start - Blobs */
                          /* Start - Blob Bottom */
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            child: SizedBox(
                                height: 253,
                                width: 253,
                                child: Image(
                                    image: AssetImage("blob_bottom.png")
                                )
                            ),
                          ),
                          /* End - Blob Bottom */

                          /* Start - Blob Top */
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: SizedBox(
                                height: 253,
                                width: 253,
                                child: Image(
                                    image: AssetImage("blob_top.png")
                                )
                            ),
                          ),
                          /* End - Blob Top */
                          /* End - Blobs */

                          /* Start - Blurry Background */
                          const Blur(
                            blur: 31.0,
                            blurColor: ColorsResources.primaryColorDarkest,
                            colorOpacity: 0.19,
                            child: SizedBox(
                              height: double.maxFinite,
                              width: double.maxFinite,
                            ),
                          ),
                          /* End - Blurry Background */
                          /* End - Decoration */

                          /* Start - Stroke | Play */
                          Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(37),
                                border: Border.all(
                                    color: ColorsResources.primaryColorLighter,
                                    width: 1.3,
                                    strokeAlign: StrokeAlign.inside
                                ),
                                color: ColorsResources.primaryColorDarkest.withOpacity(0.1)
                            ),
                            child: playButtonDesign()
                          ),
                          /* End - Stroke | Play */
                          /* End - Decoration */

                          waitingAnimationPlaceholder,

                          /* Start - Content */
                          /* Start - Branding */
                          Positioned(
                              top: 37,
                              left: 37,
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
                          ),
                          Positioned(
                              top: 37,
                              left: 37,
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
                                          child: const Image(
                                            image: AssetImage("logo.png"),
                                            height: 73,
                                            width: 73,
                                          )
                                      )
                                  ),
                                child: const Image(
                                  image: AssetImage("squircle.png"),
                                  height: 73,
                                  width: 73,
                                ),
                              )
                          ),
                          /* End - Branding */

                          /* Start - Level */
                          Positioned(
                              top: 37,
                              right: 37,
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
                          ),
                          Positioned(
                              top: 37,
                              right: 37,
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
                                                  currentLevel,
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
                          ),
                          Positioned(
                            top: 119,
                            right: 37,
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
                                  image: AssetImage("level_indicator.png"),
                                  fit: BoxFit.contain,
                                )
                              )
                            )
                          ),
                          /* End - Level */

                          /* Start - Preferences */
                          Positioned(
                              bottom: 37,
                              left: 37,
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
                          ),
                          Positioned(
                              bottom: 37,
                              left: 37,
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

                                          Future.delayed(const Duration(milliseconds: 333), () {

                                            navigateTo(context, const PreferencesInterface());

                                          });

                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(0, 13, 0, 7),
                                          child: Image(
                                              image: AssetImage("settings.png")
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
                          ),
                          /* End - Preferences */

                          /* Start - Link */
                          Positioned(
                              bottom: 37,
                              right: 37,
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
                          ),
                          Positioned(
                              bottom: 37,
                              right: 37,
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
                                          FirebaseAnalytics.instance.logEvent(name: "GeeksEmpireLinks");

                                          launchUrl(Uri.parse(StringsResources.linksGeeksEmpire()), mode: LaunchMode.externalApplication);

                                        },
                                        child: const Padding(
                                            padding: EdgeInsets.fromLTRB(0, 13, 0, 7),
                                            child: Image(
                                                image: AssetImage("link.png")
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
                          ),
                          /* End - Link */
                          /* End - Content */

                        ],
                      )
                    )
                )
            )
        )
    );
  }

  @override
  void syncCompleted(int syncedCurrentLevel) {

    setState(() {

      currentLevel = syncedCurrentLevel.toString();

    });

  }

  @override
  void syncError() {}

  @override
  void assetsDownloaded() {

    startBackgroundMusic();

  }

  void retrievePreferences() async {

    currentLevel = (await preferencesIO.retrieveCurrentLevel()).toString();
    
    setState(() {

      currentLevel;

    });

  }

  void cacheGameplayData() {

    setState(() {

      waitingAnimationPlaceholder = waitingAnimation();

    });

    FirebaseFirestore.instance
        .collection(gameplayPaths.allLevelPath())
        .get(const GetOptions(source: Source.serverAndCache)).then((collections) => {

          Future.delayed(Duration.zero, () {

            if (collections.docs.isNotEmpty) {
              debugPrint("All Levels Collections Retrieved Successfully");

              maximumLevels = collections.size;

              setState(() {

                waitingAnimationPlaceholder = Container();

                playButtonOpacity = 1.0;

                maximumLevels;

              });

            } else {
              debugPrint("No Levels Collections");
            }

          })

        });

  }

  Widget waitingAnimation() {

    return Center(
        child: Container(
            height: 333,
            width: 333,
            alignment: Alignment.center,
            child: LoadingAnimationWidget.discreteCircle(
                color: ColorsResources.goldenColor,
                secondRingColor: ColorsResources.primaryColorLighter,
                thirdRingColor: ColorsResources.cyan,
                size: 73
            )
        )
    );
  }

  Widget playButtonDesign() {

    return AnimatedOpacity(
        opacity: playButtonOpacity,
        duration: const Duration(milliseconds: 357),
        child: Center(
            child: SizedBox(
                height: 399,
                width: 399,
                child: Stack(
                  children: [

                    WidgetMask(
                        blendMode: BlendMode.srcATop,
                        childSaveLayer: true,
                        mask: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: ColorsResources.primaryColor,
                                splashFactory: InkRipple.splashFactory,
                                onTap: () {

                                  Future.delayed(const Duration(milliseconds: 333), () {

                                    navigateTo(context, HueToHue(maximumLevels: maximumLevels));

                                  });

                                },
                                child: const Image(
                                  image: AssetImage("blob_play.png"),
                                  height: 399,
                                  width: 399,
                                )
                            )
                        ),
                        child: const Image(
                          image: AssetImage("blob_play.png"),
                          height: 399,
                          width: 399,
                        )
                    ),

                    /* Start - Chaotic Play */
                    Positioned(
                      right: 31,
                      bottom: 31,
                      child: chaoticPlayDesign(),
                    ),
                    /* End - Chaotic Play */

                  ],
                )
            )
        )
    );
  }

  Widget chaoticPlayDesign() {

    return SizedBox(
      height: 137,
      width: 137,
      child: WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: InkWell(
                  splashColor: ColorsResources.primaryColor,
                  splashFactory: InkRipple.splashFactory,
                  onTap: () {

                    Future.delayed(const Duration(milliseconds: 333), () {
                      FirebaseAnalytics.instance.logEvent(name: "ChaoticComingSoon");

                      showToast(
                        "coming soon...",
                        textStyle: TextStyle(
                          color: ColorsResources.premiumLight,
                          fontSize: 17,
                          fontFamily: "Electric",
                          letterSpacing: 1.3,
                          shadows: [
                            Shadow(
                              color: ColorsResources.white.withOpacity(0.31),
                              blurRadius: 13,
                              offset: const Offset(0, 3)
                            )
                          ]
                        ),
                        context: context,
                        fullWidth: true,
                        position: const StyledToastPosition(align: Alignment.bottomCenter, offset: 173),
                        backgroundColor: ColorsResources.primaryColorDarker.withOpacity(0.73),
                        borderRadius: BorderRadius.circular(19),
                        animation: StyledToastAnimation.slideFromBottomFade,
                        reverseAnimation: StyledToastAnimation.slideToBottomFade,
                        curve: Curves.easeIn,
                        reverseCurve: Curves.easeOut,
                        isIgnoring: false,
                        duration: const Duration(milliseconds: 3333),
                      );

                      // navigateTo(context, ChaoticHueToHue(maximumLevels: maximumLevels));

                    });

                  },
                  child: const Image(
                    image: AssetImage("chaotic_play.png"),
                    height: 137,
                    width: 137,
                  )
              )
          ),
          child: const Image(
            image: AssetImage("chaotic_play.png"),
            height: 137,
            width: 137,
          )
      )
    );
  }

  void syncCheckpoint() {

    if (FirebaseAuth.instance.currentUser != null) {

      syncIO.startSyncingProcess(preferencesIO, FirebaseAuth.instance.currentUser!.uid, this);

    }

  }

  void startBackgroundMusic() async {

    preferencesIO.retrieveSounds().then((value) => {

      Future(() async {

        if (value) {

          final assetsDirectory = await getApplicationSupportDirectory();

          String backgroundMusic = await gameplayPaths.prepareBackgroundMusicPath();

          final backgroundMusicPath = "${assetsDirectory.path}/$backgroundMusic";
          final file = File(backgroundMusicPath);

          if (file.existsSync()) {
            debugPrint("Background Music Playing...");

            await backgroundAudioPlayer.setFilePath(backgroundMusicPath);

            backgroundAudioPlayer.setVolume(0.13);
            backgroundAudioPlayer.play();

            backgroundAudioPlayer.playerStateStream.listen((state) {

              if (state.playing) {

              } else {

              }

              switch (state.processingState) {
                case ProcessingState.idle: {
                  break;
                }
                case ProcessingState.loading: {
                  break;
                }
                case ProcessingState.buffering: {
                  break;
                }
                case ProcessingState.ready: {
                  break;
                }
                case ProcessingState.completed: {
                  debugPrint("Background Music Finished | Start Replaying...");

                  backgroundAudioPlayer.stop();

                  backgroundAudioPlayer.setFilePath(backgroundMusicPath);

                  backgroundAudioPlayer.setVolume(0.13);
                  backgroundAudioPlayer.play();

                  break;
                }
              }

            });

          } else {

          }

        }

      })

    });

  }

}


/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/8/23, 6:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huehue/preferences/data/PreferencesKeys.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/preferences/util/elements/SwitchPreferences.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/sync/sync_io.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/ui/elements/nexted_tooltip.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:widget_mask/widget_mask.dart';

class PreferencesInterface extends StatefulWidget {

  const PreferencesInterface({super.key});

  @override
  State<PreferencesInterface> createState() => _PreferencesInterfaceState();
}

class _PreferencesInterfaceState extends State<PreferencesInterface> with SynchronizationStatus {

  SyncIO syncIO = SyncIO();

  PreferencesIO preferencesIO = PreferencesIO();

  Widget loginPlaceholder = Text(
      StringsResources.loginTitle(),
      style: TextStyle(
          color: ColorsResources.premiumLight,
          fontSize: 17,
          fontFamily: "Nasa",
          letterSpacing: 1.3,
          shadows: [
            Shadow(
                color: ColorsResources.white.withOpacity(0.37),
                blurRadius: 13,
                offset: const Offset(0, 3)
            )
          ]
      )
  );

  Widget waitingAnimationPlaceholder = Container();

  bool loginTooltip = true;

  double contentsListPadding = 173;

  @override
  void initState() {
    FirebaseAnalytics.instance.logEvent(name: "Preferences");

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {

      //loginTooltip = false;

      contentsListPadding = 159;

      loginPlaceholder = WidgetMask(
          blendMode: BlendMode.srcIn,
          childSaveLayer: true,
          mask: SizedBox(
              height: 63,
              width: 63,
              child: Center(
                  child: Image.network(
                      FirebaseAuth.instance.currentUser!.photoURL!,
                      fit: BoxFit.cover
                  )
              )
          ),
          child: const Image(
            image: AssetImage("squircle.png"),
            height: 63,
            width: 63,
          )
      );

    }

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
                                      image: AssetImage("blob_preferences_bottom.png")
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
                                      image: AssetImage("blob_preferences_top.png")
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

                            /* Start - Stroke */
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
                                )
                            ),
                            /* End - Stroke */
                            /* End - Decoration */

                            /* Start - Content */
                            /* Start - Preferences */
                            ClipRRect(
                              borderRadius: BorderRadius.circular(37),
                              child: ListView(
                                padding: EdgeInsets.fromLTRB(0, contentsListPadding, 0, 37),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                children: [

                                  /* Start - Continuously Switch */
                                  SwitchPreferences(preferencesIO: preferencesIO, preferencesKey: PreferencesKeys.continuously,
                                      titlePreferences: StringsResources.switchTitleContinuously(), descriptionPreferences: StringsResources.switchDescriptionContinuously()),
                                  /* End - Continuously Switch */

                                  const Divider(
                                    height: 37,
                                    color: Colors.transparent
                                  ),

                                  /* Start - Sounds Switch */
                                  SwitchPreferences(preferencesIO: preferencesIO, preferencesKey: PreferencesKeys.sounds,
                                      titlePreferences: StringsResources.switchTitleSounds(), descriptionPreferences: StringsResources.switchDescriptionSounds())
                                  /* End - Sounds Switch */

                                ],
                              )
                            ),
                            /* End - Preferences */

                            /* Start - Back */
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

                                            Future.delayed(const Duration(milliseconds: 333), () {

                                              navigatePop(context);

                                            });

                                          },
                                          child: const Padding(
                                              padding: EdgeInsets.fromLTRB(0, 19, 5, 13),
                                              child: Image(
                                                image: AssetImage("back.png"),
                                                height: 37,
                                                width: 37,
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
                            /* End - Back */

                            /* Start - Login */
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

                                            startLoginProcess();

                                          },
                                          child: SizedBox(
                                            height: 73,
                                            width: 73,
                                            child: Center(
                                              child: loginPlaceholder
                                            )
                                          )
                                      )
                                  ),
                                  child: const Image(
                                    image: AssetImage("squircle.png"),
                                    height: 73,
                                    width: 73,
                                  )
                                )
                            ),
                            NextedTooltips(
                                atStartShow: loginTooltip,
                                topPosition: 115, bottomPosition: 0, leftPosition: 0, rightPosition: 37,
                                tooltipMessage: StringsResources.synchronizationNotice()
                            ),
                            /* End - Login */
                            /* End - Content */

                            /* Start - Syncing... */
                            waitingAnimationPlaceholder
                            /* End - Syncing... */

                          ],
                        )
                    )
                )
            )
        )
    );
  }

  void startLoginProcess() async {

    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

    final googleCredentials = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

     FirebaseAuth.instance.signInWithCredential(googleCredentials).then((userCredentials) => {

       Future.delayed(const Duration(milliseconds: 73), () {

         syncIO.startSyncingProcess(preferencesIO, userCredentials.user!.uid, this);

         setState(() {

           loginTooltip = false;

           contentsListPadding = 159;

           waitingAnimationPlaceholder = syncWaitingDesign();

           loginPlaceholder = WidgetMask(
               blendMode: BlendMode.srcIn,
               childSaveLayer: true,
               mask: SizedBox(
                   height: 63,
                   width: 63,
                   child: Center(
                       child: Image.network(
                           userCredentials.user!.photoURL!,
                           fit: BoxFit.cover
                       )
                   )
               ),
               child: const Image(
                 image: AssetImage("squircle.png"),
                 height: 63,
                 width: 63,
               )
           );

         });

       })

     });

  }

  Widget syncWaitingDesign() {

    return Container(
      color: ColorsResources.primaryColorDarkest.withOpacity(0.91),
      child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Center(
              child: SizedBox(
                  height: 333,
                  width: 333,
                  child: Container(
                      height: 333,
                      width: 333,
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.discreteCircle(
                          color: ColorsResources.cyan,
                          secondRingColor: ColorsResources.primaryColorLighter,
                          thirdRingColor: ColorsResources.goldenColor,
                          size: 73
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

      waitingAnimationPlaceholder = Container();

    });

  }

  @override
  void syncError() {

  }

}

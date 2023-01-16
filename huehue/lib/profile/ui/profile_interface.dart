/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/23, 7:48 AM
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
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/ui/elements/wavy_counter.dart';
import 'package:huehue/utils/ui/gradient_text/constants.dart';
import 'package:huehue/utils/ui/gradient_text/gradient.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';
import 'package:widget_mask/widget_mask.dart';

class ProfileInterface extends StatefulWidget {

  const ProfileInterface({super.key});

  @override
  State<ProfileInterface> createState() => _ProfileInterfaceState();
}

class _ProfileInterfaceState extends State<ProfileInterface> with TickerProviderStateMixin {

  PreferencesIO preferencesIO = PreferencesIO();

  User? firebaseUser = FirebaseAuth.instance.currentUser;

  String profileName = StringsResources.applicationName();

  Widget profileImage = const Image(
    image: AssetImage("logo.png"),
    fit: BoxFit.cover,
    height: 373,
    width: 373,
  );

  late WavyCounter wavyLuckCounter;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    FirebaseAnalytics.instance.logEvent(name: "Preferences");

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    retrieveAccountInformation();

    wavyLuckCounter = WavyCounter(
        vsync: this,
        initialCounter: 2,
        radiusFactor: 137,
        blend: BlendMode.difference,
        initialColors: [
          ColorsResources.cyan,
          ColorsResources.red,
          ColorsResources.blue,
        ]);

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

                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                                child: ListView(
                                  padding: const EdgeInsets.fromLTRB(0, 137, 0, 37),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  children: [

                                    /* Start - Profile Image/Name */
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(37, 0, 37, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                /* Start - Profile Image */
                                                Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                        height: 201,
                                                        width: 201,
                                                        child: Stack(
                                                          children: [
                                                            WidgetMask(
                                                              blendMode: BlendMode.srcATop,
                                                              childSaveLayer: true,
                                                              mask /* Original Image */: Container(
                                                                decoration: BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                        colors: [
                                                                          ColorsResources.premiumLight.withOpacity(0.73),
                                                                          ColorsResources.primaryColorLighter,
                                                                        ],
                                                                        transform: const GradientRotation(45)
                                                                    )
                                                                ),
                                                              ),
                                                              child: const Image(
                                                                image: AssetImage("squircle.png"),
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: const EdgeInsets.all(1.7),
                                                                child: WidgetMask(
                                                                  blendMode: BlendMode.srcATop,
                                                                  childSaveLayer: true,
                                                                  mask /* Original Image */: profileImage,
                                                                  child: const Image(
                                                                    image: AssetImage("squircle.png"),
                                                                  ),
                                                                )
                                                            )
                                                          ],
                                                        )
                                                    )
                                                ),
                                                /* End - Profile Image */

                                                /* Start - Profile Name */
                                                Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                        height: 201,
                                                        width: 201,
                                                        child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(19, 37, 0, 0),
                                                            child: GradientText(
                                                              profileName.replaceFirst(" ", "\n"),
                                                              overflow: TextOverflow.fade,
                                                              style: const TextStyle(
                                                                  fontSize: 31
                                                              ),
                                                              gradientDirection: GradientDirection.tltbr,
                                                              maxLinesNumber: 2,
                                                              colors: const [
                                                                ColorsResources.premiumLight,
                                                                ColorsResources.light
                                                              ],
                                                            )
                                                        )
                                                    )
                                                )
                                                /* End - Profile Name */

                                              ],
                                            )
                                        )
                                    ),
                                    /* End - Profile Image/Name */

                                    const Divider(
                                      height: 73,
                                      color: Colors.transparent,
                                    ),

                                    SizedBox(
                                        height: 173,
                                        width: 173,
                                        child: Center(
                                            child: wavyLuckCounter.build(context)
                                        )
                                    )

                                  ],
                                )
                            ),

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

                                              navigatePopWithResult(context, true);

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
                            /* End - Content */

                          ],
                        )
                    )
                )
            )
        )
    );
  }

  void retrieveAccountInformation() async {

    if (firebaseUser != null) {

      profileName = firebaseUser!.displayName!;

      profileImage = Image.network(
        firebaseUser!.photoURL.toString(),
        fit: BoxFit.cover,
        height: 301,
        width: 301,
      );

      setState(() {

        profileName;

        profileImage;

      });

    }

    preferencesIO.retrieveLastLuck().then((value) => {

      Future.delayed(Duration.zero, () async {

        for (int i = 0; i < 99; i++) {

        //  await Future.delayed(const Duration(milliseconds: 777));

          wavyLuckCounter.incrementCounter();

        }

      })

    });

  }

}

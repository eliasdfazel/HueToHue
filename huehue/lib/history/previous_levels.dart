/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/15/23, 10:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:huehue/gameplay/scenes/ordered_universe/data/gameplay_paths.dart';
import 'package:huehue/gameplay/scenes/ordered_universe/data/levels_data_structure.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/calculations/display.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:widget_mask/widget_mask.dart';

class PreviousInterface extends StatefulWidget {

  const PreviousInterface({super.key});

  @override
  State<PreviousInterface> createState() => _PreviousInterfaceState();
}

class _PreviousInterfaceState extends State<PreviousInterface> {

  GameplayPaths gameplayPaths = GameplayPaths();

  Widget allPreviousLevels = Container();

  Widget waitingAnimationPlaceholder = Container();

  @override
  void initState() {
    FirebaseAnalytics.instance.logEvent(name: "Preferences");

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    retrievePreviousLevels();

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
                                      image: AssetImage("blob_previous_bottom.png")
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
                                      image: AssetImage("blob_previous_top.png")
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
                                child: allPreviousLevels
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

                            /* End - Content */

                            waitingAnimationPlaceholder

                          ],
                        )
                    )
                )
            )
        )
    );
  }

  Widget waitingDesign() {

    return Center(
        child: Container(
            height: 333,
            width: 333,
            alignment: Alignment.center,
            child: LoadingAnimationWidget.discreteCircle(
                color: ColorsResources.springColor,
                secondRingColor: ColorsResources.summerColor,
                thirdRingColor: ColorsResources.winterColor,
                size: 73
            )
        )
    );
  }

  void retrievePreviousLevels() {

    setState(() {

      waitingAnimationPlaceholder = waitingDesign();

    });

    FirebaseFirestore.instance
        .doc("/HueToHue/Players/${FirebaseAuth.instance.currentUser!.uid}/Synchronized")
        .get().then((documentSnapshot) => {

          if (documentSnapshot.exists) {

            Future.delayed(Duration.zero, () {
              debugPrint("Previous Levels: ${documentSnapshot.data()}");

              int maxLevelPassed = documentSnapshot.get("currentLevel");

              FirebaseFirestore.instance
                  .collection(gameplayPaths.allLevelPath())
                  .orderBy("level", descending: false)
                  .get(const GetOptions(source: Source.cache)).then((querySnapshot) => {

                    if (querySnapshot.docs.isNotEmpty) {

                      preparePreviousLevels(querySnapshot.docs, maxLevelPassed)

                    }

                  });

            })

          }

        });

  }

  void preparePreviousLevels (List<DocumentSnapshot> documentSnapshots, int maxLevelPassed) async {
    debugPrint("Setting Previous Levels Up To: $maxLevelPassed");

    List<Widget> previousLevels = [];

    for (int documentIndex = 0; documentIndex < maxLevelPassed; documentIndex++) {

      LevelsDataStructure levelsDataStructure = LevelsDataStructure(documentSnapshots[documentIndex]);

      previousLevels.add(previousLevelsItem(levelsDataStructure));

    }

    int gridColumnCount = (displayLogicalWidth(context) / 137).round();

    setState(() {

      allPreviousLevels = GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridColumnCount,
            childAspectRatio: 1,
            mainAxisSpacing: 37.0,
            crossAxisSpacing: 37.0,
          ),
          padding: const EdgeInsets.fromLTRB(37, 159, 37, 37),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: previousLevels
      );

      setState(() {

        waitingAnimationPlaceholder = Container();

      });

    });

  }

  Widget previousLevelsItem(LevelsDataStructure levelsDataStructure) {
    debugPrint("Level Data: ${levelsDataStructure.levelsDocumentData}");

    List<Widget> colorBoxes = [];

    for (Color aColor in levelsDataStructure.allColors()) {
      debugPrint("Level Color: $aColor");

      colorBoxes.add(Expanded(
        child: ColoredBox(color: aColor)
      ));

    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: ColorsResources.premiumLight.withOpacity(0.37),
          strokeAlign: StrokeAlign.outside,
          width: 3
        ),
        color: ColorsResources.premiumLight.withOpacity(0.37),
        boxShadow: [
          BoxShadow(
            color: ColorsResources.primaryColor.withOpacity(0.73),
            blurRadius: 11,
            offset: const Offset(0, 7)
          )
        ]
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: SizedBox(
              height: 137,
              width: 137,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: colorBoxes,
              )
          )
      )
    );
  }

}

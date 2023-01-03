/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/3/23, 8:31 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:huehue/preferences/util/ui/SwitchPreferences.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/ui/system_bars.dart';
import 'package:widget_mask/widget_mask.dart';

class PreferencesInterface extends StatefulWidget {

  const PreferencesInterface({super.key});

  @override
  State<PreferencesInterface> createState() => _PreferencesInterfaceState();
}

class _PreferencesInterfaceState extends State<PreferencesInterface> {

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();
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
                              blur: 37.0,
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

                                            navigatePop(context);

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

                            /* Start - Preferences */
                            ClipRRect(
                              borderRadius: BorderRadius.circular(37),
                              child: ListView(
                                padding: const EdgeInsets.fromLTRB(0, 159, 0, 37),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                children: [

                                  /* Start - Continuously Switch */
                                  SwitchPreferences(titlePreferences: StringsResources.switchTitleContinuously(), descriptionPreferences: StringsResources.switchDescriptionContinuously())
                                  /* End - Continuously Switch */

                                ],
                              )
                            ),
                            /* End - Preferences */

                            /* Start - Branding */
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
                            /* End - Content */

                          ],
                        )
                    )
                )
            )
        )
    );
  }

}

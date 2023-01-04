/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/4/23, 2:40 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:huehue/gameplay/hue_to_hue.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/preferences/preferences_interface.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/ui/system_bars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({super.key});

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}

class _DashboardInterfaceState extends State<DashboardInterface> {

  PreferencesIO preferencesIO = PreferencesIO();

  String currentLevel = "0";

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    retrievePreferences();

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
                            blur: 37.0,
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
                            child: Center(
                                child: SizedBox(
                                    height: 399,
                                    width: 399,
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

                                                  navigateTo(context, const HueToHue());

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
                                    )
                                )
                            )
                          ),
                          /* End - Stroke | Play */
                          /* End - Decoration */

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

  void retrievePreferences() async {

    currentLevel = await preferencesIO.retrieveCurrentLevel();
    
    setState(() {

      currentLevel;

    });

  }

}

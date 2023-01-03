/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/3/23, 5:33 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
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
                                    blurRadius: 37,
                                    offset: const Offset(0, 0)
                                )
                              ],
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(37),
                                      border: Border.all(
                                          color: ColorsResources.primaryColorLighter,
                                          width: 1,
                                          strokeAlign: StrokeAlign.inside
                                      ),
                                      color: ColorsResources.primaryColorDarkest
                                  )
                              )
                          ),
                          /* End - Glow */

                          /* Start - Blurry Background */
                          const Blur(
                            blur: 13.0,
                            blurColor: ColorsResources.primaryColorDarkest,
                            colorOpacity: 0.13,
                            child: SizedBox(
                              height: double.maxFinite,
                              width: double.maxFinite,
                            ),
                          ),
                          /* End - Blurry Background */
                          /* End - Decoration */

                          /* Start - Stroke */
                          Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(37),
                                border: Border.all(
                                    color: ColorsResources.primaryColorLighter,
                                    width: 1,
                                    strokeAlign: StrokeAlign.inside
                                ),
                                color: ColorsResources.primaryColorDarkest
                            ),
                            child: const Center(
                                child: SizedBox(
                                    height: 399,
                                    width: 399,
                                    child: Image(
                                        image: AssetImage("blob_play.png")
                                    )
                                )
                            ),
                          ),
                          /* End - Stroke */
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
                                  child: WidgetMask(
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
                                                  "99",
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
                                  child: WidgetMask(
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

                                          navigateTo(context, const PreferencesInterface());

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
                                  child: WidgetMask(
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

}

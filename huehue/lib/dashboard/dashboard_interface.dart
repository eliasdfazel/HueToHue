/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/2/23, 4:19 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/animation/fade_transition.dart';
import 'package:huehue/utils/ui/system_bars.dart';
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

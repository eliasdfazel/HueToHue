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

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({super.key});

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}

class _DashboardInterfaceState extends State<DashboardInterface> with SingleTickerProviderStateMixin  {

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
                      child: InnerShadow(
                          shadows: [
                            Shadow(
                                color: ColorsResources.primaryColorLighter.withOpacity(0.37),
                                blurRadius: 37,
                                offset: const Offset(0, 0)
                            )
                          ],
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
                                      ),
                                      child: const Center(
                                          child: SizedBox(
                                              height: 303,
                                              width: 303,
                                              child: Image(
                                                image: AssetImage("logo.png"),
                                                fit: BoxFit.contain,
                                              )
                                          )
                                      )
                                  )
                              ),
                              /* End - Glow */

                              /* Start - Content */
                              Center(
                                child: SizedBox(
                                    height: 133,
                                    width: 733,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(37),
                                            border: Border.all(
                                                color: ColorsResources.primaryColorLighter,
                                                width: 1,
                                                strokeAlign: StrokeAlign.inside
                                            ),
                                            color: ColorsResources.yellow
                                        )
                                    )
                                )
                              ),
                              /* End - Content */

                              /* Start - Stroke */
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(37),
                                      border: Border.all(
                                          color: ColorsResources.primaryColorLighter,
                                          width: 1,
                                          strokeAlign: StrokeAlign.inside
                                      ),
                                      color: ColorsResources.primaryColorDarkest.withOpacity(0.1)
                                  )
                              )
                              /* End - Stroke */

                            ],
                          )
                      )
                    )
                )
            )
        )
    );
  }

}

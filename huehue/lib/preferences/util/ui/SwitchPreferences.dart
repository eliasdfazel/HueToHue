/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/3/23, 9:16 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/ui/gradient_text/constants.dart';
import 'package:huehue/utils/ui/gradient_text/gradient.dart';
import 'package:huehue/utils/ui/system_bars.dart';

class SwitchPreferences extends StatefulWidget {

  String titlePreferences;
  String descriptionPreferences;

  SwitchPreferences({super.key, required this.titlePreferences, required this.descriptionPreferences});

  @override
  State<SwitchPreferences> createState() => _SwitchPreferencesState();
}

class _SwitchPreferencesState extends State<SwitchPreferences> {

  String switchStatusText = "Off";
  Color switchStatusColor = ColorsResources.switchOff;

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return switchPreferences(widget.titlePreferences, widget.descriptionPreferences);
  }

  Widget switchPreferences(String titlePreferences, String descriptionPreferences) {

    return Padding(
      padding: EdgeInsets.fromLTRB(37, 0, 37, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Blur(
          blur: 37,
          blurColor: ColorsResources.primaryColorDarkest,
          colorOpacity: 0.13,
          overlay: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                  child: GradientText(
                    widget.titlePreferences,
                    colors: const [
                      ColorsResources.white,
                      ColorsResources.premiumLight,
                    ],
                    gradientType: GradientType.radial,
                    radius: 3,
                    maxLinesNumber: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorsResources.premiumLight,
                      fontSize: 23,
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
              ),

              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Material(
                        shadowColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: ColorsResources.primaryColor,
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            setState(() {

                              if (switchStatusText == StringsResources.switchOn()) {

                                switchStatusText = StringsResources.switchOff();
                                switchStatusColor = ColorsResources.switchOff;

                              } else {

                                switchStatusText = StringsResources.switchOn();
                                switchStatusColor = ColorsResources.switchOn;

                              }

                            });

                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      width: 1,
                                      color: switchStatusColor,
                                      strokeAlign: StrokeAlign.inside
                                  ),
                                  color: ColorsResources.primaryColorDarkest,
                                  boxShadow: [
                                    BoxShadow(
                                        color: switchStatusColor,
                                        blurRadius: 7
                                    )
                                  ]
                              ),
                              child: SizedBox(
                                  width: 73,
                                  height: 31,
                                  child: Center(
                                      child: Text(
                                          switchStatusText,
                                          style: const TextStyle(
                                              color: ColorsResources.premiumLight,
                                              fontSize: 15,
                                              letterSpacing: 1.9,
                                              fontFamily: "Nasa"
                                          )
                                      )
                                  )
                              )
                          )
                        )
                      )
                    )
                  )
              )

            ],
          ),
          child: const SizedBox(
            height: 53,
            width: double.maxFinite
          ),
        )
      )
    );
  }

}

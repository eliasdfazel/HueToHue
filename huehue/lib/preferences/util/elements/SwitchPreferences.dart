/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/9/23, 6:36 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huehue/dashboard/dashboard_interface.dart';
import 'package:huehue/preferences/data/PreferencesKeys.dart';
import 'package:huehue/preferences/io/preferences_io.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/ui/gradient_text/constants.dart';
import 'package:huehue/utils/ui/gradient_text/gradient.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';

class SwitchPreferences extends StatefulWidget {

  PreferencesIO preferencesIO;

  String preferencesKey;

  String titlePreferences;
  String descriptionPreferences;

  SwitchPreferences({super.key, required this.preferencesIO, required this.preferencesKey, required this.titlePreferences, required this.descriptionPreferences});

  @override
  State<SwitchPreferences> createState() => _SwitchPreferencesState();
}

class _SwitchPreferencesState extends State<SwitchPreferences> with TickerProviderStateMixin {

  AnimationController? animationController;

  String switchStatusText = StringsResources.switchOff();
  Color switchStatusColor = ColorsResources.switchOff;

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

    super.initState();

    animationController = AnimationController(vsync: this);
    animationController?.duration = const Duration(milliseconds: 357);

    Animation<Color?> animationColor = ColorTween(begin: ColorsResources.switchOff, end: ColorsResources.switchOn).animate(animationController!);

    animationColor..addListener(() {

      setState(() {

        switchStatusColor = animationColor.value!;

      });

    })..addStatusListener((status) {

      switch (status) {
        case AnimationStatus.completed: {
          break;
        }
        case AnimationStatus.dismissed: {
          break;
        }
        case AnimationStatus.forward: {

          switchStatusText = StringsResources.switchOn();

          break;
        }
        case AnimationStatus.reverse: {

          switchStatusText = StringsResources.switchOff();

          break;
        }
      }

    });

    initializeSwitch();

  }

  @override
  Widget build(BuildContext context) {

    return switchPreferences(widget.titlePreferences, widget.descriptionPreferences);
  }

  Widget switchPreferences(String titlePreferences, String descriptionPreferences) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(37, 0, 37, 0),
      child: Column(
        children: [

          ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Blur(
                blur: 37,
                blurColor: ColorsResources.black,
                colorOpacity: 0.13,
                overlay: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /* Start - Title */
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
                    /* End - Title */

                    /* Start - Switch */
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        width: 1,
                                        color: switchStatusColor,
                                        strokeAlign: BorderSide.strokeAlignInside
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
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Material(
                                          shadowColor: Colors.transparent,
                                          color: Colors.transparent,
                                          child: InkWell(
                                              splashColor: ColorsResources.primaryColor,
                                              splashFactory: InkRipple.splashFactory,
                                              onTap: () {

                                                Future.delayed(const Duration(milliseconds: 333), ()  {

                                                  storeValuesSwitch();

                                                  if (switchStatusText == StringsResources.switchOn()) {

                                                    animationController?.reverse();

                                                  } else {

                                                    animationController?.forward();

                                                  }

                                                });

                                              },
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
                                          ),
                                        )
                                    )
                                )
                            )
                        )
                    )
                    /* End - Switch */

                  ],
                ),
                child: const SizedBox(
                    height: 53,
                    width: double.maxFinite
                ),
              )
          ),

          const Divider(
            height: 13,
            color: Colors.transparent
          ),

          const Image(
            image: AssetImage("assets/preferences_pointer.png"),
            height: 11,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                color: ColorsResources.premiumLight.withOpacity(0.07),
                child: SizedBox(
                  height: 53,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.descriptionPreferences,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: const TextStyle(
                            color: ColorsResources.premiumLight,
                            fontSize: 13,
                            fontFamily: "Ubuntu",
                            letterSpacing: 1.1,
                            height: 1.3
                          ),
                        )
                    )
                  )
                )
              )
          ),

        ],
      )
    );
  }

  void initializeSwitch() async {

    switch (widget.preferencesKey) {
      case PreferencesKeys.continuously: {

        bool continuouslyValue = await widget.preferencesIO.retrieveContinuously();
        debugPrint("Initial Continuously: $continuouslyValue");

        continuouslyValue ? animationController?.forward() : animationController?.reverse();

        break;
      }
      case PreferencesKeys.sounds: {

        bool sounds = await widget.preferencesIO.retrieveSounds();
        debugPrint("Initial Sounds: $sounds");

        sounds ? animationController?.forward() : animationController?.reverse();

        break;
      }
    }

  }

  void storeValuesSwitch() async {

    switch (widget.preferencesKey) {
      case PreferencesKeys.continuously: {
        FirebaseAnalytics.instance.logEvent(name: "Continuously");

        bool continuouslyValue = await widget.preferencesIO.retrieveContinuously();
        debugPrint("Continuously: $continuouslyValue | Switching It...");

        continuouslyValue ? widget.preferencesIO.storeContinuously(false) : widget.preferencesIO.storeContinuously(true);

        break;
      }
      case PreferencesKeys.sounds: {
        FirebaseAnalytics.instance.logEvent(name: "Sounds");

        bool soundsValue = await widget.preferencesIO.retrieveSounds();
        debugPrint("Sounds: $soundsValue | Switching It...");

        soundsValue ? widget.preferencesIO.storeSounds(false) : widget.preferencesIO.storeSounds(true);

        soundsValue ? DashboardInterfaceState.backgroundAudioPlayer.pause() : DashboardInterfaceState.backgroundAudioPlayer.play() ;

        break;
      }
    }

  }

}

/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/23, 6:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:huehue/resources/colors_resources.dart';

class NextedTooltips extends StatefulWidget {

  static const int sectionTopLeft = 1;
  static const int sectionTopRight = 2;
  static const int sectionBottomLeft = 3;
  static const int sectionBottomRight = 4;

  bool atStartShow = false;

  int displaySection = NextedTooltips.sectionTopRight;

  double topPosition = 37;
  double bottomPosition = 37;
  double leftPosition = 37;
  double rightPosition = 37;

  String tooltipMessage = "Geeks Empire";

  NextedTooltips({super.key, required this.atStartShow,
    required this.displaySection,
    required this.topPosition, required this.bottomPosition, required this.leftPosition, required this.rightPosition,
    required this.tooltipMessage});

  @override
  State<NextedTooltips> createState() => _NextedTooltipsState();
}

class _NextedTooltipsState extends State<NextedTooltips> {

  double loginTooltip = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((frameDuration) {

      Future.delayed(const Duration(milliseconds: 357), () => {

        if (widget.atStartShow) {

          setState(() {

            loginTooltip = 1.0;

          })

        }

      });

    });

  }

  @override
  Widget build(BuildContext context) {

    if (!widget.atStartShow) {

      setState(() {

        loginTooltip = 0.0;

      });

    }

    Widget tooltipWidget = Container();

    switch (widget.displaySection) {
      case NextedTooltips.sectionTopLeft: {

        tooltipWidget = widgetTopLeft();

        break;
      }
      case NextedTooltips.sectionTopRight: {

        tooltipWidget = widgetTopRight();

        break;
      }
      case NextedTooltips.sectionBottomLeft: {

        tooltipWidget = widgetBottomLeft();

        break;
      }
      case NextedTooltips.sectionBottomRight: {

        tooltipWidget = widgetBottomRight();

        break;
      }
    }

    return tooltipWidget;
  }

  Widget widgetTopLeft() {

    return Positioned(
        top: widget.topPosition,
        left: widget.leftPosition,
        right: widget.rightPosition,
        child: AnimatedOpacity(
            opacity: loginTooltip,
            duration: const Duration(milliseconds: 999),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                    height: 13,
                    width: 73,
                    child: Image(
                      image: AssetImage("preferences_pointer.png"),
                      height: 13,
                      color: ColorsResources.primaryColorDarkest,
                    )
                ),

                SizedBox(
                    height: 37,
                    width: 193,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Container(
                            decoration: BoxDecoration(
                                color: ColorsResources.primaryColorDarkest.withOpacity(0.07),
                                border: Border(
                                    bottom: BorderSide(
                                        color: ColorsResources.primaryColorDarkest.withOpacity(0.31),
                                        width: 1,
                                        strokeAlign: StrokeAlign.inside
                                    )
                                )
                            ),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.tooltipMessage,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: ColorsResources.premiumLight,
                                          fontSize: 13,
                                          fontFamily: "Ubuntu",
                                          letterSpacing: 1.1,
                                          height: 1.3,
                                          shadows: [
                                            Shadow(
                                                color: ColorsResources.white.withOpacity(0.31),
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
                )

              ],
            )
        )
    );
  }

  Widget widgetTopRight() {

    return Positioned(
        top: widget.topPosition,
        left: widget.leftPosition,
        right: widget.rightPosition,
        child: AnimatedOpacity(
            opacity: loginTooltip,
            duration: const Duration(milliseconds: 999),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                const SizedBox(
                    height: 13,
                    width: 73,
                    child: Image(
                      image: AssetImage("preferences_pointer.png"),
                      height: 13,
                      color: ColorsResources.primaryColorDarkest,
                    )
                ),

                SizedBox(
                    height: 37,
                    width: 193,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Container(
                            decoration: BoxDecoration(
                                color: ColorsResources.primaryColorDarkest.withOpacity(0.07),
                                border: Border(
                                  bottom: BorderSide(
                                      color: ColorsResources.primaryColorDarkest.withOpacity(0.31),
                                      width: 1,
                                      strokeAlign: StrokeAlign.inside
                                  )
                                )
                            ),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.tooltipMessage,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: ColorsResources.premiumLight,
                                          fontSize: 13,
                                          fontFamily: "Ubuntu",
                                          letterSpacing: 1.1,
                                          height: 1.3,
                                          shadows: [
                                            Shadow(
                                                color: ColorsResources.white.withOpacity(0.31),
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
                )

              ],
            )
        )
    );
  }

  Widget widgetBottomLeft() {

    return Positioned(
        bottom: widget.bottomPosition,
        left: widget.leftPosition,
        right: widget.rightPosition,
        child: AnimatedOpacity(
            opacity: loginTooltip,
            duration: const Duration(milliseconds: 999),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                    height: 37,
                    width: 193,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Container(
                            decoration: BoxDecoration(
                                color: ColorsResources.primaryColorDarkest.withOpacity(0.07),
                                border: Border(
                                    top: BorderSide(
                                        color: ColorsResources.primaryColorDarkest.withOpacity(0.31),
                                        width: 1,
                                        strokeAlign: StrokeAlign.inside
                                    )
                                )
                            ),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.tooltipMessage,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: ColorsResources.premiumLight,
                                          fontSize: 13,
                                          fontFamily: "Ubuntu",
                                          letterSpacing: 1.1,
                                          height: 1.3,
                                          shadows: [
                                            Shadow(
                                                color: ColorsResources.white.withOpacity(0.31),
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

                const SizedBox(
                    height: 13,
                    width: 73,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Image(
                        image: AssetImage("preferences_pointer.png"),
                        height: 13,
                        color: ColorsResources.red,
                      )
                    )
                )

              ],
            )
        )
    );
  }

  Widget widgetBottomRight() {

    return Positioned(
        bottom: widget.bottomPosition,
        left: widget.leftPosition,
        right: widget.rightPosition,
        child: AnimatedOpacity(
            opacity: loginTooltip,
            duration: const Duration(milliseconds: 999),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                SizedBox(
                    height: 37,
                    width: 193,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Container(
                            decoration: BoxDecoration(
                                color: ColorsResources.primaryColorDarkest.withOpacity(0.07),
                                border: Border(
                                    top: BorderSide(
                                        color: ColorsResources.primaryColorDarkest.withOpacity(0.31),
                                        width: 1,
                                        strokeAlign: StrokeAlign.inside
                                    )
                                )
                            ),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.tooltipMessage,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: ColorsResources.premiumLight,
                                          fontSize: 13,
                                          fontFamily: "Ubuntu",
                                          letterSpacing: 1.1,
                                          height: 1.3,
                                          shadows: [
                                            Shadow(
                                                color: ColorsResources.white.withOpacity(0.31),
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

                const SizedBox(
                    height: 13,
                    width: 73,
                    child: RotatedBox(
                        quarterTurns: 2,
                        child: Image(
                          image: AssetImage("preferences_pointer.png"),
                          height: 13,
                          color: ColorsResources.red,
                        )
                    )
                )

              ],
            )
        )
    );
  }

}

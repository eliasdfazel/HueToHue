/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/15/23, 5:52 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:widget_mask/widget_mask.dart';

abstract class GameStatuesListener {
  void retryPlay(){}
  void startNextPlay(){}
  void chaoticFinished(){}
}

class GameStatues {

  Widget gameOverScene(GameStatuesListener gameStatuesListener) {

    return ClipRRect(
        borderRadius: BorderRadius.circular(37),
        child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(
                children: [

                  /* Start - Blurry Background */
                  const Blur(
                    blur: 19.0,
                    blurColor: ColorsResources.primaryColorDarkest,
                    colorOpacity: 0.73,
                    child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ),
                  ),
                  /* End - Blurry Background */

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                        width: double.maxFinite,
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

                                        gameStatuesListener.retryPlay();

                                      });

                                    },
                                    child: const Image(
                                      image: AssetImage("restart_blob_play.png"),
                                      width: double.maxFinite,
                                    )
                                )
                            ),
                            child: const Image(
                              image: AssetImage("restart_blob_play.png"),
                              width: double.maxFinite,
                            )
                        )
                    )
                  ),

                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 173, left: 0, right: 0),
                        child: Column(
                          children: [

                            Text(
                              "game",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorsResources.premiumLight,
                                  fontSize: 73,
                                  fontFamily: "Electric",
                                  shadows: [
                                    Shadow(
                                      color: ColorsResources.white.withOpacity(0.37),
                                      blurRadius: 37,
                                      offset: const Offset(0, 3)
                                    )
                                  ]
                              ),
                            ),

                            Text(
                              "over",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorsResources.premiumLight,
                                  fontSize: 73,
                                  letterSpacing: 9,
                                  fontFamily: "Electric",
                                  shadows: [
                                    Shadow(
                                        color: ColorsResources.white.withOpacity(0.37),
                                        blurRadius: 37,
                                        offset: const Offset(0, 3)
                                    )
                                  ]
                              ),
                            ),

                            const Divider(
                              height: 3,
                              color: Colors.transparent,
                            ),

                            Text(
                              StringsResources.timedout(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorsResources.premiumLight,
                                  fontSize: 17,
                                  letterSpacing: 17,
                                  fontFamily: "Nasa",
                                  shadows: [
                                    Shadow(
                                        color: ColorsResources.white.withOpacity(0.53),
                                        blurRadius: 13,
                                        offset: const Offset(0, 3)
                                    )
                                  ]
                              ),
                            ),

                          ],
                        )
                    )
                  )

                ]
            )
        )
    );
  }

  Widget gameWinScene(GameStatuesListener gameStatuesListener) {

    return ClipRRect(
        borderRadius: BorderRadius.circular(37),
        child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(
                children: [

                  /* Start - Blurry Background */
                  const Blur(
                    blur: 19.0,
                    blurColor: ColorsResources.primaryColorDarkest,
                    colorOpacity: 0.73,
                    child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ),
                  ),
                  /* End - Blurry Background */

                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                          width: double.maxFinite,
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

                                          gameStatuesListener.startNextPlay();

                                        });

                                      },
                                      child: const Image(
                                        image: AssetImage("restart_blob_play.png"),
                                        width: double.maxFinite,
                                      )
                                  )
                              ),
                              child: const Image(
                                image: AssetImage("restart_blob_play.png"),
                                width: double.maxFinite,
                              )
                          )
                      )
                  ),

                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 199, left: 0, right: 0),
                          child: Column(
                            children: [

                              Text(
                                "next level",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsResources.premiumLight,
                                    fontSize: 31,
                                    fontFamily: "Electric",
                                    letterSpacing: 3,
                                    shadows: [
                                      Shadow(
                                          color: ColorsResources.white.withOpacity(0.37),
                                          blurRadius: 37,
                                          offset: const Offset(0, 3)
                                      )
                                    ]
                                ),
                              ),

                              Text(
                                "unlocked",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsResources.premiumLight,
                                    fontSize: 43,
                                    fontFamily: "Electric",
                                    shadows: [
                                      Shadow(
                                          color: ColorsResources.white.withOpacity(0.37),
                                          blurRadius: 37,
                                          offset: const Offset(0, 3)
                                      )
                                    ]
                                ),
                              ),

                            ],
                          )
                      )
                  )

                ]
            )
        )
    );
  }

  Widget chaoticGameWinScene(GameStatuesListener gameStatuesListener) {

    return ClipRRect(
        borderRadius: BorderRadius.circular(37),
        child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(
                children: [

                  /* Start - Blurry Background */
                  const Blur(
                    blur: 19.0,
                    blurColor: ColorsResources.primaryColorDarkest,
                    colorOpacity: 0.73,
                    child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ),
                  ),
                  /* End - Blurry Background */

                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                          width: double.maxFinite,
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

                                          gameStatuesListener.chaoticFinished();

                                        });

                                      },
                                      child: const Image(
                                        image: AssetImage("restart_blob_play.png"),
                                        width: double.maxFinite,
                                      )
                                  )
                              ),
                              child: const Image(
                                image: AssetImage("restart_blob_play.png"),
                                width: double.maxFinite,
                              )
                          )
                      )
                  ),

                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 199, left: 0, right: 0),
                          child: Column(
                            children: [

                              Text(
                                "chaotic finished",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsResources.premiumLight,
                                    fontSize: 31,
                                    fontFamily: "Electric",
                                    letterSpacing: 3,
                                    shadows: [
                                      Shadow(
                                          color: ColorsResources.white.withOpacity(0.37),
                                          blurRadius: 37,
                                          offset: const Offset(0, 3)
                                      )
                                    ]
                                ),
                              ),

                              Text(
                                "you are lucky!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsResources.premiumLight,
                                    fontSize: 43,
                                    fontFamily: "Electric",
                                    shadows: [
                                      Shadow(
                                          color: ColorsResources.white.withOpacity(0.37),
                                          blurRadius: 37,
                                          offset: const Offset(0, 3)
                                      )
                                    ]
                                ),
                              ),

                            ],
                          )
                      )
                  )

                ]
            )
        )
    );
  }

}
/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/8/23, 5:15 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:widget_mask/widget_mask.dart';

class GameStatues {

  Widget gameOverScene() {

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
                    bottom: -137,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                        height: 513,
                        width: double.maxFinite,
                        child: Stack(
                          children: [

                            WidgetMask(
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

                                            // navigateTo(context, HueToHue(maximumLevels: maximumLevels));

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
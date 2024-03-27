
/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/27/24, 12:18 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:url_launcher/url_launcher.dart';

Widget updateWidget(String applicationLink) {

  return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                ColorsResources.primaryColor,
                ColorsResources.primaryColorDarker
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    child: Material(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        child: InkWell(
            splashColor: ColorsResources.lightGreen.withOpacity(0.73),
            splashFactory: InkRipple.splashFactory,
            onTap: () {

              Future.delayed(const Duration(milliseconds: 555), () {

                launchUrl(Uri.parse(applicationLink), mode: LaunchMode.externalApplication);

              });

            },
            child: Center(
              child: SizedBox(
                  height: 333,
                  width: 333,
                  child: Center(
                      child: Text(
                          StringsResources.availableUpdate(),
                          style: const TextStyle(
                              color: ColorsResources.premiumLight,
                              fontSize: 37,
                              fontFamily: 'Electric'
                          )
                      )
                  )
              )
            )
        )
    )
  );

}
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/11/22, 7:21 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';

void navigateTo(BuildContext context, StatefulWidget statefulWidget) {

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => statefulWidget),
  );

}

void navigateToWithPop(BuildContext context, StatefulWidget statefulWidget) {

  Navigator.pop(context);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => statefulWidget),
  );

}

void navigatePop(BuildContext context) {

  Navigator.pop(context);

}

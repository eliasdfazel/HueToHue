/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/5/22, 10:54 AM
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

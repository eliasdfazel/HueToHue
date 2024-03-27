/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/8/23, 6:21 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:huehue/dashboard/dashboard_interface.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/utils/navigations/navigation_commands.dart';
import 'package:huehue/utils/ui/system/system_bars.dart';

class EntryConfigurations extends StatefulWidget {

  const EntryConfigurations({super.key});

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}

class _EntryConfigurationsState extends State<EntryConfigurations> with SingleTickerProviderStateMixin  {

  Widget placeholderEntry = Container();

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    changeColor(ColorsResources.primaryColorDarkest, ColorsResources.primaryColorDarkest);

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 1357), () {

      navigateToWithPop(context, const DashboardInterface());

    });

    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: ColorsResources.primaryColorDarkest,
        body: ClipRRect(
            borderRadius: BorderRadius.circular(37),
            child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: InnerShadow(
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
                                width: 1.3,
                                strokeAlign: BorderSide.strokeAlignInside
                            ),
                            color: ColorsResources.primaryColorDarkest
                        ),
                        child: const Center(
                            child: SizedBox(
                                height: 303,
                                width: 303,
                                child: Image(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.contain,
                                )
                            )
                        )
                    )
                )
            )
        )
    );
  }

}

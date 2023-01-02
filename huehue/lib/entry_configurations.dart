import 'package:flutter/material.dart';
import 'package:huehue/resources/colors_resources.dart';
import 'package:huehue/resources/strings_resources.dart';
import 'package:huehue/utils/operations/numbers.dart';

class EntryConfigurations extends StatefulWidget {

  const EntryConfigurations({super.key});

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationsState();
}

class _EntryConfigurationsState extends State<EntryConfigurations> with SingleTickerProviderStateMixin  {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringsResources.applicationName(),
          color: ColorsResources.primaryColor,
          theme: ThemeData(
            fontFamily: 'Ubuntu',
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
            backgroundColor: ColorsResources.black,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            }),
          ),
          home: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              backgroundColor: ColorsResources.black,
              body: ClipRRect(
                  borderRadius: BorderRadius.circular(37),
                  child: SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: InkWell(
                        onTap: () {



                        },
                        child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: const [
                                      ColorsResources.pink,
                                      ColorsResources.blueGray
                                    ],
                                    transform: GradientRotation(degreeToRadian(137))
                                )
                            )
                        ),
                      )
                  )
              )
          )
      )
    );
  }
}

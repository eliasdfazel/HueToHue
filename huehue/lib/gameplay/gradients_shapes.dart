/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/5/23, 7:21 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:huehue/utils/operations/numbers.dart';

class GradientsShapes extends StatefulWidget {

  List<Color> gradientColors;

  GradientsShapes({super.key, required this.gradientColors});

  @override
  State<GradientsShapes> createState() => _GradientsShapesState();
}

class _GradientsShapesState extends State<GradientsShapes>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Blob.random(
      size: 200,
      edgesCount:5,
      minGrowth:4,
      styles:  BlobStyles(
        color: Colors.green,
        fillType: BlobFillType.fill,
        gradient: LinearGradient(
            colors: List.generate(widget.gradientColors.length, (index) => widget.gradientColors[index]),
            transform: GradientRotation(degreeToRadian(137))
        ).createShader(Rect.fromLTRB(0, 0, 333, 333)),
        strokeWidth:3,
      )
    );
  }

}
/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/5/23, 9:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:huehue/gameplay/data/levels_data_structure.dart';
import 'package:huehue/utils/operations/colors.dart';
import 'package:huehue/utils/operations/numbers.dart';

class GradientsShapes extends StatefulWidget {

  LevelsDataStructure? levelsDataStructure;

  GradientsShapes({super.key, required this.levelsDataStructure});

  List<Color> randomShapedColor = [];

  @override
  State<GradientsShapes> createState() => _GradientsShapesState();
}

class _GradientsShapesState extends State<GradientsShapes>  {

  BlobController blobController = BlobController();


  @override
  void dispose() {

    blobController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    blobController.change();

    Widget blobShape = Container();

    if (widget.levelsDataStructure != null) {

      widget.randomShapedColor = List.generate(widget.levelsDataStructure!.gradientLayers(), (index) => randomColor(widget.levelsDataStructure!.allColors()));

      blobShape = Align(
          alignment: Alignment.topCenter,
          child: Blob.random(
              controller: blobController,
              size: 333,
              edgesCount: 7,
              minGrowth: 3,
              styles: BlobStyles(
                  fillType: BlobFillType.fill,
                  gradient: LinearGradient(
                      colors: widget.randomShapedColor,
                      transform: GradientRotation(degreeToRadian(137))
                  ).createShader(Rect.zero)
              )
          )
      );

    }

    return blobShape;
  }

}
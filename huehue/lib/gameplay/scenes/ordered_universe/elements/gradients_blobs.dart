/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/8/23, 3:37 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:huehue/gameplay/scenes/ordered_universe/data/levels_data_structure.dart';
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

  ColorsUtils colorsUtils = ColorsUtils();

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

      widget.randomShapedColor = colorsUtils.prepareBlobGradient(widget.levelsDataStructure!.allColors(), widget.levelsDataStructure!.gradientLayersCount());

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
                  ).createShader(const Rect.fromLTRB(0, 0, 333, 333))
              )
          )
      );

    }

    return blobShape;
  }

}
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
import 'package:huehue/gameplay/scenes/chaotic_universe/data/chaotic_data_structure.dart';
import 'package:huehue/utils/operations/colors.dart';
import 'package:huehue/utils/operations/numbers.dart';

class ChaoticGradientsShapes extends StatefulWidget {

  ChaoticDataStructure? chaoticDataStructure;

  ChaoticGradientsShapes({super.key, required this.chaoticDataStructure});

  List<Color> randomShapedColor = [];

  @override
  State<ChaoticGradientsShapes> createState() => _GradientsShapesState();
}

class _GradientsShapesState extends State<ChaoticGradientsShapes>  {

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

    if (widget.chaoticDataStructure != null) {

      widget.randomShapedColor = colorsUtils.prepareBlobGradient(widget.chaoticDataStructure!.allColors(), widget.chaoticDataStructure!.gradientLayersCount());

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
                      transform: GradientRotation(degreeToRadian(widget.chaoticDataStructure!.gradientRotation()))
                  ).createShader(const Rect.fromLTRB(0, 0, 333, 333))
              )
          )
      );

    }

    return blobShape;
  }

}
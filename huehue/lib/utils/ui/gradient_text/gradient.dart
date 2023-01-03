/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/3/23, 4:47 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:huehue/utils/ui/gradient_text/constants.dart';

/// A gradient text.
class GradientText extends StatelessWidget {
  /// Colors used to show the gradient.
  final List<Color> colors;

  /// Direction in which the gradient will be displayed.
  final GradientDirection? gradientDirection;

  /// The type of gradient to apply.
  final GradientType gradientType;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The radius of the gradient, as a fraction of the shortest side
  /// of the paint box.
  final double radius;

  final int maxLinesNumber;

  /// If non-null, the style to use for this text.
  final TextStyle? style;

  /// The text to display.
  final String text;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    required this.colors,
    this.gradientDirection = GradientDirection.ltr,
    this.gradientType = GradientType.linear,
    Key? key,
    this.overflow,
    this.radius = 1.0,
    this.maxLinesNumber = 1,
    this.style,
    this.textAlign,
  })  : assert(
          colors.length >= 2,
          'Colors list must have at least two colors',
        ),
        super(key: key);

  @override
  Widget build(final BuildContext context) {
    return ShaderMask(
      shaderCallback: (final Rect bounds) {
        switch (gradientType) {
          case GradientType.linear:
            final Map<String, Alignment> map = {};
            switch (gradientDirection) {
              case GradientDirection.tltbr:
                map['begin'] = Alignment.topLeft;
                map['end'] = Alignment.bottomRight;
                break;
              case GradientDirection.rtl:
                map['begin'] = Alignment.centerRight;
                map['end'] = Alignment.centerLeft;
                break;
              case GradientDirection.ttb:
                map['begin'] = Alignment.topCenter;
                map['end'] = Alignment.bottomCenter;
                break;
              case GradientDirection.btt:
                map['begin'] = Alignment.bottomCenter;
                map['end'] = Alignment.topCenter;
                break;
              default:
                map['begin'] = Alignment.centerLeft;
                map['end'] = Alignment.centerRight;
                break;
            }
            return LinearGradient(
              begin: map['begin']!,
              colors: colors,
              end: map['end']!,
            ).createShader(bounds);
          case GradientType.radial:
            return RadialGradient(
              colors: colors,
              radius: radius,
            ).createShader(bounds);
        }
      },
      child: Text(
        text,
        maxLines: maxLinesNumber,
        overflow: overflow,
        style: style != null
            ? style?.copyWith(color: Colors.white)
            : const TextStyle(color: Colors.white),
        textAlign: textAlign,
      ),
    );
  }
}

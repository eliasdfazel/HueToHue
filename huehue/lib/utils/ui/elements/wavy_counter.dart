/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/23, 7:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huehue/utils/calculations/math_utils.dart';

class WavyCounter {

  late List<Color> _colors;
  AnimationController? _controller;
  late AnimationController _addPointController;
  Animation<double>? _addPointAnimation;
  int? _counter;
  BlendMode? _blend;
  int _radiusFactor = 19;


  WavyCounter(
      {required TickerProvider vsync,
        required List<Color> initialColors,
        required int initialCounter,
        int radiusFactor = 19,
        BlendMode blend = BlendMode.hardLight}) {

    _counter = initialCounter;
    _colors = initialColors;
    _blend = blend;
    _radiusFactor = radiusFactor;
    _controller = AnimationController(
      vsync: vsync,
      upperBound: 2,
      duration: const Duration(seconds: 10),
    )..repeat();
    _addPointController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 500),
    );
    _addPointAnimation =
        _addPointController.drive(CurveTween(curve: Curves.ease));

    for (int i = 0; i < _counter!; i++) {
      _addPointController.forward(from: 0);
    }
  }


  void incrementCounter() async {
    _counter = _counter! + 1;
    await _addPointController.forward(from: 0);
  }

  void decrementCounter() {
    if (_counter! > 0) {
      _counter = _counter! - 1;
      _addPointController.forward(from: 0);
    }
  }

  int? getCounter() {
    return _counter;
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < _colors.length; i++)
          Positioned.fill(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              builder: (_, double opacity, __) {
                return CustomPaint(
                  painter: _WavyCounterPainter(
                    _controller,
                    _addPointAnimation,
                    i,
                    _colors[i].withOpacity(opacity),
                    _counter,
                    _radiusFactor,
                    _blend,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _WavyCounterPainter extends CustomPainter {

  final Animation<double>? animation;
  final Animation<double>? addAnimation;
  final int index;
  final Color color;
  int radiusFactor;
  final int? count;
  final BlendMode? blend;

  static const halfPi = math.pi / 2;
  static const twoPi = math.pi * 2;
  final n = 7;

  _WavyCounterPainter(
      this.animation,
      this.addAnimation,
      this.index,
      this.color,
      this.count,
      this.radiusFactor,
      this.blend,
      ) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation!.value;
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    final q = index * halfPi;

    List<Offset> computeOffsets(int length) {
      final offsets = <Offset>[];
      for (var i = 0; i < length; i++) {
        final th = i * twoPi / length;
        double os = map(math.cos(th - twoPi * t), -1, 1, 0, 1);
        os = 0.125 * math.pow(os, 2.75);
        final r = radiusFactor * (1 + os * math.cos(n * th + 1.5 * twoPi * t + q));
        offsets.add(Offset(
            r * math.sin(th) + halfWidth, -r * math.cos(th) + halfHeight));
      }
      return offsets;
    }

    final List<Offset> offsets = computeOffsets(count!);

    if (count! > 1 && addAnimation!.value < 1) {
      final t = addAnimation!.value;
      final oldOffsets = computeOffsets(count! - 1);
      for (var i = 0; i < count! - 1; i++) {
        offsets[i] = Offset.lerp(oldOffsets[i], offsets[i], t)!;
      }
      offsets[count! - 1] = Offset.lerp(
        oldOffsets[count! - 2],
        offsets[count! - 1],
        t,
      )!;
    }

    final path = Path()
      ..addPolygon(offsets!, true);

    canvas.drawPath(
      path,
      Paint()
        ..blendMode = blend!
        ..color = color
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
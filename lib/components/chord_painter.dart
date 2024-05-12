import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordPainter extends CustomPainter {
  final ChordPosition chordPosition;

  ChordPainter({required this.chordPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = min(size.width, 100);
    final double height = min(size.height, 120);

    const double paddingTop = 0;
    final double stringSpacing = width / (6 - 1);

    final double fretSpacing = height / 4;
    final double fretboardWidth = width;

    final double fontSize = width * 0.16;
    final double strokeWidth = width < 70 ? 1 : 2;

    // Draw freet number indicator (X or 0)
    for (int i = 0; i < 6; i++) {
      if (chordPosition.frets[i] == 'x' || chordPosition.frets[i] == '0') {
        final double x = stringSpacing * i;
        final double y = paddingTop - height * 0.01;

        final String fingerPosition = chordPosition.frets[i] == 'x' ? 'X' : '0';
        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: fingerPosition,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              // fontFamily: '',
              height: 1,
              // fontFamilyFallback: const <String>["Courier"]
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter.paint(
            canvas, Offset(x - textPainter.width / 2, y - width * 0.3));
      }
    }

    // Draw nut
    canvas.drawRect(
        Rect.fromPoints(Offset(-1, paddingTop),
            Offset(fretboardWidth + 1, paddingTop - (height * 0.08))),
        Paint()..color = Colors.black);

    // Draw freets
    for (int i = 0; i < 5; i++) {
      final double y = paddingTop + fretSpacing * i;
      canvas.drawLine(Offset(0, y), Offset(fretboardWidth, y),
          Paint()..strokeWidth = strokeWidth);
    }

    // Draw strings
    for (int i = 0; i < 6; i++) {
      final double x = stringSpacing * i;
      canvas.drawLine(Offset(x, paddingTop + 0), Offset(x, paddingTop + height),
          Paint()..strokeWidth = strokeWidth);
    }

    final double positionIndicatorWidth = width * 0.09;
    final double positionIndicatorFontSize = width * 0.12;

    // Draw finger positions
    for (int stringIndex = 0; stringIndex < 6; stringIndex++) {
      final int fingerPosition = int.parse(chordPosition.fingers[stringIndex]);

      if (fingerPosition != 0) {
        final double x = stringSpacing * stringIndex;
        final double y = paddingTop +
            fretSpacing * int.parse(chordPosition.frets[stringIndex]) -
            fretSpacing / 2;

        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: fingerPosition.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: positionIndicatorFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        canvas.drawCircle(Offset(x, y), positionIndicatorWidth,
            Paint()..color = const Color(0xFF2465FF));
        textPainter.paint(canvas,
            Offset(x - textPainter.width / 2, y - textPainter.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

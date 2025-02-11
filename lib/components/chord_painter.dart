import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordPainter extends CustomPainter {
  final ChordPosition chordPosition;
  final ThemeData theme;

  ChordPainter({required this.chordPosition, required this.theme});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = min(size.width, 100);
    final double height = min(width * 1.2, 120);

    const double paddingTop = 0;
    final double stringSpacing = width / (6 - 1);

    final double fretSpacing = height / 4;
    final double fretboardWidth = width;

    final double fontSize = width * 0.16;
    final double strokeWidth = width < 70 ? 1 : 2;

    final bool showFingerNumber = width >= 70;

    // Draw freet number indicator (X or 0)
    for (int i = 0; i < 6; i++) {
      if (chordPosition.frets[i] == 'x' || chordPosition.frets[i] == '0') {
        final double x = stringSpacing * i;
        final double y = paddingTop - height * 0.01;

        final String fingerPosition = chordPosition.frets[i] == 'x' ? '✕' : '○';
        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: fingerPosition,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              // fontFamily: '',
              height: 1,
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
        Rect.fromPoints(const Offset(-1, paddingTop),
            Offset(fretboardWidth + 1, paddingTop - (height * 0.08))),
        Paint()..color = theme.colorScheme.primary);

    // Draw freets
    for (int i = 0; i < 5; i++) {
      final double y = paddingTop + fretSpacing * i;
      canvas.drawLine(
          Offset(0, y),
          Offset(fretboardWidth, y),
          Paint()
            ..strokeWidth = strokeWidth
            ..color = theme.colorScheme.primary);
    }

    // Draw strings
    for (int i = 0; i < 6; i++) {
      final double x = stringSpacing * i;
      canvas.drawLine(
          Offset(x, paddingTop + 0),
          Offset(x, paddingTop + height),
          Paint()
            ..strokeWidth = strokeWidth
            ..color = theme.colorScheme.primary);
    }

    final double positionIndicatorWidth = width * 0.08;
    final double positionIndicatorFontSize = width * 0.12;

    // Draw finger positions
    for (int stringIndex = 0; stringIndex < 6; stringIndex++) {
      final int fingerPosition = int.parse(chordPosition.fingers[stringIndex]);

      if (fingerPosition != 0 && chordPosition.frets[stringIndex] != 'x') {
        final double x = stringSpacing * stringIndex;
        final double y = paddingTop +
            fretSpacing * int.parse(chordPosition.frets[stringIndex]) -
            fretSpacing / 2;

        canvas.drawCircle(Offset(x, y), positionIndicatorWidth,
            Paint()..color = theme.colorScheme.tertiary);

        if (showFingerNumber) {
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

          textPainter.paint(canvas,
              Offset(x - textPainter.width / 2, y - textPainter.height / 2));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordPainter extends CustomPainter {
  final ChordModel chord;

  ChordPainter({required this.chord});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double paddingTop = size.height * 0.2;
    final double stringSpacing = width / (chord.positions.length - 1);

    final double fretSpacing = size.height / 4;
    final double fretboardWidth = width;

    // Draw freet number indicator (X or 0)
    for (int i = 0; i < chord.positions.length; i++) {
      if (chord.positions[i].fret == null || chord.positions[i].fret == 0) {
        final double x = stringSpacing * i;
        final double y = paddingTop - size.height * 0.08;

        final String fingerPosition =
            chord.positions[i].fret == null ? 'X' : '0';
        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: fingerPosition,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - 24));

        // TODO: Temp Chord Number
        final TextPainter textPainter2 = TextPainter(
          text: TextSpan(
            text: chord.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter2.paint(
            canvas, Offset(textPainter2.width / 2, size.height + 44));
      }
    }

    // Draw nut
    canvas.drawRect(
      Rect.fromPoints(Offset(-1, paddingTop),
          Offset(fretboardWidth + 1, paddingTop - (size.height * 0.08))),
      Paint()..color = Colors.black,
    );

    // Draw freets
    for (int i = 0; i < 5; i++) {
      final double y = paddingTop + fretSpacing * i;
      canvas.drawLine(
          Offset(0, y), Offset(fretboardWidth, y), Paint()..strokeWidth = 2);
    }

    // Draw strings
    for (int i = 0; i < chord.positions.length; i++) {
      final double x = stringSpacing * i;
      canvas.drawLine(Offset(x, paddingTop + 0),
          Offset(x, paddingTop + size.height), Paint()..strokeWidth = 2);
    }

    final double positionIndicatorWidth = size.width * 0.09;
    final double positionIndicatorFontSize = size.width * 0.12;

    // Draw finger positions
    for (int stringIndex = 0;
        stringIndex < chord.positions.length;
        stringIndex++) {
      final int? fingerPosition = chord.positions[stringIndex].finger;

      if (fingerPosition != null) {
        final double x = stringSpacing * stringIndex;
        final double y = paddingTop +
            fretSpacing * chord.positions[stringIndex].fret! -
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
    return true;
  }
}

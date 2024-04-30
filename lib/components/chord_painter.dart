import 'package:flutter/material.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordPainter extends CustomPainter {
  final ChordModel chord;

  ChordPainter({required this.chord});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double paddingTop = size.height * 0.2;
    final double stringSpacing = width / (chord.notes.length - 1);

    final double fretSpacing = size.height / 4;
    final double fretboardWidth = width;

    // Draw freet number indicator (X or 0)
    for (int i = 0; i < chord.notes.length; i++) {
      if (chord.notes[i].fret == null || chord.notes[i].fret == 0) {
        final double x = stringSpacing * i;
        final double y = paddingTop - size.height * 0.08;

        final String fingerPosition = chord.notes[i].fret == null ? 'X' : '0';
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
    for (int i = 0; i < chord.notes.length; i++) {
      final double x = stringSpacing * i;
      canvas.drawLine(Offset(x, paddingTop + 0),
          Offset(x, paddingTop + size.height), Paint()..strokeWidth = 2);
    }

    const double positionIndicatorWidth = 12;

    // Draw finger positions
    for (int stringIndex = 0; stringIndex < chord.notes.length; stringIndex++) {
      final int? fingerPosition = chord.notes[stringIndex].fret;

      if (fingerPosition != null && fingerPosition != 0) {
        final double x = stringSpacing * stringIndex;
        final double y =
            paddingTop + fretSpacing * fingerPosition - fretSpacing / 2;

        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: fingerPosition.toString(), // TODO: Update this
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
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

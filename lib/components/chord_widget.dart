import 'package:flutter/material.dart';

class ChordWidget extends StatelessWidget {
  const ChordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(50, 100),
      painter: ChordPainter(['X', '3', '2', '0', '1', '0']),
    );
  }
}

class ChordPainter extends CustomPainter {
  final List<String> strings;

  ChordPainter(this.strings);

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double paddingTop = size.height * 0.2;
    final double stringSpacing = width / (strings.length - 1);

    final double fretSpacing = size.height / 4;
    final double fretboardWidth = width;

    // Draw freet number indicator (X or 0)
    for (int i = 0; i < strings.length; i++) {
      if (strings[i] == 'X' || strings[i] == '0') {
        final String fingerPosition = strings[i];
        final double x = stringSpacing * i;
        final double y = paddingTop - size.height * 0.08;

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
    for (int i = 0; i < strings.length; i++) {
      final double x = stringSpacing * i;
      canvas.drawLine(Offset(x, paddingTop + 0),
          Offset(x, paddingTop + size.height), Paint()..strokeWidth = 2);
    }

    const double positionIndicatorWidth = 12;

    // Draw finger positions
    for (int stringIndex = 0; stringIndex < strings.length; stringIndex++) {
      final String fingerPosition = strings[stringIndex];

      if (fingerPosition != 'X' && fingerPosition != '0') {
        final double x = stringSpacing * stringIndex;
        final double y = paddingTop +
            fretSpacing * double.parse(fingerPosition) -
            fretSpacing / 2;

        canvas.drawCircle(Offset(x, y), positionIndicatorWidth,
            Paint()..color = const Color(0xFF2465FF));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

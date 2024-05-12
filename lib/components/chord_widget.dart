import 'package:flutter/material.dart';
import 'package:test_drive/components/chord_painter.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordWidget extends StatelessWidget {
  final ChordPosition chordPosition;
  final VoidCallback? onTap;

  const ChordWidget({super.key, required this.chordPosition, this.onTap});

  @override
  Widget build(BuildContext context) {
    print("chord position >  ${chordPosition.toJson()}");
    return GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          size: const Size(60, 72),
          painter: ChordPainter(chordPosition: chordPosition),
        ));
  }
}

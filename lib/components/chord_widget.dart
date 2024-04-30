import 'package:flutter/material.dart';
import 'package:test_drive/components/chord_painter.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordWidget extends StatelessWidget {
  final ChordModel chord;
  final VoidCallback? onTap;

  const ChordWidget({super.key, required this.chord, this.onTap});

  @override
  Widget build(BuildContext context) {
    print(chord.toJson());
    return GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          size: const Size(50, 100),
          painter: ChordPainter(chord: chord),
        ));
  }
}

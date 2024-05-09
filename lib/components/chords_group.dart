import 'package:flutter/material.dart';
import 'package:test_drive/models/chord_model.dart';

class ChordsGroup extends StatelessWidget {
  const ChordsGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: EdgeInsets.all(50),
            child: Text("hoal 22222",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold))));
  }
}

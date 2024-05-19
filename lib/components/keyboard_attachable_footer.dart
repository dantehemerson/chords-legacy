import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

class KeyboardAttachableFooter extends StatelessWidget {
  final void Function(String) onTap;

  const KeyboardAttachableFooter({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const buttonStyle = ButtonStyle(
      padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
      textStyle: MaterialStatePropertyAll(TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      )),
    );

    return KeyboardAttachable(
      child: Container(
        padding: const EdgeInsets.only(left: 0, top: 7, bottom: 2, right: 0),
        height: 40,
        color: const Color(0xFFd1d3da),
        child: Row(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () => onTap('maj'), // Call onTap with 'maj'
                  style: buttonStyle,
                  child: const Text('maj'),
                ),
                TextButton(
                  onPressed: () => onTap('min'), // Call onTap with 'min'
                  style: buttonStyle,
                  child: const Text('min'),
                ),
                TextButton(
                  onPressed: () => onTap('sus'), // Call onTap with 'sus'
                  style: buttonStyle,
                  child: const Text('sus'),
                ),
                TextButton(
                  onPressed: () => onTap('add'), // Call onTap with 'add'
                  style: buttonStyle,
                  child: const Text('add'),
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => onTap('♯'), // Call onTap with '♯'
                  child: const Text('♯'),
                ),
                TextButton(
                  onPressed: () => onTap('♭'), // Call onTap with '♭'
                  child: const Text('♭'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

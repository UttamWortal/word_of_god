import 'package:flutter/material.dart';
import 'package:god/config/color.dart';

class CommonTextfieldName extends StatelessWidget {
  final String text;
  const CommonTextfieldName({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: textField,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

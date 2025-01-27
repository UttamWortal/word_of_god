import 'package:flutter/material.dart';
import 'package:god/config/color.dart';

class commonText extends StatelessWidget {
  final String text;
  const commonText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textLightGrey,
        fontWeight: FontWeight.w100,
        fontSize: 15.6,
      ),
    );
  }
}

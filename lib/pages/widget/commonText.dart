import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonText extends StatelessWidget {
  final String text;
  const CommonText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: lightGrey,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}

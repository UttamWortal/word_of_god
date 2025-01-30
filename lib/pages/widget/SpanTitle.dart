import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:google_fonts/google_fonts.dart';

class SpanTitle extends StatelessWidget {
  final String mainTitle;
  final String subTitle;
  const SpanTitle({
    super.key,
    required this.mainTitle,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: mainTitle,
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
          TextSpan(
            text: subTitle,
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: blue,
            ),
          ),
        ],
      ),
    );
  }
}

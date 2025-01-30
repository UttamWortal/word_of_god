import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    return Container(
      width: size * 0.2,
      height: size * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: blue,
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? align;

  const AppText(
      {super.key,
      required this.text,
      this.fontSize = 16.0,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: align,
    );
  }
}

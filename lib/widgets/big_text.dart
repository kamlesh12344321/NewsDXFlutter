import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final String text;
  double? size = 16;
  Color? color = Colors.black12;
  double? wordSpacing = 2.0;

  BigText(this.size, this.color, this.wordSpacing, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style : GoogleFonts.roboto(
        fontWeight: FontWeight.w500,
        fontSize: size,
        color: color,
      ),
      maxLines: 3,
    );
  }
}

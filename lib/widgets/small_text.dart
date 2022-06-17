import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String? text;
  double? size = 14;
  Color? color = Colors.black12;
  double? wordSpacing = 2.0;

  SmallText(
      this.text, this.size, this.color, this.wordSpacing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: size,
        wordSpacing: wordSpacing,
        fontFamily: "FiraSans"
      ),
    );
  }
}

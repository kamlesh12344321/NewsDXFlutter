import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsdx/utils/CustomColors.dart';

class SmallIconArticle extends StatelessWidget{
  String? imagePath;
  double? height;
  double? width;


  SmallIconArticle(this.imagePath, this.height, this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: Container(
          child: SvgPicture.asset(imagePath!),
          decoration: const BoxDecoration(
            color: CustomColors.topPicksSection,
          ),
        ),
      ),
    );
  }
}
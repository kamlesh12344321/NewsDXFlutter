import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PoweredByAdsWidget extends StatelessWidget {
  const PoweredByAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 90,
        decoration: const BoxDecoration(
          color: Color(0xffE1EBFA),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("This App is Powered by", style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w300
              ),),
              SvgPicture.asset("assets/powered_news.svg")
            ],
          ),
        )
      ),
    );
  }
}

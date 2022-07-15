import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants/string_constant.dart';
import '../widgets/app_bar.dart';

class ThanksForSubscribeWidget extends StatefulWidget {
  const ThanksForSubscribeWidget({Key? key}) : super(key: key);

  @override
  State<ThanksForSubscribeWidget> createState() => _ThanksForSubscribeWidgetState();
}

class _ThanksForSubscribeWidgetState extends State<ThanksForSubscribeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(MyConstant.noTitle),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 21,
                    ),
                    child: SizedBox(
                      height: 37,
                      width: 39,
                      child: SvgPicture.asset("assets/app_logo_new.svg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 21,
                    ),
                    child: Column(
                      children: [
                        Text(
                          MyConstant.appName,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Text(
                          MyConstant.appType,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
               Padding(
                padding:
                const EdgeInsets.only(left: 16.0, top: 14.0, right: 0.0, bottom: 0.0),
                child: Text(
                  "Thank you\nfor Subscribing",
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                  ),
                ),
              ),
               Padding(
                padding:
                const EdgeInsets.only(left: 16.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: Text(
                  "We assure , you have\na great journal",
                  style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87
                  ),
                ),
              ),
              Padding(
                padding:
                 const EdgeInsets.only(left: 16.0, top: 10.0, right: 0.0, bottom: 0.0),
                  child:  SvgPicture.asset("assets/subs_big", height: 400, width: double.infinity,),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Column(
                      children: [
                        Text(MyConstant.signInScreenPrivacyPolicy, style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87
                        ),),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(MyConstant.tcTitle, style: GoogleFonts.roboto(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 40,
                          ),
                          transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                          child: Text(
                            MyConstant.poweredBy,
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SvgPicture.asset("assets/powered_news.svg")
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

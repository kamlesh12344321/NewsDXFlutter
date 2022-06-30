import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _initialized = false;
  late AppState appState;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0,0.0),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/app_logo_new.svg"),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          MyConstant.appName,
                          style: GoogleFonts.roboto(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          MyConstant.appType,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
             Align(
              alignment: const AlignmentDirectional(-0.02, 0.92),
               child: SizedBox(
                 height: 60,
                 width: double.infinity,
                 child:  Column(
                   children: [
                     Container(
                       margin: const EdgeInsets.only(right: 40,),
                      transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                       child:  Text(MyConstant.poweredBy,
                         style: GoogleFonts.roboto(
                           fontSize: 13,
                           fontWeight: FontWeight.w400,
                         ),),
                     ),
                     SvgPicture.asset("assets/powered_news.svg")
                   ],
                 ),
               )
            )
          ],
        ),
      )
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      Timer(const Duration(milliseconds: 2000), () {
        appState.setSplashFinished();
      });
    }
  }
}

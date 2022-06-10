
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/screens/home_screen.dart';
import 'package:newsdx/widgets/app_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
        appBar: AppBarWidget(MyConstant.noTitle),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
            children: [
              Row(
                children: [
                   Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 10,
                    ),
                    child: SizedBox(
                      height: 37,
                      width: 37,
                      child: SvgPicture.asset("assets/app_logo_new.svg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 10,
                    ),
                    child: Column(
                      children: const [
                        Text(
                          MyConstant.appName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          MyConstant.appType,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 0.0, bottom: 10.0),
                  child: Text(
                    MyConstant.loginScreenTitle,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, top: 0.0, right: 0.0, bottom: 10.0),
                  child: Text(
                    MyConstant.loginScreenSubTitle,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 0.0, bottom: 10.0),
                  child: Text(
                    MyConstant.otpTitle,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 0.0, right: 16.0, bottom: 10.0),
                  child: PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.black,
                      borderWidth: 1.0,
                      selectedFillColor: Colors.white
                    ),
                    animationDuration: const Duration(microseconds: 500),
                    backgroundColor: Colors.white,
                    enableActiveFill: true,
                    autoFocus: true,
                    onCompleted: (V){
                    },
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    }, appContext: context,
                    )
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 0.0, right: 0.0, bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      Text(MyConstant.otp_sent,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),),
                      Text(MyConstant.otp_mail_id,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 16.0, bottom: 10.0),
                  child: TextButton(
                    onPressed: () {},
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      child: const Text(MyConstant.verifyButtonTitle),
                      onPressed: () {
                        appState.currentAction = PageAction(
                            state: PageState.replaceAll,
                            widget: const HomeScreen(),
                            page: HomePageConfig);
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 260,
              ),
               Align(
                 alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                       Container(
                         margin: const EdgeInsets.only(right: 50, ),
                         child: Text( MyConstant.poweredBy,
                           style:GoogleFonts.lato(
                             textStyle: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 12,
                                 fontWeight: FontWeight.w500),
                           ),),
                       ),
                      SvgPicture.asset("assets/powered_news.svg")
                    ],
                  ),
                ),
              ),
            ],
          ),
      );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return SizedBox(
      height: 50,
      width: 50,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/model/user_data.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/screens/home_screen.dart';
import 'package:newsdx/screens/otp_screen.dart';
import 'package:newsdx/widgets/app_bar.dart';
import 'package:newsdx/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ChangeNotifier {
  late final User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController myController = TextEditingController();
  String? email = "";

  @override
  void initState() {
    myController.addListener(() {
      email = myController.text;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(MyConstant.noTitle),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 14.0, right: 0.0, bottom: 0.0),
                    child: Text(
                      MyConstant.loginScreenTitle,
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: .5,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 10.0, right: 0.0, bottom: 0.0),
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
                        left: 16.0, top: 16.0, right: 0.0, bottom: 0.0),
                    child: Text(
                      MyConstant.emailErrorMsg,
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
                        left: 16.0, top: 5.0, right: 16.0, bottom: 0.0),
                    child: TextField(
                      controller: myController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(MyConstant.emailHint),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 18.0, right: 16.0, bottom: 0.0),
                    child: TextButton(
                      onPressed: () {},
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(MyConstant.signInButtonTitle),
                        onPressed: () {
                          if (email!.isNotEmpty) {
                          bool? isLogged = Prefs.getIsLoggedIn();

                          }
                          appState.currentAction = PageAction(
                              state: PageState.addWidget,
                              widget: const OTPScreen(),
                              page: OtpPageConfig);
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 17.0, right: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset("assets/line.png"),
                        const Text("or"),
                        Image.asset("assets/line.png"),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 15.0, right: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              Future<UserCredential> signIn =
                              signInWithGoogle();
                              signIn
                                  .then((value) =>
                              {
                                if (value.user != null)
                                  {
                                    appState.login(true),
                                  }
                              })
                                  .onError((error, stackTrace) =>
                              {
                                // show snakeBar
                              });
                            },
                            child:
                            SvgPicture.asset("assets/google_logo_new.svg")),
                        TextButton(
                            onPressed: () {
                              Future<UserCredential?> signIn =
                              signInWithFacebook();
                              signIn
                                  .then((value) =>
                              {
                                if (value?.user != null)
                                  {
                                    appState.login(true),
                                  }
                              })
                                  .onError((error, stackTrace) =>
                              {
                                // show snakeBar
                              });
                            },
                            child: Image.asset("assets/facebook.png")),
                        TextButton(
                            onPressed: () {},
                            child: Image.asset("assets/apple.png")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: const AlignmentDirectional(-0.02, 0.92),
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Column(
                  children: const [
                    Text(MyConstant.signInScreenPrivacyPolicy),
                    SizedBox(
                      height: 10,
                    ),
                    Text(MyConstant.tcTitle),
                  ],
                ),
              ),
            ),
            Align(
                alignment: const AlignmentDirectional(-0.02, 0.92),
                child: SizedBox(
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
                ))
          ],
        ),
      ),
    );
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email', 'user_friends']
    );
    if(result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/app_constants/string_constant.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: Transform.scale(
            scale: 1.2,
            child: IconButton(
                icon: SvgPicture.asset("assets/back.svg"), onPressed: () {}),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Transform.scale(
              scale: 1,
              child: SvgPicture.asset("assets/profile_placeholder.svg"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16),
              child: Row(
                children: [
                  SvgPicture.asset("assets/more.svg", height: 20, width: 20,),
                  const Text(" More", style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    color: Colors.black
                  ),),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Notification", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),),
                    SvgPicture.asset("assets/profile_placeholder.svg")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ],
            ),),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dark mode", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),),
                    SvgPicture.asset("assets/profile_placeholder.svg")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ],
            ),),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Personalise myFeed", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),),
                    SvgPicture.asset("assets/forward.svg")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ],
            ),),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("GDPR", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),),
                    SvgPicture.asset("assets/forward.svg")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ],
            ),),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Text to Speech ", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),),
                    SvgPicture.asset("assets/forward.svg")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ],
            ),),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                     children: [
                       const Text("Notifications", style: TextStyle(
                         color: Colors.grey,
                         fontSize: 16,
                       ),),
                       const SizedBox(
                         width: 4,
                       ),
                       SvgPicture.asset("assets/dot.svg"),
                     ],
                   ),
                   Row(
                     children: [
                       const Text("200 unread",
                       style: TextStyle(
                         color: Colors.grey,
                         fontSize: 14
                       ),),
                       const SizedBox(
                         width: 5,
                       ),
                       SvgPicture.asset("assets/forward.svg"),
                     ],
                   ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ],
            ),),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text("Bookmark", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),),
                        const SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset("assets/dot.svg"),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("200 unread",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14
                          ),),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset("assets/forward.svg"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                )
              ],
            ),),
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 150),
                    child: SizedBox(
                      width: 75,
                      height: 20 ,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text("Version "),
                                Text("1.0.1", style: TextStyle(
                                    color: Colors.blue
                                ),)

                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                Padding(padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 300,
                      height: 50 ,
                      child: Center(
                        child: Column(
                          children: const [
                            Text("For support contact"),
                            Text("wecare@alpinenews.com", style: TextStyle(
                                color: Colors.blue
                            ),),
                          ],
                        ),
                      ),
                    )
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
            )
          ],
        ),
      ),
    );
  }
}

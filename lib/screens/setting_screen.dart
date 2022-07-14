import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/bookmark/bookmark.dart';
import 'package:newsdx/screens/notificaton_screen.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

import '../bookmark/model/bookmark_article.dart';
import '../database/data_helper.dart';
import '../objectbox.g.dart';
import '../userprofile/user_profile_info_screen.dart';
import 'login_screen.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Transform.scale(
                scale: 1,
                child:   CircleAvatar(
                  backgroundImage: Prefs.getIsLoggedIn() == true ?
                  NetworkImage(Prefs.getUserImageUrlInfo()!) : const NetworkImage('https://newsdx.io/assets/others/carbon_user-avatar-filled.svg') ,
                  radius: 15,
                ),
              ),
              onPressed: () {
                if(Prefs.getIsLoggedIn() == true){
                  appState.currentAction = PageAction(
                      state: PageState.addWidget,
                      widget: const UserProfileInfoScreen(),
                      page: UserProfileInfoPageConfig);
                } else{
                  appState.currentAction = PageAction(
                      state: PageState.addWidget,
                      widget: const LoginScreen(),
                      page: LoginPageConfig);
                }
              },
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
                   Text(" More", style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                     fontSize: 30,
                  ),),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("Notification", style: GoogleFonts.roboto(
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: Colors.black54
                     ),),
                    GFToggle(
                      onChanged: (val){},
                      value: true,
                      enabledTrackColor: Colors.blue,
                      type: GFToggleType.ios,
                    )
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
                GestureDetector(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text("Dark mode", style:  GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54
                      ),),
                      GFToggle(
                        onChanged: (val){},
                        value: true,
                        enabledTrackColor: Colors.blue,
                        type: GFToggleType.ios,
                      )
                    ],
                  ),
                  onTap: (){
                    ThemeProvider.controllerOf(context).nextTheme();
                  },
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
            // Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const Text("Personalise myFeed", style: TextStyle(
            //           color: Colors.grey,
            //           fontSize: 16,
            //         ),),
            //         SvgPicture.asset("assets/forward.svg")
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //
            //     Container(
            //       height: 1,
            //       width: double.infinity,
            //       color: Colors.grey,
            //     )
            //   ],
            // ),),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("GDPR", style:  GoogleFonts.roboto(
                         fontSize: 16,
                         fontWeight: FontWeight.w400,
                         color: Colors.black54
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
                     Text("Text to Speech ", style:  GoogleFonts.roboto(
                         fontSize: 16,
                         fontWeight: FontWeight.w400,
                         color: Colors.black54
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
            InkWell(
              onTap: (){
                appState.currentAction = PageAction(
                    state: PageState.addWidget,
                    widget: const NotificationScreen(),
                    page: NotificationPageConfig);
              },
              child: Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children:  [
                          Text("Notifications", style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54
                          ),),
                          const SizedBox(
                            width: 4,
                          ),
                          // SvgPicture.asset("assets/dot.svg"),
                        ],
                      ),
                      Row(
                        children: [
                          // 200 unread can be added notification
                           Text("",
                            style:  GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54
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
            ),
           InkWell(
             onTap: (){
               appState.currentAction = PageAction(
                   state: PageState.addWidget,
                   widget:  BookMarks(
                     bookmarkArticleIdList : bookMarkList(),
                   ),
                   page: BookMarkPageConfig);
             },
             child:  Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20), child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       children:  [
                         Text("Bookmark", style:  GoogleFonts.roboto(
                             fontSize: 16,
                             fontWeight: FontWeight.w400,
                             color: Colors.black54
                         ),),
                         const SizedBox(
                           width: 4,
                         ),
                         // SvgPicture.asset("assets/dot.svg"),
                       ],
                     ),
                     Row(
                       children: [
                         // 200 unread can be added for bookmark
                          Text("",
                           style:  GoogleFonts.roboto(
                               fontSize: 16,
                               fontWeight: FontWeight.w400,
                               color: Colors.black54
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
               ],
             ),),
           ),
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 110),
                    child: SizedBox(
                      width: 80,
                      height: 20 ,
                      child: Center(
                        child: Column(
                          children: [
                           FittedBox(
                             child:  Row(
                               children:  [
                                 Text("Version ", style:  GoogleFonts.roboto(
                                     fontSize: 16,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.black54
                                 ),),
                                 Text("1.0.1", style:  GoogleFonts.roboto(
                                     fontSize: 16,
                                     fontWeight: FontWeight.w400,
                                     color: Colors.blueAccent
                                 ),)

                               ],
                             ),
                           )
                          ],
                        ),
                      ),
                    )
                ),
                Padding(padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: SizedBox(
                      width: 300,
                      height: 50 ,
                      child: Center(
                        child: Column(
                          children:  [
                            Text("For support contact", style:  GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54
                            ),),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("wecare@alpinenews.com", style:  GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.blueAccent
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

  String bookMarkList() {
    String articleIdList = "";

    List<BookMarkArticleModel>? data =  Helpers.getAllBookmarkList();

    if (data?.length == 0) {
      return articleIdList;
    } else {
      for (int i = 0 ; i < data!.length ; i++) {
        if ( i == 0) {
          articleIdList = data[i].articleId;
        }  else {
          articleIdList = data[i].articleId+","+articleIdList;
        }
      }
      return articleIdList;
    }
  }
}

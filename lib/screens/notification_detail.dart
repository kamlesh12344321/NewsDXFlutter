import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:newsdx/model/article_detail_pojo.dart';
import 'package:newsdx/widgets/common_toolbar.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../app_constants/string_constant.dart';
import '../model/SectionPojo.dart';
import 'package:http/http.dart' as http;

import '../shared/shared_method.dart';
import '../widgets/article_detail_fullimage.dart';


class NotificationArticleDetailScreen extends StatefulWidget {
   String? articleIdFromNotification;
   NotificationArticleDetailScreen({Key? key,  this.articleIdFromNotification}) : super(key: key);

  @override
  State<NotificationArticleDetailScreen> createState() => _NotificationArticleDetailScreenState();
}

class _NotificationArticleDetailScreenState extends State<NotificationArticleDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticleDetailPojo>(
        future: getArticleFromNotification(widget.articleIdFromNotification),
        builder: (context, snapshot){
          if(snapshot.hasData){
            TextToSpeech tts = TextToSpeech();
            String? _timestamp =
                snapshot.data!.dATA!.pUBLISHDATE;
               var _convertedTimestamp =
               DateTime.parse(_timestamp!);

            var result = GetTimeAgo.parse(_convertedTimestamp);
            bool isSpeaking = false;
            String? imageId = "";
            if (snapshot.data?.dATA?.iMAGES?.length == 0) {
              imageId = "";
            } else {
              imageId = snapshot.data?.dATA?.iMAGES?[0].iMAGEID;
            }
            bool? isPremium = snapshot.data?.dATA?.premium;
            if (isPremium == true) {
              showMaterialModalBottomSheet(
                  context: context,
                  expand: false,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      (Colors.transparent.withAlpha(0)),
                                      Colors.transparent.withAlpha(10)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )),
                            ),
                            Text(
                              "Read Premium Content",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Center(
                                  child: Text(
                                    "You will get access to all the premium and personalised contents with AD free experience",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Starts at 10.99/month",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text("View Plans"),
                              onPressed: () {
                                // appState.currentAction = PageAction(
                                //     state: PageState.addWidget,
                                //     widget: const SubscriptionPlanScreen(),
                                //     page: SubscriptionPlanPageConfig);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Already  Subscribed ? ",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.blueAccent,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              "For support contact",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "wecare@alpinenews.com ",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                color: Colors.blueAccent,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return  Scaffold(
              appBar: const CommonToolbar( title: '',),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 16, left: 16),
                                child: CircleAvatar(
                                  backgroundColor: Colors.brown,
                                  child: Text(
                                    "A",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text("Kailash"),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Transform.scale(
                                  scale: 1,
                                  child: IconButton(
                                      icon: SvgPicture.asset("assets/share.svg"),
                                      onPressed: () {
                                        Shared.onArticleShare(context,
                                            snapshot.data!.dATA!.tITLE!,
                                            snapshot.data!.dATA!.lINK!);
                                      })),
                              Transform.scale(
                                scale: 1,
                                child: IconButton(
                                  icon:
                                  // widget.bookmarkStatus!
                                  //     ? SvgPicture.asset("assets/bookmark_filled.svg")
                                  //     :
                                  SvgPicture.asset("assets/bi_bookmark.svg"),
                                  onPressed: () {
                                    // setState(() {
                                    //   if( widget.bookmarkStatus == true){
                                    //     widget.bookmarkStatus = false;
                                    //   } else {
                                    //     widget.bookmarkStatus = true;
                                    //   }
                                    // });
                                    // onBookmark(widget.articleItem!.articleid!);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isSpeaking) {
                                isSpeaking = false;
                                tts.stop();
                              } else {
                                isSpeaking = true;
                                tts.speak(
                                    removeAllHtmlTags(snapshot.data?.dATA?.dESCRIPTION) ?? "");
                              }
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SvgPicture.asset(
                                "assets/speaker.svg",
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              snapshot.data!.dATA!.tITLE ?? "",
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          result,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 16, right: 16, bottom: 5),
                      child: FullImageViewItemG(
                        articleImage: imageId,
                      ),
                    ),
                    // Text( articleItem?.images?[0].caption ?? ""),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Html(
                        data: "<div>" + snapshot.data!.dATA!.dESCRIPTION! + "</div>,",

                      ),
                    ),
                  ],
                ),
              )
            );

          } else if(snapshot.hasError){
            return  const Scaffold(
              appBar: CommonToolbar( title: '',),
            );

          } else {
            return const Center(child: CircularProgressIndicator());
          }

    });
  }
  String? removeAllHtmlTags(String? htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText?.replaceAll(exp, '');
  }

  Future<ArticleDetailPojo> getArticleFromNotification(String? articleId) async {
    String? getAccessToken = MyConstant.propertyToken;
    var url = Uri.parse(MyConstant.articleDetail);
    final response = await http.post(
      url,
      body: {"articleId": articleId},
      headers: {
        "Authorization": getAccessToken,
      },
    );
    ArticleDetailPojo articleDetailPojo = modelClassFromJson(response.body);
    return articleDetailPojo;
  }
  ArticleDetailPojo modelClassFromJson(String str) =>
      ArticleDetailPojo.fromJson(jsonDecode(str));
}

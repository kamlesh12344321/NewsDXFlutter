import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/subscription/subscriprtion_plan_screen.dart';
import 'package:newsdx/widgets/article_detail_fullimage.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../bookmark/model/bookmark_article.dart';
import '../database/data_helper.dart';
import '../objectbox.g.dart';
import '../shared/shared_method.dart';

class ArticleDetail extends StatefulWidget {
  final Articles? articleItem;

  bool? bookmarkStatus;
  Function? callbackBookMark;
  int? row_index;

  ArticleDetail({
    Key? key,
    this.articleItem,
    this.bookmarkStatus,
    this.callbackBookMark,
    this.row_index
  }) : super(key: key);

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {

  late String articleId;
  late String bookmarkStatus;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    TextToSpeech tts = TextToSpeech();
    double volume = 1.0;
    String? _timestamp =
        widget.articleItem!.publishdate; // [DateTime] formatted as String.
    var _convertedTimestamp =
        DateTime.parse(_timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(_convertedTimestamp);
    double _height = 1;
    bool isSpeaking = false;
    String? imageId = "";
    if (widget.articleItem?.images?.length == 0) {
      imageId = "";
    } else {
      imageId = widget.articleItem!.images![0].imageid;
    }
    bool? isPremium = widget.articleItem!.premium;
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
                        appState.currentAction = PageAction(
                            state: PageState.addWidget,
                            widget: const SubscriptionPlanScreen(),
                            page: SubscriptionPlanPageConfig);
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          leading: Transform.scale(
            scale: 1.2,
            child: IconButton(
                icon: SvgPicture.asset("assets/back.svg"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          title: Transform.scale(
            scale: 1,
            child: SvgPicture.asset("assets/app_log.svg"),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Transform.scale(
                scale: 1,
                child: SvgPicture.asset("assets/profile_placeholder.svg"),
              ),
            ),
          ],
        ),
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
                                      widget.articleItem!.title!,
                                      widget.articleItem!.link!);
                                })),
                        Transform.scale(
                            scale: 1,
                            child: IconButton(
                              icon:  widget.bookmarkStatus!
                                  ? SvgPicture.asset("assets/bookmark_filled.svg")
                                  : SvgPicture.asset("assets/bi_bookmark.svg"),
                              onPressed: () {
                                setState(() {
                                  if( widget.bookmarkStatus == true){
                                    widget.bookmarkStatus = false;
                                    bookmarkStatus = "Remove";
                                  } else {
                                    widget.bookmarkStatus = true;
                                    bookmarkStatus = "Add";
                                  }
                                });
                                onBookmark(widget.articleItem!.articleid!);
                                articleId =  widget.articleItem!.articleid!;
                                Prefs.saveBookMarkArticleId(widget.articleItem!.articleid!);
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
                              removeAllHtmlTags(widget.articleItem!.descpart1!) ?? "");
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
                        widget.articleItem?.title ?? "",
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
                  data: widget.articleItem?.descpart1,
                  //     style: {
                  //   "body" : Style(
                  //     fontSize: FontSize(18.0),
                  //     fontWeight: FontWeight.w300,
                  //     fontFamily: "Roboto",
                  //     height: 1.4,
                  //   )
                  // },
                ),
              ),
            ],
          ),
        ));
  }

  String? removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }


  void onBookmark(String articleId) {

    var result = Helpers.queryArticleId(articleId);
    result.then((value) => {
      if (value!.length == 0)
        {
          Helpers.insert(BookMarkArticleModel(articleId: articleId)),
          debugPrint("Bookmark Result added $articleId"),
        }
      else
        {
          Helpers.delete(articleId),
          debugPrint("Bookmark Result remove "+value.first.articleId),
        }
    });

    setState(() {});
  }


  @override
  void dispose() {
    widget.callbackBookMark!(articleId,bookmarkStatus,widget.row_index);
  }
}

class FadingEffect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
    LinearGradient lg = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          //create 2 white colors, one transparent
          Color.fromARGB(0, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255)
        ]);
    Paint paint = Paint()..shader = lg.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(FadingEffect linePainter) => false;


}

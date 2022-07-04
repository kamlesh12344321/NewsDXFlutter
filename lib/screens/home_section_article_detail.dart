import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/widgets/article_detail_fullimage.dart';
import 'package:text_to_speech/text_to_speech.dart';

import '../bookmark/model/bookmark_article.dart';
import '../objectbox.g.dart';
import '../shared/shared_method.dart';
import 'package:path_provider/path_provider.dart';


class HomeSectionArticleDetail extends StatefulWidget {
  final HomeArticle? homeArticle;
  const HomeSectionArticleDetail({Key? key,this.homeArticle}) : super(key: key);

  @override
  State<HomeSectionArticleDetail> createState() => _HomeSectionArticleDetailState();
}

class _HomeSectionArticleDetailState extends State<HomeSectionArticleDetail> {
  Store? _store;
  Box<BookMarkArticleModel>? orderBox;
  late BookMarkArticleModel bookMarkArticleModel;

  @override
  void initState() {
    super.initState();
    openStore().then((Store store) {
      _store = store;
      orderBox = store.box<BookMarkArticleModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isBookMarkState = false;
    TextToSpeech tts = TextToSpeech();
    double volume = 1.0;
    String? _timestamp = widget.homeArticle?.publishDate.toString(); // [DateTime] formatted as String.
    var _convertedTimestamp = DateTime.parse(_timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(_convertedTimestamp);
    double _height = 1;
    bool isSpeaking = false;
    String imageId = "";
    if(widget.homeArticle?.images.length == 0){
      imageId = "";
    } else{
      imageId = widget.homeArticle!.images[0].imageId;
    }

    // onBookmark();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          leading: Transform.scale(
            scale: 1.2,
            child: IconButton(
                icon: SvgPicture.asset("assets/back.svg"), onPressed: () {
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
                children:  [
                  Container(
                    child: Row(
                      children: const [ Padding(
                        padding: EdgeInsets.only(top: 16, left: 16),
                        child: CircleAvatar(
                          backgroundColor: Colors.brown,
                          child: Text(
                            "A",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                        Padding(padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text("Kailash"),),],
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
                                  widget.homeArticle?.title ?? "",
                                  widget.homeArticle?.link ?? "");
                            })),
                        Transform.scale( // 8296545235
                            scale: 1,
                            child: IconButton(
                                icon:  isBookMarkState ? SvgPicture.asset("assets/bi_bookmark.svg") : SvgPicture.asset("assets/bi_bookmark.svg") , onPressed: () {
                                  setState((){
                                    isBookMarkState = !isBookMarkState;
                                  });
                                  onBookmark();
                            }))
                      ],
                    ),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10, left: 16, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: ()  {
                        if(isSpeaking){
                          isSpeaking  = false;
                          tts.stop();
                        } else {
                          isSpeaking  = true;
                          tts.speak(removeAllHtmlTags(widget.homeArticle!.descPart1) ?? "");
                        }
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child :SvgPicture.asset("assets/speaker.svg", height: 20,width: 20,),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(widget.homeArticle!.title ?? "", style: GoogleFonts.roboto(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),),
                    ),
                  ],
                ),),
              Padding(padding: const EdgeInsets.only(left: 16, top: 10),child: Align(
                alignment: Alignment.topLeft,
                child: Text(result,),
              ),),
              Padding(padding: const EdgeInsets.only(top: 10, left: 16, right: 16,bottom: 5), child:
              FullImageViewItemG(articleImage: imageId,),),
              // // Text( articleItem?.images?[0].caption ?? ""),
              Padding(padding: const EdgeInsets.only(left: 16, right: 16,), child: Html(data: widget.homeArticle?.descPart1,
              //   style: {
              //   "data": Style(
              //     fontWeight: FontWeight.w300,
              //     fontSize: const FontSize(18.0),
              //     fontFamily: "Roboto",
              //     height: 1.4,
              //   )
              // },
              ),),
            ],
          ),
        )
    );
  }

  String? removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }

  @override
  void dispose() {
    _store?.close();
    super.dispose();
  }

  void onBookmark() {
    final query = orderBox
        ?.query(BookMarkArticleModel_.articleId
            .equals(widget.homeArticle!.articleId))
        .build();
    final people = query?.find();
    debugPrint(people.toString());
    if (people!.length == 0) {
      onAddBookMark();
    } else {
      onRemoveBookMark(people.first.id);
    }
    setState(() {});
  }

  void onAddBookMark() {
    bookMarkArticleModel =
        BookMarkArticleModel(articleId: widget.homeArticle!.articleId);
    int id = orderBox!.put(bookMarkArticleModel);
    debugPrint("kk id -> $id");
  }

  void onRemoveBookMark(int id) {
    orderBox!.remove(id);
  }
}
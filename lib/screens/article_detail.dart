import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/utils/bookmark_method.dart';
import 'package:newsdx/widgets/article_detail_fullimage.dart';
import 'package:newsdx/widgets/full_image_view_item.dart';
import 'package:text_to_speech/text_to_speech.dart';

import '../model/bookmark_article_list.dart';
import '../utils/shared_method.dart';


class ArticleDetail extends StatelessWidget {
  final Articles? articleItem;

  const ArticleDetail({Key? key, this.articleItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextToSpeech tts = TextToSpeech();
    double volume = 1.0;
    String? _timestamp = articleItem!.publishdate; // [DateTime] formatted as String.
    var _convertedTimestamp = DateTime.parse(_timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(_convertedTimestamp);
    double _height = 1;
    bool isSpeaking = false;
    return Scaffold(
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
                              icon: SvgPicture.asset("assets/share.svg"), onPressed: () {
                            Shared.onArticleShare(context,
                                articleItem!.title!,
                                articleItem!.link!);
                          })),
                      Transform.scale(
                          scale: 1,
                          child: IconButton(
                              icon: SvgPicture.asset("assets/bi_bookmark.svg"), onPressed: () async{
                                var addBookMark = BookmarkedArticleList(articleId: articleItem!.articleid!);
                            int id = await BookMark.onAddBookMark(addBookMark);
                                int cont = 0;
                                await BookMark.onAllBookMark().then((value) => {
                                  cont = value.length
                                });
                                print("Sucessfull inserted an $cont object with $id");
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
                     tts.speak(removeAllHtmlTags(articleItem!.descpart1!) ?? "");
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
                  child: Text(articleItem?.title ?? "", style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                  ),),
                ),
              ],
            ),),
            Padding(padding: const EdgeInsets.only(left: 16, top: 10),child: Align(
              alignment: Alignment.topLeft,
              child: Text(result,),
            ),),
            Padding(padding: const EdgeInsets.only(top: 10, left: 16, right: 16,bottom: 5), child:
              FullImageViewItemG(article: articleItem,),),
            // Text( articleItem?.images?[0].caption ?? ""),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16,), child: Html(data: articleItem?.descpart1),),
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

}

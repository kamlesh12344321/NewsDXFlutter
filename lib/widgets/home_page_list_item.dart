import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/model/bookmark_article_list.dart';
import 'package:newsdx/preference/user_preference.dart';import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_icon_article.dart';
import 'package:newsdx/widgets/small_text.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../utils/bookmark_method.dart';
import '../utils/shared_method.dart';


class HomePageListItem extends StatefulWidget {
  final Articles? articleItem;
  HomePageListItem({required this.articleItem});

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {
  late bool? bookmarked_local = false;
  @override
  Widget build(BuildContext context) {
    String imageUrl = "";
    String? _timestamp = widget.articleItem!.publishdate; // [DateTime] formatted as String.
    var _convertedTimestamp = DateTime.parse(_timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(_convertedTimestamp);

    if(widget.articleItem!.images!.isNotEmpty) {
       imageUrl = "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.articleItem?.images?[0].imageid}_100.jpg";
    } else{
      imageUrl = "https://via.placeholder.com/600x340";
    }
    return Container(
      width: double.infinity,
      height: 112,
      margin: const EdgeInsets.only(top: 12, bottom: 12, left: 0 , right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                SizedBox(
                  width: 149.0,
                  height: 112.0,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 149.0,
                      height: 112.0,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: widget.articleItem?.premium == true ? SvgPicture.asset("assets/dot.svg") : Container(child: Text(""),),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(16, Colors.black, 1, widget.articleItem?.title ?? ""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText(result , 12, Colors.black, 1.0),
                      ],
                    ),
                    Row(
                      children: [
                         InkWell(
                           child:  SvgPicture.asset("assets/share.svg"),
                           onTap: (){
                             Shared.onArticleShare(context,
                                 widget.articleItem!.title!,
                                 widget.articleItem!.link!);
                           },
                         ),
                         const SizedBox(
                          width: 18,
                          height: 17,
                        ),
                       InkWell(
                         child: bookmarked_local== true ? SvgPicture.asset("assets/bookmark_filled.svg") : SvgPicture.asset("assets/bi_bookmark.svg"),
                         onTap: () async{
                           var addBookMark = BookmarkedArticleList(articleId: widget.articleItem!.articleid!);
                           int id = await BookMark.onAddBookMark(addBookMark);
                           int cont = 0;
                           await BookMark.onAllBookMark().then((value) => {
                              cont = value.length
                           });
                           print("Sucessfull inserted an $cont object with $id");
                           /*String articleId = widget.articleItem?.articleid ?? "";
                           List<String>? artiList = <String>[];
                           artiList.add(articleId);
                           Prefs.saveArticleBookedList(artiList);
                           widget.articleItem?.bookmarked == true;
                           setState(() {
                             bookmarked_local == true;
                           });*/

                         },
                       ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

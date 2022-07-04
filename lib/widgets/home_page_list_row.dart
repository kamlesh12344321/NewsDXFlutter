import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/small_icon_article.dart';
import 'package:newsdx/widgets/small_text.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../bookmark/bookmark_method.dart';
import '../bookmark/model/bookmark_article.dart';
import '../objectbox.g.dart';
import '../shared/shared_method.dart';


class HomePageListItem extends StatefulWidget {
  final Articles? articleItem;
  HomePageListItem({required this.articleItem});

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {
  bool selected = false;

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



    String imageUrl = "";
    String? _timestamp =
        widget.articleItem!.publishdate; // [DateTime] formatted as String.
    var _convertedTimestamp =
        DateTime.parse(_timestamp!); // Converting into [DateTime] object
    var result = GetTimeAgo.parse(_convertedTimestamp);

    if (widget.articleItem!.images!.isNotEmpty) {
      imageUrl =
          "https://ndxv3.s3.ap-south-1.amazonaws.com/${widget.articleItem?.images?[0].imageid}_100.jpg";
    } else {
      imageUrl = "https://via.placeholder.com/600x340";
    }

    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                SizedBox(
                  width: 149.0,
                  height: 100.0,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 149.0,
                      height: 100.0,
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
                BigText(14, Colors.black, 1, widget.articleItem?.title ?? ""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText(result, 12, Colors.black, 1.0),
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
                          width: 14,
                          height: 17,
                        ),
                        IconButton(
                          icon: selected
                              ? SvgPicture.asset("assets/bookmark_filled.svg")
                              : SvgPicture.asset("assets/bi_bookmark.svg"),
                          onPressed: () {
                            // widget.articleItem?.bookmarked == true;
                            onBookmark(widget.articleItem!.articleid!);
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

  @override
  void dispose() {
    _store?.close();
    super.dispose();
  }

  void onBookmark(String articleId) {
    final query = orderBox
        ?.query(BookMarkArticleModel_.articleId.equals(articleId))
        .build();

    final people = query?.find();

    debugPrint(people.toString());
    if (people!.length == 0) {
      setState(() {
        selected = !selected;
      });
      onAddBookMark(articleId);
    } else {
      setState(() {
        selected = !selected;
      });
      onRemoveBookMark(people.first.id);
    }
    setState(() {});
  }

  void onAddBookMark(String articleId) {
    bookMarkArticleModel = BookMarkArticleModel(articleId: articleId);
    int id = orderBox!.put(bookMarkArticleModel);
    debugPrint("kk id -> $id");
  }

  void onRemoveBookMark(int id) {
    orderBox!.remove(id);
  }
}

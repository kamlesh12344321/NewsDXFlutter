import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/bookmark/model/bookmark_article.dart';
import 'package:newsdx/objectbox.g.dart';
import 'package:newsdx/widgets/app_bar.dart';
import 'package:newsdx/bookmark/bookmarkList.dart';
import 'package:newsdx/bookmark/empty_bookmark.dart';
class BookMarks extends StatefulWidget {

  String? bookmarkArticleIdList;
  Box<BookMarkArticleModel>? bookmarkBox;
  BookMarkArticleModel? bookMarkArticleModel;

  BookMarks({Key? key,
  this.bookmarkArticleIdList,
  this.bookmarkBox,
  this.bookMarkArticleModel}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {

  @override
  Widget build(BuildContext context) {

   bool showScree = false;
    if( widget.bookmarkArticleIdList != "") {
      showScree = true;
    }

    return Scaffold(
      appBar: AppBarWidget(MyConstant.noTitle,),
      body: showScree
          ? BookMarkFilledContainer(bookmarkArticleList: widget.bookmarkArticleIdList,
          bookmarkBox: widget.bookmarkBox,
          bookMarkArticleModel : widget.bookMarkArticleModel
      )
          : EmptyBookMarkContainer()
    );
  }

  void onBookmark(String articleId) {
    final query = widget.bookmarkBox
        ?.query(BookMarkArticleModel_.articleId.equals(articleId))
        .build();
    final bookMarkArtilce = query?.find();
    onRemoveBookMark(bookMarkArtilce!.first.id);
    setState(() {});
  }

  void onRemoveBookMark(int id) {
    widget.bookmarkBox?.remove(id);
  }
}

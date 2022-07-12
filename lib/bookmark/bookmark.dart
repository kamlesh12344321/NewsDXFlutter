import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/widgets/app_bar.dart';
import 'package:newsdx/bookmark/bookmarkList.dart';
import 'package:newsdx/bookmark/empty_bookmark.dart';
class BookMarks extends StatefulWidget {

  String? bookmarkArticleIdList;

  BookMarks({Key? key,
  this.bookmarkArticleIdList}) : super(key: key);

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
          ? BookMarkFilledContainer(bookmarkArticleList: widget.bookmarkArticleIdList
      )
          : EmptyBookMarkContainer()
    );
  }
}

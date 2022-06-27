import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/widgets/app_bar.dart';
import 'package:newsdx/widgets/bookmarkList.dart';
import 'package:newsdx/widgets/empty_bookmark.dart';
class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  int size = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(MyConstant.noTitle),
      body: size == 0 ? const EmptyBookMarkContainer() : const BookMarkFilledContainer(),
    );
  }
}

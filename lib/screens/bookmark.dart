import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/bookmark/model/bookmark_article.dart';
import 'package:newsdx/objectbox.g.dart';
import 'package:newsdx/widgets/app_bar.dart';
import 'package:newsdx/bookmark/bookmarkList.dart';
import 'package:newsdx/widgets/empty_bookmark.dart';
class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
 late  Future<List<String>> articleDatabaseIdsList;
 Store? _store;
 late Box<BookMarkArticleModel>? bookmarkBox;
 BookMarkArticleModel? bookMarkArticleModel;
  int size = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(MyConstant.noTitle,),
      body: FutureBuilder<List<String>>(
        future:  getBookMarkStatus(),
        builder: (context, snapShot){
          if(snapShot.hasData){
            return Text("${snapShot.data}");
          }
          return Text("${snapShot.data}");
        },
      )
    );
  }

 @override
  void initState() {
   openStore().then((Store store) {
     _store = store;
     bookmarkBox = store.box<BookMarkArticleModel>();
   });
    super.initState();
//
  }
 @override
 void dispose() {
   _store?.close();
   super.dispose();
 }

 Future<List<String>> getBookMarkStatus() {
   List<String> articleIdList = [];
   final bookMarkQuery = bookmarkBox?.query().build();
   List<BookMarkArticleModel>? data =  bookMarkQuery?.find();
   for(BookMarkArticleModel id in data!){
     articleIdList.add(id.articleId);
   }
   return Future.value(articleIdList);
 }
}

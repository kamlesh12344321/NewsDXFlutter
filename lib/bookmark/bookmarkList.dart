import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/bookmark/bookmark_list_row.dart';
import 'package:newsdx/bookmark/empty_bookmark.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:provider/provider.dart';
import '../model/SectionPojo.dart';
import '../router/app_state.dart';
import '../router/ui_pages.dart';
import '../screens/article_detail.dart';
import '../widgets/app_bar.dart';

class BookMarkFilledContainer extends StatefulWidget {
  String? bookmarkArticleList;

  BookMarkFilledContainer({
    Key? key,
    this.bookmarkArticleList,
  }) : super(key: key);

  @override
  State<BookMarkFilledContainer> createState() =>
      _BookMarkFilledContainerState();
}

class _BookMarkFilledContainerState extends State<BookMarkFilledContainer> {
  TextEditingController myController = TextEditingController();
  String? email = "";
  bool rememberMe = false;
  bool? shouldRefress = false;
  late Future<SectionPojo> myData;
  late List<Articles> articleList;
 late bool isDataPresent  = true;

  updateData() {
    setState(() {
      shouldRefress = true;
    });
  }

  late int markedIndex;

  callback(bookmarkIndex) {
    setState(() {
      articleList = List.from(articleList)..removeAt(bookmarkIndex);
      String articleIdList = "";
      for (int i = 0; i < articleList.length; i++) {
        if (i == 0) {
          articleIdList = articleList[i].articleid!;
        } else {
          articleIdList = "${articleList[i].articleid!},$articleIdList";
        }
      }
      if (articleList.isNotEmpty) {
        widget.bookmarkArticleList = articleIdList;
        setState((){
          isDataPresent = true;
        });
      } else {
        widget.bookmarkArticleList = "";
        setState((){
          isDataPresent = false;
        });

      }
    });
  }

  callbackBookMarkArticleId(
      String articleId, String bookmarkStatus, int index) {
    debugPrint("ArticleDitail call back $articleId $bookmarkStatus");
    setState(() {
      articleList = List.from(articleList)..removeAt(index);
      String articleIdList = "";
      for (int i = 0; i < articleList.length; i++) {
        if (i == 0) {
          articleIdList = articleList[i].articleid!;
        } else {
          articleIdList = "${articleList[i].articleid!},$articleIdList";
        }
      }
      widget.bookmarkArticleList = articleIdList;
      myData = getArticles(widget.bookmarkArticleList!);
    });
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(() {
      email = myController.text;
      setState(() {});
    });

    String? articleId = Prefs.getBookMarkArticelId();
    debugPrint("Bookmakr remove article id kk => $articleId");
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    if(widget.bookmarkArticleList == ""){
      setState((){
        isDataPresent = false;
      });
    }
    var futureBuilder = FutureBuilder<SectionPojo>(
      future: getArticles(widget.bookmarkArticleList!),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          DataPojo? articleItem = snapShot.data?.data;
          articleList = articleItem?.articles ?? [];
          if(articleList == []){
            setState((){
              isDataPresent = false;
            });
          }
          return SizedBox(
            child: ListView.builder(
              itemCount: articleList.length,
              itemBuilder: (context, index) {
                Articles? article = articleList[index];
                return ListTile(
                  tileColor: Colors.white,
                  title: BookmarkListRow(
                    articleItem: article,
                    rowIndex: index,
                    callback: callback,
                  ),
                  onTap: () {
                    appState.currentAction = PageAction(
                        state: PageState.addWidget,
                        widget: ArticleDetail(
                          articleItem: article,
                          bookmarkStatus:
                              getBookMarkStatus(article.articleid!),
                          callbackBookMark: callbackBookMarkArticleId,
                          row_index: index,
                        ),
                        page: ArticleDetailPageConfig);
                  },
                );
              },
            ),
          );
        } else if (snapShot.hasError) {
          String? er = snapShot.hasError.toString();
          return Center(
            child: Text("Error :: $er",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
    return Scaffold(
      appBar: AppBarWidget(MyConstant.noTitle,),
      body: isDataPresent == true ? futureBuilder : const EmptyBookMarkContainer(),
    );
  }

  Future<SectionPojo> getArticles(String articleIdsList) async {
    String? getAccessToken = MyConstant.propertyToken;
    var url = Uri.parse("https://api.newsdx.io/V1/articles/getArticless");
    final response = await http.post(
      url,
      body: {"articleId": articleIdsList},
      headers: {
        "Authorization": getAccessToken,
      },
    );

    SectionPojo allSection = modelClassFromJson(response.body);
    return allSection;
  }

  bool getBookMarkStatus(String articleId) {
    return true;
  }

  SectionPojo modelClassFromJson(String str) =>
      SectionPojo.fromJson(json.decode(str));
}

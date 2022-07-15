import 'package:newsdx/myfeed/model/myfeed_section.dart';

import '../bookmark/model/bookmark_article.dart';
import '../objectbox.g.dart';

class Helpers {

  static Box<BookMarkArticleModel>? _boxBookMark;
  static Box<MyFeedModel>? _boxMyFeed;

  static Future init() async
  {
    final store = await openStore();
    _boxBookMark = Box<BookMarkArticleModel>(store);
    _boxMyFeed = Box<MyFeedModel>(store);
  }

  static Future<int> insert(BookMarkArticleModel articleModel) async {
    return _boxBookMark!.put(articleModel);
  }

  static Future<List<BookMarkArticleModel>?> queryArticleId(String articleId) async {
    var box = await _boxBookMark?.query(BookMarkArticleModel_.articleId.equals(articleId)).build();
    var result =box?.find();
    return result;
  }

  static List<BookMarkArticleModel>? queryArticleIds(String articleId)  {
    var box =  _boxBookMark?.query(BookMarkArticleModel_.articleId.equals(articleId)).build();
    var result =box?.find();
    return result;
  }

  static List<BookMarkArticleModel>? getAllBookmarkList()  {
    var box =  _boxBookMark?.query().build();
    var result =box?.find();
    return result;
  }

  static Future delete(String articleId) async {
    var box =  _boxBookMark?.query(BookMarkArticleModel_.articleId.equals(articleId)).build();
    var result =box?.find();
    return _boxBookMark?.remove(result!.first.id);
  }


  static Future<int> insertMyFeed(MyFeedModel myFeedModel) async {
    return _boxMyFeed!.put(myFeedModel);
  }

  static List<MyFeedModel>? queryMyFeed(String sectionId) {
    var box = _boxMyFeed?.query(MyFeedModel_.sectionId.equals(sectionId)).build();
    var result = box?.find();
    return result;
  }

  static bool? deleteMyFeed(String sectionId) {
   var myFeedModels = queryMyFeed(sectionId);
    return _boxMyFeed?.remove(myFeedModels!.first.id);
  }

}
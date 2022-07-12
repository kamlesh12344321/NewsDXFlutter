import '../bookmark/model/bookmark_article.dart';
import '../objectbox.g.dart';

class Helpers {

  static Box<BookMarkArticleModel>? _box;

  static Future<Box<BookMarkArticleModel>?> init() async
  {
    final store = await openStore();
    _box = Box<BookMarkArticleModel>(store);
    return _box;
  }

  static Future<int> insert(BookMarkArticleModel articleModel) async {
    return _box!.put(articleModel);
  }

  static Future<List<BookMarkArticleModel>?> queryArticleId(String articleId) async {

    var box = await _box?.query(BookMarkArticleModel_.articleId.equals(articleId)).build();

      var result =box?.find();

    return result;
  }


  static List<BookMarkArticleModel>? queryArticleIds(String articleId)  {

    var box =  _box?.query(BookMarkArticleModel_.articleId.equals(articleId)).build();

    var result =box?.find();

    return result;
  }

  static List<BookMarkArticleModel>? getAllBookmarkList()  {
    var box =  _box?.query().build();
    var result =box?.find();
    return result;
  }



  static Future delete(String articleId) async {
    var box =  _box?.query(BookMarkArticleModel_.articleId.equals(articleId)).build();
    var result =box?.find();
    return _box?.remove(result!.first.id);
  }





  /*static Future<int> insert(BookMarkArticleModel person) async {
    var box = MyObjectBox.create();
    return box.put(person);
  }

  static Future<bool> delete(int id) async {
    var store = await MyObjectBox.getStore();
    var box = store.box<BookMarkArticleModel>();
    return box.remove(id);
  }

  static Future<BookMarkArticleModel> queryPerson(int id) async {
    var store = await MyObjectBox.getStore();
    var box = store.box<BookMarkArticleModel>();
    return box.get(id);
  }

  static Future<BookMarkArticleModel> queryArticleId(String articleId) async {
    var store = await MyObjectBox.getStore();

   var box = store.query(BookMarkArticleModel_.articleId.equals(articleId)).build();


    return box.get(id);
  }*/
}
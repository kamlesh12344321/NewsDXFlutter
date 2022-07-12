import 'bookmark/model/bookmark_article.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

class MyObjectBox {

  late final Store _store;
  late final Box<BookMarkArticleModel> _bookmaarkBox;

  //////////////////////////////////////

  MyObjectBox._init(this._store) {
    _bookmaarkBox = Box<BookMarkArticleModel>(_store);
  }

  static Future<MyObjectBox> init() async {
    final store = await openStore();
    return MyObjectBox._init(store);
  }

  BookMarkArticleModel? getBookmarkArticleId(int id) => _bookmaarkBox.get(id);

  Stream<List<BookMarkArticleModel>> getBookmarkArticleList() => _bookmaarkBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());


  int onInsertArticle(BookMarkArticleModel bookmarkArticle){
     return _bookmaarkBox.put(bookmarkArticle);
  }

  Stream<List<BookMarkArticleModel>> getBookmarkArticleFirst(String articleId) => _bookmaarkBox
      .query(BookMarkArticleModel_.articleId.equals(articleId))
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  int insertBookmarkArticle(BookMarkArticleModel bookmarkArticle) => _bookmaarkBox.put(bookmarkArticle);

  bool deleteUser(int id) => _bookmaarkBox.remove(id);
}
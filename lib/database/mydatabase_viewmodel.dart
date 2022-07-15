
import 'dart:io';

import '../bookmark/model/bookmark_article.dart';
import '../objectbox.g.dart';

class ViewModel {
  final Store _store;
  late final Box<BookMarkArticleModel> _box;

  ViewModel()
      : _store = Store(getObjectBoxModel()) {
    _box = _store.box<BookMarkArticleModel>();
  }

  void addNote(BookMarkArticleModel bookmark ) {
    _box.put(bookmark);
  }
}
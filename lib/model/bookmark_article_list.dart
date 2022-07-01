import 'package:objectbox/objectbox.dart';

@Entity()
class BookmarkedArticleList {
  int id;
  String articleId;

  BookmarkedArticleList({this.id = 0, required this.articleId});
}



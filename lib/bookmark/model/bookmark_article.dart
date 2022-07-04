

import 'package:objectbox/objectbox.dart';

@Entity()
class BookMarkArticleModel {
  int id = 0;
  String articleId;

  BookMarkArticleModel({required this.articleId});
}


import 'package:flutter/material.dart';
import 'package:newsdx/repo/api_status.dart';
import 'package:newsdx/repo/section_service.dart';
import 'package:newsdx/widgets/article_list.dart';

class ArticleListViewModel extends ChangeNotifier{
  bool _isLoading = false;
  ArticleListById? _homeArticle;
  bool get loading => _isLoading;
  ArticleListById? get homeArticles => _homeArticle;


  ArticleListViewModel(){
    getArticles();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
  }

  setArticleList(ArticleListById? homeArticleList){
    _homeArticle = homeArticleList;
  }

  getArticles() async {
    setLoading(true);
    var response = await SectionServices.getArticles();
    if(response is Success){
      setArticleList(response.response as ArticleListById?);
      notifyListeners();
    }
  }
}
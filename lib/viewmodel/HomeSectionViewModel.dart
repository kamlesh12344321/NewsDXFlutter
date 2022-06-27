import 'package:flutter/material.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/repo/api_status.dart';
import '../repo/section_service.dart';


class HomeSectionsViewModel extends ChangeNotifier{
  bool _isLoading = false;
  HomeSection? _homeSectionListModel;

  bool get loading => _isLoading;

  HomeSection? get homeSectionList => _homeSectionListModel;
  HomeSectionsViewModel(){
    getSections();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
  }

  setSectionListModel( HomeSection sectionList){
    _homeSectionListModel = sectionList;
  }

  getSections() async {
    setLoading(true);
    var response = await SectionServices.getHomeSection();
    if(response is Success){
      setSectionListModel(response.response as HomeSection);
      notifyListeners();
    }
  }
}
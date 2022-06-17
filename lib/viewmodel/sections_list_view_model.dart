import 'package:flutter/material.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/repo/api_status.dart';
import 'package:newsdx/widgets/section_list.dart';
import '../repo/section_service.dart';


class SectionsViewModel extends ChangeNotifier{
  bool _isLoading = false;
  Sections? _sectionListModel;

  bool get loading => _isLoading;

  Sections? get sectionList => _sectionListModel;
  SectionsViewModel(){
    getSections();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
  }

  setSectionListModel( Sections sectionList){
    _sectionListModel = sectionList;
  }

  getSections() async {
    setLoading(true);
    var response = await SectionServices.getSections(Prefs.getAccessToken(),);
    if(response is Success){
      setSectionListModel(response.response as Sections);
      notifyListeners();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/repo/api_status.dart';
import '../repo/section_service.dart';


class SectionsViewModel extends ChangeNotifier{
  bool _isLoading = false;
  SectionsList? _sectionListModel;

  bool get loading => _isLoading;

  SectionsList? get sectionList => _sectionListModel;
  SectionsViewModel(){
    getSections();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
  }

  setSectionListModel( SectionsList sectionList){
    _sectionListModel = sectionList;
  }

  getSections() async {
    setLoading(true);
    var response = await SectionServices.getSections();
    if(response is Success){
      setSectionListModel(response.response as SectionsList);
      setLoading(false);
      notifyListeners();
    }
  }
}
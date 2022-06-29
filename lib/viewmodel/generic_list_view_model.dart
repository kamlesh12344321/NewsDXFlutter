//
//
// import 'package:flutter/material.dart';
// import 'package:newsdx/repo/api_status.dart';
// import 'package:newsdx/repo/section_service.dart';
// import 'package:newsdx/widgets/generic_data.dart';
//
// class GenericViewModel extends ChangeNotifier{
//
//   bool _isLoading = false;
//   GenericList? _genericList;
//   var id;
//
//   GenericViewModel({this.id}){
//     getGenericList();
//   }
//
//   bool get loading => _isLoading;
//   GenericList? get get_genericList => _genericList;
//
//
//   setLoading(bool loading) async {
//     _isLoading = loading;
//   }
//
//   setGenericListModel( GenericList? genericList){
//     genericList = _genericList;
//   }
//
//   getGenericList() async {
//     setLoading(true);
//     var response = await SectionServices.getGenericArticles(id ?? "13");
//     if(response is Success){
//       setGenericListModel(response.response as GenericList?);
//       notifyListeners();
//     }
//   }
// }
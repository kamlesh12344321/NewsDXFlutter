


import 'package:flutter/material.dart';
import 'package:newsdx/repo/api_status.dart';
import 'package:newsdx/repo/section_service.dart';
import 'package:newsdx/widgets/sport_stars.dart';

class SportStarsViewModel extends ChangeNotifier{
  bool _isLoading = false;
  SportStars? _sportStars;
  bool get loading => _isLoading;
  SportStars? get sportStars => _sportStars;

  SportStarsViewModel(){
    getSportStars();
  }
  setLoading(bool loading) async {
    _isLoading = loading;
  }

  setSportStarsList(SportStars? sportStars){
    _sportStars = sportStars;
  }

   getSportStars() async {
     setLoading(true);
     var response = await SectionServices.getSportStars();
     if(response is Success){
       setSportStarsList(response.response as SportStars?);
       notifyListeners();
     }
   }
}
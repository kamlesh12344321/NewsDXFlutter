import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/repo/api_status.dart';
import 'package:newsdx/widgets/article_list.dart';
import 'package:newsdx/widgets/generic_data.dart';
import 'package:newsdx/widgets/section_list.dart';
import 'package:newsdx/widgets/sport_stars.dart';


class SectionServices{
  static Future<Object> getSections(String? token) async{
    try{

      var url = Uri.parse(MyConstant.SECTION_LIST);
      var response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
        },);
      if(200 == response.statusCode){
        return Success(response: sectionsFromJson(response.body));
      }
      return Failure(code: 100, failureResponse: "Invalid response");

    } on HttpException{
      return Failure(code: 101, failureResponse: "No Internet");
    } on FormatException{
      return Failure(code: 102, failureResponse: "Invalid format");
    } catch (e){
      return Failure(code: 103, failureResponse: "Unknown error");

    }
  }


  static Future<Object> getArticles() async{
    try{
      var url = Uri.parse(MyConstant.ARTICLE_LIST);
      var response = await http.get(url, headers: {
        'Authorization': Prefs.getAccessToken.toString(),
      });
      if(200 == response.statusCode){
        return Success(response: homeArticleFromJson(response.body));
      }
      return Failure(code: 100, failureResponse: "Invalid response");

    } on HttpException{
      return Failure(code: 101, failureResponse: "No Internet");
    } on FormatException{
      return Failure(code: 102, failureResponse: "Invalid format");
    } catch (e){
      return Failure(code: 103, failureResponse: "Unknown error");

    }
  }

  static Future<Object> getSportStars() async{
    try{
      Map data = {
        "section_id": false,
        "article_id": false,
        "property_id" : 2
      };
      var bodyData = json.encode(data);
      var url = Uri.parse(MyConstant.ARTICLE_LIST);
      var response = await http.post(url,
      headers:{"Content-Type": "application/json"},
        body: bodyData
      );
      if(200 == response.statusCode){
        return Success(response: sportStarsFromJson(response.body));
      }
      return Failure(code: 100, failureResponse: "Invalid response");

    } on HttpException{
      return Failure(code: 101, failureResponse: "No Internet");
    } on FormatException{
      return Failure(code: 102, failureResponse: "Invalid format");
    } catch (e){
      return Failure(code: 103, failureResponse: "Unknown error");

    }
  }

  static Future<Object> getGenericArticles(String? id) async{
    try{
      Map data = {
        "section_id": id,
        "article_id": false,
      };
      var bodyData = json.encode(data);
      var url = Uri.parse(MyConstant.ARTICLE_LIST);
      var response = await http.post(url,
          headers:{"Content-Type": "application/json"},
          body: bodyData
      );
      if(200 == response.statusCode){
        return Success(response: genericListFromJson(response.body));
      }
      return Failure(code: 100, failureResponse: "Invalid response");

    } on HttpException{
      return Failure(code: 101, failureResponse: "No Internet");
    } on FormatException{
      return Failure(code: 102, failureResponse: "Invalid format");
    } catch (e){
      return Failure(code: 103, failureResponse: "Unknown error");

    }
  }
}
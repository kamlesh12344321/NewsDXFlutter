import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/repo/api_status.dart';
import 'package:newsdx/widgets/article_list.dart';

class SectionServices {
  static Future<Object> getSections() async {
    String? getAccessToken = MyConstant.propertyToken;
    try {
      var url = Uri.parse(MyConstant.sectionList);
      final response = await http.get(
        url,
        headers: {
          "Authorization":  getAccessToken,
        },
      );
      if (200 == response.statusCode) {
        return Success(response: sectionsListFromJson(response.body));
      }
      return Failure(code: 100, failureResponse: "Invalid response");
    } on HttpException {
      return Failure(code: 101, failureResponse: "No Internet");
    } on FormatException {
      return Failure(code: 102, failureResponse: "Invalid format");
    } catch (e) {
      return Failure(code: 103, failureResponse: "Unknown error");
    }
  }

  static Future<Object> getArticles() async {
    String? getAccessToken = MyConstant.propertyToken;
    try {
      var url = Uri.parse(MyConstant.articleList);
      var response = await http.post(url,
        body: {"sectionId" : "1"},
        headers: {
        "Authorization":  getAccessToken,
      },
      );
      if (200 == response.statusCode) {
        return Success(response: homeArticleFromJson(response.body));
      }
      return Failure(code: 100, failureResponse: "Invalid response");
    } on HttpException {
      return Failure(code: 101, failureResponse: "No Internet");
    } on FormatException {
      return Failure(code: 102, failureResponse: "Invalid format");
    } catch (e) {
      return Failure(code: 103, failureResponse: "Unknown error");
    }
  }

  static Future<Object> getHomeSection() async {
    String? getAccessToken = MyConstant.propertyToken;
    try {
      var url = Uri.parse(MyConstant.homeSection);
      var response = await http.post(url,
        headers: {
          "Authorization" : getAccessToken
        },
      );
      if (200 == response.statusCode) {
        return Success(response: homeSectionFromJson(response.body));
      }
      return Failure(code: 100, failureResponse: "Invalid response");
    } on HttpException {
      return Failure(code: 101, failureResponse: "No Internet");
    } on FormatException {
      return Failure(code: 102, failureResponse: "Invalid format");
    } catch (e) {
      return Failure(code: 103, failureResponse: "Unknown error");
    }
  }


}

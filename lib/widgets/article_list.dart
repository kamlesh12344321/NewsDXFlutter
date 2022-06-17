// To parse this JSON data, do
//
//     final homeArticle = homeArticleFromJson(jsonString);

import 'dart:convert';

HomeArticle homeArticleFromJson(String str) => HomeArticle.fromJson(json.decode(str));

String homeArticleToJson(HomeArticle data) => json.encode(data.toJson());

class HomeArticle {
  HomeArticle({
    this.data,
    this.status,
  });

  List<Article>? data;
  bool? status;

  factory HomeArticle.fromJson(Map<String, dynamic> json) => HomeArticle(
    data: json["data"] == null ? null : List<Article>.from(json["data"].map((x) => Article.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class Article {
  Article({
    this.articleId,
    this.property,
    this.premium,
    required this.imgUrl,
    this.location,
    this.title,
    this.section,
    this.createdAt,
    this.description,
    this.sectionId,
  });

  String? articleId;
  Property? property;
  String? premium;
  String imgUrl;
  String? location;
  String? title;
  String? section;
  DateTime? createdAt;
  String? description;
  String? sectionId;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    articleId: json["article_id"] == null ? null : json["article_id"],
    property: json["property"] == null ? null : propertyValues.map[json["property"]],
    premium: json["premium"] == null ? null : json["premium"],
    imgUrl: json["img_url"],
    location: json["location"] == null ? null : json["location"],
    title: json["title"] == null ? null : json["title"],
    section: json["section"] == null ? null : json["section"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    description: json["description"] == null ? null : json["description"],
    sectionId: json["section_id"] == null ? null : json["section_id"],
  );

  Map<String, dynamic> toJson() => {
    "article_id": articleId == null ? null : articleId,
    "property": property == null ? null : propertyValues.reverse[property],
    "premium": premium == null ? null : premium,
    "img_url": imgUrl == null ? null : imgUrl,
    "location": location == null ? null : location,
    "title": title == null ? null : title,
    "section": section == null ? null : section,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "description": description == null ? null : description,
    "section_id": sectionId == null ? null : sectionId,
  };
}

enum Property { THE_HINDU }

final propertyValues = EnumValues({
  "The Hindu": Property.THE_HINDU
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

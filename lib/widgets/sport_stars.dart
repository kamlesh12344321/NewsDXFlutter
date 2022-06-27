// To parse this JSON data, do
//
//     final sportStars = sportStarsFromJson(jsonString);

import 'dart:convert';

SportStars sportStarsFromJson(String str) => SportStars.fromJson(json.decode(str));

String sportStarsToJson(SportStars data) => json.encode(data.toJson());

class SportStars {
  SportStars({
    this.data,
    this.status,
  });

  List<Sports>? data;
  bool? status;

  factory SportStars.fromJson(Map<String, dynamic> json) => SportStars(
    data: json["data"] == null ? null : List<Sports>.from(json["data"].map((x) => Sports.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class Sports {
  Sports({
    this.articleId,
    this.property,
    this.premium,
    this.imgUrl,
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
  String? imgUrl;
  String? location;
  String? title;
  SportSection? section;
  DateTime? createdAt;
  String? description;
  String? sectionId;

  factory Sports.fromJson(Map<String, dynamic> json) => Sports(
    articleId: json["article_id"] == null ? null : json["article_id"],
    property: json["property"] == null ? null : propertyValues.map[json["property"]],
    premium: json["premium"] == null ? null : json["premium"],
    imgUrl: json["img_url"] == null ? null : json["img_url"],
    location: json["location"] == null ? null : json["location"],
    title: json["title"] == null ? null : json["title"],
    section: json["section"] == null ? null : sectionValues.map[json["section"]],
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
    "section": section == null ? null : sectionValues.reverse[section],
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "description": description == null ? null : description,
    "section_id": sectionId == null ? null : sectionId,
  };
}

enum Property { SPORTS_STAR }

final propertyValues = EnumValues({
  "Sports Star": Property.SPORTS_STAR
});

enum SportSection { ATHLETICS, CRICKET, TENNIS, MOTORSPORT, FOOTBALL }

final sectionValues = EnumValues({
  "Athletics": SportSection.ATHLETICS,
  "Cricket": SportSection.CRICKET,
  "Football": SportSection.FOOTBALL,
  "Motorsport": SportSection.MOTORSPORT,
  "Tennis": SportSection.TENNIS
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

// To parse this JSON data, do
//
//     final genericList = genericListFromJson(jsonString);

import 'dart:convert';

GenericList genericListFromJson(String str) => GenericList.fromJson(json.decode(str));

String genericListToJson(GenericList data) => json.encode(data.toJson());

class GenericList {
  GenericList({
    this.data,
    this.status,
  });

  List<GenericItem>? data;
  bool? status;

  factory GenericList.fromJson(Map<String, dynamic> json) => GenericList(
    data: json["data"] == null ? null : List<GenericItem>.from(json["data"].map((x) => GenericItem.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class GenericItem {
  GenericItem({
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
  Location? location;
  String? title;
  GenericSection? section;
  DateTime? createdAt;
  String? description;
  String? sectionId;

  factory GenericItem.fromJson(Map<String, dynamic> json) => GenericItem(
    articleId: json["article_id"] == null ? null : json["article_id"],
    property: json["property"] == null ? null : propertyValues.map[json["property"]],
    premium: json["premium"] == null ? null : json["premium"],
    imgUrl: json["img_url"],
    location: json["location"] == null ? null : locationValues.map[json["location"]],
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
    "location": location == null ? null : locationValues.reverse[location],
    "title": title == null ? null : title,
    "section": section == null ? null : sectionValues.reverse[section],
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "description": description == null ? null : description,
    "section_id": sectionId == null ? null : sectionId,
  };
}

enum Location { EMPTY, LONDON, GUWAHATI, KOCHI }

final locationValues = EnumValues({
  "": Location.EMPTY,
  "GUWAHATI": Location.GUWAHATI,
  "KOCHI": Location.KOCHI,
  "London": Location.LONDON
});

enum Property { THE_HINDU }

final propertyValues = EnumValues({
  "The Hindu": Property.THE_HINDU
});

enum GenericSection { T }

final sectionValues = EnumValues({
  "": GenericSection.T
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

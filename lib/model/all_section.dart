// To parse this JSON data, do
//
//     final allSection = allSectionFromJson(jsonString);

import 'dart:convert';

AllSection allSectionFromJson(String str) => AllSection.fromJson(json.decode(str));

String allSectionToJson(AllSection data) => json.encode(data.toJson());

class AllSection {
  AllSection({
    this.status,
    this.statusMsg,
    this.data,
  });

  bool? status;
  String? statusMsg;
  DataAllSection? data;

  AllSection copyWith({
    bool? status,
    String? statusMsg,
    DataAllSection? data,
  }) =>
      AllSection(
        status: status ?? this.status,
        statusMsg: statusMsg ?? this.statusMsg,
        data: data ?? this.data,
      );

  factory AllSection.fromJson(Map<String, dynamic> json) => AllSection(
    status: json["STATUS"],
    statusMsg: json["STATUS_MSG"],
    data: DataAllSection.fromJson(json["DATA"]),
  );

  Map<String, dynamic> toJson() => {
    "STATUS": status,
    "STATUS_MSG": statusMsg,
    "DATA": data?.toJson(),
  };
}

class DataAllSection {
  DataAllSection({
    required this.currentpage,
    this.timestamp,
    this.articles,
  });

  late int currentpage;
  String? timestamp;
  List<ArticleAllSection>? articles;


  factory DataAllSection.fromJson(Map<String, dynamic> json) => DataAllSection(
    currentpage: json["CURRENTPAGE"],
    timestamp: json["TIMESTAMP"],
    articles: List<ArticleAllSection>.from(json["ARTICLES"].map((x) => ArticleAllSection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CURRENTPAGE": currentpage,
    "TIMESTAMP": timestamp,
    "ARTICLES": List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class ArticleAllSection {
  ArticleAllSection({
    this.sectionName,
    this.sectionId,
    this.articleId,
    this.propKey,
    this.title,
    this.leadText,
    this.link,
    this.type,
    this.category,
    this.author,
    this.audioUrl,
    this.videoUrl,
    this.location,
    this.publishDate,
    this.images,
    this.relatedArticles,
    this.shortDescription,
    this.descPart1,
    this.publishDateGmtMillis,
    this.authorPhoto,
    this.guid,
  });

  SectionName? sectionName;
  String? sectionId;
  String? articleId;
  PropKey? propKey;
  String? title;
  String? leadText;
  String? link;
  Type? type;
  String? category;
  String? author;
  String? audioUrl;
  String? videoUrl;
  String? location;
  DateTime? publishDate;
  List<ImageAllSection>? images;
  List<dynamic>? relatedArticles;
  String? shortDescription;
  String? descPart1;
  int? publishDateGmtMillis;
  String? authorPhoto;
  String? guid;

  ArticleAllSection copyWith({
    SectionName? sectionName,
    String? sectionId,
    String? articleId,
    PropKey? propKey,
    String? title,
    String? leadText,
    String? link,
    Type? type,
    String? category,
    String? author,
    String? audioUrl,
    String? videoUrl,
    String? location,
    DateTime? publishDate,
    List<ImageAllSection>? images,
    List<dynamic>? relatedArticles,
    String? shortDescription,
    String? descPart1,
    int? publishDateGmtMillis,
    String? authorPhoto,
    String? guid,
  }) =>
      ArticleAllSection(
        sectionName: sectionName ?? this.sectionName,
        sectionId: sectionId ?? this.sectionId,
        articleId: articleId ?? this.articleId,
        propKey: propKey ?? this.propKey,
        title: title ?? this.title,
        leadText: leadText ?? this.leadText,
        link: link ?? this.link,
        type: type ?? this.type,
        category: category ?? this.category,
        author: author ?? this.author,
        audioUrl: audioUrl ?? this.audioUrl,
        videoUrl: videoUrl ?? this.videoUrl,
        location: location ?? this.location,
        publishDate: publishDate ?? this.publishDate,
        images: images ?? this.images,
        relatedArticles: relatedArticles ?? this.relatedArticles,
        shortDescription: shortDescription ?? this.shortDescription,
        descPart1: descPart1 ?? this.descPart1,
        publishDateGmtMillis: publishDateGmtMillis ?? this.publishDateGmtMillis,
        authorPhoto: authorPhoto ?? this.authorPhoto,
        guid: guid ?? this.guid,
      );

  factory ArticleAllSection.fromJson(Map<String, dynamic> json) => ArticleAllSection(
    sectionName: sectionNameValues.map?[json["SECTION_NAME"]],
    sectionId: json["SECTION_ID"],
    articleId: json["ARTICLE_ID"],
    propKey: propKeyValues.map?[json["PROP_KEY"]],
    title: json["TITLE"],
    leadText: json["LEAD_TEXT"],
    link: json["LINK"],
    type: typeValues.map?[json["TYPE"]],
    category: json["CATEGORY"],
    author: json["AUTHOR"],
    audioUrl: json["AUDIO_URL"],
    videoUrl: json["VIDEO_URL"],
    location: json["LOCATION"],
    publishDate: DateTime.parse(json["PUBLISH_DATE"]),
    images: List<ImageAllSection>.from(json["IMAGES"].map((x) => ImageAllSection.fromJson(x))),
    relatedArticles: List<dynamic>.from(json["RELATED_ARTICLES"].map((x) => x)),
    shortDescription: json["SHORT_DESCRIPTION"],
    descPart1: json["DESC_PART_1"],
    publishDateGmtMillis: json["PUBLISH_DATE_GMT_MILLIS"],
    authorPhoto: json["AUTHOR_PHOTO"],
    guid: json["guid"],
  );

  Map<String, dynamic> toJson() => {
    "SECTION_NAME": sectionNameValues.reverse?[sectionName],
    "SECTION_ID": sectionId,
    "ARTICLE_ID": articleId,
    "PROP_KEY": propKeyValues.reverse?[propKey],
    "TITLE": title,
    "LEAD_TEXT": leadText,
    "LINK": link,
    "TYPE": typeValues.reverse?[type],
    "CATEGORY": category,
    "AUTHOR": author,
    "AUDIO_URL": audioUrl,
    "VIDEO_URL": videoUrl,
    "LOCATION": location,
    "PUBLISH_DATE": publishDate?.toIso8601String(),
    "IMAGES": List<dynamic>.from(images!.map((x) => x.toJson())),
    "RELATED_ARTICLES": List<dynamic>.from(relatedArticles!.map((x) => x)),
    "SHORT_DESCRIPTION": shortDescription,
    "DESC_PART_1": descPart1,
    "PUBLISH_DATE_GMT_MILLIS": publishDateGmtMillis,
    "AUTHOR_PHOTO": authorPhoto,
    "guid": guid,
  };
}

class ImageAllSection {
  ImageAllSection({
    this.imageId,
    this.caption,
  });

  String? imageId;
  String? caption;

  ImageAllSection copyWith({
    String? imageId,
    String? caption,
  }) =>
      ImageAllSection(
        imageId: imageId ?? this.imageId,
        caption: caption ?? this.caption,
      );

  factory ImageAllSection.fromJson(Map<String, dynamic> json) => ImageAllSection(
    imageId: json["IMAGE_ID"],
    caption: json["CAPTION"],
  );

  Map<String, dynamic> toJson() => {
    "IMAGE_ID": imageId,
    "CAPTION": caption,
  };
}

enum PropKey { THE_0_A415906_DF2_FD643733_B865167_ADB19_D }

final propKeyValues = EnumValues({
  "0a415906df2fd643733b865167adb19d": PropKey.THE_0_A415906_DF2_FD643733_B865167_ADB19_D
});

enum SectionName { SPORTS }

final sectionNameValues = EnumValues({
  "Sports": SectionName.SPORTS
});

enum Type { ARTICLE }

final typeValues = EnumValues({
  "ARTICLE": Type.ARTICLE
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

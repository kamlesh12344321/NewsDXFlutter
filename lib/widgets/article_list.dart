// To parse this JSON data, do
//
//     final homeArticle = homeArticleFromJson(jsonString);

import 'dart:convert';

ArticleListById homeArticleFromJson(String str) => ArticleListById.fromJson(json.decode(str));

String homeArticleToJson(ArticleListById data) => json.encode(data.toJson());

class ArticleListById {
  ArticleListById({
    this.status,
    this.statusMsg,
    this.data,
  });

   bool? status;
   String? statusMsg;
   Data? data;

  ArticleListById copyWith({
    bool? status,
    String? statusMsg,
    Data? data,
  }) =>
      ArticleListById(
        status: status ?? this.status,
        statusMsg: statusMsg ?? this.statusMsg,
        data: data ?? this.data,
      );

  factory ArticleListById.fromJson(Map<String, dynamic> json) => ArticleListById(
    status: json["STATUS"] ?? false,
    statusMsg: json["STATUS_MSG"] ?? "",
    data: json["DATA"] == null ? null : Data.fromJson(json["DATA"]),
  );

  Map<String, dynamic> toJson() => {
    "STATUS": status ?? false,
    "STATUS_MSG": statusMsg ?? "",
    "DATA": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.currentpage,
    this.timestamp,
    this.articles,
  });

   String? currentpage;
   String? timestamp;
   List<ArticleById>? articles;

  Data copyWith({
    String? currentpage,
    String? timestamp,
    List<ArticleById>? articles,
  }) =>
      Data(
        currentpage: currentpage ?? this.currentpage,
        timestamp: timestamp ?? this.timestamp,
        articles: articles ?? this.articles,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentpage: json["CURRENTPAGE"],
    timestamp: json["TIMESTAMP"],
    articles: json["ARTICLES"] == null ? null : List<ArticleById>.from(json["ARTICLES"].map((x) => ArticleById.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CURRENTPAGE": currentpage ?? "",
    "TIMESTAMP": timestamp ?? "",
    "ARTICLES": articles == null ? null : List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class ArticleById {
  ArticleById({
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
   List<Photo>? images;
   List<dynamic>? relatedArticles;
   String? shortDescription;
   String? descPart1;
   int? publishDateGmtMillis;
   String? authorPhoto;
   String? guid;

  ArticleById copyWith({
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
    List<Photo>? images,
    List<dynamic>? relatedArticles,
    String? shortDescription,
    String? descPart1,
    int? publishDateGmtMillis,
    String? authorPhoto,
    String? guid,
  }) =>
      ArticleById(
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

  factory ArticleById.fromJson(Map<String, dynamic> json) => ArticleById(
    sectionName: json["SECTION_NAME"] == null ? null : sectionNameValues.map![json["SECTION_NAME"]],
    sectionId: json["SECTION_ID"] ?? "",
    articleId: json["ARTICLE_ID"] ?? "",
    propKey: json["PROP_KEY"] == null ? null : propKeyValues.map![json["PROP_KEY"]],
    title: json["TITLE"] ?? "",
    leadText: json["LEAD_TEXT"] ?? "",
    link: json["LINK"] ?? "",
    type: json["TYPE"] == null ? null : typeValues.map![json["TYPE"]],
    category: json["CATEGORY"] ?? "",
    author: json["AUTHOR"] ?? "",
    audioUrl: json["AUDIO_URL"] ?? "",
    videoUrl: json["VIDEO_URL"] ?? "",
    location: json["LOCATION"] ?? "",
    publishDate: json["PUBLISH_DATE"] == null ? null : DateTime.parse(json["PUBLISH_DATE"]),
    images: json["IMAGES"] == null ? null : List<Photo>.from(json["IMAGES"].map((x) => Photo.fromJson(x))),
    relatedArticles: json["RELATED_ARTICLES"] == null ? null : List<dynamic>.from(json["RELATED_ARTICLES"].map((x) => x)),
    shortDescription: json["SHORT_DESCRIPTION"] ?? "",
    descPart1: json["DESC_PART_1"] ?? "",
    publishDateGmtMillis: json["PUBLISH_DATE_GMT_MILLIS"] ?? "",
    authorPhoto: json["AUTHOR_PHOTO"] ?? "",
    guid: json["guid"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "SECTION_NAME": sectionName == null ? null : sectionNameValues.reverse![sectionName],
    "SECTION_ID": sectionId ?? "",
    "ARTICLE_ID": articleId ?? "",
    "PROP_KEY": propKey == null ? null : propKeyValues.reverse![propKey],
    "TITLE": title ?? "",
    "LEAD_TEXT": leadText ?? "",
    "LINK": link ?? "",
    "TYPE": type == null ? null : typeValues.reverse![type],
    "CATEGORY": category ?? "",
    "AUTHOR": author ?? "",
    "AUDIO_URL": audioUrl ?? "",
    "VIDEO_URL": videoUrl ?? "",
    "LOCATION": location ?? "",
    "PUBLISH_DATE": publishDate == null ? null : publishDate!.toIso8601String(),
    "IMAGES": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "RELATED_ARTICLES": relatedArticles == null ? null : List<dynamic>.from(relatedArticles!.map((x) => x)),
    "SHORT_DESCRIPTION": shortDescription ?? "",
    "DESC_PART_1": descPart1 ?? "",
    "PUBLISH_DATE_GMT_MILLIS": publishDateGmtMillis ?? "",
    "AUTHOR_PHOTO": authorPhoto ?? "",
    "guid": guid ?? "",
  };
}

class Photo {
  Photo({
    this.imageId,
    this.caption,
  });

   String? imageId;
   String? caption;

  Photo copyWith({
    String? imageId,
    String? caption,
  }) =>
      Photo(
        imageId: imageId ?? this.imageId,
        caption: caption ?? this.caption,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    imageId: json["IMAGE_ID"] ?? "",
    caption: json["CAPTION"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "IMAGE_ID": imageId ?? "",
    "CAPTION": caption ?? "",
  };
}

enum PropKey { THE_0_A415906_DF2_FD643733_B865167_ADB19_D }

 EnumValues<PropKey> propKeyValues = EnumValues({
  "0a415906df2fd643733b865167adb19d": PropKey.THE_0_A415906_DF2_FD643733_B865167_ADB19_D
});

enum SectionName { EDUCATION }

 EnumValues<SectionName> sectionNameValues = EnumValues({
  "Education": SectionName.EDUCATION
});

enum Type { ARTICLE }

 EnumValues<Type> typeValues = EnumValues({
  "ARTICLE": Type.ARTICLE
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) =>  MapEntry(v, k));
    return reverseMap;
  }
}

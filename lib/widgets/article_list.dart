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
    status: json["STATUS"] ?? null,
    statusMsg: json["STATUS_MSG"] ?? null,
    data: json["DATA"] == null ? null : Data.fromJson(json["DATA"]),
  );

  Map<String, dynamic> toJson() => {
    "STATUS": status ?? null,
    "STATUS_MSG": statusMsg ?? null,
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
    currentpage: json["CURRENTPAGE"] ?? null,
    timestamp: json["TIMESTAMP"] ?? null,
    articles: json["ARTICLES"] == null ? null : List<ArticleById>.from(json["ARTICLES"].map((x) => ArticleById.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CURRENTPAGE": currentpage ?? null,
    "TIMESTAMP": timestamp ?? null,
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
    sectionId: json["SECTION_ID"] ?? null,
    articleId: json["ARTICLE_ID"] ?? null,
    propKey: json["PROP_KEY"] == null ? null : propKeyValues.map![json["PROP_KEY"]],
    title: json["TITLE"] ?? null,
    leadText: json["LEAD_TEXT"] ?? null,
    link: json["LINK"] ?? null,
    type: json["TYPE"] == null ? null : typeValues.map![json["TYPE"]],
    category: json["CATEGORY"] ?? null,
    author: json["AUTHOR"] ?? null,
    audioUrl: json["AUDIO_URL"] ?? null,
    videoUrl: json["VIDEO_URL"] ?? null,
    location: json["LOCATION"] ?? null,
    publishDate: json["PUBLISH_DATE"] == null ? null : DateTime.parse(json["PUBLISH_DATE"]),
    images: json["IMAGES"] == null ? null : List<Photo>.from(json["IMAGES"].map((x) => Photo.fromJson(x))),
    relatedArticles: json["RELATED_ARTICLES"] == null ? null : List<dynamic>.from(json["RELATED_ARTICLES"].map((x) => x)),
    shortDescription: json["SHORT_DESCRIPTION"] ?? null,
    descPart1: json["DESC_PART_1"] ?? null,
    publishDateGmtMillis: json["PUBLISH_DATE_GMT_MILLIS"] ?? null,
    authorPhoto: json["AUTHOR_PHOTO"] ?? null,
    guid: json["guid"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "SECTION_NAME": sectionName == null ? null : sectionNameValues.reverse![sectionName],
    "SECTION_ID": sectionId ?? null,
    "ARTICLE_ID": articleId ?? null,
    "PROP_KEY": propKey == null ? null : propKeyValues.reverse![propKey],
    "TITLE": title ?? null,
    "LEAD_TEXT": leadText ?? null,
    "LINK": link ?? null,
    "TYPE": type == null ? null : typeValues.reverse![type],
    "CATEGORY": category ?? null,
    "AUTHOR": author ?? null,
    "AUDIO_URL": audioUrl ?? null,
    "VIDEO_URL": videoUrl ?? null,
    "LOCATION": location ?? null,
    "PUBLISH_DATE": publishDate == null ? null : publishDate!.toIso8601String(),
    "IMAGES": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "RELATED_ARTICLES": relatedArticles == null ? null : List<dynamic>.from(relatedArticles!.map((x) => x)),
    "SHORT_DESCRIPTION": shortDescription ?? null,
    "DESC_PART_1": descPart1 ?? null,
    "PUBLISH_DATE_GMT_MILLIS": publishDateGmtMillis ?? null,
    "AUTHOR_PHOTO": authorPhoto ?? null,
    "guid": guid ?? null,
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
    imageId: json["IMAGE_ID"] ?? null,
    caption: json["CAPTION"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "IMAGE_ID": imageId ?? null,
    "CAPTION": caption ?? null,
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
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

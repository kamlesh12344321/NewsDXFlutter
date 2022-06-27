// To parse this JSON data, do
//
//     final homeArticle = homeArticleFromJson(jsonString);

import 'dart:convert';

ArticleList homeArticleFromJson(String str) => ArticleList.fromJson(json.decode(str));

String homeArticleToJson(ArticleList data) => json.encode(data.toJson());

class ArticleList {
  ArticleList({
    this.status,
    this.statusMsg,
    this.data,
  });

   bool? status;
   String? statusMsg;
   Data? data;

  ArticleList copyWith({
    bool? status,
    String? statusMsg,
    Data? data,
  }) =>
      ArticleList(
        status: status ?? this.status,
        statusMsg: statusMsg ?? this.statusMsg,
        data: data ?? this.data,
      );

  factory ArticleList.fromJson(Map<String, dynamic> json) => ArticleList(
    status: json["STATUS"] == null ? null : json["STATUS"],
    statusMsg: json["STATUS_MSG"] == null ? null : json["STATUS_MSG"],
    data: json["DATA"] == null ? null : Data.fromJson(json["DATA"]),
  );

  Map<String, dynamic> toJson() => {
    "STATUS": status == null ? null : status,
    "STATUS_MSG": statusMsg == null ? null : statusMsg,
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
   List<Article>? articles;

  Data copyWith({
    String? currentpage,
    String? timestamp,
    List<Article>? articles,
  }) =>
      Data(
        currentpage: currentpage ?? this.currentpage,
        timestamp: timestamp ?? this.timestamp,
        articles: articles ?? this.articles,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentpage: json["CURRENTPAGE"] == null ? null : json["CURRENTPAGE"],
    timestamp: json["TIMESTAMP"] == null ? null : json["TIMESTAMP"],
    articles: json["ARTICLES"] == null ? null : List<Article>.from(json["ARTICLES"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CURRENTPAGE": currentpage == null ? null : currentpage,
    "TIMESTAMP": timestamp == null ? null : timestamp,
    "ARTICLES": articles == null ? null : List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class Article {
  Article({
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

  Article copyWith({
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
      Article(
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

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    sectionName: json["SECTION_NAME"] == null ? null : sectionNameValues.map![json["SECTION_NAME"]],
    sectionId: json["SECTION_ID"] == null ? null : json["SECTION_ID"],
    articleId: json["ARTICLE_ID"] == null ? null : json["ARTICLE_ID"],
    propKey: json["PROP_KEY"] == null ? null : propKeyValues.map![json["PROP_KEY"]],
    title: json["TITLE"] == null ? null : json["TITLE"],
    leadText: json["LEAD_TEXT"] == null ? null : json["LEAD_TEXT"],
    link: json["LINK"] == null ? null : json["LINK"],
    type: json["TYPE"] == null ? null : typeValues.map![json["TYPE"]],
    category: json["CATEGORY"] == null ? null : json["CATEGORY"],
    author: json["AUTHOR"] == null ? null : json["AUTHOR"],
    audioUrl: json["AUDIO_URL"] == null ? null : json["AUDIO_URL"],
    videoUrl: json["VIDEO_URL"] == null ? null : json["VIDEO_URL"],
    location: json["LOCATION"] == null ? null : json["LOCATION"],
    publishDate: json["PUBLISH_DATE"] == null ? null : DateTime.parse(json["PUBLISH_DATE"]),
    images: json["IMAGES"] == null ? null : List<Photo>.from(json["IMAGES"].map((x) => Photo.fromJson(x))),
    relatedArticles: json["RELATED_ARTICLES"] == null ? null : List<dynamic>.from(json["RELATED_ARTICLES"].map((x) => x)),
    shortDescription: json["SHORT_DESCRIPTION"] == null ? null : json["SHORT_DESCRIPTION"],
    descPart1: json["DESC_PART_1"] == null ? null : json["DESC_PART_1"],
    publishDateGmtMillis: json["PUBLISH_DATE_GMT_MILLIS"] == null ? null : json["PUBLISH_DATE_GMT_MILLIS"],
    authorPhoto: json["AUTHOR_PHOTO"] == null ? null : json["AUTHOR_PHOTO"],
    guid: json["guid"] == null ? null : json["guid"],
  );

  Map<String, dynamic> toJson() => {
    "SECTION_NAME": sectionName == null ? null : sectionNameValues.reverse![sectionName],
    "SECTION_ID": sectionId == null ? null : sectionId,
    "ARTICLE_ID": articleId == null ? null : articleId,
    "PROP_KEY": propKey == null ? null : propKeyValues.reverse![propKey],
    "TITLE": title == null ? null : title,
    "LEAD_TEXT": leadText == null ? null : leadText,
    "LINK": link == null ? null : link,
    "TYPE": type == null ? null : typeValues.reverse![type],
    "CATEGORY": category == null ? null : category,
    "AUTHOR": author == null ? null : author,
    "AUDIO_URL": audioUrl == null ? null : audioUrl,
    "VIDEO_URL": videoUrl == null ? null : videoUrl,
    "LOCATION": location == null ? null : location,
    "PUBLISH_DATE": publishDate == null ? null : publishDate!.toIso8601String(),
    "IMAGES": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "RELATED_ARTICLES": relatedArticles == null ? null : List<dynamic>.from(relatedArticles!.map((x) => x)),
    "SHORT_DESCRIPTION": shortDescription == null ? null : shortDescription,
    "DESC_PART_1": descPart1 == null ? null : descPart1,
    "PUBLISH_DATE_GMT_MILLIS": publishDateGmtMillis == null ? null : publishDateGmtMillis,
    "AUTHOR_PHOTO": authorPhoto == null ? null : authorPhoto,
    "guid": guid == null ? null : guid,
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
    imageId: json["IMAGE_ID"] == null ? null : json["IMAGE_ID"],
    caption: json["CAPTION"] == null ? null : json["CAPTION"],
  );

  Map<String, dynamic> toJson() => {
    "IMAGE_ID": imageId == null ? null : imageId,
    "CAPTION": caption == null ? null : caption,
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

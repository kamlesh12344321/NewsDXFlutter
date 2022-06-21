// To parse this JSON data, do
//
//     final homsSection = homsSectionFromJson(jsonString);

import 'dart:convert';

HomeSection homeSectionFromJson(String str) => HomeSection.fromJson(json.decode(str));

String homeSectionToJson(HomeSection data) => json.encode(data.toJson());

class HomeSection {
  HomeSection({
    required this.status,
    required this.statusMsg,
    required this.data,
  });

  final bool status;
  final String statusMsg;
  final Data data;

  HomeSection copyWith({
    required bool status,
    required String statusMsg,
    required Data data,
  }) =>
      HomeSection(
        status: status ?? this.status,
        statusMsg: statusMsg ?? this.statusMsg,
        data: data ?? this.data,
      );

  factory HomeSection.fromJson(Map<String, dynamic> json) => HomeSection(
    status: json["STATUS"],
    statusMsg: json["STATUS_MSG"],
    data: Data.fromJson(json["DATA"]),
  );

  Map<String, dynamic> toJson() => {
    "STATUS": status,
    "STATUS_MSG": statusMsg,
    "DATA": data.toJson(),
  };
}

class Data {
  Data({
    required this.banner,
    required this.widgets,
    required this.articles,
    required this.liveWidget,
    required this.htmlWidget,
  });

  final List<Article> banner;
  final List<WidgetHome> widgets;
  final List<Article> articles;
  final LiveWidget liveWidget;
  final HtmlWidget htmlWidget;

  Data copyWith({
    required List<Article> banner,
    required List<WidgetHome> widgets,
    required List<Article> articles,
    required LiveWidget liveWidget,
    required HtmlWidget htmlWidget,
  }) =>
      Data(
        banner: banner ?? this.banner,
        widgets: widgets ?? this.widgets,
        articles: articles ?? this.articles,
        liveWidget: liveWidget ?? this.liveWidget,
        htmlWidget: htmlWidget ?? this.htmlWidget,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banner: List<Article>.from(json["BANNER"].map((x) => Article.fromJson(x))),
    widgets: List<WidgetHome>.from(json["WIDGETS"].map((x) => WidgetHome.fromJson(x))),
    articles: List<Article>.from(json["ARTICLES"].map((x) => Article.fromJson(x))),
    liveWidget: LiveWidget.fromJson(json["LIVE_WIDGET"]),
    htmlWidget: HtmlWidget.fromJson(json["HTML_WIDGET"]),
  );

  Map<String, dynamic> toJson() => {
    "BANNER": List<dynamic>.from(banner.map((x) => x.toJson())),
    "WIDGETS": List<dynamic>.from(widgets.map((x) => x.toJson())),
    "ARTICLES": List<dynamic>.from(articles.map((x) => x.toJson())),
    "LIVE_WIDGET": liveWidget.toJson(),
    "HTML_WIDGET": htmlWidget.toJson(),
  };
}

class Article {
  Article({
      this.sectionName,
    required this.sectionId,
    required this.articleId,
    required this.propKey,
    required this.title,
    required this.leadText,
    required this.link,
    required this.type,
    required this.category,
    required this.author,
    required this.audioUrl,
    required this.videoUrl,
    required this.location,
    required this.publishDate,
    required this.images,
    required  this.relatedArticles,
    required this.shortDescription,
    required this.descPart1,
    required this.publishDateGmtMillis,
    required this.authorPhoto,
    required this.guid,
  });

   SectionName? sectionName;
  final String sectionId;
  final String articleId;
   PropKey? propKey;
  final String title;
  final String leadText;
  final String link;
   Type? type;
  final String category;
  final String author;
  final String audioUrl;
  final String videoUrl;
  final String location;
  final DateTime publishDate;
  final List<ImageHome> images;
  final List<dynamic> relatedArticles;
  final String shortDescription;
  final String descPart1;
  final int publishDateGmtMillis;
  final String authorPhoto;
  final String guid;

  Article copyWith({
    required SectionName sectionName,
    required  String sectionId,
    required String articleId,
     PropKey? propKey,
    required String title,
    required String leadText,
    required String link,
     Type? type,
    required String category,
    required  String author,
    required String audioUrl,
    required String videoUrl,
    required String location,
    required DateTime publishDate,
    required List<ImageHome> images,
    required  List<dynamic> relatedArticles,
    required String shortDescription,
    required String descPart1,
    required int publishDateGmtMillis,
    required String authorPhoto,
    required String guid,
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
    sectionName: sectionNameValues!.map[json["SECTION_NAME"]],
    sectionId: json["SECTION_ID"],
    articleId: json["ARTICLE_ID"],
    propKey: propKeyValues.map[json["PROP_KEY"]],
    title: json["TITLE"],
    leadText: json["LEAD_TEXT"],
    link: json["LINK"],
    type: typeValues.map[json["TYPE"]],
    category: json["CATEGORY"],
    author: json["AUTHOR"],
    audioUrl: json["AUDIO_URL"],
    videoUrl: json["VIDEO_URL"],
    location: json["LOCATION"],
    publishDate: DateTime.parse(json["PUBLISH_DATE"]),
    images: List<ImageHome>.from(json["IMAGES"].map((x) => ImageHome.fromJson(x))),
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
    "PUBLISH_DATE": publishDate.toIso8601String(),
    "IMAGES": List<dynamic>.from(images.map((x) => x.toJson())),
    "RELATED_ARTICLES": List<dynamic>.from(relatedArticles.map((x) => x)),
    "SHORT_DESCRIPTION": shortDescription,
    "DESC_PART_1": descPart1,
    "PUBLISH_DATE_GMT_MILLIS": publishDateGmtMillis,
    "AUTHOR_PHOTO": authorPhoto,
    "guid": guid,
  };
}

class ImageHome {
  ImageHome({
    required this.imageId,
    required this.caption,
  });

  final String imageId;
  final String caption;

  ImageHome copyWith({
     required String imageId,
      required String caption,
  }) =>
      ImageHome(
        imageId: imageId ?? this.imageId,
        caption: caption ?? this.caption,
      );

  factory ImageHome.fromJson(Map<String, dynamic> json) => ImageHome(
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

enum SectionName { EDUCATION, SPORTS }

final sectionNameValues = EnumValues({
  "Education": SectionName.EDUCATION,
  "Sports": SectionName.SPORTS
});

enum Type { ARTICLE }

final typeValues = EnumValues({
  "ARTICLE": Type.ARTICLE
});

class HtmlWidget {
  HtmlWidget({
    required this.isEnabled,
    required this.url,
    required this.position,
    required this.action,
    required this.source,
  });

  final bool isEnabled;
  final String url;
  final String position;
  final String action;
  final String source;

  HtmlWidget copyWith({
    required bool isEnabled,
    required String url,
    required String position,
    required String action,
    required String source,
  }) =>
      HtmlWidget(
        isEnabled: isEnabled ?? this.isEnabled,
        url: url ?? this.url,
        position: position ?? this.position,
        action: action ?? this.action,
        source: source ?? this.source,
      );

  factory HtmlWidget.fromJson(Map<String, dynamic> json) => HtmlWidget(
    isEnabled: json["IS_ENABLED"],
    url: json["URL"],
    position: json["POSITION"],
    action: json["ACTION"],
    source: json["SOURCE"],
  );

  Map<String, dynamic> toJson() => {
    "IS_ENABLED": isEnabled,
    "URL": url,
    "POSITION": position,
    "ACTION": action,
    "SOURCE": source,
  };
}

class LiveWidget {
  LiveWidget({
    required this.isEnabled,
    required this.position,
    required this.refreshInterval,
    required this.articlesLimit,
    required this.articles,
  });

  final bool isEnabled;
  final String position;
  final String refreshInterval;
  final int articlesLimit;
  final List<dynamic> articles;

  LiveWidget copyWith({
    required bool isEnabled,
    required String position,
    required String refreshInterval,
    required int articlesLimit,
    required List<dynamic> articles,
  }) =>
      LiveWidget(
        isEnabled: isEnabled ?? this.isEnabled,
        position: position ?? this.position,
        refreshInterval: refreshInterval ?? this.refreshInterval,
        articlesLimit: articlesLimit ?? this.articlesLimit,
        articles: articles ?? this.articles,
      );

  factory LiveWidget.fromJson(Map<String, dynamic> json) => LiveWidget(
    isEnabled: json["IS_ENABLED"],
    position: json["POSITION"],
    refreshInterval: json["REFRESH_INTERVAL"],
    articlesLimit: json["ARTICLES_LIMIT"],
    articles: List<dynamic>.from(json["ARTICLES"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "IS_ENABLED": isEnabled,
    "POSITION": position,
    "REFRESH_INTERVAL": refreshInterval,
    "ARTICLES_LIMIT": articlesLimit,
    "ARTICLES": List<dynamic>.from(articles.map((x) => x)),
  };
}

class WidgetHome {
  WidgetHome({
    required this.sectionId,
    required this.sectionName,
    required this.displayOrder,
    required this.type,
    required this.articles,
  });

  final String sectionId;
   SectionName? sectionName;
  final int displayOrder;
  final String type;
  final List<Article> articles;

  WidgetHome copyWith({
    required String sectionId,
    required SectionName sectionName,
    required int displayOrder,
    required String type,
    required List<Article> articles,
  }) =>
      WidgetHome(
        sectionId: sectionId ?? this.sectionId,
        sectionName: sectionName ?? this.sectionName,
        displayOrder: displayOrder ?? this.displayOrder,
        type: type ?? this.type,
        articles: articles ?? this.articles,
      );

  factory WidgetHome.fromJson(Map<String, dynamic> json) => WidgetHome(
    sectionId: json["SECTION_ID"],
    sectionName: sectionNameValues.map[json["SECTION_NAME"]],
    displayOrder: json["DISPLAY_ORDER"],
    type: json["TYPE"],
    articles: List<Article>.from(json["ARTICLES"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SECTION_ID": sectionId,
    "SECTION_NAME": sectionNameValues.reverse?[sectionName],
    "DISPLAY_ORDER": displayOrder,
    "TYPE": type,
    "ARTICLES": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

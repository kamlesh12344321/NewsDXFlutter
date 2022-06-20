

// To parse this JSON data, do
//
//     final homsSection = homsSectionFromJson(jsonString);

import 'dart:convert';

HomeSection homeSectionFromJson(String str) => HomeSection.fromJson(json.decode(str));

String homeSectionToJson(HomeSection data) => json.encode(data.toJson());

class HomeSection {
  HomeSection({
    this.status,
    this.statusMsg,
    this.data,
  });

   bool? status;
   String? statusMsg;
   Data? data;

  HomeSection copyWith({
    bool? status,
    String? statusMsg,
    Data? data,
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
    "DATA": data?.toJson(),
  };
}

class Data {
  Data({
    this.banner,
    this.widgets,
    this.articles,
    this.liveWidget,
    this.htmlWidget,
  });

   List<Article>? banner;
   List<SectionWidget>? widgets;
   List<Article>? articles;
   LiveWidget? liveWidget;
   HtmlWidget? htmlWidget;

  Data copyWith({
    List<Article>? banner,
    List<SectionWidget>? widgets,
    List<Article>? articles,
    LiveWidget? liveWidget,
    HtmlWidget? htmlWidget,
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
    widgets: List<SectionWidget>.from(json["WIDGETS"].map((x) => SectionWidget.fromJson(x))),
    articles: List<Article>.from(json["ARTICLES"].map((x) => Article.fromJson(x))),
    liveWidget: LiveWidget.fromJson(json["LIVE_WIDGET"]),
    htmlWidget: HtmlWidget.fromJson(json["HTML_WIDGET"]),
  );

  Map<String, dynamic> toJson() => {
    "BANNER": List<dynamic>.from(banner!.map((x) => x.toJson())),
    "WIDGETS": List<dynamic>.from(widgets!.map((x) => x.toJson())),
    "ARTICLES": List<dynamic>.from(articles!.map((x) => x.toJson())),
    "LIVE_WIDGET": liveWidget?.toJson(),
    "HTML_WIDGET": htmlWidget?.toJson(),
  };
}

class Article {
  Article({
    this.sectionName,
    this.sectionId,
    this.articleId,
    this.propId,
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
    this.hasImages,
    this.thumbnail,
    this.images,
    this.relatedArticles,
    this.shortDescription,
    this.descPart1,
    this.descPart2,
    this.publishDateGmtMillis,
  });

   String? sectionName;
   String? sectionId;
   String? articleId;
   String? propId;
   PropKey? propKey;
   String? title;
   String? leadText;
   String? link;
   Type? type;
   String? category;
   String? author;
   String? audioUrl;
   VideoUrl? videoUrl;
   String? location;
   DateTime? publishDate;
   bool? hasImages;
   String? thumbnail;
   List<Image>? images;
   List<dynamic>? relatedArticles;
   String? shortDescription;
   String? descPart1;
   String? descPart2;
   int? publishDateGmtMillis;

  Article copyWith({
    String? sectionName,
    String? sectionId,
    String? articleId,
    String? propId,
    PropKey? propKey,
    String? title,
    String? leadText,
    String? link,
    Type? type,
    String? category,
    String? author,
    String? audioUrl,
    VideoUrl? videoUrl,
    String? location,
    DateTime? publishDate,
    bool? hasImages,
    String? thumbnail,
    List<Image>? images,
    List<dynamic>? relatedArticles,
    String? shortDescription,
    String? descPart1,
    String? descPart2,
    int? publishDateGmtMillis,
  }) =>
      Article(
        sectionName: sectionName ?? this.sectionName,
        sectionId: sectionId ?? this.sectionId,
        articleId: articleId ?? this.articleId,
        propId: propId ?? this.propId,
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
        hasImages: hasImages ?? this.hasImages,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
        relatedArticles: relatedArticles ?? this.relatedArticles,
        shortDescription: shortDescription ?? this.shortDescription,
        descPart1: descPart1 ?? this.descPart1,
        descPart2: descPart2 ?? this.descPart2,
        publishDateGmtMillis: publishDateGmtMillis ?? this.publishDateGmtMillis,
      );

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    sectionName: json["SECTION_NAME"],
    sectionId: json["SECTION_ID"],
    articleId: json["ARTICLE_ID"],
    propId: json["PROP_ID"],
    propKey: propKeyValues.map?[json["PROP_KEY"]],
    title: json["TITLE"],
    leadText: json["LEAD_TEXT"],
    link: json["LINK"],
    type: typeValues.map?[json["TYPE"]],
    category: json["CATEGORY"],
    author: json["AUTHOR"],
    audioUrl: json["AUDIO_URL"],
    videoUrl: videoUrlValues.map?[json["VIDEO_URL"]],
    location: json["LOCATION"],
    publishDate: DateTime.parse(json["PUBLISH_DATE"]),
    hasImages: json["HAS_IMAGES"],
    thumbnail: json["THUMBNAIL"],
    images: List<Image>.from(json["IMAGES"].map((x) => Image.fromJson(x))),
    relatedArticles: List<dynamic>.from(json["RELATED_ARTICLES"].map((x) => x)),
    shortDescription: json["SHORT_DESCRIPTION"],
    descPart1: json["DESC_PART_1"],
    descPart2: json["DESC_PART_2"],
    publishDateGmtMillis: json["PUBLISH_DATE_GMT_MILLIS"],
  );

  Map<String, dynamic> toJson() => {
    "SECTION_NAME": sectionName,
    "SECTION_ID": sectionId,
    "ARTICLE_ID": articleId,
    "PROP_ID": propId,
    "PROP_KEY": propKeyValues.reverse![propKey],
    "TITLE": title,
    "LEAD_TEXT": leadText,
    "LINK": link,
    "TYPE": typeValues.reverse![type],
    "CATEGORY": category,
    "AUTHOR": author,
    "AUDIO_URL": audioUrl,
    "VIDEO_URL": videoUrlValues.reverse![videoUrl],
    "LOCATION": location,
    "PUBLISH_DATE": publishDate?.toIso8601String(),
    "HAS_IMAGES": hasImages,
    "THUMBNAIL": thumbnail,
    "IMAGES": List<dynamic>.from(images!.map((x) => x.toJson())),
    "RELATED_ARTICLES": List<dynamic>.from(relatedArticles!.map((x) => x)),
    "SHORT_DESCRIPTION": shortDescription,
    "DESC_PART_1": descPart1,
    "DESC_PART_2": descPart2,
    "PUBLISH_DATE_GMT_MILLIS": publishDateGmtMillis,
  };
}

class Image {
  Image({
    this.imageId,
    this.caption,
  });

   String? imageId;
   String? caption;

  Image copyWith({
    String? imageId,
    String? caption,
  }) =>
      Image(
        imageId: imageId ?? this.imageId,
        caption: caption ?? this.caption,
      );

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imageId: json["IMAGE_ID"],
    caption: json["CAPTION"],
  );

  Map<String, dynamic> toJson() => {
    "IMAGE_ID": imageId,
    "CAPTION": caption,
  };
}

enum PropKey { THE_7_DAC8_A2317_C54_BB70_B28_EBA723685859 }

final propKeyValues = EnumValues({
  "7dac8a2317c54bb70b28eba723685859": PropKey.THE_7_DAC8_A2317_C54_BB70_B28_EBA723685859
});

enum Type { ARTICLE, VIDEO }

final typeValues = EnumValues({
  "ARTICLE": Type.ARTICLE,
  "VIDEO": Type.VIDEO
});

enum VideoUrl { EMPTY, BIN_U9_LT_V_QM_Q, VC_AT7_A_S15_CW, AZC0_GB_ZMF_MO, CVC_XOA12_S_YW }

final videoUrlValues = EnumValues({
  "AZC0GBZmfMo": VideoUrl.AZC0_GB_ZMF_MO,
  "BinU9LtVQmQ": VideoUrl.BIN_U9_LT_V_QM_Q,
  "CVCXoa12sYw": VideoUrl.CVC_XOA12_S_YW,
  "": VideoUrl.EMPTY,
  "vcAT7aS15Cw": VideoUrl.VC_AT7_A_S15_CW
});

class HtmlWidget {
  HtmlWidget({
    this.isEnabled,
    this.url,
    this.position,
    this.action,
    this.source,
  });

   bool? isEnabled;
   String? url;
   String? position;
   String? action;
   String? source;

  HtmlWidget copyWith({
    bool? isEnabled,
    String? url,
    String? position,
    String? action,
    String? source,
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
    this.isEnabled,
    this.position,
    this.refreshInterval,
    this.articlesLimit,
    this.articles,
  });

   bool? isEnabled;
   String? position;
   int? refreshInterval;
   int? articlesLimit;
   List<Article>? articles;

  LiveWidget copyWith({
    bool? isEnabled,
    String? position,
    int? refreshInterval,
    int? articlesLimit,
    List<Article>? articles,
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
    articles: List<Article>.from(json["ARTICLES"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IS_ENABLED": isEnabled,
    "POSITION": position,
    "REFRESH_INTERVAL": refreshInterval,
    "ARTICLES_LIMIT": articlesLimit,
    "ARTICLES": List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class SectionWidget {
  SectionWidget({
    this.sectionId,
    this.sectionName,
    this.displayOrder,
    this.type,
    this.articles,
  });

   String? sectionId;
  final String? sectionName;
  final int? displayOrder;
  final String? type;
  final List<Article>? articles;

  SectionWidget copyWith({
    String? sectionId,
    String? sectionName,
    int? displayOrder,
    String? type,
    List<Article>? articles,
  }) =>
      SectionWidget(
        sectionId: sectionId ?? this.sectionId,
        sectionName: sectionName ?? this.sectionName,
        displayOrder: displayOrder ?? this.displayOrder,
        type: type ?? this.type,
        articles: articles ?? this.articles,
      );

  factory SectionWidget.fromJson(Map<String, dynamic> json) => SectionWidget(
    sectionId: json["SECTION_ID"],
    sectionName: json["SECTION_NAME"],
    displayOrder: json["DISPLAY_ORDER"],
    type: json["TYPE"],
    articles: List<Article>.from(json["ARTICLES"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SECTION_ID": sectionId,
    "SECTION_NAME": sectionName,
    "DISPLAY_ORDER": displayOrder,
    "TYPE": type,
    "ARTICLES": List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map?.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class SectionPojo {
  SectionPojo({
      bool? status, 
      String? statusmsg, 
      DataPojo? data,}){
    _status = status;
    _statusmsg = statusmsg;
    _data = data;
}

  SectionPojo.fromJson(dynamic json) {
    _status = json['STATUS'];
    _statusmsg = json['STATUS_MSG'];
    _data = json['DATA'] != null ? DataPojo.fromJson(json['DATA']) : null;
  }
  bool? _status;
  String? _statusmsg;
  DataPojo? _data;
SectionPojo copyWith({  bool? status,
  String? statusmsg,
  DataPojo? data,
}) => SectionPojo(  status: status ?? _status,
  statusmsg: statusmsg ?? _statusmsg,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get statusmsg => _statusmsg;
  DataPojo? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STATUS'] = _status;
    map['STATUS_MSG'] = _statusmsg;
    if (_data != null) {
      map['DATA'] = _data?.toJson();
    }
    return map;
  }

}

class DataPojo {
  DataPojo({
      String? currentpage, 
      String? timestamp, 
      List<Articles>? articles,}){
    _currentpage = currentpage;
    _timestamp = timestamp;
    _articles = articles;
}

  DataPojo.fromJson(dynamic json) {
    _currentpage = json['CURRENTPAGE'];
    _timestamp = json['TIMESTAMP'];
    if (json['ARTICLES'] != null) {
      _articles = [];
      json['ARTICLES'].forEach((v) {
        _articles?.add(Articles.fromJson(v));
      });
    }
  }
  dynamic? _currentpage;
  String? _timestamp;
  List<Articles>? _articles;
DataPojo copyWith({  String? currentpage,
  String? timestamp,
  List<Articles>? articles,
}) => DataPojo(  currentpage: currentpage ?? _currentpage,
  timestamp: timestamp ?? _timestamp,
  articles: articles ?? _articles,
);
  String? get currentpage => _currentpage;
  String? get timestamp => _timestamp;
  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CURRENTPAGE'] = _currentpage;
    map['TIMESTAMP'] = _timestamp;
    if (_articles != null) {
      map['ARTICLES'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Articles {
  Articles({
      String? sectionname, 
      String? sectionid, 
      String? articleid, 
      String? propkey, 
      String? title, 
      String? leadtext, 
      String? link, 
      String? type, 
      String? category, 
      String? author, 
      String? audiourl, 
      String? videourl, 
      String? location, 
      String? publishdate, 
      List<Images>? images, 
      // List<dynamic>? relatedarticles,
      String? shortdescription, 
      String? descpart1, 
      int? publishdategmtmillis, 
      String? authorphoto, 
      String? guid,}){
    _sectionname = sectionname;
    _sectionid = sectionid;
    _articleid = articleid;
    _propkey = propkey;
    _title = title;
    _leadtext = leadtext;
    _link = link;
    _type = type;
    _category = category;
    _author = author;
    _audiourl = audiourl;
    _videourl = videourl;
    _location = location;
    _publishdate = publishdate;
    _images = images;
    //_relatedarticles = relatedarticles;
    _shortdescription = shortdescription;
    _descpart1 = descpart1;
    _publishdategmtmillis = publishdategmtmillis;
    _authorphoto = authorphoto;
    _guid = guid;
}

  Articles.fromJson(dynamic json) {
    _sectionname = json['SECTION_NAME'];
    _sectionid = json['SECTION_ID'];
    _articleid = json['ARTICLE_ID'];
    _propkey = json['PROP_KEY'];
    _title = json['TITLE'];
    _leadtext = json['LEAD_TEXT'];
    _link = json['LINK'];
    _type = json['TYPE'];
    _category = json['CATEGORY'];
    _author = json['AUTHOR'];
    _audiourl = json['AUDIO_URL'];
    _videourl = json['VIDEO_URL'];
    _location = json['LOCATION'];
    _publishdate = json['PUBLISH_DATE'];
    if (json['IMAGES'] != null) {
      _images = [];
      json['IMAGES'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    if (json['RELATED_ARTICLES'] != null) {
      //_relatedarticles = [];
      json['RELATED_ARTICLES'].forEach((v) {
        //_relatedarticles?.add(Dynamic.fromJson(v));
      });
    }
    _shortdescription = json['SHORT_DESCRIPTION'];
    _descpart1 = json['DESC_PART_1'];
    _publishdategmtmillis = json['PUBLISH_DATE_GMT_MILLIS'];
    _authorphoto = json['AUTHOR_PHOTO'];
    _guid = json['guid'];
  }
  String? _sectionname;
  String? _sectionid;
  String? _articleid;
  String? _propkey;
  String? _title;
  String? _leadtext;
  String? _link;
  String? _type;
  String? _category;
  String? _author;
  String? _audiourl;
  String? _videourl;
  String? _location;
  String? _publishdate;
  List<Images>? _images;
  //List<dynamic>? _relatedarticles;
  String? _shortdescription;
  String? _descpart1;
  int? _publishdategmtmillis;
  String? _authorphoto;
  String? _guid;
Articles copyWith({  String? sectionname,
  String? sectionid,
  String? articleid,
  String? propkey,
  String? title,
  String? leadtext,
  String? link,
  String? type,
  String? category,
  String? author,
  String? audiourl,
  String? videourl,
  String? location,
  String? publishdate,
  List<Images>? images,
  // List<dynamic>? relatedarticles,
  String? shortdescription,
  String? descpart1,
  int? publishdategmtmillis,
  String? authorphoto,
  String? guid,
}) => Articles(  sectionname: sectionname ?? _sectionname,
  sectionid: sectionid ?? _sectionid,
  articleid: articleid ?? _articleid,
  propkey: propkey ?? _propkey,
  title: title ?? _title,
  leadtext: leadtext ?? _leadtext,
  link: link ?? _link,
  type: type ?? _type,
  category: category ?? _category,
  author: author ?? _author,
  audiourl: audiourl ?? _audiourl,
  videourl: videourl ?? _videourl,
  location: location ?? _location,
  publishdate: publishdate ?? _publishdate,
  images: images ?? _images,
  //relatedarticles: relatedarticles ?? _relatedarticles,
  shortdescription: shortdescription ?? _shortdescription,
  descpart1: descpart1 ?? _descpart1,
  publishdategmtmillis: publishdategmtmillis ?? _publishdategmtmillis,
  authorphoto: authorphoto ?? _authorphoto,
  guid: guid ?? _guid,
);
  String? get sectionname => _sectionname;
  String? get sectionid => _sectionid;
  String? get articleid => _articleid;
  String? get propkey => _propkey;
  String? get title => _title;
  String? get leadtext => _leadtext;
  String? get link => _link;
  String? get type => _type;
  String? get category => _category;
  String? get author => _author;
  String? get audiourl => _audiourl;
  String? get videourl => _videourl;
  String? get location => _location;
  String? get publishdate => _publishdate;
  List<Images>? get images => _images;
  // List<dynamic>? get relatedarticles => _relatedarticles;
  String? get shortdescription => _shortdescription;
  String? get descpart1 => _descpart1;
  int? get publishdategmtmillis => _publishdategmtmillis;
  String? get authorphoto => _authorphoto;
  String? get guid => _guid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SECTION_NAME'] = _sectionname;
    map['SECTION_ID'] = _sectionid;
    map['ARTICLE_ID'] = _articleid;
    map['PROP_KEY'] = _propkey;
    map['TITLE'] = _title;
    map['LEAD_TEXT'] = _leadtext;
    map['LINK'] = _link;
    map['TYPE'] = _type;
    map['CATEGORY'] = _category;
    map['AUTHOR'] = _author;
    map['AUDIO_URL'] = _audiourl;
    map['VIDEO_URL'] = _videourl;
    map['LOCATION'] = _location;
    map['PUBLISH_DATE'] = _publishdate;
    if (_images != null) {
      map['IMAGES'] = _images?.map((v) => v.toJson()).toList();
    }
    // if (_relatedarticles != null) {
    //   map['RELATED_ARTICLES'] = _relatedarticles?.map((v) => v.toJson()).toList();
    // }
    map['SHORT_DESCRIPTION'] = _shortdescription;
    map['DESC_PART_1'] = _descpart1;
    map['PUBLISH_DATE_GMT_MILLIS'] = _publishdategmtmillis;
    map['AUTHOR_PHOTO'] = _authorphoto;
    map['guid'] = _guid;
    return map;
  }

}

class Images {
  Images({
      String? imageid, 
      String? caption,}){
    _imageid = imageid;
    _caption = caption;
}

  Images.fromJson(dynamic json) {
    _imageid = json['IMAGE_ID'];
    _caption = json['CAPTION'];
  }
  String? _imageid;
  String? _caption;
Images copyWith({  String? imageid,
  String? caption,
}) => Images(  imageid: imageid ?? _imageid,
  caption: caption ?? _caption,
);
  String? get imageid => _imageid;
  String? get caption => _caption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IMAGE_ID'] = _imageid;
    map['CAPTION'] = _caption;
    return map;
  }

}
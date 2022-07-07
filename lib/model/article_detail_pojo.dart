class ArticleDetailPojo {
  bool? sTATUS;
  String? sTATUSMSG;
  DATA? dATA;

  ArticleDetailPojo({this.sTATUS, this.sTATUSMSG, this.dATA});

  ArticleDetailPojo.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    sTATUSMSG = json['STATUS_MSG'];
    dATA = json['DATA'] != null ? new DATA.fromJson(json['DATA']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['STATUS_MSG'] = this.sTATUSMSG;
    if (this.dATA != null) {
      data['DATA'] = this.dATA!.toJson();
    }
    return data;
  }
}

class DATA {
  String? guid;
  String? tITLE;
  String? lEADTEXT;
  String? aRTICLEID;
  String? sECTIONNAME;
  String? dESCRIPTION;
  String? lINK;
  String? lOCATION;
  String? pUBLISHDATE;
  String? tIMESTAMP;
  List<IMAGES>? iMAGES;
  bool? premium;

  DATA(
      {this.guid,
        this.tITLE,
        this.lEADTEXT,
        this.aRTICLEID,
        this.sECTIONNAME,
        this.dESCRIPTION,
        this.lINK,
        this.lOCATION,
        this.pUBLISHDATE,
        this.tIMESTAMP,
        this.iMAGES,
        this.premium});

  DATA.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    tITLE = json['TITLE'];
    lEADTEXT = json['LEAD_TEXT'];
    aRTICLEID = json['ARTICLE_ID'];
    sECTIONNAME = json['SECTION_NAME'];
    dESCRIPTION = json['DESCRIPTION'];
    lINK = json['LINK'];
    lOCATION = json['LOCATION'];
    pUBLISHDATE = json['PUBLISH_DATE'];
    tIMESTAMP = json['TIMESTAMP'];
    if (json['IMAGES'] != null) {
      iMAGES = <IMAGES>[];
      json['IMAGES'].forEach((v) {
        iMAGES!.add(new IMAGES.fromJson(v));
      });
    }
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    data['TITLE'] = this.tITLE;
    data['LEAD_TEXT'] = this.lEADTEXT;
    data['ARTICLE_ID'] = this.aRTICLEID;
    data['SECTION_NAME'] = this.sECTIONNAME;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['LINK'] = this.lINK;
    data['LOCATION'] = this.lOCATION;
    data['PUBLISH_DATE'] = this.pUBLISHDATE;
    data['TIMESTAMP'] = this.tIMESTAMP;
    if (this.iMAGES != null) {
      data['IMAGES'] = this.iMAGES!.map((v) => v.toJson()).toList();
    }
    data['premium'] = this.premium;
    return data;
  }
}

class IMAGES {
  String? iD;
  String? pROPID;
  String? aRTICLEID;
  String? iMAGEID;
  String? cAPTION;
  String? iNSERTEDON;

  IMAGES(
      {this.iD,
        this.pROPID,
        this.aRTICLEID,
        this.iMAGEID,
        this.cAPTION,
        this.iNSERTEDON});

  IMAGES.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pROPID = json['PROP_ID'];
    aRTICLEID = json['ARTICLE_ID'];
    iMAGEID = json['IMAGE_ID'];
    cAPTION = json['CAPTION'];
    iNSERTEDON = json['INSERTED_ON'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['PROP_ID'] = this.pROPID;
    data['ARTICLE_ID'] = this.aRTICLEID;
    data['IMAGE_ID'] = this.iMAGEID;
    data['CAPTION'] = this.cAPTION;
    data['INSERTED_ON'] = this.iNSERTEDON;
    return data;
  }
}

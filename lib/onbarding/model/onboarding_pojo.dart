import 'dart:convert';
OnboardingPojo onboardingPojoFromJson(String str) => OnboardingPojo.fromJson(json.decode(str));
String onboardingPojoToJson(OnboardingPojo data) => json.encode(data.toJson());
class OnboardingPojo {
  OnboardingPojo({
      this.status, 
      this.statusmsg, 
      this.data,});

  OnboardingPojo.fromJson(dynamic json) {
    status = json['status'];
    statusmsg = json['STATUS_MSG'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? statusmsg;
  List<Data>? data;
OnboardingPojo copyWith({  bool? status,
  String? statusmsg,
  List<Data>? data,
}) => OnboardingPojo(  status: status ?? this.status,
  statusmsg: statusmsg ?? this.statusmsg,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['STATUS_MSG'] = statusmsg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.title, 
      this.imageUrl,});

  Data.fromJson(dynamic json) {
    title = json['title'];
    imageUrl = json['image_url'];
  }
  String? title;
  String? imageUrl;
Data copyWith({  String? title,
  String? imageUrl,
}) => Data(  title: title ?? this.title,
  imageUrl: imageUrl ?? this.imageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['image_url'] = imageUrl;
    return map;
  }
}
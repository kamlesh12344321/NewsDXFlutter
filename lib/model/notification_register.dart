class NotificationRegistration {
  bool? status;
  String? statusMsg;
  DATA? data;

  NotificationRegistration({this.status, this.statusMsg, this.data});

  NotificationRegistration.fromJson(Map<String, dynamic> json) {
    status = json['STATUS'];
    statusMsg = json['STATUS_MSG'];
    data = json['DATA'] != null ? DATA.fromJson(json['DATA']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['STATUS'] = status;
    data['STATUS_MSG'] = statusMsg;
    if (this.data != null) {
      data['DATA'] = this.data!.toJson();
    }
    return data;
  }
}

class DATA {
  DATA();

DATA.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}
}

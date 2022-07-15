// To parse this JSON data, do
//
//     final otpVerification = otpVerificationFromJson(jsonString);

import 'dart:convert';

OtpVerification otpVerificationFromJson(String str) => OtpVerification.fromJson(json.decode(str));

String otpVerificationToJson(OtpVerification data) => json.encode(data.toJson());

class OtpVerification {
  OtpVerification({
    required this.status,
    required this.statusMsg,
    required this.data,
  });

  final bool status;
  final String statusMsg;
  final Data data;

  OtpVerification copyWith({
    required bool status,
    required String statusMsg,
    required Data data,
  }) =>
      OtpVerification(
        status: status,
        statusMsg: statusMsg,
        data: data,
      );

  factory OtpVerification.fromJson(Map<String, dynamic> json) => OtpVerification(
    status: json["status"],
    statusMsg: json["STATUS_MSG"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "STATUS_MSG": statusMsg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.firstTimeUser,
    required this.accessToken,
  });

  final bool firstTimeUser;
  final String accessToken;

  Data copyWith({
    required bool firstTimeUser,
    required String accessToken,
  }) =>
      Data(
        firstTimeUser: firstTimeUser,
        accessToken: accessToken,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstTimeUser: json["first_time_user"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "first_time_user": firstTimeUser,
    "access_token": accessToken,
  };
}

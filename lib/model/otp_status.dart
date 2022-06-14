// To parse this JSON data, do
//
//     final otpStatus = otpStatusFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OtpStatus otpStatusFromJson(String str) => OtpStatus.fromJson(json.decode(str));

String otpStatusToJson(OtpStatus data) => json.encode(data.toJson());

class OtpStatus {
  OtpStatus({
    required this.status,
    required this.statusMsg,
    required this.data,
  });

  final bool status;
  final String statusMsg;
  final Data data;

  OtpStatus copyWith({
    required bool status,
    required String statusMsg,
    required Data data,
  }) =>
      OtpStatus(
        status: status ?? this.status,
        statusMsg: statusMsg ?? this.statusMsg,
        data: data ?? this.data,
      );

  factory OtpStatus.fromJson(Map<String, dynamic> json) => OtpStatus(
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
    required this.otpId,
  });

  final int otpId;

  Data copyWith({
    required int otpId,
  }) =>
      Data(
        otpId: otpId ?? this.otpId,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otpId: json["otp_id"],
  );

  Map<String, dynamic> toJson() => {
    "otp_id": otpId,
  };
}

// To parse this JSON data, do
//
//     final otpStatus = otpStatusFromJson(jsonString);

import 'dart:convert';

OtpSendStatus otpStatusFromJson(String str) => OtpSendStatus.fromJson(json.decode(str));

String otpStatusToJson(OtpSendStatus data) => json.encode(data.toJson());

class OtpSendStatus {
  OtpSendStatus({
    required this.status,
    required this.statusMsg,
    required this.data,
  });

  final bool status;
  final String statusMsg;
  final Data data;

  OtpSendStatus copyWith({
    required bool status,
    required String statusMsg,
    required Data data,
  }) =>
      OtpSendStatus(
        status: status,
        statusMsg: statusMsg,
        data: data,
      );

  factory OtpSendStatus.fromJson(Map<String, dynamic> json) => OtpSendStatus(
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
        otpId: otpId,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otpId: json["otp_id"],
  );

  Map<String, dynamic> toJson() => {
    "otp_id": otpId,
  };
}

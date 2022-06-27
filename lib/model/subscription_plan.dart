// To parse this JSON data, do
//
//     final subscriptionPlan = subscriptionPlanFromJson(jsonString);

import 'dart:convert';

SubscriptionPlan subscriptionPlanFromJson(String str) => SubscriptionPlan.fromJson(json.decode(str));

String subscriptionPlanToJson(SubscriptionPlan data) => json.encode(data.toJson());

class SubscriptionPlan {
  SubscriptionPlan({
    this.status,
    this.statusMsg,
    this.data,
  });

  bool? status;
  String? statusMsg;
  List<Plan>? data;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
    status: json["status"],
    statusMsg: json["STATUS_MSG"],
    data: List<Plan>.from(json["data"].map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "STATUS_MSG": statusMsg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Plan {
  Plan({
    this.id,
    this.productId,
    this.referenceName,
    this.productFeatures,
  });

  String? id;
  String? productId;
  String? referenceName;
  List<String>? productFeatures;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    productId: json["productId"],
    referenceName: json["referenceName"],
    productFeatures: List<String>.from(json["product_features"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "referenceName": referenceName,
    "product_features": List<dynamic>.from(productFeatures!.map((x) => x)),
  };
}

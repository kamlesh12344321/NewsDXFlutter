// To parse this JSON data, do
//
//     final subscriptionPlan = subscriptionPlanFromMap(jsonString);

import 'dart:convert';

SubscriptionPlan subscriptionPlanFromMap(String str) => SubscriptionPlan.fromMap(json.decode(str));

String subscriptionPlanToMap(SubscriptionPlan data) => json.encode(data.toMap());

class SubscriptionPlan {
  SubscriptionPlan({
    this.status,
    this.statusMsg,
    this.data,
  });

   bool? status;
   String? statusMsg;
   List<Datum>? data;

  factory SubscriptionPlan.fromMap(Map<String, dynamic> json) => SubscriptionPlan(
    status: json["status"],
    statusMsg: json["STATUS_MSG"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "STATUS_MSG": statusMsg,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  Datum({
    this.id,
    this.productId,
    this.productFeatures,
  });

   String? id;
   String? productId;
   List<String>? productFeatures;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    productId: json["productId"],
    productFeatures: List<String>.from(json["product_features"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "productId": productId,
    "product_features": List<dynamic>.from(productFeatures!.map((x) => x)),
  };
}

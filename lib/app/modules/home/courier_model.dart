// To parse this JSON data, do
//
//     final courierModel = courierModelFromJson(jsonString);

import 'dart:convert';

CourierModel courierModelFromJson(String str) =>
    CourierModel.fromJson(json.decode(str));

String courierModelToJson(CourierModel data) => json.encode(data.toJson());

class CourierModel {
  CourierModel({
    required this.code,
    required this.name,
    required this.costs,
  });

  String code;
  String name;
  List<CourierModelCost> costs;

  factory CourierModel.fromJson(Map<String, dynamic> json) => CourierModel(
        code: json["code"],
        name: json["name"],
        costs: List<CourierModelCost>.from(
            json["costs"].map((x) => CourierModelCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
      };

  static List<CourierModel> fromJsonList(List list) {
    if (list.length == 0) return List<CourierModel>.empty();
    return list.map((item) => CourierModel.fromJson(item)).toList();
  }
}

class CourierModelCost {
  CourierModelCost({
    required this.service,
    required this.description,
    required this.cost,
  });

  String service;
  String description;
  List<CostCost> cost;

  factory CourierModelCost.fromJson(Map<String, dynamic> json) =>
      CourierModelCost(
        service: json["service"],
        description: json["description"],
        cost:
            List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
      };
}

class CostCost {
  CostCost({
    required this.value,
    required this.etd,
    required this.note,
  });

  int value;
  String etd;
  String note;

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}

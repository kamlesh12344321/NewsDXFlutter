// To parse this JSON data, do
//
//     final sections = sectionsFromJson(jsonString);

import 'dart:convert';

Sections sectionsFromJson(String str) => Sections.fromJson(json.decode(str));

String sectionsToJson(Sections data) => json.encode(data.toJson());

class Sections {
  Sections({
    this.status,
    this.data,
  });

  bool? status;
  List<Section>? data;

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Section>.from(json["data"].map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Section {
  Section({
    this.sectionId,
    this.name,
    this.subSections,
  });

  String? sectionId;
  String? name;
  List<SubSection>? subSections;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    sectionId: json["section_id"] == null ? null : json["section_id"],
    name: json["name"] == null ? null : json["name"],
    subSections: json["sub_sections"] == null ? null : List<SubSection>.from(json["sub_sections"].map((x) => SubSection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "section_id": sectionId == null ? null : sectionId,
    "name": name == null ? null : name,
    "sub_sections": subSections == null ? null : List<dynamic>.from(subSections!.map((x) => x.toJson())),
  };
}

class SubSection {
  SubSection({
    this.sectionId,
    this.name,
  });

  String? sectionId;
  String? name;
  bool isSelected = false;

  factory SubSection.fromJson(Map<String, dynamic> json) => SubSection(
    sectionId: json["section_id"] == null ? null : json["section_id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "section_id": sectionId == null ? null : sectionId,
    "name": name == null ? null : name,
  };
}

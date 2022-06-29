// To parse this JSON data, do
//
//     final sectionsList = sectionsListFromJson(jsonString);

import 'dart:convert';

SectionsList sectionsListFromJson(String str) => SectionsList.fromJson(json.decode(str));

String sectionsListToJson(SectionsList data) => json.encode(data.toJson());

class SectionsList {
  SectionsList({
    this.status,
    this.statusMsg,
    this.data,
  });

   bool? status;
   String? statusMsg;
   List<Section>? data;

  SectionsList copyWith({
    bool? status,
    String? statusMsg,
    List<Section>? data,
  }) =>
      SectionsList(
        status: status ?? this.status,
        statusMsg: statusMsg ?? this.statusMsg,
        data: data ?? this.data,
      );

  factory SectionsList.fromJson(Map<String, dynamic> json) => SectionsList(
    status: json["STATUS"],
    statusMsg: json["STATUS_MSG"],
    data: List<Section>.from(json["DATA"].map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "STATUS": status,
    "STATUS_MSG": statusMsg,
    "DATA": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Section {
  Section({
    this.id,
    this.sectionName,
    this.sectionType,
    this.showInTopMenu,
    this.showInHamburger,
    this.propId,
    this.widget,
    this.subsections,
  });

   String? id;
   String? sectionName;
   String? sectionType;
   String? showInTopMenu;
   String? showInHamburger;
   String? propId;
   Item? widget;
   List<dynamic>? subsections;

  Section copyWith({
    String? id,
    String? sectionName,
    String? sectionType,
    String? showInTopMenu,
    String? showInHamburger,
    String? propId,
    Item? widget,
    List<dynamic>? subsections,
  }) =>
      Section(
        id: id ?? this.id,
        sectionName: sectionName ?? this.sectionName,
        sectionType: sectionType ?? this.sectionType,
        showInTopMenu: showInTopMenu ?? this.showInTopMenu,
        showInHamburger: showInHamburger ?? this.showInHamburger,
        propId: propId ?? this.propId,
        widget: widget ?? this.widget,
        subsections: subsections ?? this.subsections,
      );

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["ID"],
    sectionName: json["SECTION_NAME"],
    sectionType: json["SECTION_TYPE"],
    showInTopMenu: json["SHOW_IN_TOP_MENU"],
    showInHamburger: json["SHOW_IN_HAMBURGER"],
    propId: json["PROP_ID"],
    widget: Item.fromJson(json["WIDGET"]),
    subsections: List<dynamic>.from(json["SUBSECTIONS"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "SECTION_NAME": sectionName,
    "SECTION_TYPE": sectionType,
    "SHOW_IN_TOP_MENU": showInTopMenu,
    "SHOW_IN_HAMBURGER": showInHamburger,
    "PROP_ID": propId,
    "WIDGET": widget?.toJson(),
    "SUBSECTIONS": List<dynamic>.from(subsections!.map((x) => x)),
  };
}

class Item {
  Item({
    this.isEnabled,
    this.url,
    this.position,
    this.action,
    this.source,
  });

   bool? isEnabled;
   String? url;
   String? position;
   String? action;
   String? source;

  Item copyWith({
    bool? isEnabled,
    String? url,
    String? position,
    String? action,
    String? source,
  }) =>
      Item(
        isEnabled: isEnabled ?? this.isEnabled,
        url: url ?? this.url,
        position: position ?? this.position,
        action: action ?? this.action,
        source: source ?? this.source,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    isEnabled: json["IS_ENABLED"],
    url: json["URL"] == null ? null : json["URL"],
    position: json["POSITION"] == null ? null : json["POSITION"],
    action: json["ACTION"] == null ? null : json["ACTION"],
    source: json["SOURCE"] == null ? null : json["SOURCE"],
  );

  Map<String, dynamic> toJson() => {
    "IS_ENABLED": isEnabled,
    "URL": url == null ? null : url,
    "POSITION": position == null ? null : position,
    "ACTION": action == null ? null : action,
    "SOURCE": source == null ? null : source,
  };
}

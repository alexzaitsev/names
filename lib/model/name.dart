import 'package:flutter/foundation.dart';

@immutable
class Name {
  final String name;
  final bool male;
  final String category;
  final String history;
  final String shortForms;

  const Name(
      {required this.name,
      required this.male,
      required this.category,
      required this.history,
      required this.shortForms});

  factory Name.fromJson(json) {
    return Name(
        name: "${json['Name']}",
        male: false,
        // TODO stub
        category: "${json['Primary category']}",
        history: "${json['Meaning and history']}",
        shortForms: "${json['Short forms']}");
  }
}

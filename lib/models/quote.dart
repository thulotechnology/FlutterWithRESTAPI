// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Quote {
  final String title;
  final String from;
  Quote({
    required this.title,
    required this.from,
  });

  Quote copyWith({
    String? title,
    String? from,
  }) {
    return Quote(
      title: title ?? this.title,
      from: from ?? this.from,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'from': from,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      title: map['title'] as String,
      from: map['from'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) =>
      Quote.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Quote(title: $title, from: $from)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Quote && other.title == title && other.from == from;
  }

  @override
  int get hashCode => title.hashCode ^ from.hashCode;
}

import 'dart:convert';

import 'package:quotes_app_with_api/models/meta.dart';

import 'datum.dart';

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

String quoteToJson(Quote data) => json.encode(data.toJson());

class Quote {
  Quote({
    required this.data,
    required this.meta,
  });

  final List<Datum> data;
  final Meta meta;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

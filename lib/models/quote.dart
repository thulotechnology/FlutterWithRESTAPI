import 'dart:convert';

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

class Datum {
  Datum({
    required this.id,
    required this.attributes,
  });

  final int id;
  final Attributes attributes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    required this.title,
    required this.from,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  final String title;
  final String from;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        title: json["title"],
        from: json["from"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "from": from,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  final Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}

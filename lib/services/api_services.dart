import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_app_with_api/models/attribute.dart';
import 'package:quotes_app_with_api/models/quote.dart';

class APIService {
  static String apiURL = "http://192.168.1.66:1337/api/quotes";

  static Future<Quote> getQuotes() async {
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // var onlydata = data["data"];
      // for (Map i in onlydata) {
      //   Map data = i["attributes"];
      //   quotes.add(Quote.fromMap(data as Map<String, dynamic>));
      // }
      // print(quotes);
      // return quotes;
      return Quote.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Add
  static Future<bool> addQuote(Attributes a) async {
    final url = Uri.parse(apiURL);
    String mybody = """
  {
  "data": {
    "title": "${a.title}",
    "from": "${a.from}"
  }
}
""";
    final response =
        await http.post(url, body: mybody, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete
  static Future<bool> deleteQuote(int id) async {
    final url = Uri.parse("$apiURL/$id");
    final response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Update
  static Future<bool> updateQuote(int id, Attributes a) async {
    final url = Uri.parse("$apiURL/$id");
    String mybody = """
  {
  "data": {
    "title": "${a.title}",
    "from": "${a.from}"
  }
}
""";
    final response =
        await http.put(url, body: mybody, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

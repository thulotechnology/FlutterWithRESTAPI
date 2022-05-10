import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_app_with_api/models/quote.dart';

class APIService {
  static String apiURL = "http://192.168.1.66:1337/api";

  static Future<List<Quote>> getQuotes() async {
    final response = await http.get(Uri.parse("$apiURL/quotes"));
    if (response.statusCode == 200) {
      List<Quote> quotes = [];
      var data = jsonDecode(response.body);
      var onlydata = data["data"];
      for (Map i in onlydata) {
        Map data = i["attributes"];
        quotes.add(Quote.fromMap(data as Map<String, dynamic>));
      }
      print(quotes);
      return quotes;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> addQuote(Quote q) async {
    final url = Uri.parse("$apiURL/quotes");
    String mybody = """
  {
  "data": {
    "title": "${q.title}",
    "from": "${q.from}"
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
}

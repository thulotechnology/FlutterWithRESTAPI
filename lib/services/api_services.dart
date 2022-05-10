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

      // for (Map i in data) {
      //   quotes.add(Quote.fromJson(i as Map<String, dynamic>));
      // }
      return quotes;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

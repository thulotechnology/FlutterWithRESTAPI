import 'package:flutter/material.dart';
import 'package:quotes_app_with_api/models/quote.dart';
import 'package:quotes_app_with_api/services/api_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Motivational Quotes"),
      ),
      body: FutureBuilder<List<Quote>>(
          future: APIService.getQuotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (contxt, index) {
                  return Text(snapshot.data.toString());
                },
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

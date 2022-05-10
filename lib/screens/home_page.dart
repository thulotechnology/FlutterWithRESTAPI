import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app_with_api/models/quote.dart';
import 'package:quotes_app_with_api/screens/add_update_quote.dart';
import 'package:quotes_app_with_api/services/api_services.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Quote>> futureQuotes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureQuotes = APIService.getQuotes();
  }

  void refresh() {
    setState(() {
      futureQuotes = APIService.getQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Motivational Quotes"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refresh();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddorUpdateQuote(
                      true,
                      q: Quote(title: "", from: ""),
                    )),
          );
          if (result == true) {
            showToast("Quote Added successfully");
            refresh();
          }
        },
      ),
      body: FutureBuilder<List<Quote>>(
          future: futureQuotes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (contxt, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].from),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

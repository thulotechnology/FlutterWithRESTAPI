import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quotes_app_with_api/models/attribute.dart';
import 'package:quotes_app_with_api/models/quote.dart';
import 'package:quotes_app_with_api/services/api_services.dart';

import 'add_update_quote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Quote> futureQuotes;
  @override
  void initState() {
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
            icon: const Icon(Icons.refresh),
            onPressed: () {
              refresh();
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddorUpdateQuote(
                      true,
                    )),
          );
          if (result == true) {
            showToast("Quote Added successfully");
            refresh();
          }
        },
      ),
      body: FutureBuilder<Quote>(
          future: futureQuotes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (contxt, index) {
                  return ListTile(
                    title: Text(snapshot.data!.data[index].attributes.title),
                    subtitle: Text(snapshot.data!.data[index].attributes.from),
                    leading: CircleAvatar(
                      child: Text(snapshot.data!.data[index].id.toString()),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddorUpdateQuote(
                                        false,
                                        id: snapshot.data!.data[index].id,
                                        a: snapshot
                                            .data!.data[index].attributes,
                                      )),
                            );
                            if (result == true) {
                              showToast("Quote Updated successfully");
                              refresh();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20.0,
                          ),
                          onPressed: () {
                            // delete code
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Do you want to  delete?"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            bool result =
                                                await APIService.deleteQuote(
                                                    snapshot
                                                        .data!.data[index].id);
                                            if (result) {
                                              showToast(
                                                  "Quote deleted successfully.");
                                              refresh();
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text("Confirm Delete")),
                                      OutlinedButton(
                                          onPressed: () {
                                            // Go Back
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"))
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}

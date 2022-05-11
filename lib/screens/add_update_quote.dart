import 'package:flutter/material.dart';
import 'package:quotes_app_with_api/models/quote.dart';

import '../services/api_services.dart';

class AddorUpdateQuote extends StatelessWidget {
  final bool isAdded;
  late Attributes a;
  AddorUpdateQuote(this.isAdded, {required this.a});

  TextEditingController cTitle = TextEditingController();
  TextEditingController cFrom = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!isAdded) {
      cTitle.text = a.title;
      cFrom.text = a.from;
    }
    return Scaffold(
      appBar: AppBar(
        title: isAdded ? const Text("Add Quote") : const Text("Update Quoute"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: cTitle,
                  decoration: const InputDecoration(labelText: "Quote Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  }),
              TextFormField(
                  controller: cFrom,
                  decoration: const InputDecoration(labelText: "From"),
                  maxLength: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter from';
                    }
                    return null;
                  }),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (isAdded) {
                        bool result = await APIService.addQuote(
                            Attributes(title: cTitle.text, from: cFrom.text));
                        Navigator.pop(context, result);
                      } else {}
                    }
                  },
                  child: isAdded ? const Text("Add") : const Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}

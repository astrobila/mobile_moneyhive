import 'package:flutter/material.dart';

import 'package:moneyhive/shared_widgets/loading_dialog.dart';
import 'package:moneyhive/libraries/models/transactions_model.dart';

class PageTransactionsAdd extends StatefulWidget {
  const PageTransactionsAdd({super.key});

  @override
  State<PageTransactionsAdd> createState() => _PageTransactionsAddState();
}

class _PageTransactionsAddState extends State<PageTransactionsAdd> {
  final TextEditingController txtTitle = TextEditingController(text: '');
  final TextEditingController txtContent = TextEditingController(text: '');

  final addKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
      ),
      body: Form(
        key: addKey,
        child: ListView(
          children: [
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: txtTitle,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Title', border: OutlineInputBorder()),
                maxLines: 1,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: txtContent,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return 'Please type something';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Content', border: OutlineInputBorder()),
                maxLines: null,
                minLines: 10,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (addKey.currentState!.validate()) {
                          showLoadingDialog(context);
                          await TransactionModel.add(
                            Transaction(
                              title: txtTitle.text,
                              description: txtContent.text,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 50)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Save',
                          textScaleFactor: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:moneyhive/shared_widgets/loading_dialog.dart';
import 'package:moneyhive/libraries/models/transactions_model.dart';

class PageTransactionEdit extends StatefulWidget {
  const PageTransactionEdit({super.key});

  @override
  State<PageTransactionEdit> createState() => _PageTransactionEditState();
}

class _PageTransactionEditState extends State<PageTransactionEdit> {
  @override
  final TextEditingController txtTitle = TextEditingController(text: '');
  final TextEditingController txtContent = TextEditingController(text: '');
  String txtLastEditBy = "";

  final addKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final Transaction transaction =
        ModalRoute.of(context)!.settings.arguments as Transaction;

    txtTitle.text = transaction.title;
    txtContent.text = transaction.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
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
              child: Text(txtLastEditBy),
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
                              id: transaction.id,
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

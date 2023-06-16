import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import 'package:moneyhive/shared_widgets/loading_dialog.dart';
import 'package:moneyhive/shared_widgets/confirm_dialog.dart';
import 'package:moneyhive/libraries/models/transactions_model.dart';

class PageTransactions extends StatefulWidget {
  const PageTransactions({super.key});

  @override
  State<PageTransactions> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageTransactions> {
  @override
  List<Transaction> transactions = [];

  Future<int> loadData() async {
    transactions = await TransactionModel.getList();
    return 1;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blogs'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(LineIcons.plus),
          onPressed: () async {
            await Navigator.pushNamed(context, '/blogs_add');
            setState(() {});
          },
        ),
        body: FutureBuilder(
            future: loadData(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return ListView.separated(
                  itemBuilder: (BuildContext context, int idx) {
                    return ListTile(
                      leading: const Icon(LineIcons.book),
                      title: Text(blogs[idx].title),
                      subtitle: Text(blogs[idx].author ?? ''),
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/blogs_edit',
                          arguments: blogs[idx],
                        );
                        setState(() {});
                      },
                      trailing: IconButton(
                        icon: Icon(LineIcons.trash),
                        onPressed: () async {
                          showConfirmDialog(
                            context,
                            confirmTitle: 'Delete current note?',
                            yesOnPressed: () async {
                              showLoadingDialog(context);
                              BlogModel.delete(blogs[idx]);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              setState(() {});
                            },
                            noOnPressed: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int idx) {
                    return const Divider();
                  },
                  itemCount: blogs.length,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
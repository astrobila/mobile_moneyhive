import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moneyhive/libraries/models/wishlist_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:moneyhive/shared_widgets/loading_dialog.dart';
import 'package:moneyhive/shared_widgets/confirm_dialog.dart';
import 'package:moneyhive/libraries/models/transactions_model.dart';

class PageWishlist extends StatefulWidget {
  const PageWishlist({super.key});

  @override
  State<PageWishlist> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageWishlist> {
  @override
  List<Wishlist> wishlist = [];

  Future<int> loadData() async {
    wishlist = await WishlistModel.getList();
    return 1;
  }

  String statusString(int? status) {
    switch (status) {
      case 1:
        return 'Ongoing';
      case 2:
        return 'Done';
      case 3:
        return 'Cancelled';
    }

    return '';
  }

  double calculateProgress(double? progress, double? price) {
    double itemProgress = progress ?? 0;
    double itemPrice = price ?? 1;
    return itemProgress / itemPrice;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(LineIcons.plus),
        onPressed: () async {
          await Navigator.pushNamed(context, '/wishlist_add');
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
                    leading: const Icon(LineIcons.starAlt),
                    title: Text(wishlist[idx].itemName),
                    subtitle: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          statusString(wishlist[idx].status),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      LinearPercentIndicator(
                        width: 323.0,
                        lineHeight: 14.0,
                        percent: calculateProgress(
                            wishlist[idx].progress, wishlist[idx].itemPrice),
                        backgroundColor: Colors.grey,
                        progressColor: Colors.yellow,
                      )
                    ]),
                    isThreeLine: true,
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        '/wishlist_progress',
                        arguments: wishlist[idx],
                      );
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int idx) {
                  return const Divider();
                },
                itemCount: wishlist.length,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

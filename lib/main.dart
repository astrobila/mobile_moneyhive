import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/session.dart';
import 'package:moneyhive/pages/wishlist/page_wishlist_add.dart';
import 'package:moneyhive/pages/wishlist/page_wishlist_progress.dart';

import 'package:moneyhive/shared_widgets/menu_icon.dart';
import 'package:moneyhive/shared_widgets/alert_dialog.dart';

import 'package:moneyhive/pages/login/page_login.dart';

import 'package:moneyhive/pages/transactions/page_transactions.dart';
import 'package:moneyhive/pages/transactions/page_transactions_add.dart';
import 'package:moneyhive/pages/transactions/page_transactions_edit.dart';

import 'package:moneyhive/pages/wishlist/page_wishlist.dart';

import 'package:moneyhive/pages/home/page_home.dart';

import 'package:moneyhive/pages/profile/page_profile.dart';

final routes = {
  '/': (BuildContext context) => const MyHomePage(),
  '/login': (BuildContext context) => const PageLogin(),
  '/transactions_edit': (BuildContext context) => const PageTransactionEdit(),
  '/transactions_add': (BuildContext context) => const PageTransactionsAdd(),
  '/wishlist_add': (BuildContext context) => const PageWishlistAdd(),
  '/wishlist_progress': (BuildContext context) => const PageWishlistProgress()
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      //if (selectedIndex == 3) Session.destroySession();
    });
  }

  Future<Widget> selectedOption() async {
    if ((await Session.getSession()).status != 1) {
      //await Navigator.pushNamed(context, '/login');
    }
    switch (selectedIndex) {
      case 0:
        return PageHome();
      case 1:
        return PageTransactions();
      case 2:
        return PageWishlist();
      case 3:
        return PageProfile();
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: FutureBuilder(
            future: selectedOption(),
            builder: (context, snapshot) {
              if (snapshot.hasData) return snapshot.data ?? Container();
              return Container();
            },
          ),
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.green,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.white,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.paid),
                  label: 'Transaction',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
              currentIndex: selectedIndex,
              fixedColor: Color.fromARGB(255, 255, 221, 68),
              onTap: onItemTapped,
            )));
  }
}

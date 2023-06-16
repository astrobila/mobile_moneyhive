import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/session.dart';

import 'package:moneyhive/shared_widgets/menu_icon.dart';
import 'package:moneyhive/shared_widgets/alert_dialog.dart';

import 'package:moneyhive/pages/login/page_login.dart';

import 'package:moneyhive/pages/transactions/page_transactions.dart';
import 'package:moneyhive/pages/transactions/page_transactions_add.dart';
import 'package:moneyhive/pages/transactions/page_transactions_edit.dart';

final routes = {
  '/': (BuildContext context) => const MyHomePage(),
  '/transactions': (BuildContext context) => const PageTransactions(),
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
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BottomNavigationBar Sample'),
        ),
        body: Center(
          child: Text('Test'),
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
                  icon: Icon(Icons.add_shopping_cart),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            )));
  }
}

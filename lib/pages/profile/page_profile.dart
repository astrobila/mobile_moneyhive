import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moneyhive/libraries/session.dart';

import 'package:moneyhive/shared_widgets/loading_dialog.dart';
import 'package:moneyhive/shared_widgets/confirm_dialog.dart';
import 'package:moneyhive/libraries/models/transactions_model.dart';

class PageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
            ),
            SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile_edit');
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(fontSize: 13),
                    )),
                SizedBox(width: 5),
                Icon(Icons.edit, size: 10),
              ],
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Tartaglia'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('tatang69@example.com'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Session.destroySession();
                  Navigator.pushNamed(context, '/login');
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}

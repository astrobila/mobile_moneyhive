import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import 'package:moneyhive/shared_widgets/loading_dialog.dart';
import 'package:moneyhive/shared_widgets/confirm_dialog.dart';
import 'package:moneyhive/libraries/models/transactions_model.dart';

class PageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/illyan.png'),
            ),
            SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => EditPage()),
                    );
                  },
                  child:
                  Text(
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
          ],
        ),
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Old-Password',
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'New-Password',
                  ),
                ),
                Text("Save "),
              ],
            ),
          ),
        ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:moneyhive/shared_widgets/alert_dialog.dart';
import 'package:moneyhive/libraries/session.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController txtUsername = TextEditingController(text: '');
  final TextEditingController txtPassword = TextEditingController(text: '');

  final addKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    txtUsername.text = '';
    txtPassword.text = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: addKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(48, 8, 48, 8),
                child: TextFormField(
                  controller: txtUsername,
                  autofocus: true,
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Username', border: OutlineInputBorder()),
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(48, 8, 48, 8),
                child: TextFormField(
                  obscureText: true,
                  controller: txtPassword,
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(48, 8, 48, 8),
                child: ElevatedButton(
                  onPressed: () async {
                    if (addKey.currentState!.validate()) {
                      SessionData sessdata = await Session.login(
                          txtUsername.text, txtPassword.text);
                      if (sessdata.status != 1) {
                        showAlertXDialog(
                          context,
                          'Login_1',
                          sessdata.data.toString(),
                        );
                      } else {
                        await showAlertXDialog(
                          context,
                          'Login_2',
                          sessdata.data.toString(),
                        );
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(64),
                  ),
                  child: const Text(
                    'Login',
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
              //Container(
              //height: 200,
              //),
            ],
          ),
        ),
      ),
    );
  }
}

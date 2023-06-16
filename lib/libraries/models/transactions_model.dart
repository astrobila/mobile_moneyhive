import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/diox.dart';
import 'package:moneyhive/libraries/session.dart';

class Transaction {}

class TransactionModel {
  static const _listURL = '${AppConfig.baseURL}/api.transactions.php';
  static const _addURL = '${AppConfig.baseURL}/api.transactions.add.php';
  static const _editURL = '${AppConfig.baseURL}/api.transactions.edit.php';
  static const _deleteURL = '${AppConfig.baseURL}/api.transactions.delete.php';

  static Future<List<Transaction>> getList() async {
    SessionData sessData = await Session.getURL(
        '$_listURL?${DateTime.now().millisecondsSinceEpoch.toString()}');
    if (sessData.status != 1) return [];

    List<Transaction> Transactions = [];

    return Transactions;
  }
}

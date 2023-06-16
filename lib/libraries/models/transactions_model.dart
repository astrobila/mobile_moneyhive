import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/diox.dart';
import 'package:moneyhive/libraries/session.dart';

class Transaction {
  int? id;
  int? userId;
  String? title;
  String? description;
  int? status;
  double? itemPrice;
  double? progress;
}

class TransactionModel {
  static const _listURL = '${AppConfig.baseURL}/api.transactions.php';
  static const _addURL = '${AppConfig.baseURL}/api.transactions.add.php';
  static const _editURL = '${AppConfig.baseURL}/api.transactions.edit.php';
  static const _deleteURL = '${AppConfig.baseURL}/api.transactions.delete.php';
  static const _balanceURL =
      '${AppConfig.baseURL}/api.transactions.balance.php';

  static Future<List<Transaction>> getList() async {
    SessionData sessData = await Session.getURL(
        '$_listURL?${DateTime.now().millisecondsSinceEpoch.toString()}');
    if (sessData.status != 1) return [];

    List<Transaction> Transactions = [];

    return Transactions;
  }

  static Future<double> getBalance() async {
    SessionData sessData = await Session.getURL(
        '$_balanceURL?${DateTime.now().millisecondsSinceEpoch.toString()}');
    double Balance = 0.2;
    return Balance;
  }

  static Future<int> delete(Transaction transaction) async {
    SessionData sessData = await Session.postURL(
        '$_deleteURL?${DateTime.now().millisecondsSinceEpoch.toString()}', {
      'id': transaction.id,
    });
    return sessData.status;
  }
}

import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/diox.dart';
import 'package:moneyhive/libraries/session.dart';

class Transaction {
  int? id;
  int? userId;
  String title;
  String description;
  int? account;
  double? amount;

  Transaction({
    this.id,
    this.userId,
    required this.title,
    required this.description,
    this.account,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'account': account,
      'amount': amount,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: (map['title'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      account: map['account'] as int,
      amount: map['amount'] as double,
    );
  }
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

    (sessData.data['data'] as List).forEach((value) {
      Transactions.add(
        Transaction.fromMap(
          {
            'id': int.parse(value['id']),
            'userId': int.parse(value['user_id']),
            'title': value['title'] ?? '',
            'description': value['description'] ?? '',
            'account': int.parse(value['account']),
            'amount': double.parse(value['amount']),
          },
        ),
      );
    });
    return Transactions;
  }

  static Future<double> getBalance() async {
    SessionData sessData = await Session.getURL(
        '$_balanceURL?${DateTime.now().millisecondsSinceEpoch.toString()}');
    if (sessData.status != 1) return 0;

    double Balance = double.parse(sessData.data['data']);

    return Balance;
  }

  static Future<int> add(Transaction transaction) async {
    SessionData sessData = await Session.postURL(
        '$_addURL?${DateTime.now().millisecondsSinceEpoch.toString()}',
        {'title': transaction.title, 'description': transaction.description});

    return sessData.status;
  }

  static Future<int> delete(Transaction transaction) async {
    SessionData sessData = await Session.postURL(
        '$_deleteURL?${DateTime.now().millisecondsSinceEpoch.toString()}', {
      'id': transaction.id,
    });
    return sessData.status;
  }
}

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

  Transaction(
      {this.id,
      this.userId,
      this.title,
      this.description,
      this.status,
      this.itemPrice,
      this.progress});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'status': status,
      'itemPrice': itemPrice,
      'progress': progress,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: (map['title'] ?? '') as String,
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
            'author': value['author'],
            'lastEdit': value['username'],
            'title': value['title'] ?? '',
            'content': value['content'] ?? '',
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

  static Future<int> delete(Transaction transaction) async {
    SessionData sessData = await Session.postURL(
        '$_deleteURL?${DateTime.now().millisecondsSinceEpoch.toString()}', {
      'id': transaction.id,
    });
    return sessData.status;
  }
}

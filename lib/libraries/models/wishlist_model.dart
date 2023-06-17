import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/diox.dart';
import 'package:moneyhive/libraries/session.dart';

class Wishlist {
  int? id;
  int? userId;
  String itemName;
  String description;
  int? status;
  double? itemPrice;
  double? progress;

  Wishlist(
      {this.id,
      this.userId,
      required this.itemName,
      required this.description,
      this.status,
      this.itemPrice,
      this.progress});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'itemName': itemName,
      'description': description,
      'status': status,
      'itemPrice': itemPrice,
      'progress': progress,
    };
  }

  factory Wishlist.fromMap(Map<String, dynamic> map) {
    return Wishlist(
        id: map['id'] as int,
        userId: map['userId'] as int,
        itemName: (map['itemName'] ?? '') as String,
        description: (map['description'] ?? '') as String,
        status: map['status'] as int,
        itemPrice: map['itemPrice'] as double,
        progress: map['progress'] as double);
  }
}

class WishlistModel {
  static const _listURL = '${AppConfig.baseURL}/api.wishlist.php';
  static const _addURL = '${AppConfig.baseURL}/api.wishlist.add.php';
  static const _editURL = '${AppConfig.baseURL}/api.wishlist.edit.php';
  static const _deleteURL = '${AppConfig.baseURL}/api.wishlist.delete.php';

  static Future<List<Wishlist>> getList() async {
    SessionData sessData = await Session.getURL(
        '$_listURL?${DateTime.now().millisecondsSinceEpoch.toString()}');
    if (sessData.status != 1) return [];

    List<Wishlist> Wishlists = [];
    (sessData.data['data'] as List).forEach((value) {
      Wishlists.add(
        Wishlist.fromMap(
          {
            'id': int.parse(value['id']),
            'userId': int.parse(value['user_id']),
            'itemName': value['item_name'] ?? '',
            'description': value['description'] ?? '',
            'status': int.parse(value['status']),
            'itemPrice': double.parse(value['item_price']),
            'progress': double.parse(value['progress']),
          },
        ),
      );
    });
    return Wishlists;
  }

  static Future<int> add(Wishlist wishlist) async {
    SessionData sessData = await Session.postURL(
        '$_addURL?${DateTime.now().millisecondsSinceEpoch.toString()}', {
      'itemName': wishlist.itemName,
    });
    return sessData.status;
  }

  static Future<int> delete(Wishlist wishlist) async {
    SessionData sessData = await Session.postURL(
        '$_deleteURL?${DateTime.now().millisecondsSinceEpoch.toString()}', {
      'id': wishlist.id,
    });
    return sessData.status;
  }
}

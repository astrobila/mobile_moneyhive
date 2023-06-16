import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/diox.dart';
import 'package:moneyhive/libraries/session.dart';

class Wishlist {
  int? id;
  int? userId;
  String? title;
  String? description;
  int? status;
  double? itemPrice;
  double? progress;

  Wishlist(
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

  factory Wishlist.fromMap(Map<String, dynamic> map) {
    return Wishlist(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: (map['title'] ?? '') as String,
    );
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

    return Wishlists;
  }

  static Future<int> add(Wishlist wishlist) async {
    SessionData sessData = await Session.postURL(
        '$_addURL?${DateTime.now().millisecondsSinceEpoch.toString()}', {
      'title': wishlist.title,
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

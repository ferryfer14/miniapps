import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

class Catalog {
  final int id;
  final String name;
  final String price;
  final String image;
  Catalog(this.id, this.name, this.price, this.image);

  Catalog.init()
      : id = 0,
        name = '',
        price = '',
        image = '';

  Catalog.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        price = json['price'].toString() as String,
        image = json['image'].toString() as String;
}

class CatalogModel extends GetxController {
  List<Catalog> list_item = [];
  CatalogModel();
  @override
  onInit() async {
    list_item = await client_get();
    super.onInit();
  }

  Future<List<Catalog>> client_get() async {
    final String data = await rootBundle.loadString('assets/catalogue.json');
    list_item = json.decode(data).map<Catalog>((json) {
      return Catalog.fromJson(json);
    }).toList();
    return list_item;
  }
}

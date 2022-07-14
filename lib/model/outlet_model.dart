import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:miniapps/variable/global.dart' as global;

import 'package:get/get.dart';

class Outlet {
  final int id;
  final String name;
  final String address;
  Outlet(this.id, this.name, this.address);

  Outlet.init()
      : id = 0,
        name = '',
        address = '';

  Outlet.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        address = json['address'].toString() as String;
}

class OutletModel extends GetxController {
  List<Outlet> list_item = [];
  OutletModel();
  @override
  onInit() async {
    list_item = await client_get();
    super.onInit();
  }

  Future<List<Outlet>> client_get() async {
    final String data = await rootBundle.loadString('assets/outlet.json');
    list_item = json.decode(data).map<Outlet>((json) {
      return Outlet.fromJson(json);
    }).toList();
    return list_item;
  }
}

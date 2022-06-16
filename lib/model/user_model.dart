import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:miniapps/variable/global.dart' as global;

import 'package:get/get.dart';

class User {
  final int id;
  final String username;
  final String fullname;
  final String email;
  final String phone;
  final String avatar;
  User(this.id, this.username, this.fullname, this.email, this.phone,
      this.avatar);

  User.init()
      : id = 0,
        username = '',
        fullname = '',
        email = '',
        phone = '',
        avatar = '';

  User.fromMap(Map<String, Object> map)
      : id = map['id'] as int,
        username = map['username'] as String,
        fullname = map['fullname'] as String,
        email = map['email'] as String,
        phone = map['phone'] as String,
        avatar = map['avatar'] as String;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        username = json['username'] as String,
        fullname = json['fullname'] as String,
        email = json['email'] as String,
        phone = json['phone'] as String,
        avatar = json['avatar'] as String;
}

class UserModel extends GetxController {
  List<User> list_item = [];
  UserModel();
  @override
  onInit() async {
    list_item = await client_get(global.user_url);
    super.onInit();
  }

  Future<List<User>> client_get(String url) async {
    var dio = Dio();
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));

      if (response.statusCode == 200) {
        print(response.data['data']['id']);
        list_item.add(User(
            response.data['data']['id'],
            response.data['data']['username'],
            response.data['data']['fullname'],
            response.data['data']['email'],
            response.data['data']['phone'],
            response.data['data']['avatar']));
        print(list_item);
        return list_item;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
      return [];
    }
  }
}

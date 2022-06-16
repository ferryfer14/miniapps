import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:miniapps/variable/global.dart' as global;

import 'package:get/get.dart';

class Place {
  final int id;
  final String title;
  final String content;
  final String type;
  final String image;
  final List media;
  Place(this.id, this.title, this.content, this.type, this.image, this.media);

  Place.init()
      : id = 0,
        title = '',
        content = '',
        type = '',
        image = '',
        media = [];

  Place.fromMap(Map<String, Object> map)
      : id = map['id'] as int,
        title = map['title'] as String,
        content = map['content'] as String,
        type = map['type'] as String,
        image = map['image'] as String,
        media = map['media'] as List;

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        content = json['content'] as String,
        type = json['type'] as String,
        image = json['image'] as String,
        media = json['media'] as List;
}

class PlaceModel extends GetxController {
  List<Place> list_item = [];
  List<Place> search_item = [];
  PlaceModel();
  @override
  onInit() async {
    list_item = await client_get(global.place_url);
    super.onInit();
  }

  Future<List<Place>> client_get(String url) async {
    var dio = Dio();
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> map =
            json.decode(json.encode(response.data['data']));
        List<dynamic> data = map["content"];
        print(data);
        list_item = map["content"].map<Place>((json) {
          return Place.fromJson(json);
        }).toList();
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

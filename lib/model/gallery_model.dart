import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:miniapps/variable/global.dart' as global;

import 'package:get/get.dart';

class Gallery {
  final String caption;
  final String thumbnail;
  final String image;
  Gallery(this.caption, this.thumbnail, this.image);

  Gallery.init()
      : caption = '',
        thumbnail = '',
        image = '';

  Gallery.fromMap(Map<String, Object> map)
      : caption = map['caption'] as String,
        thumbnail = map['thumbnail'] as String,
        image = map['image'] as String;

  Gallery.fromJson(Map<String, dynamic> json)
      : caption = json['caption'] as String,
        thumbnail = json['thumbnail'] as String,
        image = json['image'] as String;
}

class GalleryModel extends GetxController {
  List<Gallery> list_item = [];
  List<Gallery> search_item = [];
  GalleryModel();
  @override
  onInit() async {
    list_item = await client_get(global.gallery_url);
    super.onInit();
  }

  Future<List<Gallery>> client_get(String url) async {
    var dio = Dio();
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(json.encode(response.data));
        List<dynamic> data = map["data"];
        print(data);
        list_item = map["data"].map<Gallery>((json) {
          return Gallery.fromJson(json);
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

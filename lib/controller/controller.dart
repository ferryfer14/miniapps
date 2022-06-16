import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class Controller extends GetxController {
  void client_get(String url) async {
    var dio = Dio();
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        debugPrint(response.data);
        return response.data;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response.statusCode!;
      }
    } catch (error) {
      print(error);
    }
  }
}

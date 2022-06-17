import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniapps/model/place_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:miniapps/model/user_model.dart';

class UserPage extends StatefulWidget {
  @override
  State createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLoading = false;

  final _client = Get.put(UserModel());

  @override
  void initState() {
    super.initState();
    _client.onInit();
    setState(() {});
  }

  Widget data_profile(list) {
    return Center(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(list[0].avatar)),
        SizedBox(
          height: 20,
        ),
        Text(
          list[0].fullname,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          list[0].username,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          list[0].email,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          list[0].phone,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
        body: GetBuilder<UserModel>(
            init: UserModel(),
            builder: (data) => data.list_item.length != 0
                ? data_profile(data.list_item)
                : Container()));
  }
}

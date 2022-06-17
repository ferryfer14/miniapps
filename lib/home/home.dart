import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bottom_navigation_view/bottom_navigation_view.dart';
import 'package:get/get.dart';
import 'package:miniapps/controller/controller.dart';
import 'package:miniapps/home/item/gallery.dart';
import 'package:miniapps/home/item/place.dart';
import 'package:miniapps/home/item/user.dart';
import 'package:miniapps/login/sign_in.dart';
import 'package:miniapps/model/place_model.dart';
import 'package:miniapps/variable/global.dart' as global;

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final BottomNavigationController _controller;
  String title = "Place";
  final _client = Get.put(PlaceModel());

  @override
  void initState() {
    super.initState();
    _controller = BottomNavigationController(vsync: this);
    _client.onInit();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("$title")),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: BottomNavigationView(
        controller: _controller,
        transitionType: BottomNavigationTransitionType.fadeInOut,
        children: [
          PlacePage(),
          GalleryPage(),
          UserPage(),
        ],
      )),
      bottomNavigationBar: BottomNavigationIndexedBuilder(
        controller: _controller,
        builder: (context, index, child) {
          return BottomNavigationBar(
            currentIndex: index,
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  title = "Place";
                } else if (index == 1) {
                  title = "Gallery";
                } else {
                  title = "User";
                }
              });
              _controller.goTo(index);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Text('PLACE'),
                activeIcon: Text(
                  'PLACE',
                  style: TextStyle(color: Colors.blue),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Text('GALLERY'),
                activeIcon: Text(
                  'GALLERY',
                  style: TextStyle(color: Colors.blue),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Text('USER'),
                activeIcon: Text(
                  'USER',
                  style: TextStyle(color: Colors.blue),
                ),
                label: '',
              ),
            ],
          );
        },
      ),
    );
  }
}

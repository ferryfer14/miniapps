import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bottom_navigation_view/bottom_navigation_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:miniapps/controller/controller.dart';
import 'package:miniapps/home/drawer/drawer.dart';
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
  bool hover_outlet = false;
  bool hover_order = false;
  bool hover_notification = false;
  bool hover_history = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget catalog() {
    return Material(
        color: Colors.white,
        child: InkWell(
            onTap: () {}, // Image tapped
            child: Text(
              'Catalog'.toUpperCase(),
              style: TextStyle(
                  fontFamily: "Proxima",
                  color: Theme.of(context).hintColor,
                  fontSize: 16),
            )));
  }

  Color setColor(bool hover) {
    if (hover) {
      return Color(0xffff972f);
    }
    return Color(0xff522D07);
  }

  Widget myoutlet() {
    return Container(
        child: GestureDetector(
            onPanDown: (_) {
              setState(() => hover_outlet = true);
            },
            onPanCancel: () {
              setState(() {
                hover_outlet = false;
              });
            },
            child: ElevatedButton(
                child: Column(children: [
                  SvgPicture.asset(
                    'assets/shop_icon.svg',
                    color: setColor(hover_outlet),
                    height: 50,
                    width: 50,
                    allowDrawingOutsideViewBox: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("My Outlet",
                      style: TextStyle(
                          fontSize: 14, color: setColor(hover_outlet)))
                ]),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff522D07))))),
                onPressed: () {
                  setState(() {});
                })));
  }

  Widget order() {
    return Container(
        child: GestureDetector(
            onPanDown: (_) {
              setState(() => hover_order = true);
            },
            onPanCancel: () {
              setState(() {
                hover_order = false;
              });
            },
            child: ElevatedButton(
                child: Column(children: [
                  SvgPicture.asset(
                    'assets/cart_icon.svg',
                    color: setColor(hover_order),
                    height: 50,
                    width: 50,
                    allowDrawingOutsideViewBox: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Order",
                      style:
                          TextStyle(fontSize: 14, color: setColor(hover_order)))
                ]),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff522D07))))),
                onPressed: () {
                  setState(() {});
                })));
  }

  Widget notification() {
    return Container(
        height: 150,
        child: GestureDetector(
            onPanDown: (_) {
              setState(() => hover_order = true);
            },
            onPanCancel: () {
              setState(() {
                hover_order = false;
              });
            },
            child: ElevatedButton(
                child: Column(children: [
                  SvgPicture.asset(
                    'assets/notification_icon.svg',
                    color: setColor(hover_order),
                    height: 50,
                    width: 50,
                    allowDrawingOutsideViewBox: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Notification",
                      style:
                          TextStyle(fontSize: 14, color: setColor(hover_order)))
                ]),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff522D07))))),
                onPressed: () {
                  setState(() {});
                })));
  }

  Widget history() {
    return Container(
        child: GestureDetector(
            onPanDown: (_) {
              setState(() => hover_order = true);
            },
            onPanCancel: () {
              setState(() {
                hover_order = false;
              });
            },
            child: ElevatedButton(
                child: Column(children: [
                  SvgPicture.asset(
                    'assets/history_icon.svg',
                    color: setColor(hover_order),
                    height: 50,
                    width: 50,
                    allowDrawingOutsideViewBox: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("History",
                      style:
                          TextStyle(fontSize: 14, color: setColor(hover_order)))
                ]),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Color(0xff522D07)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff522D07))))),
                onPressed: () {
                  setState(() {});
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: DrawerWidget(),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/bg.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Welcome\nPartner :)',
                                  style: TextStyle(
                                      fontSize: 24, fontFamily: "Proxima"),
                                ))),
                        Expanded(
                            child: Center(
                                child: Image.asset(
                          "assets/banner.jpg",
                          height: 150,
                        )))
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(child: Center(child: catalog()))
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: myoutlet(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: order())
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: notification(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: history())
                        ]),
                  ]),
            ))
          ])),
    );
  }
}

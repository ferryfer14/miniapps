import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniapps/model/gallery_model.dart';
import 'package:miniapps/model/place_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GalleryPage extends StatefulWidget {
  @override
  State createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool isLoading = false;
  TextEditingController search_controller = new TextEditingController();

  final _client = Get.put(GalleryModel());

  @override
  void initState() {
    super.initState();
    _client.onInit();
    setState(() {});
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget search() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: FormBuilderTextField(
          onChanged: (value) {
            onSearchTextChanged(value!);
          },
          controller: search_controller,
          textInputAction: TextInputAction.next,
          name: 'search',
          decoration: InputDecoration(
            labelText: 'Search',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            labelStyle: TextStyle(color: Colors.black87),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            counterText: "",
          ),
          style: TextStyle(height: 1, color: Colors.black),
        ));
  }

  onSearchTextChanged(String text) async {
    _client.search_item.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _client.list_item.forEach((userDetail) {
      if (userDetail.caption.toLowerCase().contains(text.toLowerCase())) {
        _client.search_item.add(userDetail);
      }
    });

    setState(() {});
  }

  Widget _view(list) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.4),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: list.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              list[index].caption,
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
                image: new DecorationImage(
              image: new NetworkImage(list[index].image),
              fit: BoxFit.fill,
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
        body: Column(children: [
      search(),
      Expanded(
          child: GetBuilder<GalleryModel>(
              init: GalleryModel(),
              builder: (data) => data.search_item.length != 0 ||
                      search_controller.text.isNotEmpty
                  ? _view(data.search_item)
                  : _view(data.list_item)))
    ]));
  }
}

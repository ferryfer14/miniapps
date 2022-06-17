import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniapps/model/place_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PlacePage extends StatefulWidget {
  @override
  State createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  bool isLoading = false;
  TextEditingController search_controller = new TextEditingController();

  final _client = Get.put(PlaceModel());

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
      if (userDetail.title.contains(text)) {
        _client.search_item.add(userDetail);
      }
    });

    setState(() {});
  }

  Widget _view(list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Colors.grey.shade200),
                  child: Image.network(
                    list[index].image.toString() == 'null'
                        ? list[index].media[0]
                        : list[index].image,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            list[index].title,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(list[index].content),
                      ],
                    ),
                  ),
                  flex: 100,
                )
              ],
            ),
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
          child: GetBuilder<PlaceModel>(
              init: PlaceModel(),
              builder: (data) => data.search_item.length != 0 ||
                      search_controller.text.isNotEmpty
                  ? _view(data.search_item)
                  : data.list_item.length != 0
                      ? _view(data.list_item)
                      : Container()))
    ]));
  }
}

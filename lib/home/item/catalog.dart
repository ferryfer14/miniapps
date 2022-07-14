import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniapps/model/catalog_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:miniapps/variable/global.dart' as global;

class CatalogPage extends StatefulWidget {
  @override
  State createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool isLoading = false;
  TextEditingController search_controller = new TextEditingController();

  final _client = Get.put(CatalogModel());

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

  Widget _view(list) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
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
                  child: CachedNetworkImage(
                    imageUrl: list[index].image,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.scaleDown,
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
                            list[index].name,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          list[index].price + '/kg',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          centerTitle: true,
          title: Text(
            'Catalog',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor),
            onPressed: () => Get.back(),
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          GetBuilder<CatalogModel>(
              init: CatalogModel(),
              builder: (data) => FutureBuilder<List<Catalog>>(
                  future: data.client_get(),
                  builder: (context, value) {
                    return data.list_item.length != 0
                        ? _view(data.list_item)
                        : Container();
                  }))
        ])));
  }
}

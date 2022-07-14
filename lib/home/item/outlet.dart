import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:miniapps/model/outlet_model.dart';

class OutletPage extends StatefulWidget {
  @override
  State createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> {
  bool isLoading = false;

  final _client = Get.put(OutletModel());

  @override
  void initState() {
    super.initState();
    _client.onInit();
    setState(() {});
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Theme.of(context).cardColor),
                  child: SvgPicture.asset(
                    'assets/shop_icon.svg',
                    color: Theme.of(context).primaryColor,
                    height: 30,
                    width: 30,
                    allowDrawingOutsideViewBox: true,
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
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          list[index].address,
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 12,
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
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          centerTitle: true,
          title: Text(
            'Franchise Outlet',
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
          GetBuilder<OutletModel>(
              init: OutletModel(),
              builder: (data) => FutureBuilder<List<Outlet>>(
                  future: data.client_get(),
                  builder: (context, value) {
                    return data.list_item.length != 0
                        ? _view(data.list_item)
                        : Container();
                  }))
        ])));
  }
}

import 'package:flutter/services.dart';
import 'package:fmc_salesman/Item_group_screen/item_group.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';


class Item_main extends StatefulWidget {
  Item_main({Key key}) : super(key: key);

  @override
  _Item_mainState createState() => _Item_mainState();
}

class _Item_mainState extends State<Item_main> {
  DateTime currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
    child:Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Item Main Group"),
        ),
        body: GridDemo()
    ));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      var message='exit_warning';
      showInSnackBar(message);
      SystemNavigator.pop();
     // Fluttertoast.showToast(msg: exit_warning);
      return Future.value(false);

    }

    return Future.value(true);

  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.whiteColor ,));
  }
}

class ItemData {
  final String url;
  final String title;
  final String id;
  ItemData({this.url,this.title,this.id});

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      id:json['id'],
      url: json['image'],
      title:json['etitle'],

    );
  }
}

class GridDemo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ItemData>>(
      future: _fetchItemData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ItemData> data = snapshot.data;
          return Grid(context, data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.whiteColor),));
      },
    );
  }

  Future<List<ItemData>> _fetchItemData() async {
    final jobsListAPIUrl = 'http://sharegiants.in/ruchi/itemmaingroup.php?action=fetch_all';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
Grid(context,data) {
  final width = MediaQuery.of(context).size.width;
  final height=MediaQuery.of(context).size.height;
  final containerh= height/2;
  if (height > 450 && width > 450 && width < 835  ) {
    //samsung tab vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //  height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFFECEFF1),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url,    height: containerh / 2.5,
                      width: width / 2,),
                    Container(
                      height: containerh / 15, width: width / 2,
                      child: Text(
                        data[index].title, textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ),
          );
        }
    );
  }
  else
  if (width > 450 && width < 835) {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.5),
            crossAxisCount: 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url, height: containerh / 1.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child: Text(
                          data[index].title, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else
  if (width < 450) {
    //samsung A51 vertical |
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.7),
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url, height: containerh / 3.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 21, width: width / 2,
                        child: Text(
                          data[index].title, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  else {
    //samsung A51 horizontal _____
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.45),
            crossAxisCount: 5),

        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(data[index].id);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) =>
                      ItemGroup(
                          itemid: data[index].id, itemtitle: data[index].title))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //  height: containerh,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network('http://sharegiants.in/ruchi/images/itemmaingroupimages/'+data[index].url, height: containerh / 1.5,
                        width: width / 2,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child: Text(
                          data[index].title, textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

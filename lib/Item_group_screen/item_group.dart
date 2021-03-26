import 'dart:convert';
import 'package:fmc_salesman/Item_group_screen/item_subgroup.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class ItemGroup extends StatefulWidget {
  final itemid;
  final itemtitle;

  ItemGroup({Key key, @required this.itemid,@required this.itemtitle}) : super(key: key);
  @override
  _ItemGroupState createState() => _ItemGroupState();
}

class ItemGrpData {
  final String url;
  final String title;
  final String id;
  ItemGrpData({this.url,this.title,this.id});

  factory ItemGrpData.fromJson(Map<String, dynamic> json) {
    return ItemGrpData(
      id:json['id'],
      url: json['image'],
      title:json['etitle'],

    );
  }
}

class _ItemGroupState extends State<ItemGroup> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemtitle),
      ),
      body: FutureBuilder<List<ItemGrpData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemGrpData> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.whiteColor),));
        },
      ),
    );
  }

  Future<List<ItemGrpData>> _fetchItemGrpData() async {
    final url = 'http://sharegiants.in/ruchi/itemgroup.php';
    var data = {
      'itemid': widget.itemid
    };
    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemGrpData.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

Grid(context, data) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final containerh = height / 2;
  if (height > 450 && width > 450 && width < 835  ) {
    print('samsung tab vertical |');
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
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
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'http://sharegiants.in/ruchi/images/itemgroupimages/' +
                          data[index].url,
                      height: containerh / 2.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 15,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });
  }else
  if (width > 450 && width < 835) {
    print('samsung A51 horizontal _____');
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
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
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'http://sharegiants.in/ruchi/images/itemgroupimages/' +
                          data[index].url,
                      height: containerh / 1.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 10,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });

  } else if (width < 450) {
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
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
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'http://sharegiants.in/ruchi/images/itemgroupimages/' +
                          data[index].url, height: containerh / 3.5,
                      width: width / 2,
                    ),
                    Container(
                      height: containerh / 21,
                      width: width / 2,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                //  ),
              ),
            ),
          );
        });
  }
  else {
    //samsung tab horizontal ----
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ItemSub(
                          itemsubid: data[index].id,
                          itemetitle: data[index].title)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: height / 3,
                width: width / 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'http://sharegiants.in/ruchi/images/itemgroupimages/' +
                            data[index].url,
                        height: containerh / 1.5,
                        width: width / 2,
                      ),
                      Container(
                        height: containerh / 10,
                        width: width / 2,
                        child: Text(
                          data[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

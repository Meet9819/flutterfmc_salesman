import 'dart:convert';
import 'package:fmc_salesman/Item_group_screen/item_group_list.dart';
import 'package:fmc_salesman/Item_group_screen/item_subgroup_list.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class ItemSub extends StatefulWidget {
  final itemsubid;
  final itemetitle;

  ItemSub({Key key, @required this.itemsubid, @required this.itemetitle}) : super(key: key);
  @override
  _ItemSubState createState() => _ItemSubState();
}

class ItemSubData {
  final String url;
  final String title;
  final String id;
  ItemSubData({this.url,this.title,this.id});

  factory ItemSubData.fromJson(Map<String, dynamic> json) {
    return ItemSubData(
      id:json['id'],
      url: json['image'],
      title:json['etitle'],

    );
  }
}

class _ItemSubState extends State<ItemSub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemetitle),
      ),
      body: FutureBuilder<List<ItemSubData>>(
        future: _fetchItemSubData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
print(widget.itemsubid);
              return ListItems(itemnull:widget.itemsubid);
            }
            List<ItemSubData> data = snapshot.data;
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.whiteColor),));
        },
      ),
    );
  }

  Future<List<ItemSubData>> _fetchItemSubData() async {
    final url = 'http://sharegiants.in/ruchi/itemsubgroup.php';
    var data = {
      'itemsubid': widget.itemsubid
    };
    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new ItemSubData.fromJson(job)).toList();
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
                      SubList_Items(
                        sublist: data[index].id, title: data[index].title,))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: 160,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFECEFF1),
                    ),
                    borderRadius: BorderRadius.circular(13), color: Colors.white
                ),
                // child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'http://sharegiants.in/ruchi/images/itemsubgroupimages/' +
                          data[index].url,   height: containerh / 2.5,
                      width: width / 2,),
                    // Image.network(data[index].url, height: 150, width: 200,),
                    Container(
                      height: containerh /15, width: width / 2,
                      child: Text(
                        data[index].title,
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
                      SubList_Items(
                        sublist: data[index].id, title: data[index].title,))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //height: 160,
                width: width/2,
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
                      Image.network(
                        'http://sharegiants.in/ruchi/images/itemsubgroupimages/' +
                            data[index].url, height: containerh / 1.5,
                        width: width / 2,),
                      // Image.network(data[index].url, height: 150, width: 200,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child:Text(
                          data[index].title,textAlign: TextAlign.center,
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
                      SubList_Items(
                        sublist: data[index].id, title: data[index].title,))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                //  height: 160,
                width: width/2,
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
                      Image.network(
                        'http://sharegiants.in/ruchi/images/itemsubgroupimages/' +
                            data[index].url, height: containerh / 3.5,
                        width: width / 2,),
                      // Image.network(data[index].url, height: 150, width: 200,),
                      Container(
                        height: containerh / 21, width: width / 2,
                        child:Text(
                          data[index].title,textAlign: TextAlign.center,
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
                      SubList_Items(
                        sublist: data[index].id, title: data[index].title,))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 160,
                width: 120,
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
                      Image.network(
                        'http://sharegiants.in/ruchi/images/itemsubgroupimages/' +
                            data[index].url, height: containerh / 1.5,
                        width: width / 2,),
                      // Image.network(data[index].url, height: 150, width: 200,),
                      Container(
                        height: containerh / 10, width: width / 2,
                        child:Text(
                          data[index].title,textAlign: TextAlign.center,
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
        }


    );
  }
}
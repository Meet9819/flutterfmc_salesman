import 'dart:convert';
import 'package:fmc_salesman/Item_group_screen/detail_page.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String invoiceprice;
getStringValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  invoiceprice=prefs.getString('invoiceprice');


}
class ListItems extends StatefulWidget {
  final itemnull;

  ListItems({Key key, @required this.itemnull}) : super(key: key);
  @override
  _ListItemsState createState() => _ListItemsState();
}

class ItemGrpData {
  final String itemid;
  final String img;
  final String itemname_en;
  final String labelname;
  final String itempack;
  final String itemstrength;
  final String itemmaingrouptitle;
  final String itemgrouptitle;
  final String itemproductgrouptitle;
  final String itemproductgroupimage;
  final String type;
  final String itemdosageid;
  final String itemclassid;
  final String manufactureshortname;
  final String seq;
  final String maxretailprice;
  final String minretailprice;
  final String rs;
  final String origin;
  final String whichcompany;
  final String allowsonapp;
  final String status;
  final String shortdescription;
  final String description;
  final String additionalinformation;
  final String itemproductgroupid;
  final String url;
final String itemgroupid;
  final String ws;
  final String minwsprice;
  final String maxwsprice;
  ItemGrpData(
      {this.itemid,
      this.img,
      this.itemname_en,
      this.labelname,
      this.itempack,
      this.itemstrength,
      this.itemmaingrouptitle,
      this.itemgrouptitle,
      this.itemproductgrouptitle,
      this.itemproductgroupimage,
      this.type,
      this.itemdosageid,
      this.itemclassid,
      this.manufactureshortname,
      this.seq,
      this.maxretailprice,
      this.minretailprice,
      this.rs,
      this.origin,
      this.whichcompany,
      this.allowsonapp,
      this.status,
      this.shortdescription,
      this.description,
      this.additionalinformation,
      this.itemproductgroupid,this.url,this.itemgroupid,this.ws,this.maxwsprice,this.minwsprice});

  factory ItemGrpData.fromJson(Map<String, dynamic> json) {
    return ItemGrpData(
        itemid: json['itemid'],
        img: json['img'],
        itemname_en: json['itemname_en'],
        labelname: json['labelname'],
        itempack: json['itempack'],
        itemstrength: json['itemstrength'],
        itemmaingrouptitle: json['itemmaingrouptitle'],
        itemgrouptitle: json['itemgrouptitle'],
        itemproductgrouptitle: json['itemproductgrouptitle'],
        itemproductgroupimage: json['itemproductgroupimage'],
        type: json['type'],
        itemdosageid: json['itemdosageid'],
        itemclassid: json['itemclassid'],
        manufactureshortname: json['manufactureshortname'],
        seq: json['seq'],
        maxretailprice: json['maxretailprice'],
        minretailprice: json['minretailprice'],
        rs: json['rs'],
        origin: json['origin'],
        whichcompany: json['whichcompany'],
        allowsonapp: json['allowsonapp'],
        status: json['status'],
        shortdescription: json['shortdescription'],
        description: json['description'],
        additionalinformation: json['additionalinformation'],
        itemproductgroupid: json['itemproductgroupid'],
      url: json['image'],
        itemgroupid:json['itemgroupid'],
        ws: json['ws'],
        maxwsprice: json['maxwsprice'],
        minwsprice:json['minwsprice']);
  }
}

class _ListItemsState extends State<ListItems> {
  @override
  void initState() {
    super.initState();
    getStringValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ItemGrpData>>(
        future: _fetchItemGrpData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemGrpData> data = snapshot.data;
            print(invoiceprice);
            return Grid(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),

    );

  }

  Future<List<ItemGrpData>> _fetchItemGrpData() async {
    final url = 'http://sharegiants.in/ruchi/list_groupitems.php';
    var data = {'itemid': widget.itemnull};
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
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    itemBuilder: (context, index) {
      print(data[index]);
      return InkWell(

          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListDetails(todo: data[index],invoiceprice:invoiceprice)));
          },
          // var finalprice = data[index].price;

          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.5),
                    top: BorderSide(color: Colors.grey[300], width: 1.5),
                  )),
              height: 100.0,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5.0)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                       image: DecorationImage(
                            image:
                                NetworkImage('http://sharegiants.in/ruchi/images/item/'+data[index].img),
                            fit: BoxFit.fill)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              data[index].itemproductgrouptitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,

                            ),
                          ),
                        ]),
                        SizedBox(height: 5),
                        Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              data[index].itemmaingrouptitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13.0,color:LightColor.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                        SizedBox(height: 5),

                      invoiceprice==null || invoiceprice=='Retail'?
                        getprice(data[index].maxretailprice,
                            data[index].minretailprice):  getprice(data[index].maxwsprice, data[index].minwsprice)



                        /* Row(
      children: <Widget>[
                            Expanded(
                              child: Text(
                                data[index].minretailprice,
                                style: TextStyle(fontWeight: FontWeight
                                    .w600, fontSize: 15.0),overflow: TextOverflow.ellipsis,),
                            ),]),*/
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ));
    },
  );
}

getprice(max, min) {
  if (max == min) {
    return Row(children: <Widget>[
      Expanded(
        child: Text(
          "\QR ${max}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color:LightColor.blueColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  } else {
    return Row(children: <Widget>[
      Text(
        "\QR ${max}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color:LightColor.blueColor),
        overflow: TextOverflow.ellipsis,
      ),
      Text(" - "),
      Text(
        "\QR ${min}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color:LightColor.blueColor),
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}

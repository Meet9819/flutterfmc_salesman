import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';



class related_products {
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
final String itemmaingroupid;
  related_products({this.itemid,
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
    this.itemproductgroupid,this.url,this.itemmaingroupid,
  });
//List data;
  factory related_products.fromJson(Map<String, dynamic> json) {
    return related_products(
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
        itemmaingroupid:json['itemmaingroupid'],

    );
  }
}
class Related_products extends StatefulWidget {
  final id;

  Related_products({Key key, @required this.id}) : super(key: key);
  @override
  _related_productsState createState() => _related_productsState();
}


class _related_productsState extends State<Related_products> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<related_products>>(
      future: _fetchrelated_products(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<related_products> data = snapshot.data;
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.whiteColor),));
      },
    );
  }

  Future<List<related_products>> _fetchrelated_products() async {
    final jobsListAPIUrl = 'http://sharegiants.in/ruchi/related_product.php';
    print(widget.id);
    var data = {'itemid':widget.id};
    final response = await http.post(jobsListAPIUrl, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new related_products.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
imageSlider(context,data) {
  return
    /*new ListView(

    children: <Widget>[
      Container(
       height: 160,
        //width:100,*/

    ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(


                onTap: () {
                 /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListDetails(todo: data[index])));*/
                },
            child: Card(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: 100,
                            height:100,
                            child:  new Image.network(
                              'http://sharegiants.in/ruchi/images/item/'+data[index].img,
                              fit: BoxFit.fitWidth,
                              width: 100,
                            )

                        ),
                        SizedBox(height: 10,),
                        SizedBox( width: 120, height:20,
                            child: Padding( padding: EdgeInsets.only(left: 10,),
                              child: Text(data[index].itemname_en, textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,color:LightColor.whiteColor)),

                            ) ),
//Divider(),
                        SizedBox( width: 120, height:20,

                            child: Padding( padding: EdgeInsets.only(left: 15,),
                              child:Text("\QR ${data[index].maxretailprice} ", textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color:LightColor.whiteColor)),
                            ) ),





                      ]
                  ),

                )

            )

        );
      },

      //   ),
      //   ),

//    ],

    );
}



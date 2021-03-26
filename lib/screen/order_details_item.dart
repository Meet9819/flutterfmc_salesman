import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';



class order_details {
  final String order_item_id;
  final String order_id;
  final String itemcode;
  final String item_name;
  final String batch;
  final String expirydate;
  final String units;
  final String packing;
  final String order_item_quantity;
  final String foc;
  final String extrabonus;
  final String disprice;
  final String order_item_price;
  final String order_item_actual_amount;
  final String order_item_final_amount;
  final String img;


  order_details({this.order_item_id,
    this.order_id,
    this.itemcode,
    this.item_name,
    this.batch,
    this.expirydate,
    this.units,
    this.packing,
    this.order_item_quantity,
    this.foc,
    this.extrabonus,
    this.disprice,
    this.order_item_price,
    this.order_item_actual_amount,
    this.order_item_final_amount,
    this.img,


  });
//List data;
  factory order_details.fromJson(Map<String, dynamic> json) {
    return order_details(
      order_item_id: json['order_item_id'],
      order_id: json['order_id'],
      itemcode: json['itemcode'],
      item_name: json['item_name'],
      batch: json['batch'],
      expirydate: json['expirydate'],
      units: json['units'],
      packing: json['packing'],
      order_item_quantity: json['order_item_quantity'],
      foc: json['foc'],
      extrabonus: json['extrabonus'],
      disprice: json['disprice'],
      order_item_price: json['order_item_price'],
      order_item_actual_amount: json['order_item_actual_amount'],
      order_item_final_amount: json['order_item_final_amount'],
      img: json['img'],



    );
  }
}
class OrderdetailsItemsDemo extends StatefulWidget {
  final id;
  OrderdetailsItemsDemo({Key key, @required this.id}) : super(key: key);
  //List data;
  @override
  _OrderdetailsItemsDemoState createState() => _OrderdetailsItemsDemoState();
}

class _OrderdetailsItemsDemoState extends State<OrderdetailsItemsDemo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<order_details>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<order_details> data = snapshot.data;
          //print('hii');
          return imageSlider(context, data);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(LightColor.whiteColor),));
      },
    );
  }

  Future<List<order_details>> _fetchJobs() async {
    final jobsListAPIUrl = 'http://sharegiants.in/ruchi/myorders_salesman_detail.php';
    var data = {'order_id':widget.id};
    final response = await http.post(jobsListAPIUrl, body: json.encode(data));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new order_details.fromJson(job)).toList();
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
                              child: Text(data[index].item_name, textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,)),

                            ) ),
//Divider(),
                        SizedBox( width: 120, height:20,

                            child: Padding( padding: EdgeInsets.only(left: 15,),
                              child:Text("\QR ${data[index].order_item_price} x ${data[index].order_item_quantity}", textAlign: TextAlign.left,
                                  // softWrap: true,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,)),
                            ) ),


                        Chip(
                          backgroundColor: LightColor.blueColor,
                          label: Text('QR ${data[index].order_item_actual_amount}',      style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),),
                        ),



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



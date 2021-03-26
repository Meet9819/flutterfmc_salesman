import 'package:fmc_salesman/Sales_Order/generate_sales_order.dart';
import 'package:fmc_salesman/home_screen.dart';
import 'package:fmc_salesman/screen/myorders_detail.dart';
import 'package:fmc_salesman/screen/profile_page.dart';
import 'package:fmc_salesman/screen/serach_screen.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class OrderItem {
  final String order_id;
  final String sales_localrfqid;
  final String whichcompany;
  final String whichbranch;
  final String soreferenceno;
  final String soorderprifix;
  final String customername;
  final String name;
  final String customeremail;
  final String customertype;
  final String localpo;
  final String attach;
  final String employeeid;
  final String employee_tbl_id;
  final String order_date;
  final String order_total_before_tax;
  final String order_total_after_tax;
  final String order_datetime;
  final String status;
  final String notess;
  final String typeoflead;

  // final String email;
  OrderItem({
    this.order_id,
    this.sales_localrfqid,
    this.whichcompany,
    this.whichbranch,
    this.soreferenceno,
    this.soorderprifix,
    this.customername,
    this.name,
    this.customeremail,
    this.customertype,
    this.localpo,
    this.attach,
    this.employeeid,
    this.employee_tbl_id,
    this.order_date,
    this.order_total_before_tax,
    this.order_total_after_tax,
    this.order_datetime,
    this.status,
    this.notess,
    this.typeoflead,

  });
//List data;
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      order_id: json['order_id'],
      sales_localrfqid: json['sales_localrfqid'],
      whichcompany: json['whichcompany'],
      whichbranch: json['whichbranch'],
      soreferenceno: json['soreferenceno'],
      soorderprifix: json['soorderprifix'],
      customername: json['customername'],
      name: json['name'],
      customeremail: json['customeremail'],
      customertype: json['customertype'],
      localpo: json['localpo'],
      attach: json['attach'],
      employeeid: json['employeeid'],
      employee_tbl_id: json['employee_tbl_id'],
      order_date: json['order_date'],
      order_total_before_tax: json['order_total_before_tax'],
      order_total_after_tax: json['order_total_after_tax'],
      order_datetime: json['order_datetime'],
      status: json['status'],
      notess: json['notess'],
      typeoflead: json['typeoflead'],


    );
  }
}

class myorder extends StatefulWidget {
  @override
  _myorderState createState() => _myorderState();
}

class _myorderState extends State<myorder> {
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id = prefs.getString('id');
    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    return Scaffold(
      appBar: AppBar(title: Text("My Orders"), automaticallyImplyLeading: false,),
      body: FutureBuilder<List<OrderItem>>(
        future: _fetchmyorder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderItem> data = snapshot.data;
            if (snapshot.data.length == 0) {
              return Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                  child: Image.asset("assets/cart.png"));
            }

            return imageSlider(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.whiteColor),
              ));
        },
      ),

        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 3, // Use this to update the Bar giving a position
            onTap: (index){
              if(index==0){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
              else if(index==1){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => UserFilterDemo()));
              }
              else if(index==2){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Generate_Sales()));
              }
              else if(index==3){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => myorder()));
              }
              else if(index==4){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyProfile()));
              }
              print("Selected Index: $index");
            },
            items: [
              TitledNavigationBarItem(title: Text('Home'), icon: Icons.home,),
              TitledNavigationBarItem(title: Text('Search'), icon: Icons.search),
              TitledNavigationBarItem(title: Text('Customer'), icon: Icons.people),
              TitledNavigationBarItem(title: Text('Orders'), icon: Icons.shopping_cart),
              TitledNavigationBarItem(title: Text('Profile'), icon: Icons.person_outline),
            ]
        )
    );
  }

  Future<List<OrderItem>> _fetchmyorder() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'http://sharegiants.in/ruchi/myorders_salesman.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse.map((item) => new OrderItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {
//int total=0;
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {

          return InkWell(
              onTap: () {
                //print(data[index].id);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) =>
                        myorderdetail(todo:data[index]))
                );
              },
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  // height: 150.0,
                  child: Row(
                    children: <Widget>[

                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                          data[index].name ,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,color: Colors.blue,
                                              fontSize: 13.0),
                                          overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Text(
                                      "\  Document No ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0),textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        data[index].whichcompany+'/'+data[index].whichbranch+'/'+data[index].order_id ,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),



                                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                                  //Icon(icon.),
                                  Text(
                                    "\  Order Date ",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      data[index].order_date,
                                      style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold,),
                                    ),
                                  ),

                                ]),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                                  Text(
                                    "\  Status",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  if(data[index].status=='1')(
                                      Center(
                                          child: Chip(
                                            backgroundColor: Colors.green,
                                            label: Text(
                                              'Approved',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: LightColor.whiteColor),
                                            ),)
                                      )
                                  )
                                  else   if(data[index].status=='0')(
                                      Center(
                                          child: Chip(
                                            backgroundColor: Colors.red,
                                            label: Text(
                                              'Not Approved',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: LightColor.whiteColor),
                                            ),)
                                      )
                                  )
                                    else(
                                      Center(
                                          child: Chip(
                                            backgroundColor: Colors.blue,
                                            label: Text(
                                             data[index].status,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: LightColor.whiteColor),
                                            ),)
                                      )
                                  ),
                                ]),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ));
        },
      ),
    );

  }
}

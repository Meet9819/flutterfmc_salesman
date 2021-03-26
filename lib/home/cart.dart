import 'package:flutter/services.dart';
import 'package:fmc_salesman/home/order_summary.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

var totalid;
String invoiceprice,selectedcustbranch;


class CartItem {
  final String item_code;
  final String user_id;

  final String img;
  final String itemname_en;
  final String qty;
  final String cust_type;
  final String foc;
  final String ex_foc;
  final String disc;
  final String rs;
  final String ws;

  // final String email;
  CartItem(
      {this.item_code,
      this.user_id,
      this.img,
      this.itemname_en,
      this.qty,
      this.cust_type,
      this.foc,
      this.ex_foc,
      this.disc,
      this.rs,
      this.ws});
//List data;
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        item_code: json['item_code'],
        user_id: json['user_id'],
        img: json['img'],
        itemname_en: json['itemname_en'],
        qty: json['qty'],
        cust_type: json['cust_type'],
        foc: json['foc'],
        ex_foc: json['ex_foc'],
        disc: json['disc'],
        rs: json['rs'],
        ws: json['ws']);
  }
}

class TotalItem {
  final String Total;

  // final String email;
  TotalItem({
    this.Total,
  });
//List data;
  factory TotalItem.fromJson(Map<String, dynamic> json) {
    return TotalItem(
      Total: json['Total'],
    );
  }
}

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String quantity, fixed_foc, allocated_foc, ex_foc, disc;
  List<int> _counter_ = List();
  List<int> finalprice = List();
  int sump;
  int sum;
  int price;
  var total;

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String cust_id = prefs.getString('cust_id');
    return cust_id;
  }
  getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    invoiceprice = prefs.getString('invoiceprice');
    selectedcustbranch=prefs.getString('selectedcustbranch');
    return selectedcustbranch;
  }
  int counter = 0;
  int subTotal = 0;
  //final productprice;

  void increment(price, counter) {
    setState(() {
      counter++;
      // finalprice = double.parse(price) * counter;
    });
  }

  void decrement(price, counter) {
    setState(() {
      counter--;

      //finalprice = double.parse(price) * counter;
    });
  }

  Future addquantity(finalprice, quantity, id) async {
    print(finalprice);
    print(id);
    print(quantity);
    var data = {'finalprice': finalprice, 'quantity': quantity, 'id': id};
    var url = 'http://sharegiants.in/ruchi/update_cart.php';
    var response = await http.post(url, body: json.encode(data));
  }

  Future removecart(id) async {
    print(id);
    dynamic token = await getStringValues();

    var url = 'http://sharegiants.in/ruchi/removecart.php';
    var data = {'id': id};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);
    setState(() {
      _fetchCartItem();
    });
  }

  Future update_cart(item_code) async {
    dynamic cust_id = await getStringValues();

    // SERVER API URL
    var url = 'http://sharegiants.in/ruchi/salesman_update_cart.php';
    // print(firstname);print(lastname);print(email);
    // Store all data with Param Name.
    var data = {
      'item_code': item_code,
      'cust_id': cust_id,
      'quantity': quantity,
      'fixed_foc': fixed_foc,
      'allocated_foc': allocated_foc,
      'ex_foc': ex_foc,
      'disc': disc
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    //showInSnackBar(message);
    _fetchCartItem();
  }

  @override
  void initState() {
    super.initState();
    getStringValues();getStringValues();
  }

  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart_>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
        appBar: AppBar(title: Text("Cart List")),
        body: Column(children: <Widget>[
          Expanded(
            child: FutureBuilder<List<CartItem>>(
              future: _fetchCartItem(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CartItem> data = snapshot.data;
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(LightColor.blueColor),
                ));
              },
            ),
          ),
          Container(
            height: 80,
            child: Total_screen(),
          ),
        ]),
        floatingActionButton: Container(
            height: 50.0,
            width: 150.0,
            //child: FittedBox(
            child: FloatingActionButton.extended(
              //  icon: Icon(Icons.add_shopping_cart),
              //  label: Text("Add to Cart"),
              backgroundColor: LightColor.whiteColor,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Order_SummaryScreen()));
              },
              // icon: Icon(Icons.save),
              label: Center(
                  child: Text(
                "Proceed",
                style: TextStyle(
                    fontSize: 18,
                    color: LightColor.blueColor,
                    fontWeight: FontWeight.bold),
              )),
            )));
  }

  Future<List<CartItem>> _fetchCartItem() async {
    dynamic token = await getStringValues();
    dynamic branch = await getvalues();
    print(token); print(branch);
    var data = {'userid': token,'selectedcustbranch':selectedcustbranch};
    var url = 'http://sharegiants.in/ruchi/salesman_cart.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    int total = 0;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        quantity = data[index].qty;
        fixed_foc = data[index].foc;
        ex_foc = data[index].ex_foc;
        allocated_foc = '';
        disc = data[index].disc;
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: InkWell(
                onTap: () {
                  update_cart(data[index].item_code);
                },
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[100], width: 1.0),
                          top: BorderSide(color: Colors.grey[100], width: 1.0),
                        )),
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 5.0)
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'http://sharegiants.in/ruchi/images/item/' +
                                          data[index].img),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 100.0,
                          width: 100.0,
                          child: Column(children: <Widget>[
                            Text(
                              '${data[index].item_code} - ${data[index].itemname_en}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )
                          ]),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 90,
                            child: Column(children: <Widget>[

                              if (invoiceprice == null ||
                                  invoiceprice == 'Retail')
                                (Text(
                                  "\QR ${data[index].rs}",
                                  style: TextStyle(
                                      fontSize: 15, //fontWeight: FontWeight.bold
                                  ),
                                ))
                              else if (invoiceprice == 'Wholesale')
                                (Text(
                                  "\QR ${data[index].ws}",
                                  style: TextStyle(
                                      fontSize: 15, //fontWeight: FontWeight.bold
                                  ),
                                )),

                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 90,
                            child: Column(children: <Widget>[
                              Text(
                                'Qty',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              TextFormField(
                                initialValue: quantity,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true),
                                onChanged: (text) {
                                  quantity = text;
                                },
                              ),
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 90,
                            child: Column(children: <Widget>[
                              Text(
                                'Fixed FOC',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              TextFormField(
                                  initialValue: fixed_foc,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                  onChanged: (text) {
                                    fixed_foc = text;
                                  }),
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 120,
                            child: Column(children: <Widget>[
                              Text(
                                'Allot. FOC',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              TextFormField(
                                  initialValue: allocated_foc,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                  onChanged: (text) {
                                    allocated_foc = text;
                                  }),
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 90,
                            child: Column(children: <Widget>[
                              Text(
                                'Ex FOC',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              TextFormField(
                                  initialValue: ex_foc,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                  onChanged: (text) {
                                    ex_foc = text;
                                  }),
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 90,
                            child: Column(children: <Widget>[
                              Text(
                                'Disc%',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              TextFormField(
                                  initialValue: disc,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                  onChanged: (text) {
                                    disc = text;
                                  }),
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 90,
                            child: Column(children: <Widget>[
                              Text(
                                'Disc',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              TextFormField(
                                  initialValue: disc,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                  onChanged: (text) {
                                    disc = text;
                                  }),
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: 90,
                            child: Column(children: <Widget>[
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              TextFormField(

                                  // initialValue: '',
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true)),
                            ])),
                      ],
                    ),
                  ),
                )));
      },
    );
  }
}

class Total_screen extends StatefulWidget {
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total_screen> {
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
      // appBar: AppBar(title: Text("Cart List")),
      body: Column(children: <Widget>[
        Expanded(
          child: FutureBuilder<List<TotalItem>>(
            future: _fetchTotal(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TotalItem> data = snapshot.data;
                if (snapshot.data.length == 0) {
                  return Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                      child: Image.asset("assets/cart.png"));
                }

                return totalSlider(context, data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.blueColor),
              ));
            },
          ),
        ),
      ]),
    );
  }

  Future<List<TotalItem>> _fetchTotal() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'http://sharegiants.in/ruchi/total.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    // _finalprice_= jsonResponse["price"].map((item) => new Item.fromJson(item)).toList();

    return jsonResponse.map((item) => new TotalItem.fromJson(item)).toList();
  }

  totalSlider(context, data) {
    int total = 0;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        totalid = data[index];
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                height: 10.0,
                width: 10.0,
                child: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "\ Total Amount ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            if (data[index].Total == null)
                              (Text(
                                "\ QR 0",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ))
                            else
                              (Text(
                                "\ QR ${data[index].Total}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          ]))),
            ],
          ),
        );
      },
    );
  }
}

totalprice(int sum) {
  return sum;
}

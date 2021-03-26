import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' ;

List<int> itemcode = List();
List<int> quantity = List();
List<double> price = List();
List<String> itemname = List();
List<int> foc = List();
List<int> ex_foc = List();
String cust_id;String credit_limit;String credit_days; String cust_type; String cust_email,cust_name,invoiceprice,selectedcustbranch;
String useridValue;
getStringValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  cust_email=prefs.getString('cust_email');
  cust_type=prefs.getString('cust_type');
  credit_days=prefs.getString('credit_days');
  credit_limit=prefs.getString('credit_limit');
  cust_id=prefs.getString('cust_id');
  cust_name=prefs.getString('cust_name');
  invoiceprice = prefs.getString('invoiceprice');
  selectedcustbranch=prefs.getString('selectedcustbranch');
 useridValue = prefs.getString('id');
}
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



class Order_SummaryScreen extends StatefulWidget {
  //final addid, total;
 // Order_SummaryScreen({Key key, @required this.addid, @required this.total})
   //   : super(key: key);
  @override
  _Order_SummaryScreenState createState() => _Order_SummaryScreenState();
}

class _Order_SummaryScreenState extends State<Order_SummaryScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getStringValues();Order_SummaryScreen();
  }
  final sorefController = TextEditingController();
  final typeleadController = TextEditingController();
  final orderplaceController = TextEditingController();
  final emailController = TextEditingController();
  final mobilenoController = TextEditingController();
  final notesController = TextEditingController();
  Future salesorder() async {
    itemcode = itemcode.toSet().toList();
    print(useridValue); print(itemcode); print(quantity); print(price); print(itemname);print(foc);print(ex_foc);
    var data = {
      'invoiceprice': invoiceprice,
      'cust_name': cust_name,
      'cust_email': cust_email,
      'cust_type':cust_type,
      'itemcode': itemcode,
      'quantity': quantity,
      'price':price,
      'itemname':itemname,
      'foc':foc,
      'ex_foc':ex_foc,
      'soref':sorefController.text,
      'typelead':typeleadController.text,
      'orderplace':orderplaceController.text,
      'email':emailController.text,
      'mobileno':mobilenoController.text,
      'notes':notesController.text,
      'user_id':useridValue
    };
    var url = 'http://sharegiants.in/ruchi/salesman_confirm_order.php';

   var response = await http.post(url, body: json.encode(data));
    itemcode.clear();
    quantity.clear();
    price.clear();
    itemname.clear();
    foc.clear();ex_foc.clear();
  }
  /* @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ]);
  }*/
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);*/
    print(cust_id);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Order Summary")),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Text(
                  "Customer Details",
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 2),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Invoice Price",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Name ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                             'Email',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Mobile ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Type ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$cust_id',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                             '$cust_name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              " $cust_email ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$cust_id ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              " $cust_type",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      ]),

                    ],
                  ),
                ),
                Container(
                  // height: 110*d,
                  height: 200,
                  child: Summary_Cart(),
                ),
Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Container(
     child: Column(      crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
Text('Other Details',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
       SizedBox(height: 10,),
           Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
             Container(
               width: width/2.3,
               child: Text(
                 "SO Reference No",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
               ),),
             SizedBox(
               width: width/38,
             ),
             Container(
               width: width/2.3,
               child: Text(
                 "Type Of Lead",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
               ),),
           ]),
           Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
             Container(
               width: width/2.3,
               child:    TextFormField(
                 controller: sorefController,
                 keyboardType: TextInputType.emailAddress,
                 // initialValue: '29435618224',
                 decoration: InputDecoration(

                     border: InputBorder.none,
                     fillColor: Color(0xfff3f3f4),
                     filled: true
                 ),),),
             SizedBox(
               width: width/38,
             ),
             Container(
               width: width/2.3,
               child: TextFormField(

                   controller: typeleadController,
                   // initialValue: '',
                   decoration: InputDecoration(
                       border: InputBorder.none,
                       fillColor: Color(0xfff3f3f4),
                       filled: true)),),
           ]),

       SizedBox(
         height: 10,
       ),
           Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
             /*SizedBox(
            width: 10,
          ),*/
             Container(
               width: width/3.6,
               child:Text(
                 "Order Placed By",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
               ),),
             SizedBox(
               width: width/38,
             ),
             Container(
               width: width/3.6,
               child:Text(
                 "Email",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
               ),),
             SizedBox(
               width: width/38,
             ),
             Container(
               width: width/3.6,
               child: Text(
                 "Mobile No",
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
               ),),
           ]),
           Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
             /*SizedBox(
            width: 10,
          ),*/
             Container(
               width: width/3.6,
               child:   TextFormField(
                 controller: orderplaceController,
                 keyboardType: TextInputType.emailAddress,
                 // initialValue: '29435618224',
                 decoration: InputDecoration(

                     border: InputBorder.none,
                     fillColor: Color(0xfff3f3f4),
                     filled: true
                 ),),),
             SizedBox(
               width: width/38,
             ),
             Container(
               width: width/3.6,
               child:  TextFormField(

                   controller: emailController,
                   // initialValue: '',
                   decoration: InputDecoration(
                       border: InputBorder.none,
                       fillColor: Color(0xfff3f3f4),
                       filled: true)),),
             SizedBox(
               width: width/38,
             ),
             Container(
               width: width/3.6,
               child:     TextFormField(

                   controller: mobilenoController,
                   // initialValue: '',
                   decoration: InputDecoration(
                       border: InputBorder.none,
                       fillColor: Color(0xfff3f3f4),
                       filled: true)),),
           ]),

       SizedBox(
         height: 10,
       ),
       Text(
         "Notes",
         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
       ),
       TextField(
           maxLines: 4,
           keyboardType: TextInputType.multiline,
           controller: notesController,
           decoration: InputDecoration(
               border: InputBorder.none,
               fillColor: Color(0xfff3f3f4),
               filled: true)
       ),
        ])
  ),
)


              ]),
            ),
          ])),
      floatingActionButton: Container(
          height: 50.0,
          width: 150.0,
          //child: FittedBox(
          child: FloatingActionButton.extended(
            //  icon: Icon(Icons.add_shopping_cart),
            //  label: Text("Add to Cart"),
            backgroundColor: LightColor.blueColor,
            onPressed: () {

              salesorder();
            },
            // icon: Icon(Icons.save),
            label: Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                      fontSize: 18,
                      color: LightColor.whiteColor,
                      fontWeight: FontWeight.bold),
                )),
          )),

    );

  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.blueColor ,));
  }
}

class Summary_Cart extends StatefulWidget {
  @override
  _Summary_CartState createState() => _Summary_CartState();
}

class _Summary_CartState extends State<Summary_Cart> {

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String cust_id = prefs.getString('cust_id');
    return cust_id;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<List<CartItem>>(
        future: _fetchItem(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CartItem> data = snapshot.data;
            if (snapshot.data.length == 0) {
              return Image.asset("assets/empty-cart.png");
            }

            return imageSlider(context, data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.blueColor),
              ));
        },
      ),
    );
  }

  Future<List<CartItem>> _fetchItem() async {
    dynamic token = await getStringValues();
    print(token);
    var data = {'userid': token};
    var url = 'http://sharegiants.in/ruchi/salesman_cart.php';
    var response = await http.post(url, body: json.encode(data));

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new CartItem.fromJson(item)).toList();
  }

  imageSlider(context, data) {
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        double finalprice;
        int id = int.parse(data[index].item_code);
        int qt=int.parse(data[index].qty);
        int foc_ = int.parse(data[index].foc);
        int ex_foc_=int.parse(data[index].ex_foc);
        String itemen=   data[index].itemname_en;
        itemname.add(itemen);
        quantity.add(qt);
       foc.add(foc_);
       ex_foc.add(ex_foc_);
        itemcode.add(id);
        if (invoiceprice == null ||
            invoiceprice == 'Retail') {
          finalprice = double.parse(data[index].rs) *
              double.parse(data[index].qty);
          double pr=double.parse(data[index].rs); price.add(pr);
        } else if (invoiceprice == 'Wholesale'){
         finalprice = double.parse(data[index].ws) *
              double.parse(data[index].qty);
         double pr=double.parse(data[index].ws); price.add(pr);
        }
        return Container(
          width: width/2,
            child:
          InkWell(
            onTap: () {},
            child: Card(
                child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Row(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        width: 100,
                        height: 80,
                        child: new Image.network(
                          'http://sharegiants.in/ruchi/images/item/' +
                              data[index].img,
                          fit: BoxFit.fitWidth,
                          width: 100,
                        )),
                    Column( children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(

                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            data[index].item_code, textAlign: TextAlign.left,
                            // softWrap: true,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: LightColor.blueColor),

                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,width: 200,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Text(
                              data[index].itemname_en, textAlign: TextAlign.left,
                              // softWrap: true,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.blueColor),
                              overflow: TextOverflow.ellipsis, maxLines: 4,
                            ),
                          ),
                        ),]),
                    ]),
//Divider(),

                    if (invoiceprice == null ||
                        invoiceprice == 'Retail')
                      (

                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                       child: Row(
                            children: <Widget>[ Text(
                                "\QR ${data[index].rs} x ${data[index].qty} = ${finalprice.toString()}",
                               // textAlign: TextAlign.left,
                                // softWrap: true,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: LightColor.blueColor)),
                         ] )))
                    else if (invoiceprice == 'Wholesale')
                      (  Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),

                            child:
                            Row(
                                children: <Widget>[
                                  Text(
                                "\QR ${data[index].ws} x ${data[index].qty} = ${finalprice.toString()}",
                              //  textAlign: TextAlign.left,
                                // softWrap: true,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: LightColor.blueColor)),
                         ] ))),

                    //  SizedBox( width: 120, height:20,
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    "\FOC ${data[index].foc}",
                   // textAlign: TextAlign.left,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: LightColor.blueColor)),
                Text(
                    "\Extra FOC ${data[index].ex_foc}",
                    // textAlign: TextAlign.left,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: LightColor.blueColor)),
              ]),
                    //  child:
                    Chip(
                      backgroundColor: LightColor.blueColor,
                      label: Text(
                        'QR ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ]),
                ))));
      },
    );
  }
}

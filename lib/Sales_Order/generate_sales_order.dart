import 'dart:convert';
import 'dart:io';

import 'package:fmc_salesman/Sales_Order/add_new_customer.dart';
import 'package:fmc_salesman/home_screen.dart';
import 'package:fmc_salesman/screen/myorders.dart';
import 'package:fmc_salesman/screen/profile_page.dart';
import 'package:fmc_salesman/screen/serach_screen.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';


class Generate_Sales extends StatefulWidget {
  @override
  _Generate_Sales_State createState() => _Generate_Sales_State();
}

class _Generate_Sales_State extends State<Generate_Sales> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String selectedvalue,email,cust_type,credit_days,credit_limit,selectedcustbranch,staticValue,invoiceprice,invoicetype,cust_name;


  @override
  void initState() {
    super.initState();
    getallvalue();
  }
  List dropdata = List();
  List custbranchdata=List();

  addStringTo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print(email);print(cust_type);print(credit_days);print(credit_limit);print(selectedvalue);
    prefs.setString('cust_email', email,);
    prefs.setString('cust_type', cust_type,);
    prefs.setString('credit_days', credit_days,);
    prefs.setString('credit_limit', credit_limit,);
    prefs.setString('cust_id', selectedvalue,);
    prefs.setString('invoiceprice', invoiceprice,);
    prefs.setString('invoicetype', invoicetype,);
    prefs.setString('cust_name', cust_name);
    prefs.setString('selectedcustbranch', selectedcustbranch);
    //  print(user_id);
  }

  Future getallvalue() async {
    var response = await http.post(
        'http://sharegiants.in/ruchi/salesman_dropdown.php',);
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);
    setState(() {
      dropdata = jsondata;
    });
  }
  Future getcustbranchdata() async {
    var url = 'http://sharegiants.in/ruchi/salesman_get_customer_branch.php';
    var data = {'custid': selectedvalue};
    var response = await http.post(url, body: json.encode(data));
print(selectedvalue);

    var jsondata = json.decode(response.body);

    setState(() {
      custbranchdata = jsondata;
    });
    // }
  }
  Future getselectedvalue() async {
    var url = 'http://sharegiants.in/ruchi/salesman_selected_dropdown.php';
    var data = {'custid': selectedvalue};
    var response = await http.post(url, body: json.encode(data));


    var jsondataval = json.decode(response.body);

    return jsondataval;
    // }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: LightColor.yellowColor,
      appBar: AppBar(
        title: Text("Generate Sales Order"),automaticallyImplyLeading: false,

        // backgroundColor: LightColor.midnightBlue,
      ),

      body: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:10 ,),

            Text(
                  "Select Customer",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff3f3f4),
                   ),

                child:
                DropdownButton(
                  value: selectedvalue,
                  hint: Text("Select CustomerName"),
                  items: dropdata.map(
                        (list) {

                          print(invoiceprice);
                      return DropdownMenuItem(
                          child: SizedBox(
                            width: width/1.17,
                            child: Text(list['customername']),
                          ),
                          value: list['id']);
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedvalue = value;

                      getselectedvalue();
                      getcustbranchdata();
                    });
                  },
                ),
              ),
              selectedvalue != null
                  ? Container(
                 // height: height/1.2,
                  child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Text(
                          "Select Branch of Customer",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Container(
                          width:width,

                              padding: const EdgeInsets.only(left: 10.0,),
                              decoration: BoxDecoration(

                                  color: Color(0xfff3f3f4),
                                 ),
                          child:
                          DropdownButton(
                            value: selectedcustbranch,
                            hint: Text("Select Customer Branch"),
                            items: custbranchdata.map(
                                  (list) {
                                return DropdownMenuItem(
                                    child: SizedBox(
                                      width: width/1.2,
                                      child: Text(list['branchname']),
                                    ),
                                    value: list['id']);
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedcustbranch = value;

                              });
                            },
                          ),
                        ),
                      Container(
                    height: height/1.7,
                     width: width,
                     child:   FutureBuilder(
                      future: getselectedvalue(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Text(
                                "No data on this itempack");
                          }
                          return ListView.builder(
                              itemCount:
                              snapshot.data.length,
                              itemBuilder:
                                  (context, index) {
                                var list =
                                snapshot.data[index];
email= list['cemail'];cust_name= list['customername']; cust_type=list['type']; credit_days=list['creditdays']; credit_limit=list['creditlimits'];   invoiceprice=list['invoiceprice'];invoicetype=list['invoicetype'];
                                addStringTo();
                                return
                              Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Text(
                                            "Customer Email Id",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                          TextFormField(

                                            keyboardType: TextInputType.emailAddress,
                                            initialValue: list['cemail'],
                                            decoration: InputDecoration(

                                                border: InputBorder.none,
                                                fillColor: Color(0xfff3f3f4),
                                                filled: true
                                            ),),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: width/3.6,
                                                  child:Text(
                                                    "Customer Type",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  )),
                                              SizedBox(
                                                width: width/38,
                                              ),
                                              Container(
                                                width: width/3.6,
                                                child: Text(
                                                  "Credit Limit",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                ),),
                                              SizedBox(
                                                width: width/38,
                                              ),
                                              Container(
                                                width: width/3.6,
                                                child: Text(
                                                  "Credit Days",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: width/3.6,
                                                child:  TextFormField(

                                                    initialValue: list['type'],
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        fillColor: Color(0xfff3f3f4),
                                                        filled: true)),
                                              ),
                                              SizedBox(
                                                width: width/38,
                                              ),
                                              Container(
                                                width: width/3.6,
                                                child:   TextFormField(

                                                  keyboardType: TextInputType.emailAddress,
                                                  initialValue: list['creditlimits'],
                                                  decoration: InputDecoration(

                                                      border: InputBorder.none,
                                                      fillColor: Color(0xfff3f3f4),
                                                      filled: true
                                                  ),),
                                              ),
                                              SizedBox(
                                                width: width/38,
                                              ),
                                              Container(
                                                width:  width/3.6,
                                                child:TextFormField(

                                                  keyboardType: TextInputType.emailAddress,
                                                  initialValue: list['creditdays'],
                                                  decoration: InputDecoration(

                                                      border: InputBorder.none,
                                                      fillColor: Color(0xfff3f3f4),
                                                      filled: true
                                                  ),),
                                              )
                                            ],
                                          ),


                                          SizedBox(height:10 ,),
                                          ButtonTheme(
                                              minWidth: width,
                                              height: 40.0,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                                },
                                                color: LightColor.blueColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Text("Confirm",
                                                    style: TextStyle(
                                                        color: LightColor.whiteColor,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold)),
                                              )),
                                        ]);

                              });
                        }
                        return Text("No data found");
                      }))]))
                  : Container(
               child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height:10 ,),
                      Text(
                        "Select Branch of Customer",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                  Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f4),
                      ),
                      child:
               DropdownButton<String>(
               value: staticValue,
                 hint: Text("Select Customer Branch"),
                 onChanged: (String newValue) {
                   setState(() {
                     staticValue = newValue;
                   });
                 },
                 items: <String>['Select Customer Name']
                     .map<DropdownMenuItem<String>>((String value) {
                   return DropdownMenuItem<String>(

                     value: value,
                       child: SizedBox(
                       width: 350,
                       child: Text(value),
                       ),
                   );
                 }).toList(),
               )),
                      SizedBox(height:10 ,),
                      Text(
                        "Customer Email Id",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextFormField(

                        keyboardType: TextInputType.emailAddress,
                        // initialValue: '29435618224',
                        decoration: InputDecoration(

                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true
                        ),),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: width/3.6,
                              child:Text(
                                "Customer Type",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          SizedBox(
                            width: width/38,
                          ),
                          Container(
                            width: width/3.6,
                            child: Text(
                              "Credit Limit",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),),
                          SizedBox(
                            width: width/38,
                          ),
                          Container(
                            width: width/3.6,
                            child: Text(
                              "Credit Days",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width/3.6,
                            child:  TextFormField(


                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true)),
                          ),
                          SizedBox(
                            width: width/38,
                          ),
                          Container(
                            width: width/3.6,
                            child:   TextFormField(

                              keyboardType: TextInputType.emailAddress,

                              decoration: InputDecoration(

                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true
                              ),),
                          ),
                          SizedBox(
                            width: width/38,
                          ),
                          Container(
                            width:  width/3.6,
                            child:TextFormField(

                              keyboardType: TextInputType.emailAddress,

                              decoration: InputDecoration(

                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true
                              ),),
                          )
                        ],
                      ),
                      SizedBox(height:10 ,),
                      ])
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add_new_cust()));
        },
        child: Icon(Icons.add),
        backgroundColor:LightColor.blueColor,
      ),
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 2, // Use this to update the Bar giving a position
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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.blueColor,
    ));
  }
}

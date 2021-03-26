import 'dart:convert';
import 'dart:io';

import 'package:fmc_salesman/home_screen.dart';
import 'package:fmc_salesman/screen/myorders.dart';
import 'package:fmc_salesman/screen/profile_page.dart';
import 'package:fmc_salesman/screen/serach_screen.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';


class Add_new_cust extends StatefulWidget {
  @override
  _Add_new_cust_State createState() => _Add_new_cust_State();
}

class _Add_new_cust_State extends State<Add_new_cust> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final custnameController = TextEditingController();
  final custemailController = TextEditingController();
  final custmobileController = TextEditingController();
  final cust_typeController = TextEditingController();
  final remarksController = TextEditingController();
  int selectedRadioTile, selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      print(selectedRadioTile);
    });
  }
  Future addnewcust() async {
    // Showing CircularProgressIndicator.


    // Getting value from Controller
    String customername = custnameController.text;
    String custemail = custemailController.text;
    String mobileno = custmobileController.text;
    String cust_type = cust_typeController.text;
    String remarks = remarksController.text;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (mobileno.length != 8) {
      showInSnackBar("Invalid Mobile No");
      //showToast('Invalid Mobile No', gravity: Toast.BOTTOM, duration: 3);
    } else if (customername.length == 0 ||
        cust_type.length == 0 ) {
      showInSnackBar("Field Should not be empty");

    } else if (!regex.hasMatch(custemail)) {
      showInSnackBar("Enter Valid Email");

    } else {
      // SERVER API URL
      var url = 'http://sharegiants.in/ruchi/Salesman_new_customer.php';

      // Store all data with Param Name.
      var data = {
        'customername': customername,
        'custemail': custemail,
        'mobileno': mobileno,
        'cust_type': cust_type,
        'remarks': remarks,

      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);


      custnameController.clear();
      custemailController.clear();
      custmobileController.clear();
      cust_typeController.clear();

      showInSnackBar(message);
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        // backgroundColor: LightColor.yellowColor,
        appBar: AppBar(
          title: Text("New Customer"),

          // backgroundColor: LightColor.midnightBlue,
        ),

        body: new SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Container(
                    width: width/2.3,
                    child: Text(
                      "Enter Customer Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),),
                  SizedBox(
                    width: width/38,
                  ),
                  Container(
                    width: width/2.3,
                    child: Text(
                      "Customer Email Id",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Container(
                    width: width/2.3,
                    child: TextFormField(
                      controller: custnameController,
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
                    child:  TextFormField(

                        controller: custemailController,
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
                  Container(
                    width: width/2.3,
                    child: Text(
                      "Customer Mobile ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),),
                  SizedBox(
                    width: width/38,
                  ),
                  Container(
                    width: width/2.3,
                    child: Text(
                       " Customer Type",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Container(
                    width: width/2.3,
                    child: TextFormField(
                      controller: custmobileController,
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
                    child:  TextFormField(

                        controller: custemailController,
                        // initialValue: '',
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true)),),
                ]),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Container(
                  width: width/2.3,
                  child:  RadioListTile(
                  value: 1,
                  groupValue: selectedRadioTile,
                  title: Text(
                    "Request For New Customer",
                    style: TextStyle(
                        fontSize: 14,
                        color: LightColor.blueColor,
                        fontWeight: FontWeight.bold),
                  ),
                  // subtitle: Text("Cash / Card On Delivery"),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    setSelectedRadioTile(val);
                  },
                  activeColor: LightColor.blueColor,
                )),
              SizedBox(
                width: width/38,
              ),
              Container(
                  width: width/2.3,
                  child:  RadioListTile(
                  value: 2,
                  groupValue: selectedRadioTile,
                  title: Text(
                    "Visit to Customer",
                    style: TextStyle(
                        fontSize: 14,
                        color: LightColor.blueColor,
                        fontWeight: FontWeight.bold),
                  ),
                  // subtitle: Text("Radio 2 Subtitle"),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    setSelectedRadioTile(val);
                  },
                  activeColor: LightColor.blueColor,

                  selected: false,
                )),]),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                    minWidth: width,
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () {
                        addnewcust();
                      },
                      color: LightColor.blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("Save",
                          style: TextStyle(
                              color: LightColor.whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                    )),
              ],
            ),
          ),
        ),


    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: LightColor.blueColor,
    ));
  }
}

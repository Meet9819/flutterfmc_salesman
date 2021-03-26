import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fmc_salesman/Item_group_screen/item_main.dart';
import 'package:fmc_salesman/Sales_Order/generate_sales_order.dart';
import 'package:fmc_salesman/home/cart.dart';
import 'package:fmc_salesman/home/chart.dart';
import 'package:fmc_salesman/screen/myorders.dart';
import 'package:fmc_salesman/screen/profile_page.dart';
import 'package:fmc_salesman/screen/serach_screen.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:fmc_salesman/widget/AppDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'home/home_slider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  //final String email;

// Receiving Email using Constructor.
  // HomeScreen ({Key key, @required this.email}) : super(key: key);
  @override
  _HomeStateScreen createState() => _HomeStateScreen();
}

class _HomeStateScreen extends State<HomeScreen> {

  String email;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String useridValue = prefs.getString('userid');
    print(useridValue);
    //return useridValue;
    setState(() {
      email = prefs.getString("email");
      // id = prefs.getString('userid');
    });
  }
  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;


  static const routeName = "/";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();getStringValuesSF();
    GetConnect(); // calls getconnect method to check which type if connection it
  }

// Receiving Email using Constructor.

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
    resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Family Medical Company",),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.star,
              color: LightColor.whiteColor,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Item_main()));
              // do something
            },
          ),

          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: LightColor.whiteColor,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
              // do something
            },
          ),

        ],


      ),
      drawer: AppDrawer(),
      //drawer:  AppDrawer(),
      body: isInternetOn
          ? iswificonnected ? new SliderPage() : new SliderPage()
          : nointernet(),
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 0, // Use this to update the Bar giving a position
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

  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {
      iswificonnected = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      iswificonnected = true;
      setState(() async {
        wifiBSSID = await (Connectivity().getWifiBSSID());
        wifiIP = await (Connectivity().getWifiIP());
        wifiName = await (Connectivity().getWifiName());
      });
    }
  }
}

nointernet(){
  return Stack(
      children: <Widget>[
        Image.asset(
          "assets/no-int.gif",

        ),
        Center(child: Text( "\n\n\n\n  No Internet Connection",
          style: TextStyle(
              fontSize: 24,
              color: LightColor.whiteColor,
              fontWeight: FontWeight.bold),)),
      ]
  );
}
AlertDialog buildAlertDialog() {
  return AlertDialog(

    title: Text(
      "No Internet Connection Failed to Connect to Family Medical Company. Please Check your Device's network connection and try again",
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  );
}

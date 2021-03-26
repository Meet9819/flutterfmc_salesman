import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc_salesman/home_screen.dart';
import 'package:fmc_salesman/screen/report.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  //final String email;
  @override
  static const Color blueColor = Color.fromRGBO(0, 146, 238, 1);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var username;
//var userid;
  var id;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String useridValue = prefs.getString('userid');
    print(useridValue);
    //return useridValue;
    setState(() {
      username = prefs.getString("email");
      id = prefs.getString('userid');
    });
  }

  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String useridValue = prefs.getString('id');
    print(useridValue);
    //return useridValue;
    setState(() {
      // username = prefs.getString("email");
      id = prefs.getString('id');
    });
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF();
    getStringValues();
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppDrawer.blueColor),
              accountName: Text(
                '${username}',
                style:
                TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(1.0)),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                    ? new Color(0xFF0062ac)
                    : Colors.white,

                child:InkWell(
                  onTap: (){

                  },
                  child: Icon(
                    Icons.person,
                    size: 50,

                  ),

                ),

              ),

            ),
            //  DrawerHeader(

            //   child: Container(
            //     child: Text('${email}', style: TextStyle(color: Colors.white.withOpacity(1.0)),),
            //     alignment: Alignment.bottomLeft, // <-- ALIGNMENT
            //    height: 10,
            //    ),
            //  decoration: BoxDecoration(
            //       color: midnightBlue
            //   ),
            //   ),
            Divider(),
            ListTile(
              leading: new Image.asset("assets/Drawer/allcategories.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('Home',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),





            ListTile(
              leading: new Image.asset("assets/Drawer/advertise.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('Report',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Report()));
              },
            ),

            Divider(color: AppDrawer.blueColor),
            ListTile(
              leading: new Image.asset("assets/Drawer/delivery.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('All Branches',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),
            ListTile(
              leading: new Image.asset("assets/Drawer/aboutus.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('About Us',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),

            ListTile(
              leading: new Image.asset("assets/Drawer/contactus.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('Contact Us',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),
            Divider(color: AppDrawer.blueColor),
            ListTile(
              leading: new  Icon(Icons.star,
                  size: 25.0, color: AppDrawer.blueColor),
              title: Text('Rate App',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),
            ListTile(
              leading: new Icon(Icons.share,
                  size: 25.0, color: AppDrawer.blueColor),
              title: Text('Share App',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {
                final RenderBox box = context.findRenderObject();
                Share.share(

                    '\n\n Shop online on Qatar’s Most trusted pharmacy with a wide collection of items ranging from personal care, Baby care, Home care products, Medical equipment & supplements we are the healthcare with best priced deals we offer Home delivery across Qatar.'+
                        '\n\n https://www.onlinefamilypharmacy.com/'
                    ,
                    subject:"this is the subject",
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
              },
            ),
            ListTile(
              leading: new  Icon(Icons.message,
                  size: 25.0, color: AppDrawer.blueColor),
              title: Text('FAQ',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),
            ListTile(
              leading: new Image.asset("assets/Drawer/terms.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('Terms & Condition',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),

            ListTile(
              leading: new Image.asset("assets/Drawer/privacy.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('Privacy Policy',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),

            ListTile(
              leading: new  Icon(Icons.note,
                  size: 25.0, color: AppDrawer.blueColor),
              title: Text('Delivery Information',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),

            ListTile(
              leading: new  Icon(Icons.refresh_sharp,
                  size: 25.0, color: AppDrawer.blueColor),
              title: Text('Refund & Replacement',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),
            Divider(color: AppDrawer.blueColor),
            ListTile(
              leading: new Image.asset("assets/Drawer/logout.png",
                  width: 20.0, color: AppDrawer.blueColor),
              title: Text('Log Out',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              onTap: () {

              },
            ),
          ],
        ));
  }
}

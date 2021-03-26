import 'package:flutter/material.dart';
import 'package:fmc_salesman/Sales_Order/generate_sales_order.dart';
import 'package:fmc_salesman/home_screen.dart';
import 'package:fmc_salesman/screen/change_pwd.dart';
import 'package:fmc_salesman/screen/logout.dart';
import 'package:fmc_salesman/screen/myorders.dart';
import 'package:fmc_salesman/screen/serach_screen.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:fmc_salesman/widget/AppDrawer.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class MyProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title:Text("Profile"),
        automaticallyImplyLeading: false,
      ),
     // drawer:  AppDrawer(),
      body:
      UserProfilePage(),

    );
  }
}

class UserProfilePage extends StatefulWidget {

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  dynamic id;
  var userid;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return String
    setState(() {
      userid = prefs.getString("id");
    });
  }
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id=prefs.getString('id');
    setState(() {
      id=user_id;
    });
    return user_id;
  }
  @override
  void initState() {
    super.initState();
    getStringValuesSF();
  }
  String _fullName = "Meet Shah";
  //dynamic token = await getStringValues();
  final String _status = "Meetshah9819@gmail.com";

  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";

  final String _followers = "173";

  final String _posts = "24";

  final String _scores = "450";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.0,
      decoration: BoxDecoration(
        // image: DecorationImage(
        //    image: AssetImage('assets/cover.jpeg'),
        //    fit: BoxFit.cover,
        //  ),
        color: LightColor.blueColor,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/avtar.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        // color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        'Salesman Id ' + userid,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }






  Widget _changepassword() {
    return  Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => changepwd()));
            },
            child: ListTile(
              leading: Icon(Icons.vpn_key,color: Colors.blue, size: 30),
              title: Text('Change Password'),

            ),

          ) ],
      ),
    );
  }
  Widget _logout() {
    return  Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => logout()));
            },
            child:  ListTile(
              leading: Icon(Icons.lock,color: Colors.blue, size: 30),
              title: Text('Logout'),

            ),

          )  ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(

      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 4),
                  _buildProfileImage(),
                  SizedBox(height: 15.0),
                 // _buildFullName(),
                  _buildStatus(context),

                  SizedBox(height: 10.0),
                  // _buildGetInTouch(context),
                  SizedBox(height: 8.0),

                  SizedBox(height: 8.0),
                  _changepassword(),
                  SizedBox(height: 8.0),
                  _logout(),
                  SizedBox(height: 20.0),
                  Center(child: Text('Version 1.0')),
                ],
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 4, // Use this to update the Bar giving a position
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
}
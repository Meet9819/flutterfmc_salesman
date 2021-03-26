import 'package:flutter/material.dart';
import 'package:fmc_salesman/home_screen.dart';
import 'package:fmc_salesman/themes/lightcolor.dart';
import 'package:fmc_salesman/widget/bezierContainer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() async{
// checkLogin();
//WidgetsFlutterBinding.ensureInitialized();
//SharedPreferences preferences= await SharedPreferences.getInstance();
//var email =preferences.getString("email");
//await FlutterSession().set("token", email);
//runApp(MaterialApp(home: email== null?  LoginScreen() : HomeScreen(),));
//}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email=emailController.text;
    String id=salesman_id;
    prefs.setString('email', email,);
    // prefs.setString('userid', id,);
    //  print(user_id);
  }
  addStringTo(user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id=user_id;
    // prefs.setString('email', email,);
    prefs.setString('id', id,);
    //  print(user_id);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //checkLogin();
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email =prefs.getString("email");
    // bool _seen = (prefs.getBool('seen') ?? false);
    if(email == null)
    {

      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    }
    else {
      // prefs.setBool('seen', true);

      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomeScreen()));
    }

  }

  @override
  // For CircularProgressIndicator.
  bool visible = false;
  var salesman_id;
  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("email", emailController.text);
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;
    if (
    email.length == 0 ||
        password.length == 0) {
      showInSnackBar("Field Should not be empty");

    }
    print(email); print(password);
    // SERVER LOGIN API URL
    var url = 'http://sharegiants.in/ruchi/login_salesman.php';
    // Store all data with Param Name.
    var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    var url1 = 'http://sharegiants.in/ruchi/getsalesmanid.php';
    // Store all data with Param Name.
    var data1 = {'qatarid': email };

    // Starting Web API Call.
    var response1 = await http.post(url1, body: json.encode(data1));
    setState(() {
      salesman_id = jsonDecode(response1.body);
      print(salesman_id);
      addStringTo(salesman_id);
    });
    // If the Response Message is Matched.
    if (message == 'Login Matched') {


      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;

      });
      // print(user_id);
      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      showInSnackBar(message);
      // Showing Alert Dialog with Response JSON Message.
      /* showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );*/
    }
  }


  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }




  Widget _title() {
    return Center(
      child: Column(
        children: <Widget>[

          Image.asset('assets/logo.png'),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Text(
          "Qatar Id",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        TextFormField(
          controller: emailController,
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
        Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        TextFormField(
            obscureText: true,
          controller: passwordController,
           // initialValue: '',
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],

    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .3),
                      _title(),
                      SizedBox(height: 70),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      Center(
                        child: ButtonWid(
                          onClick: userLogin,

                          btnText: " Salesman Login",
                        ),

                      ),


                      SizedBox(height:5),



                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value),backgroundColor:LightColor.whiteColor ,));
  }
}

class ButtonWid extends StatelessWidget {
  var btnText ="";
  var onClick;


  ButtonWid({this.btnText, this.onClick});
  Color blue = Colors.lightBlue;
  static const Color midnightBlue = const Color.fromRGBO(1, 4, 99,1);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onClick,

        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50),),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [blue,blue])),
          child: InkWell(
            child: Text(
              ' Salesman Login',
              style: TextStyle(fontSize: 20, color:Colors.white,fontWeight: FontWeight.bold),
            ),


          ),
        )
    );
  }
}



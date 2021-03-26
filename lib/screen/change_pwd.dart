import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class changepwd extends StatefulWidget {


  @override
  _changepwdState createState() => _changepwdState();
}

class _changepwdState extends State<changepwd> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>(); bool changepwd=false;
  final oldpwdController = TextEditingController();
  final newpwdController = TextEditingController();
  final renewpwdController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  getStringValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    String user_id=prefs.getString('id');
    return user_id;
  }
  Future changepass() async {
    // Showing CircularProgressIndicator.

    // Getting value from Controller
    String oldpwd = oldpwdController.text;
    String newpwd = newpwdController.text;
    String renewpwd = renewpwdController.text;
    if (oldpwd.length == 0 ||
        newpwd.length == 0 ||
        renewpwd.length == 0 ) {
      showInSnackBar("Field Should not be empty");

    }
    else if(newpwd!=renewpwd){
      showInSnackBar("Password and confirm password is not matched");
    }
    else {
      // SERVER API URL
      var url = 'http://sharegiants.in/ruchi/changepwd.php';
      dynamic token = await getStringValues();
      // Store all data with Param Name.
      var data = {
        'oldpwd': oldpwd,
        'newpwd': newpwd,
        'userid':token

      };
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      if(message=='Old password is incorrect..!') {
        showInSnackBar(message);
      }
      else {
        showInSnackBar(message);
        oldpwdController.clear();
        newpwdController.clear();
        renewpwdController.clear();
      }
    }
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        key: _scaffoldKey,
        // backgroundColor: LightColor.yellowColor,
        appBar: AppBar(
          title: Text('Reset Password'),
         //
        ),

        body: Column(
            children: <Widget>[
              Expanded(
                  child: Container(

                      child:Form(
                          key: _form,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Text('Old Password',  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 10),
                                  TextFormField(
                                      obscureText: true,
                                      controller: oldpwdController,
                                      decoration: InputDecoration(
                                          hintText: 'Old Password',
                                          border: InputBorder.none,
                                          fillColor:
                                          Color(0xfff3f3f4),
                                          filled: true),
                                      validator: (val){
                                        if(val.isEmpty)
                                          return 'Empty';
                                        return null;
                                      }),
                                  SizedBox(height: 40),
                                  Text('New Password',  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 10),
                                  TextFormField(
                                      obscureText: true,
                                      controller: newpwdController,
                                      decoration: InputDecoration(
                                          hintText: 'New Password',
                                          border: InputBorder.none,
                                          fillColor:
                                          Color(0xfff3f3f4),
                                          filled: true),
                                      validator: (val){
                                        if(val.isEmpty)
                                          return 'Empty';
                                        return null;
                                      }),
                                  SizedBox(height: 20),
                                  Text('Re-Enter New Password',  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),),SizedBox(height: 10),
                                  TextFormField(
                                      obscureText: true,
                                      controller: renewpwdController,
                                      decoration: InputDecoration(
                                          hintText: 'Re-Enter New Password',
                                          border: InputBorder.none,
                                          fillColor:
                                          Color(0xfff3f3f4),
                                          filled: true),
                                      validator: (val){
                                        if(val.isEmpty)
                                          return 'Empty';
                                        if(val != newpwdController.text)
                                          return 'Not Match';
                                        return null;
                                      }),


                                  SizedBox(height: 10),

                                  SizedBox(height: 10),
                                  ButtonTheme(
                                    minWidth: 400.0,
                                    height: 50.0,
                                    child: RaisedButton(
                                      //     disabledColor: Colors.red,
                                      // disabledTextColor: Colors.black,
                                      padding:
                                      const EdgeInsets.all(
                                          20),
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      onPressed: changepass,
                                      child:
                                      Text('Change Password',  style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  )
                                ]),
                          ))

                  ))]),

    );
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value),backgroundColor:Colors.blue ,));
  }
}
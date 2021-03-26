import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmc_salesman/screen/spash_screen.dart';
import 'package:fmc_salesman/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

    return MaterialApp(
      title: 'Family Pharmacy Group',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),

    );
  }
}

// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:younify/tabs/google_maps.dart';
import 'package:younify/tabs/location_provider.dart';
import 'package:younify/views/Authentication/signin.dart';

//import 'main_screen.dart';

//void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //need to add if we want to initialize our main method
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
          child: MapLive(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ARent Search',
          theme: themeData(),
          home: SignIn()),
      //home: MainScreen(),
    );
  }
}

ThemeData themeData() {
  return ThemeData(
      primarySwatch: Colors.cyan,
      accentColor: Colors.deepPurple,
      canvasColor: Colors.white,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      textTheme: TextTheme(
        headline1:
            GoogleFonts.josefinSans(fontSize: 97, fontWeight: FontWeight.w300),
        headline2:
            GoogleFonts.josefinSans(fontSize: 61, fontWeight: FontWeight.w300),
        headline3:
            GoogleFonts.josefinSans(fontSize: 48, fontWeight: FontWeight.w400),
        headline4:
            GoogleFonts.josefinSans(fontSize: 34, fontWeight: FontWeight.w400),
        headline5:
            GoogleFonts.josefinSans(fontSize: 24, fontWeight: FontWeight.w400),
        headline6:
            GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.w500),
        subtitle1:
            GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.w400),
        subtitle2:
            GoogleFonts.josefinSans(fontSize: 14, fontWeight: FontWeight.w500),
        bodyText1:
            GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.w400),
        bodyText2:
            GoogleFonts.josefinSans(fontSize: 14, fontWeight: FontWeight.w400),
        button:
            GoogleFonts.josefinSans(fontSize: 14, fontWeight: FontWeight.w500),
        caption:
            GoogleFonts.josefinSans(fontSize: 12, fontWeight: FontWeight.w400),
        overline:
            GoogleFonts.josefinSans(fontSize: 10, fontWeight: FontWeight.w400),
      ));
}

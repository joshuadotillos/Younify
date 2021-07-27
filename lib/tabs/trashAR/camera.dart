import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';

import 'report.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, _route);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              // colorFilter: new ColorFilter.mode(
              //     Colors.black.withOpacity(0.0), BlendMode.multiply),
              image: AssetImage('assets/pixelCamera.png'),
              // image: NetworkImage(
              //     'https://firebasestorage.googleapis.com/v0/b/recipesharingapp-58437.appspot.com/o/images%2Ftest5.png?alt=media&token=97889664-844a-4f2f-abb6-e404d9942a46'),
              fit: BoxFit.cover),
        ),
        //color: Colors.grey,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitRing(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  void _route() {
    // Navigator.of(context).pop();
    // reportPopup(context, _currentAddress, LocationProvider().locationPosition);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Camera())); //it transitions you to a new route
  }
}

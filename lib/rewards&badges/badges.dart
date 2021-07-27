import 'package:flutter/material.dart';

class Badges extends StatefulWidget {
  @override
  _BadgesState createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Badges.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Rewards extends StatefulWidget {

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Rewards.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
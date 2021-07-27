import 'package:younify/main_screen.dart';
import 'package:younify/rewards&badges/badges.dart';
import 'package:younify/rewards&badges/rewards.dart';
import 'package:younify/tabs/profile.dart';
import 'package:flutter/material.dart';

int selectIndex = 0;

class RewardsBadges extends StatefulWidget {
  @override
  _RewardsBadgesState createState() => _RewardsBadgesState();
}

class _RewardsBadgesState extends State<RewardsBadges> {
  void itemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            ('Younify'),
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '20 Points',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
          leading: new IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              icon: new Icon(Icons.arrow_back)),
          bottom: TabBar(labelColor: Colors.black, tabs: <Tab>[
            Tab(
              child: Text(
                'REWARDS',
                style: TextStyle(fontFamily: 'Gibson'),
              ),
            ),
            Tab(
              child: Text(
                'BADGES',
                style: TextStyle(fontFamily: 'Gibson'),
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            Rewards(),
            Badges(),
          ],
        ),
      ),
    );
  }
}

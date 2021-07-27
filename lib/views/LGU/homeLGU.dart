import 'package:flutter/material.dart';
import 'package:younify/views/Authentication/signin.dart';
import 'package:younify/views/LGU/requests.dart';
import 'package:younify/views/NGO/events.dart';

int selectIndex = 0;

class MyHomePageLGU extends StatefulWidget {
  MyHomePageLGU({required this.title});
  final String title;

  @override
  _MyHomePageLGUState createState() => _MyHomePageLGUState();
}

class _MyHomePageLGUState extends State<MyHomePageLGU> {
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
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                }),
          ],
          bottom: TabBar(labelColor: Colors.black, tabs: <Tab>[
            Tab(
              child: Text(
                'STATISTICS',
                style: TextStyle(fontFamily: 'Gibson'),
              ),
            ),
            Tab(
              text: 'REQUESTS',
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            Events(),
            RequestsLGU(),
          ],
        ),
      ),
    );
  }
}

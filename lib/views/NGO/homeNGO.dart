import 'package:flutter/material.dart';
import 'package:younify/views/Authentication/signin.dart';
import 'package:younify/views/NGO/events.dart';
import '../map.dart';
import 'requests.dart';

int selectIndex = 0;

class MyHomePageNGO extends StatefulWidget {
  MyHomePageNGO({required this.title, required this.username});
  final String title;
  final String username;

  @override
  _MyHomePageNGOState createState() => _MyHomePageNGOState();
}

class _MyHomePageNGOState extends State<MyHomePageNGO> {
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
                  'EVENTS',
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
              //trashARMaps(username: widget.username),
              Events(),
              RequestsNGO(),
            ],
          ),
          floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.pin_drop),
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Maps(username: widget.username)));
              })),
    );
  }
}

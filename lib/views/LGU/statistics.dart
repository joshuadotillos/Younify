import 'package:flutter/material.dart';

int selectIndex = 0;

class Statistics extends StatefulWidget {
  @override
  _Statistics createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Statistics!'),
        ],
      ),
    ));
  }
}

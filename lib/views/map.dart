import 'package:flutter/material.dart';
import 'package:younify/tabs/trashAR/trasharMaps.dart';

int selectIndex = 0;

class Maps extends StatefulWidget {
  final String username;

  Maps({required this.username});
  @override
  _Maps createState() => _Maps();
}

class _Maps extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('choose a pinpoint'),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: trashARMaps(username: widget.username),
        ));
  }
}

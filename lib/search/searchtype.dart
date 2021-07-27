import 'package:younify/tabs/filterchips.dart';
import 'package:younify/tabs/home.dart';
import 'package:flutter/material.dart';

class SearchType extends StatefulWidget {
  final Function trial;

  SearchType({required this.trial});
  @override
  _SearchTypeState createState() => _SearchTypeState();
}

class _SearchTypeState extends State<SearchType> {
  void _addInput(List propType) {
    widget.trial(propType);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              filterTitles("Property types"),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      FilterChipWidget(
                          chipName: 'Boarding House', list: propertyType),
                      FilterChipWidget(
                          chipName: 'Apartment', list: propertyType),
                      FilterChipWidget(
                          chipName: 'Dormintory', list: propertyType),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _addInput(propertyType);
              print('pop propertyType is: ${propertyType.length}');
            },
            child: Text('Okay'))
      ],
    );
  }
}

List propertyType = [];

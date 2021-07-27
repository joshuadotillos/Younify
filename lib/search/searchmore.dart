import 'package:younify/tabs/filterchips.dart';
import 'package:younify/tabs/home.dart';
import 'package:flutter/material.dart';

class SearchMore extends StatefulWidget {
  final Function trial;

  SearchMore({required this.trial});
  @override
  _SearchMoreState createState() => _SearchMoreState();
}

class _SearchMoreState extends State<SearchMore> {
  void _addInput(List propMore) {
    widget.trial(propMore);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
          child: Column(
        children: [
          filterTitles("Rooms and beds"),
          Text('insert number of rooms (plus minus widget)'),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
          filterTitles("Amenities"),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 5.0,
                runSpacing: 3.0,
                children: <Widget>[
                  FilterChipWidget(chipName: 'Elevator', list: moreFilters),
                  FilterChipWidget(chipName: 'Kitchen', list: moreFilters),
                  FilterChipWidget(
                      chipName: 'Air conditioning', list: moreFilters),
                  FilterChipWidget(chipName: 'Wifi', list: moreFilters),
                  FilterChipWidget(chipName: 'Garden', list: moreFilters),
                  FilterChipWidget(chipName: 'Parking', list: moreFilters),
                  FilterChipWidget(chipName: 'Security', list: moreFilters),
                  FilterChipWidget(
                      chipName: 'Wheelchair access', list: moreFilters),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
          filterTitles("House Rules"),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 5.0,
                runSpacing: 3.0,
                children: <Widget>[
                  FilterChipWidget(chipName: 'Pets allowed', list: moreFilters),
                  FilterChipWidget(
                      chipName: 'Smoking allowed', list: moreFilters),
                ],
              ),
            ),
          ),
        ],
      )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _addInput(moreFilters);
            },
            child: Text('Okay'))
      ],
    );
  }
}

List moreFilters = [];

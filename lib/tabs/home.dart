import 'package:younify/search/searchmore.dart';
import 'package:younify/search/searchprice.dart';
import 'package:younify/search/searchresult.dart';
import 'package:younify/search/searchtype.dart';

import 'filterchips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text(
                //       'Search places near you',
                //       style: TextStyle(fontSize: 24.0),
                //     ),
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Theme.of(context).accentColor),
                  ),
                  //width: MediaQuery.of(context).size.width / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: searchBar(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FilterChip(
                        selected: propertyType.length > 0 ? true : false,
                        labelPadding: EdgeInsets.all(8),
                        label: Text('Type of Property'),
                        onSelected: (x) {
                          _route1();
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    FilterChip(
                        selected: pricerange.start > 0 ? true : false,
                        labelPadding: EdgeInsets.all(8),
                        label: Text('Price'),
                        onSelected: (x) {
                          _route2();
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    FilterChip(
                        selected: moreFilters.length > 0 ? true : false,
                        labelPadding: EdgeInsets.all(8),
                        label: Text('More filters'),
                        onSelected: (x) {
                          _route3();
                        }),
                  ],
                )
              ],
            ),
          ),
          searcheditingController.text.isNotEmpty
              ? Expanded(child: SearchResult())
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'My Favorites',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _addInput(List propType) {
    setState(() {});
  }

  void _addPrice(String start, String end) {
    //do not delete. somehow this function updates the list
    setState(() {});
  }

  _route1() {
    showDialog(
        context: context, builder: (context) => SearchType(trial: _addInput));
  }

  _route2() {
    showDialog(
        context: context, builder: (context) => SearchPrice(trial: _addPrice));
  }

  _route3() {
    showDialog(
        context: context, builder: (context) => SearchMore(trial: _addInput));
  }

  Widget searchBar() {
    return TextFormField(
        autocorrect: true,
        enableSuggestions: true,
        onChanged: (value) {
          //filterSearchResults(value); // passing the getting value
          setState(() {
            searched = value;
          });
          print('value : $searched');
        },
        controller: searcheditingController, //still I'm  not using
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon:
                Icon(Icons.search, color: ThemeData().primaryColor, size: 25.0),
            hintText: 'Search places near you',
            hintStyle: TextStyle(color: Colors.grey)));
  }
}

Widget filterTitles(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: titleContainer("$text"),
    ),
  );
}

Widget titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

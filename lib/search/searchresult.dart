import 'package:younify/tabs/filterchips.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'rentaldetail.dart';
import 'searchmore.dart';
import 'searchprice.dart';
import 'searchtype.dart';

var searchList;
final numformat = new NumberFormat("#,##0.00", "en_US");

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('rentals').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
            return Text("Loading...");
          }
          //Stores into a temp list<map<object>>
          List<Map<String, dynamic>> tempsearchList = snapshot.data!.docs
              .map((e) => ({
                    'amenities': e['amenities'],
                    'bath': e['bath'],
                    'bedrooms': e['bedrooms'],
                    'name': e['name'],
                    'price': e['price'],
                    'profilepic': e['profilepic'],
                    'star': e['star'],
                    'type': e['type'],
                    'url': e['url'],
                  }))
              .toList();

          //Converts the temp and search into lowercase and compares if it contains.
          //If true, it stores it back to temp and displays the query.
          searchList = tempsearchList
              .where((element) => element['name']
                  .toString()
                  .toLowerCase()
                  .contains(searcheditingController.text.toLowerCase()))
              .toList();

          // searchList = searchList
          //     .where((element) => element['amenities']
          //         .toString()
          //         .toLowerCase()
          //         .contains('garden'))
          //     .toList();

//tried passing on a list containing the amenities. pero '==' man siya. dile pwde .contains.
//.contains() doesn't accept lists. only Patterns.

          //print(list.map((v) => v.toString()));

          print('btntestpropty is $propertyType');
          // print('searchResult btntest is $btntest');
          //this is propertyType
          print(propertyType.map((v) => searchList = searchList
              .where((element) => element['type']
                  .toString()
                  .toLowerCase()
                  .contains(v.toString().toLowerCase()))
              .toList()));

          //this is propertyPrice
          searchList = searchList
              .where((element) =>
                  double.parse(element['price'].toString()) >= pricerange.start)
              .toList();

          //this is propertyMore
          print(moreFilters.map((v) => searchList = searchList
              .where((element) => element['amenities']
                  .toString()
                  .toLowerCase()
                  .contains(v.toString().toLowerCase()))
              .toList()));

          return ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      _route(searchList[index]);
                    },
                    isThreeLine: true,
                    title: Container(
                        alignment: Alignment.topRight,
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: ThemeData().accentColor,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(searchList[index]
                                          ['profilepic'] !=
                                      ""
                                  ? searchList[index]['profilepic']
                                  : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png")),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border_rounded))),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Theme.of(context).primaryColor,
                              size: 18.0,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${searchList[index]['star']} Reviews',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        Text(
                          '${searchList[index]["name"]}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${searchList[index]["type"]} in Cebu City',
                                style: Theme.of(context).textTheme.subtitle1),
                            Text(
                              'P${numformat.format(searchList[index]['price'])} / month',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        )
                      ],
                    ),
                  ));
        });
  }

  _route(dynamic e) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailRental(
                  e: e,
                )));
  }
}

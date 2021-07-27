import 'package:younify/tabs/home.dart';
import 'package:flutter/material.dart';

class SearchPrice extends StatefulWidget {
  final Function trial;

  SearchPrice({required this.trial});
  @override
  _SearchPriceState createState() => _SearchPriceState();
}

class _SearchPriceState extends State<SearchPrice> {
  void _addInput(String start, String end) {
    if (start.isNotEmpty && end.isNotEmpty) {
      widget.trial(start, end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              filterTitles("Price"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: ThemeData().primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: Text('P${pricerange.start.toStringAsFixed(0)}'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: ThemeData().primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: Text('P${pricerange.end.toStringAsFixed(0)}'),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RangeSlider(
                    min: 0,
                    max: 100,
                    values: pricerange,
                    onChanged: (RangeValues val) {
                      setState(() {
                        pricerange = val;
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _addInput(pricerange.start.toStringAsFixed(0),
                  pricerange.end.toStringAsFixed(0));
            },
            child: Text('Okay'))
      ],
    );
  }
}

var pricerange = RangeValues(0, 100);

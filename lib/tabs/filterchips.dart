import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController searcheditingController = TextEditingController();
var searched = "";

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final List list;

  FilterChipWidget({required this.chipName, required this.list});
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected;

  @override
  void initState() {
    super.initState();
    checking();
  }

  void checking() {
    if (widget.list.contains(widget.chipName)) {
      setState(() {
        _isSelected = true;
      });
    } else {
      setState(() {
        _isSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: ThemeData().primaryColor,
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          // btntest = isSelected;
          if (isSelected) {
            widget.list.add(widget.chipName);
          } else
            widget.list.remove(widget.chipName);
          print('${widget.list}');
        });
      },
      selectedColor: Color(0xffd5fbff),
    );
  }
}

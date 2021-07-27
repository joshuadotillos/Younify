import 'package:flutter/material.dart';

class DetailRental extends StatelessWidget {
  final dynamic e;

  DetailRental({required this.e});
  @override
  Widget build(BuildContext context) {
    print('RentalDetail amentities: ${e['amenities']}');

    for (var i = 0; i < e['amenities'].length; i++) {
      print('object ${e['amenities'][i]}');
    }

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(),
      ),
    );
  }
}

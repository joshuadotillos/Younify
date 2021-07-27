import 'package:younify/tabs/location_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' show Address, Coordinates, Geocoder;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

import '../filterchips.dart';

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Report());
  }
}

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  late List<Address> _currentAddress;

  @override
  void initState() {
    super.initState();
    reportType.clear();
    _getAddress(LocationProvider().locationPosition.latitude,
        LocationProvider().locationPosition.longitude);
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _currentAddress = add;
    });
    return add;
  }

  @override
  Widget build(BuildContext context) {
    var loc = LocationProvider().locationPosition;
    // StaticMapController _controller = StaticMapController(
    //   googleApiKey: "AIzaSyC0KbbYeqXqKDsxSh9uy6r9Hy--nonz_Qg",
    //   width: 400,
    //   height: 400,
    //   zoom: 14,
    //   center: Location(10.256250, 123.823333),
    // );

    // var image = _controller.image;

    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // StaticMap(
              //   zoom: 14,
              //   googleApiKey: "AIzaSyC0KbbYeqXqKDsxSh9uy6r9Hy--nonz_Qg",
              //   height: MediaQuery.of(context).size.height / 3,
              //   width: MediaQuery.of(context).size.width / 3,
              //   center: Location(10.256250, 123.823333),
              // ),
              Center(
                child: Image.asset(
                  'assets/reportex.png',
                ),
              ),
              Text(
                "${loc.latitude.toStringAsFixed(4)}, ${loc.longitude.toStringAsFixed(4)}",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text('${_currentAddress.first.addressLine}'),
              // Text(
              //     'AddressLine2: ${_currentAddress.first.featureName}, ${_currentAddress.first.countryName}'),
              // Text('adminArea: ${_currentAddress.first.adminArea}'),
              // Text('Locality: ${_currentAddress.first.locality}'),
              SizedBox(height: 20),
              Text(
                "Report Type: ",
                style: Theme.of(context).textTheme.headline6,
              ),
              Wrap(
                spacing: 5.0,
                runSpacing: 3.0,
                children: <Widget>[
                  FilterChipWidget(
                      chipName: 'Compiled Garbage', list: reportType),
                  FilterChipWidget(
                      chipName: 'Broken street lights', list: reportType),
                  FilterChipWidget(
                      chipName: 'Unclear road signages', list: reportType),
                  FilterChipWidget(
                      chipName: 'Clogged Drainage', list: reportType),
                ],
              ),
              TextButton(
                child: Text(
                  'Submit request',
                  style: Theme.of(context).textTheme.headline6,
                ),
                onPressed: () {
                  reportType.clear();
                  Navigator.of(context).pop();
                  if (reportType.length != 0) {
                    _addPoints(loc, _currentAddress);
                  }
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

List reportType = [];

reportPopup(BuildContext context, List<Address> _currentAddress, LatLng loc) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(
              "Report a problem",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    // StaticMap(
                    //   zoom: 14,
                    //   googleApiKey: "AIzaSyC0KbbYeqXqKDsxSh9uy6r9Hy--nonz_Qg",
                    //   height: MediaQuery.of(context).size.height / 3,
                    //   width: MediaQuery.of(context).size.width / 3,
                    //   center: Location(10.256250, 123.823333),
                    // ),
                    Center(
                      child: Image.asset(
                        'assets/reportex.png',
                      ),
                    ),
                    Text(
                      "${loc.latitude.toStringAsFixed(4)}, ${loc.longitude.toStringAsFixed(4)}",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('${_currentAddress.first.addressLine}'),
                    // Text(
                    //     'AddressLine2: ${_currentAddress.first.featureName}, ${_currentAddress.first.countryName}'),
                    // Text('adminArea: ${_currentAddress.first.adminArea}'),
                    // Text('Locality: ${_currentAddress.first.locality}'),
                    SizedBox(height: 20),
                    Text(
                      "Report Type: ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        FilterChipWidget(
                            chipName: 'Compiled Garbage', list: reportType),
                        FilterChipWidget(
                            chipName: 'Broken street lights', list: reportType),
                        FilterChipWidget(
                            chipName: 'Unclear road signages',
                            list: reportType),
                        FilterChipWidget(
                            chipName: 'Clogged Drainage', list: reportType),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Submit request',
                  style: Theme.of(context).textTheme.headline6,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (reportType.length != 0) {
                    _addPoints(loc, _currentAddress);
                  }
                },
              )
            ],
          ));
}

Future<DocumentReference> _addPoints(LatLng x, List<Address> currAdd) async {
  return FirebaseFirestore.instance.collection('data').add({
    'address': "${currAdd.first.addressLine}",
    'location': GeoPoint(x.latitude, x.longitude),
    'url': "",
    'isLGUVerified': false,
    'isNGOVerified': false,
    'type': reportType,
    'isCitizenVerified': false,
    'requestVolunteer': false,
    'eventName': "",
  });
}

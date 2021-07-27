import 'dart:async';

import 'package:younify/tabs/location_provider.dart';
import 'package:younify/tabs/trashAR/report.dart';
import 'package:younify/views/LGU/requests.dart';
import 'package:younify/views/NGO/createapostNGO.dart';
import 'package:younify/views/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

var hahaytemp;

class trashARMaps extends StatefulWidget {
  final String username;

  trashARMaps({required this.username});
  @override
  _trashARMapsState createState() => _trashARMapsState();
}

class _trashARMapsState extends State<trashARMaps> {
  var location = new Location();
  var added = false;
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late List<Address> _currentAddress;

  requestCitizen(message, id) {
    if (message.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(
                    'Back',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                  child: Text(
                    'I want to Volunteer',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () {
                    updateLGU("requestVolunteer", id, true);
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
      );
    }
  }

  void initMarker(specify, specifyId) async {
    print('I AM INITMARKER');
    print('specifyid is: $specifyId');
    var markerIdVal = specifyId;
    final markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      onTap: () {
        if (widget.username == 'ngo') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CreatePost(docuID: specifyId)));
        } else
          requestCitizen(
              'Do you want to volunteer in ${specify['address']}?', specifyId);
      },
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow:
          InfoWindow(title: specify['type'][0], snippet: specify['address']),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    print('widget.username is: ${widget.username}');
    if (widget.username == 'ngo') {
      FirebaseFirestore.instance
          .collection('data')
          .where(
            'isLGUVerified',
            isEqualTo: true,
          )
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var i = 0; i < value.docs.length; i++) {
            initMarker(value.docs[i].data(), value.docs[i].id);
          }
        } else
          print('WALAY SULOD IMO DATA!');
      });
    } else {
      FirebaseFirestore.instance
          .collection('data')
          .where(
            'isNGOVerified',
            isEqualTo: true,
          )
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var i = 0; i < value.docs.length; i++) {
            initMarker(value.docs[i].data(), value.docs[i].id);
          }
        } else
          print('WALAY SULOD IMO DATA!');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMarkerData();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void makeFalse() {
    print('I am making it false');
    setState(() {
      added = false;
    });
  }

  startTime() {
    print('timer starts now!');
    var duration = new Duration(seconds: 3);
    return new Timer(duration, makeFalse);
  }

  Future<List<Address>> _getAddress(double lat, double lng) async {
    final coordinates = new Coordinates(lat, lng);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _currentAddress = add;
    });
    var temp = LatLng(lat, lng);
    reportPopup(context, _currentAddress, temp);
    return add;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: googleMapUI());
  }

  Widget googleMapUI() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      return Stack(
        children: [
          GoogleMap(
            onTap: (x) async {
              if (widget.username != 'ngo') {
                reportType.clear();
                _getAddress(x.latitude, x.longitude);
                startTime();
                setState(() {
                  added = true;
                });
                SimpleDialog(
                  title: Text('finished'),
                  children: [
                    Text(
                        "If you write a message, you should care about the message."),
                  ],
                );
              } else
                print('NGO KA!');
            },
            markers: Set<Marker>.of(markers.values),
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: model.locationPosition, zoom: 15, tilt: 20.0),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: false, //directions chuchu
          ),
          TextButton(onPressed: () {}, child: Text('hello world')),
          added
              ? SimpleDialog(
                  backgroundColor: Colors.greenAccent,
                  title: Text(
                    'Geopoint added!',
                    textAlign: TextAlign.center,
                  ),
                  children: [
                    Text(
                      "If you write a message, you should care about the message.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Container()
        ],
      );
    });
  }
}

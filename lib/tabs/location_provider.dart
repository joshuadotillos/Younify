import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  late Location _location;
  Location get location => _location;
  LatLng _locationPosition = LatLng(10.258914,
      123.826531); //dapat initialized sha. masuko if dile butangang ug dummy
  LatLng get locationPosition => _locationPosition;
  bool locationService = true;

  LocationProvider() {
    _location = new Location();
  }

  initalization() async {
    print('initialization is here');
    await getUserLocation();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
    print('before event');
    location.onLocationChanged.listen((event) {
      //print('event is: ${event}');
      _locationPosition = LatLng(
        event.latitude!,
        event.longitude!,
      );
    });

    print('_locationPosition: $_locationPosition');
    notifyListeners();
  }
}

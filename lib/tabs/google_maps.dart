import 'package:younify/tabs/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapLive extends StatefulWidget {
  @override
  _MapLiveState createState() => _MapLiveState();
}

class _MapLiveState extends State<MapLive> {
  var location = new Location();
  var currentLocation;

  @override
  Widget build(BuildContext context) {
    return Container(child: googleMapUI());
  }

  Widget googleMapUI() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      return Stack(
        children: [
          GoogleMap(
            onTap: (x) {
              print('$x');
            },
            onMapCreated: (GoogleMapController controller) {},
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: model.locationPosition, zoom: 15, tilt: 20.0),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          )
        ],
      );
      //return Container(child: Center(child: CircularProgressIndicator()));
    });
  }
}

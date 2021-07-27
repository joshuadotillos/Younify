// import 'dart:async';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class Maps extends StatefulWidget {
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   late Completer<GoogleMapController> controller1; //what is late?
//   late LatLng _initialposition;
//   final Set<Marker> _markers = {};
//   static LatLng _lastMapPosition = LatLng(10.258914, 123.826531); //temp

//   late GoogleMapController _googleMapController; //what is late?
//   final CameraPosition _initialCameraPosition =
//       CameraPosition(target: LatLng(10.258914, 123.826531), zoom: 14); //initial
//   final List<Marker> markers = [];

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   Future _getUserLocation() async {
//     Position geoposition = await GeolocatorPlatform.instance
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//     List<Placemark> placemark = await GeocodingPlatform.instance
//         .placemarkFromCoordinates(geoposition.latitude, geoposition.longitude);
//     setState(() {
//       _initialposition = LatLng(geoposition.latitude, geoposition.longitude);
//       print('${placemark[0].name}');
//     });
//     print('INITIAL POSITION IS $_initialposition');
//   }

//   _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       controller1.complete(controller);
//     });
//   }

//   MapType _currentMapType = MapType.normal;

//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = _currentMapType == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }

//   _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   addMarker(coordinate) {
//     int id = Random().nextInt(100);
//     setState(() {
//       markers.add(Marker(
//           onTap: () {
//             print('I clicked pizza');
//           },
//           infoWindow: InfoWindow(title: 'Pizza'),
//           position: coordinate,
//           markerId: MarkerId(id.toString())));
//     });
//   }

//   // _onAddMarkerButtonPressed() {}

//   Widget mapButton(Icon icon, Color color) {
//     return RawMaterialButton(
//       onPressed: () {
//         setState(() {
//           _markers.add(Marker(
//               markerId: MarkerId(_lastMapPosition.toString()),
//               position: _lastMapPosition,
//               infoWindow: InfoWindow(
//                   title: "Pizza Parlour",
//                   snippet: "This is a snippet",
//                   onTap: () {}),
//               onTap: () {},
//               icon: BitmapDescriptor.defaultMarker));
//         });
//       },
//       child: icon,
//       shape: new CircleBorder(),
//       elevation: 2.0,
//       fillColor: color,
//       padding: const EdgeInsets.all(7.0),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Stack(
//       children: [
//         GoogleMap(
//           markers: markers.toSet(),
//           initialCameraPosition: _initialCameraPosition,
//           mapType: _currentMapType,
//           //myLocationButtonEnabled: false,
//           myLocationEnabled: true,
//           onMapCreated: (xmap) {
//             setState(() {
//               _googleMapController = xmap;
//             });
//           },
//           onTap: (xlatlong) {
//             print(xlatlong);
//             //updates the position of the camera
//             _googleMapController
//                 .animateCamera(CameraUpdate.newLatLng(xlatlong));
//             addMarker(xlatlong);
//           },
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: Container(
//               margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
//               child: Column(
//                 children: [mapButton(Icon(Icons.add_location), Colors.purple)],
//               )),
//         )
//       ],
//     ));
//   }

//   Widget searchResult() {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('rentals').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return ListView(
//               children: snapshot.data!.docs.map((e) {
//             var cnt = snapshot.data!.docs.length;
//             print('cnt is $cnt');
//             //var result = e.id;
//             return SingleChildScrollView(
//               child: ListTile(
//                   // onLongPress: () {
//                   //   if (e['authorEmail'] == Constants.myEmail) {
//                   //     DatabaseMethods().deleteDoc(result);
//                   //   }
//                   // },
//                   onTap: () {
//                     // _route(e, result);
//                   },
//                   title: Container(
//                     padding: EdgeInsets.symmetric(vertical: 12.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                             height: 70,
//                             width: 70,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: NetworkImage(e['profilepic'] != ""
//                                       ? e['profilepic']
//                                       : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png")),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Text('')),
//                         Flexible(child: Text('${e["name"]}')),
//                         SizedBox(
//                           width: 70.0,
//                         ),
//                         // Heart(
//                         //   docID: result,
//                         //   heartCnt: e['hearts'],
//                         // ),
//                         // Text('${e['hearts']}')
//                       ],
//                     ),
//                   ),
//                   isThreeLine: true,
//                   subtitle: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20.0),
//                         child: Image.network(
//                           //'https://media.self.com/photos/5f189b76c58e27c99fbef9e3/1:1/w_768,c_limit/blackberry-vanilla-french-toast.jpg'
//                           e['url'] != ""
//                               ? e['url']
//                               : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
//                           fit: BoxFit.cover,
//                           height: MediaQuery.of(context).size.height / 3,
//                         ),
//                       ),
//                       Text(
//                         '${e['name']}',
//                         style: TextStyle(fontSize: 24.0),
//                       ),
//                     ],
//                   )),
//             );
//           }).toList());
//         });
//   }
// }

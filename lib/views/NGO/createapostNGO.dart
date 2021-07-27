import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:younify/tabs/location_provider.dart';

class CreatePost extends StatefulWidget {
  final String docuID;

  CreatePost({required this.docuID});
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  int addVolunteer = 0;
  var isGeolocation = false;

  TextEditingController eventNameController = TextEditingController();

  TextEditingController xController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.multiply),
                      image: AssetImage('assets/pixelCamera.png'),
                      fit: BoxFit.cover),
                ),
                //color: Colors.grey,
                padding: EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/rafi.png")),
                          shape: BoxShape.circle,
                        ),
                        child: Text('')),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ramon Aboitiz Foundation Inc.',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Text(
                            "https://www.facebook.com/rafi.org.ph/",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4.2),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Add Information',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 30),
                        Text('${widget.docuID}'),
                        SizedBox(height: 30),
                        description(WGeolocation(), 1.5),
                        SizedBox(height: 10),
                        description(
                            WRentText(eventNameController,
                                'Input name of event', TextInputType.name),
                            1.5),
                        SizedBox(height: 10),
                        WButton('Volunteers', addVolunteer),
                        SizedBox(height: 20),
                        Text('Terms and Conditions',
                            style: Theme.of(context).textTheme.headline5),
                        description(
                            WRentText(
                                xController,
                                'Lorem ipsum dolor sit amet, consectetur',
                                TextInputType.name),
                            1.5),
                        SizedBox(height: 10),
                        description(
                            WRentText(
                                xController,
                                'Lorem ipsum dolor sit amet, consectetur',
                                TextInputType.name),
                            1.5),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            //_addNGO(x, currAdd);
                            updateNGO('isNGOVerified', widget.docuID, true);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Confirm",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              //style: simpleTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> updateNGO(String obj, String id, bool addHeart) async {
    print('updateNGO is: $id');
    try {
      DocumentReference docReference = FirebaseFirestore.instance
          .collection('data')
          .doc(id); //case sensitive

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction
            .get(docReference); //capture of the data in the document

        if (!snapshot.exists) {
          docReference.set({'$obj': addHeart});
          return true;
        }

        //double newAmount = snapshot.data()['amount'] + value;
        var newAmount = addHeart;
        transaction.update(docReference, {
          '$obj': newAmount,
          'eventName': eventNameController.text,
          'volunteers': addVolunteer,
        });
        return true;
      });
    } catch (e) {
      return false;
    }
    //optional
    return true;
  }

  Widget WButton(String name, int val) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        onTap: () {
          if (name == 'Volunteers' && addVolunteer > 0) {
            setState(() {
              addVolunteer--;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(30)),
          child: Icon(CupertinoIcons.minus),
        ),
      ),
      SizedBox(width: 10),
      Text(
        '$addVolunteer $name',
        style: Theme.of(context).textTheme.headline6,
      ),
      SizedBox(width: 10),
      GestureDetector(
        onTap: () {
          print('I ADDED SOMEHTING');
          if (name == 'Volunteers') {
            setState(() {
              addVolunteer++;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(30)),
          child: Icon(CupertinoIcons.add),
        ),
      ),
    ]);
  }

  Widget WGeolocation() {
    var temp = LocationProvider().locationPosition;
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: GestureDetector(
        onTap: () {},
        child: TextFormField(
            enabled: false,
            style: Theme.of(context).textTheme.headline6,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(CupertinoIcons.map_pin_ellipse,
                    color: Theme.of(context).accentColor, size: 25.0),
                hintText: '${temp.latitude}, ${temp.longitude}',
                hintStyle: TextStyle(color: Colors.grey))),
      ),
    );
  }

  Widget WRentText(
      TextEditingController x, String text, TextInputType thekeyboard) {
    return TextFormField(
        keyboardType: thekeyboard,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        autocorrect: true,
        enableSuggestions: true,
        //noOnChanged
        controller: x,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '$text',
            hintStyle: TextStyle(color: Colors.grey)));
  }

  Widget description(Widget x, double val) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(5, 5), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      width: MediaQuery.of(context).size.width / val,
      child: x,
    );
  }
}

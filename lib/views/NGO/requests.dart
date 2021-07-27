import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:younify/views/LGU/requests.dart';

int selectIndex = 0;

class RequestsNGO extends StatefulWidget {
  @override
  _RequestsNGO createState() => _RequestsNGO();
}

class _RequestsNGO extends State<RequestsNGO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ngoRequest(),
    ));
  }

  Widget ngoRequest() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('data')
            .where('requestVolunteer', isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((e) {
            var result = e.id; //get the documentID
            print('${result}');
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                  onTap: () {
                    print('ON TAP');
                    onSubmit(
                        "Do you accept the request to volunteer from this citizen?'",
                        result);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(
                          //'https://media.self.com/photos/5f189b76c58e27c99fbef9e3/1:1/w_768,c_limit/blackberry-vanilla-french-toast.jpg'
                          e['url'] != ""
                              ? e['url']
                              : 'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?size=338&ext=jpg',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text('Edrian Camacho',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: 10),
                            Text(
                                'Hello, my name is Edrian Camacho. I want to join your ${e['eventName']} event. I am more than willing to give a helping hand.'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList());
        });
  }

  onSubmit(message, id) {
    if (message.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Approval')),
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
                  child: Text('Reject'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                  child: Text('Accept'),
                  onPressed: () {
                    updateLGU('requestVolunteer', id, false);
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
      );
    }
  }

  Future<bool> updateCitizen(String obj, String id, bool addHeart) async {
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
        transaction.update(docReference, {'$obj': newAmount});
        return true;
      });
    } catch (e) {
      return false;
    }
    //optional
    return true;
  }
}

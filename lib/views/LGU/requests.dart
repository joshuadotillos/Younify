import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int selectIndex = 0;

class RequestsLGU extends StatefulWidget {
  @override
  _RequestsLGU createState() => _RequestsLGU();
}

class _RequestsLGU extends State<RequestsLGU> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: publishedList2()));
  }

  Widget publishedList2() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('data')
            .where('isLGUVerified', isEqualTo: false)
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
                        'Are you going to accept the pinpoint in ${e['address']}',
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
                              : 'https://i.ytimg.com/vi/PE0Eg9novtA/hqdefault.jpg',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Text('${e['address']}',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: 10),
                            Text(
                                'Lorem ipsum dolor sit met, consectetur adipiscing elit, sed do eiusmod tempor incididunt '),
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
                    updateLGU("isLGUVerified", id, true);
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
      );
    }
  }
}

Future<bool> updateLGU(String obj, String id, bool addHeart) async {
  try {
    DocumentReference docReference =
        FirebaseFirestore.instance.collection('data').doc(id); //case sensitive

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

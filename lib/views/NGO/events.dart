import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int selectIndex = 0;

class Events extends StatefulWidget {
  @override
  _Events createState() => _Events();
}

class _Events extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: eventsNGO(),
    ));
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
                    //updateLGU("isLGUVerified", id, true);
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
      );
    }
  }

  Widget eventsNGO() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('data')
            .where('isNGOVerified', isEqualTo: true)
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
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.green),
                //     borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                    onTap: () {
                      print('ON TAP');
                      // onSubmit(
                      //     'Are you going to accept the pinpoint in ${e['address']}',
                      //     result);
                    },
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${e['eventName']}",
                            style: Theme.of(context).textTheme.headline4),
                        Text("${e['volunteers']} Volunteers | ${e['type'][0]}",
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    title: Container(
                        alignment: Alignment.topRight,
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: ThemeData().accentColor,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(e['url'] != ""
                                  ? e['url']
                                  : 'https://i.ytimg.com/vi/PE0Eg9novtA/hqdefault.jpg')),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border_rounded)))),
              ),
            );
          }).toList());
        });
  }
}

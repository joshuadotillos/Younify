import 'package:younify/rewards&badges/rewards&badgesHOME.dart';
import 'package:younify/views/Authentication/signin.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile'),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RewardsBadges()));
              }, child: Text('Show Rewards & Badges'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text('Sign out')),
          ],
        ),
      ),
    );
  }
}

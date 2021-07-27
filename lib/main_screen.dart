import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:younify/tabs/trashAR/camera.dart';
import 'tabs/home.dart';
import 'tabs/location_provider.dart';
import 'tabs/message.dart';
import 'tabs/profile.dart';
import 'tabs/trashAR/trasharMaps.dart';

//MapsLive
final tabs = [Home(), trashARMaps(username: ""), Message(), Profile()];

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initalization();
    setState(() {});
  }

  int selectedP = 0; //4 tabs in total except middle
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Splash()));
          },
          child: Icon(
            CupertinoIcons.camera,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomTab(),
        body: tabs[selectedP],
      ),
    );
  }

  _buildBottomTab() {
    return BottomNavigationBar(
      elevation: 5.0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      currentIndex: selectedP,
      onTap: (int _index) {
        setState(() {
          this.selectedP = _index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.map),
          label: 'Maps',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.conversation_bubble),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:younify/views/LGU/homeLGU.dart';
import 'package:younify/views/NGO/homeNGO.dart';

import '../../main_screen.dart';
import 'signup.dart';

TextEditingController _userNameTextEditingController =
    new TextEditingController();
TextEditingController _passwordTextEditingController =
    new TextEditingController();

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  var _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              showAlert(),
              SizedBox(
                height: 90.0,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _userNameTextEditingController,
                      decoration: textFieldInputDecoration("Username"),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordTextEditingController,
                      decoration: textFieldInputDecoration("Password"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      (_userNameTextEditingController.text.toString() ==
                                  'lgu' &&
                              _passwordTextEditingController.text.toString() ==
                                  '123')
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePageLGU(
                                        title: "Younify LGU",
                                      )))
                          : (_userNameTextEditingController.text.toString() ==
                                      'ngo' &&
                                  _passwordTextEditingController.text
                                          .toString() ==
                                      '123')
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePageNGO(
                                            title: "Younify NGO",
                                            username:
                                                _userNameTextEditingController
                                                    .text,
                                          )))
                              : (_userNameTextEditingController.text
                                              .toString() ==
                                          'user' &&
                                      _passwordTextEditingController.text
                                              .toString() ==
                                          '123')
                                  ? Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen()))
                                  : SignIn();
                    } catch (e) {
                      setState(() {
                        _error = e;
                      });
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign In",
                    //style: simpleTextStyle(),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    // style: mediumTextStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Register Now",
                      //style: mediumTextStyle(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_error != null) {
      setState(() {
        _error = null;
      });
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(hintText: hintText);
}

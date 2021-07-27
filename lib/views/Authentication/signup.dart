import 'package:flutter/material.dart';
import 'package:younify/views/NGO/homeNGO.dart';

import 'signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  final formKey = GlobalKey<FormState>();
  var _error;

  TextEditingController _userNameTextEditingController =
      new TextEditingController();
  TextEditingController _passwordTextEditingController =
      new TextEditingController();

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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePageNGO(
                                    title: "Accenture Project Name",
                                    username:
                                        _userNameTextEditingController.text,
                                  )));
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
                    "Sign Up",
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
                    "Already registered? ",
                    // style: mediumTextStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      "Sign In Now",
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

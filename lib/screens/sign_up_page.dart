import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_health/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/services/firebase_Service.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    OutlineInputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: Constants.kBlackColor, width: 1.0));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.cyan[200],
        body:  Center(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("assets/images/sign-up.png",width: 300,height: 125),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Welcome!!",
                        style: TextStyle(
                          color: Constants.kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),

                  ])),
              Padding(padding: EdgeInsets.only(bottom: size.height * 0.005)),
              SizedBox(
                width: size.width * 0.8,
                child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: "Enter your full name",
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        enabledBorder: border,
                        focusedBorder: border)),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: "Enter your username",
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        enabledBorder: border,
                        focusedBorder: border)),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: "Enter your mail ID",
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        enabledBorder: border,
                        focusedBorder: border)),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    enabledBorder: border,
                    focusedBorder: border,
                    suffixIcon: Padding(
                      child: FaIcon(
                        FontAwesomeIcons.eye,
                        size: 15,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.only(top: 15, left: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Padding(padding: EdgeInsets.only(bottom: size.height * 0.005)),
              SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: () async {Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);},
                  child: Text(Constants.SignUp),
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.kBlackColor),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                ),
              ),
              buildRowDivider(size: size),
              GoogleSignIn(),
            ])));
  }
  Widget buildRowDivider({required Size size}) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(children: <Widget>[
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
        Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Or",
              style: TextStyle(color: Constants.kDarkGreyColor),
            )),
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
      ]),
    );
  }
}


class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({Key? key}) : super(key: key);

  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  !isLoading? SizedBox(
      width: size.width * 0.8,
      child: OutlinedButton.icon(
        icon: FaIcon(FontAwesomeIcons.google),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          FirebaseService service = new FirebaseService();
          try {
            await service.signInwithGoogle();
            Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);
          } catch(e){
            if(e is FirebaseAuthException){
              showMessage(e.message!);
            }
          }
          setState(() {
            isLoading = false;
          });
        },
        label: Text(
          Constants.textSignUpGoogle,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Constants.kBlackColor),
            side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
      ),
    ) : CircularProgressIndicator();
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

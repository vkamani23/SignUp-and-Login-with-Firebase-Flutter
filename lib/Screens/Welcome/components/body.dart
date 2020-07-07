import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surebot_app/Screens/Login/login_screen.dart';
import 'package:surebot_app/Screens/Signup/signup_screen.dart';
import 'package:surebot_app/Screens/Welcome/components/background.dart';
import 'package:surebot_app/constants.dart';
import 'package:surebot_app/ui_components/rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Welcome to Vaibhav's App",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: size.height * 0.03,),
          SvgPicture.asset("assets/icons/chat.svg",
          height: size.height * 0.45,
          ),
          SizedBox(height: size.height * 0.05,),
          RoundedButton(
            text: "LOGIN",
            color: kPrimaryColor,
            textColor: Colors.white,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                  },)
              );
            }),
          RoundedButton(
            text: "SIGNUP",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                },)
            );},),
        ],
    ),
      ),);
  }
}




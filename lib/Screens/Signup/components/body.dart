import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:surebot_app/Screens/Login/login_screen.dart';
import 'package:surebot_app/Screens/Signup/components/background.dart';
import 'package:surebot_app/Screens/Signup/components/or_divider.dart';
import 'package:surebot_app/Screens/Signup/components/social_icon.dart';
import 'package:surebot_app/constants.dart';
import 'package:surebot_app/services/auth_service.dart';
import 'package:surebot_app/ui_components/already_have_an_account_acheck.dart';
import 'package:surebot_app/ui_components/loading.dart';
import 'package:surebot_app/ui_components/rounded_button.dart';
import 'package:surebot_app/ui_components/rounded_input_field.dart';
import 'package:surebot_app/ui_components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  String username = 'xxx';
  String email = 'xxx';
  String password = 'xxx';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.25,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "User name",
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () async {
                    username = username.trim();
                    email = email.trim();
                    password = password.trim();
                    print(username);
                    print(email);
                    print(password);

                    if (username.isNotEmpty &&
                        email.isNotEmpty &&
                        password.isNotEmpty && password.length > 6) {
                      setState(() => loading = true);
                      dynamic result =
                          await _auth.createUserWithEmailAndPassword(
                              email, password, username);
                      if (result == null) {
                        setState(() => loading = false);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Provide a valid email and password greater than 6 characters"),
                        ));
                      }
                      else{
                        print(result);
                        Navigator.pop(context);
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Missing Input Fields"),
                      ));
                    }
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            /*RoundedButton(
              text: "SIGNUP",
              press: () async {
                print(username);
                print(email);
                print(password);
                if (username.isNotEmpty &&
                    email.isNotEmpty &&
                    password.isNotEmpty) {
                  dynamic result = await _auth.createUserWithEmailAndPassword(
                      email, password, username);
                  if (result == null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Something went wrong, please try again :/"),
                    ));
                  }
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Missing Input Fields"),
                  ));
                }
              },
            ),*/
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

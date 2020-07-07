import 'package:flutter/material.dart';
import 'package:surebot_app/Screens/Login/components/background.dart';
import 'package:surebot_app/Screens/Signup/signup_screen.dart';
import 'package:surebot_app/services/auth_service.dart';
import 'package:surebot_app/ui_components/already_have_an_account_acheck.dart';
import 'package:surebot_app/ui_components/loading.dart';
import 'package:surebot_app/ui_components/rounded_button.dart';
import 'package:surebot_app/ui_components/rounded_input_field.dart';
import 'package:surebot_app/ui_components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
            RoundedButton(
              text: "LOGIN",
              press: () async {
                email = email.trim();
                password = password.trim();
                print(email);
                print(password);
                if (email.isNotEmpty && password.isNotEmpty) {
                  setState(() => loading = true);
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() => loading = false);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid Credentials, please try again :/"),
                    ));
                  } else {
                    print(result);
                    Navigator.pop(context);
                  }
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Missing Input Fields"),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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

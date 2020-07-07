import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surebot_app/Screens/Profile/profile_screen.dart';
import 'package:surebot_app/Screens/Welcome/welcome_screen.dart';
import 'package:surebot_app/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return either the Welcome or Authenticate widget
    if(user == null) {
      return WelcomeScreen();
    }
    else {
      return ProfileScreen();
    }
  }
}
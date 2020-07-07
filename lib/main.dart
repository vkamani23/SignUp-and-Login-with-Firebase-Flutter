import 'package:flutter/material.dart';
import 'package:surebot_app/Screens/wrapper.dart';
import 'package:surebot_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:surebot_app/models/user.dart';
import 'package:surebot_app/services/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SureBot App',
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: Wrapper(),
      ),
    );
  }
}

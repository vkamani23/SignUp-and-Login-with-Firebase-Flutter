import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:surebot_app/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor,
      child: Center(
        child: SpinKitFadingCircle(
          color: kPrimaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
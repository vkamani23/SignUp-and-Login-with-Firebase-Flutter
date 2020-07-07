import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surebot_app/Screens/Profile/user_list.dart';
import 'package:surebot_app/constants.dart';
import 'package:surebot_app/models/userlist_model.dart';
import 'package:surebot_app/services/auth_service.dart';
import 'package:surebot_app/services/database.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection = Firestore.instance.collection("username");
  FirebaseUser user;
  String dName, dEmail;
  Future userFuture;
  @override
  void initState() {
    super.initState();

    print("I'm here in PROFILE PAGE");

    initUser();
  }

  initUser() async {
    user = await _firebaseAuth.currentUser();
    try {
      dName = user.displayName;
      dEmail = user.email;
      if(dName == null){
        await user.reload();
        user = await _firebaseAuth.currentUser();
        dName = user.displayName;
        print("INSIDE IF-----> $dName");
        if(dName == null) {
          await user.reload();
          user = await _firebaseAuth.currentUser();
          dName = user.displayName;
          print("INSIDE IF----->IF---------> $dName");
        }
      }
    } catch (error) {
      print(error.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>.value(
      value: DatabaseService().userName,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          actions: <Widget>[
            RaisedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 26,
              ),
              label: Text(""),
              color: kPrimaryColor,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kPrimaryColor, kPrimaryLightColor]),
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.38,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                        ),
                        radius: 60.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        //user.displayName != null ?
                        "${dName ?? 'Alice James'}",
                        // :
                        //"Alice James",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        //user.email != null ?
                        "${dEmail ?? 'alice@james.com'}",
                        //: "alice@james.com",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: UserList()),
          ],
        ),
    ),);
  }

}

import 'package:flutter/material.dart';
import 'package:surebot_app/models/userlist_model.dart';

class UserTile extends StatelessWidget {

  final UserModel user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
            ),
          ),
          title: Text(user.name),
          subtitle: Text(user.email),
        ),
      ),
    );
  }
}

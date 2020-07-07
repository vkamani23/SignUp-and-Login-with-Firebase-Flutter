import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surebot_app/Screens/Profile/user_tile.dart';
import 'package:surebot_app/models/userlist_model.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<UserModel>>(context) ?? [];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,//250,
        child: ListView.builder(

            itemCount: users.length,
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return UserTile(user: users[index]);
          },
        ),
      ),
    );
  }
}

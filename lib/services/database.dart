import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surebot_app/models/userlist_model.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('username');

  Future<void> updateUserData(String name, String email) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
    });
  }

  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return UserModel(
        name: doc.data['name'] ?? 'Alice James',
        email: doc.data['email'] ?? 'alice@james.com',
      );
    }).toList();
  }

  Stream<List<UserModel>> get userName {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:surebot_app/models/user.dart';
import 'package:surebot_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
  // GET UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    try{
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      await currentUser.updateProfile(userUpdateInfo);
      await currentUser.reload();
      /*await currentUser.reload();
      await currentUser.reload();
      await currentUser.reload();*/
      //print("Firebase Reload called 4 times");
      print("${currentUser.displayName}");
    } catch(error) {
      print(error.toString());
    }
  }
// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
      //return user.uid;
    } catch(error){
      print(error.toString());
      return null;
    }
  }

// register with email and password
  Future createUserWithEmailAndPassword(String email, String password, String name) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await updateUserName(name, user);
      await DatabaseService(uid: user.uid).updateUserData(name, email);
      return _userFromFirebaseUser(user);
      //return user.uid;
    } catch(error){
      print(error.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
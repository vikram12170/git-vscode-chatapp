import 'package:chatapp/models/appUse.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  appUse _userFromFirebaseUser(User user) {
    return user != null ? appUse(userId: user.uid) : null;
  }

  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = (await _auth.signInWithEmailAndPassword(
          email: email, password: password));
      User firebaseUser = result.user;

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password));
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

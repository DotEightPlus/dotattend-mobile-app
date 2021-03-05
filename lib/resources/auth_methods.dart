import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_attend/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Contains Authentication Methods being used in the entire Project
class AuthMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final CollectionReference _userCollection =
      _firestore.collection("users");

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser;
    return currentUser;
  }

  Future<UserData> getUserDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();
    return UserData.fromMap(documentSnapshot.data());
  }

  Future<UserData> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot = await _userCollection.doc(id).get();
      return UserData.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> sendEmailVerification() async {
    User currentUser = await getCurrentUser();
    currentUser.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User currentUser = await getCurrentUser();
    return currentUser.emailVerified;
  }

  Future<void> sendPasswordResetMail(String email) async {
    print('============password reset called==============>' + email);
    await _auth.sendPasswordResetEmail(email: email);
    return null;
  }

  Future<String> signIn(String email, String password) async {
    print('===========>' + email);
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<void> deleteUser() async {
    User currentUser;
    currentUser = _auth.currentUser;
    currentUser.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  Future<void> addDataToDb(
      {User currentUser,
      name,
      username,
      password,
      matricNo,
      gender,
      mobileNo,
      email}) async {
    UserData user = UserData(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      password: password,
      profilePhoto: currentUser.photoURL,
      username: username,
    );
    //driver details
    _firestore
        .collection("authusers")
        .doc(currentUser.uid)
        .set(user.toMap(user));
  }
}

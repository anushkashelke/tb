import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timbrebells/models/users.dart' as model;

class auth_methods {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // _auth is our private variable
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User_details> getUserDetails() async {
    //User_details is a class from users.dart
    User currentUser = _auth.currentUser!; //User is a class in firebase
    //currentUser returns a user if the user is signed in else returns null(hence '!' is used)
    DocumentSnapshot snap = await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .get(); //snap contains all data of current user from firebase
    return model.User_details.fromSnap(
        snap); //fromSnap is a method in users.dart
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    //required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        //||file!=null
        //register new user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //add details of user to the database
        print(cred.user!.uid);
        model.User_details user = model.User_details(
          username: username,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
        );
        _firestore.collection('users').doc(cred.user!.uid).set(  //to store data of new user in firestore collection if it doesn't exist
              user.toJson(),
            ); //to store data in collection 'users'
        /*await _firestore.collection('users').add({
           'username':username,
           'uid':cred.user!.uid,
           'email':email,
           'followers': [],
           'following': [],
         });  */
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> LogIn({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email,
            password: password); //this returns email and password back hence we need to await them
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } /*on FirebaseAuthException catch(errors){
          if(errors.code=='user-not-found'){
            res="Invalid"
          } */
    catch (err) {
      res = err.toString();
    }
    return res;
  }
  //TO SIGN OUT
  Future<void> SignOut() async{
    await _auth.signOut();
  }
}

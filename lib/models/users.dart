import 'package:cloud_firestore/cloud_firestore.dart';

//In this class all the details of user are extracted from the firebase stored and returned to the getUserDetails class of auth_method.dart
class User_details {
  final String username; //inputs from the user in the form of string
  final String email; //initialization of variables and their data types
  final String uid;
  final List followers;
  final List following;

  const User_details({
    //constructor
    required this.username,
    required this.email,
    required this.uid,
    required this.following,
    required this.followers,
  });
  Map<String, dynamic> toJson() => {
        //String:dynamic value(since multiple users)
        "username": username, //thus all the inputs are converted into an objects and stored in object file called Json
        "uid": uid,
        "email": email,
        "followers": followers,
        "following": following,
      }; //functions for user to access firebase  //toJson method to convert user details into an object
  static User_details fromSnap(DocumentSnapshot snap) {
    //DocumentSnapshot= contains data read from the firebase storage
    var snapshot = snap.data() as Map<String, dynamic>;
    //snap.data() - contains all the data of this document snapshot
    //variable snapshot contains data of user under each String
    return User_details(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}

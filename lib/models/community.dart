import 'package:cloud_firestore/cloud_firestore.dart';

class Comm_details {
  final String comm_Name; //inputs from the user in the form of string
  final String comm_id; //initialization of variables and their data types
  final String username;
  final List members;
  final String description;

  const Comm_details({
    //constructor
    required this.comm_Name,
    required this.comm_id,
    required this.username,
    required this.members,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    //String:dynamic value(since multiple users)
    "Comm_Name": comm_Name, //thus all the inputs are converted into an objects and stored in object file called Json
    "Comm_Id": comm_id,
    "CreatedBy": username,
    "Members": members,
    "Description": description,
  }; //functions for user to access firebase  //toJson method to convert user details into an object
  static Comm_details fromSnap(DocumentSnapshot snap) {
    //DocumentSnapshot= contains data read from the firebase storage
    var snapshot = snap.data() as Map<String, dynamic>;
    //snap.data() - contains all the data of this document snapshot
    //variable snapshot contains data of user under each String
    return Comm_details(
      comm_Name: snapshot['Comm_Name'],
      comm_id: snapshot['Comm_Id'],
      username: snapshot['CreatedBy'],
      members: snapshot['Members'],
      description: snapshot['Description'],
    );
  }
}
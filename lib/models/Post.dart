import 'package:cloud_firestore/cloud_firestore.dart';

class Post_details {
  final String username; //inputs from the user in the form of string
  final String description;
  final String uid;
  final String postId;
  //final String community;
  final datePublished;
  final String postUrl;
  final likes;

  const Post_details({
    //constructor
    required this.username,
    required this.uid,
    required this.postId,
    required this.postUrl,
    required this.datePublished,
    required this.description,
    required this.likes,
  });
  Map<String, dynamic> toJson() => {
        "description": description,
        "username":
            username, //thus all the inputs are converted into an objects and stored in object file called Json
        "uid": uid,
        "postId": postId,
        "DatePublished": datePublished,
        "PostUrl": postUrl,
        "Likes": likes,
      }; //functions for user to access firebase  //toJson method to convert user details into an object
  static Post_details fromSnap(DocumentSnapshot snap) {  //DocumentSnapshot= contains data read from the firebase storage
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post_details(
      username: snapshot['username'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      datePublished: snapshot['DatePublished'],
      postUrl: snapshot['PostUrl'],
      likes: snapshot['Likes'],
      description: snapshot['description'],
    );
  }
}

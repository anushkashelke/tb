import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timbrebells/models/Post.dart';
import 'package:timbrebells/resources/Storage_methods.dart';
import 'package:timbrebells/Screens/Add_post.dart';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; //to access the firebase

  //UPLOAD POST FUNCTIONALITY
  Future<String> uploadPost(
    String description_post,
    String uid_post,
    String username_post,
    Uint8List file,
  ) async {
    String res = "Some error occured";
    try {
      String url_post =
          await Storagetypes().UploadImageToStorage('Posts', file, true);
      String Id_post =
          const Uuid().v1(); //this sets a unique postId based on time
      Post_details post = Post_details(
        description: description_post,
        uid: uid_post,
        username: username_post,
        postId: Id_post,
        datePublished: DateTime.now(),
        postUrl: url_post,
        likes: [],
      );
      _firestore.collection('posts').doc(Id_post).set(
            post.toJson(),
          );
      res = "success";
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  //LIKEN POST FUNCTIONALITY
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        //if post is already liked by a particular uid/user
        await _firestore.collection('posts').doc(postId).update({
          'Likes': FieldValue.arrayRemove([uid]) //array of users/uid
          //remove the like by current user from array
        });
      } else {
        //else like the post and add uid of current user to the likes array
        await _firestore.collection('posts').doc(postId).update({
          'Likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  //DELETE POST FUNCTIONALITY
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  //FOLLOW USERS FUNCTIONALITY
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        //if user already follows and presesses unfollow
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
          //update followers list of current user
        }); //by removing the follower in followId
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
          //update following list of 'followed user'
        }); //by removing the following in current user's details
      } else {
        //if follow option is pressed
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        }); //adding followers to the followId's followers list
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        }); //adding followed user to the current user's following list
      }
    } catch (e) {
      print(e.toString());
    }
  }

}


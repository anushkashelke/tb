import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timbrebells/Profile/follow_button.dart';
import 'package:timbrebells/Utils/Image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var UserSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = UserSnap.data()!; //data shouldn't be null
      followers = UserSnap.data()!['followers'].length;
      following = UserSnap.data()!['following'].length;
      isFollowing = UserSnap.data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      //get posts data from firebase
      var PostSnap = await FirebaseFirestore.instance
          .collection('posts')
          //check if posts from posts collection belongs to current user
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = PostSnap.docs.length;
      setState(() {});
    } catch (e) {
      //if error occurs
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black, //const Color(0xff7c99ac),
              title: Text(userData['username']),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1645849337370-100dab9bb2d3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80'),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStateColumn(postLen, "Posts"),
                                  buildStateColumn(followers, "Followers"),
                                  buildStateColumn(following, "Following"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.uid
                                      ? FollowButton(
                                          text: 'Edit Profile',
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          borderColor: Colors.grey,
                                          function: () {},
                                        )
                                      : isFollowing
                                          ? FollowButton(
                                              text: 'Unfollow',
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              borderColor: Colors.blue,
                                              function: () {},
                                            )
                                          : FollowButton(
                                              text: 'Follow',
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              borderColor: Colors.blue,
                                              function: () {},
                                            )
                                ],
                              )
                            ]),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 1),
                        child: const Text(
                          'Some Description',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
  }

  Column buildStateColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timbrebells/models/users.dart';
import 'package:timbrebells/providers/Userprovider.dart';
import 'package:timbrebells/resources/FireStoreMethods.dart';
import 'package:timbrebells/widgets/likeAnimation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timbrebells/Home_Page/Home.dart';

class Post_widget extends StatefulWidget {
  final snap;
  const Post_widget({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<Post_widget> {
  @override
  bool isLikeAnimating = false;

  //get snap => snapshot.data;
  Widget build(BuildContext context) {
    final User_details user = Provider.of<UserProvider>(context).getUser;
    //User_details class from users.dart
    //UserProvider class from users.dart
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  /*backgroundImage: NetworkImage(
                    snap['postUrl'],
                  ),*/
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 7,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap[
                              'username'], //for new widgets ...widget.snap..
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          //to occupy only the required space
                          children: [
                            'Delete',
                          ]
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    FireStoreMethods()
                                        .deletePost(widget.snap['postId']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),

          //IMAGE SECTION
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              //gesture detector provides more features than InkWell
              onDoubleTap: () async {
                await FireStoreMethods().likePost(
                  widget.snap['postId'],
                  user.uid,
                  widget.snap['Likes'],
                );
                isLikeAnimating = true;
                print("Check");
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['PostUrl'],
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: Like_animation(
                      child: const Icon(Icons.favorite,
                          color: Colors.white, size: 100),
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          //LIKE COMMENT SECTION
          Row(children: [
            Like_animation(
              isAnimating: widget.snap['Likes'].contains(user.uid),
              smallLike: true,
              child: IconButton(
                onPressed: () async {
                  await FireStoreMethods().likePost(
                    widget.snap['postId'],
                    user.uid,
                    widget.snap['Likes'],
                  );
                },
                icon: widget.snap['Likes'].contains(user.uid)
                    ? const Icon(
                        //if userid already present, i.e. current user has liked the post already
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        //if the current user has not liked the post
                        Icons.favorite_border,
                      ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.comment_outlined,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send,
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            )),
          ]),
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    child: Text(
                      '${widget.snap['Likes'].length} likes',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      //gets arranged in proper row format
                      text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              //1st row
                              text: widget.snap['username'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              //2nd row
                              text: ' ${widget.snap['Description']}',
                            ),
                          ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'View all 200 comments',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap['DatePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
/*child: ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            //HEADER SECTION
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                  image: DecorationImage(
                   /* image: NetworkImage(
                      snap['profImage'],
                    ),*/
                    image: AssetImage(
                          'assesta/images/codetodo,pnd')
                  ), //put link of our img
                ),
              ),
              title: Text(
                snap['username'],
              ),
              subtitle: Text('Profession'),
              trailing: Icon(Icons.more_vert),
              onTap: () => {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                      ),
                      shrinkWrap: true, //to expand only upto the required space
                      children: [
                        'Delete',
                      ]
                          .map(
                            (e) => InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Text(e),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              },
            ),
            //IMAGE SECTION
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  //image: AssetImage('assests/images/post.jpg')
                  image: NetworkImage(snap['PostUrl']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Wrap(
                spacing: 10,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.comment_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send_sharp,
                    ),
                  ),
                  /*SvgPicture.asset(
                    'assests/image/comment.png',
                    width: 30,
                  ), //comment icon
                  SvgPicture.asset(
                    'assests/image/share.png',
                    width: 30,
                  ), //share icon   */
                ],
              ),
              trailing: Icon(
                Icons.bookmark_border_outlined,
                size: 35,
                color: Colors.black,
              ),
            ),
            //DESCRIPTION AND NUMBER OF COMMENTS
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          //copyWith: to allow specific modifications in existing widget
                          fontWeight: FontWeight.w600,
                        ),
                    child: Text(
                      '${snap['Likes'].length} likes', //since likes are stored as array, we just need the length
                      //'250 likes',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.blue),
                        children: [
                          TextSpan(
                            text: snap['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' ${snap['description']}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'View all 200 comments ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        snap['DatePublished'].toDate(),
                      ),
                      //'20/04/22 ',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    ),
    );
  }
}
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timbrebells/Bottom_navigation_bar.dart';
import 'package:timbrebells/Profile/My_Profile.dart';
import 'package:timbrebells/resources/auth_method.dart';
import 'package:timbrebells/Screens/Sign in.dart';
import 'package:timbrebells/Welcome.dart';
class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn3.vectorstock.com%2Fi%2F1000x1000%2F30%2F97%2Fflat-business-man-user-profile-avatar-icon-vector-4333097.jpg&imgrefurl=https%3A%2F%2Fwww.vectorstock.com%2Froyalty-free-vector%2Fflat-business-man-user-profile-avatar-icon-vector-4333097&tbnid=4kXGls3qUNG46M&vet=12ahUKEwjplJWrwqH2AhWDzqACHeQNBSoQMygGegUIARDGAQ..i&docid=u1SY3va6wsUW9M&w=1000&h=1080&q=userprofile&ved=2ahUKEwjplJWrwqH2AhWDzqACHeQNBSoQMygGegUIARDGAQ'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    'UserName',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Usermail@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    uid: FirebaseAuth.instance.currentUser!.uid,  //passing the details of current user to profile screen
                  ),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'logout',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () async{
              await auth_methods().SignOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Welcome(),),);
            },
          ),
        ],
      ),
    );
  }
}

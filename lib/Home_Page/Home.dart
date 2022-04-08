import 'package:flutter/material.dart';
import 'package:timbrebells/Bottom_navigation_bar.dart';
import 'package:timbrebells/Home_Page/SideDrawer.dart';
import 'package:timbrebells/Home_Page/PostWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: 3,
          title: Text(
            'Timbrebells',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              //fontFamily:'Trajan Pro',
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  MdiIcons.featureSearch,
                  size: 35,
                ),
                onPressed: () {}),
            IconButton(
                icon: const Icon(
                    MdiIcons.message, //Image.asset('assests/images/messanger.png'
                ),
                onPressed: () {},
            )
          ],
        ),
        drawer: SideDrawer(),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length, //docs gives the list of document IDs , i.e. post Ids
                itemBuilder: (context, index) => Post_widget(
                  snap: snapshot.data!.docs[index].data(), //storing posts in snap
                  //index refers to each post present in our database
                  //if 3 posts in total index=0,1,2
                ),
              );
            }),
        /*body: Column(
          children: [Expanded(child: PostWidget())],
        ), */
      ),
      //bottomNavigationBar: BottombarWidget(),
    );
  }
}

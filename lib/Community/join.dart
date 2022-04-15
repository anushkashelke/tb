import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'communityListview.dart';
import 'community_pageMain.dart';



class JoinAComm extends StatefulWidget {
  const JoinAComm({Key? key}) : super(key: key);

  @override
  _JoinACommState createState() => _JoinACommState();
}

class _JoinACommState extends State<JoinAComm> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: customSearchBar,
        backgroundColor: Color(0xff630000),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  // Perform set of instructions.
                } else {
                  customIcon = const Icon(Icons.search);
                }
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.close);
                  customSearchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'type in community name...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              });
            },
            icon: customIcon,
          ),
        ],),
        body: Container(
          color: const Color(0xffd8b6a4),
          child: ListView(
            children: const [
            Padding(
              padding: EdgeInsets.only(top: 10,left: 10,bottom: 30),
              child: Text("Top Communities:",
              style: TextStyle(
                fontFamily: 'Acme',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                decoration: TextDecoration.underline,
                decorationThickness: 3
              ),),
            ),
            CommunityListview(),
          ],
        ),
      ),
    );
  }
}

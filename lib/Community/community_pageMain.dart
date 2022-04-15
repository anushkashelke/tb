import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'create.dart';
import 'join.dart';

class CommunityPageMain extends StatefulWidget {
  const CommunityPageMain({Key? key}) : super(key: key);

  @override
  _CommunityPageMainState createState() => _CommunityPageMainState();
}

class _CommunityPageMainState extends State<CommunityPageMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JoinAComm()),
                );
              },
              child: const SizedBox(
                height: 140,
                width: double.infinity,
                child: Card(
                  color: Color(0xffd8b6a4),
                  margin: EdgeInsets.symmetric(vertical: 35, horizontal: 5.0),
                  child: ListTile(
                      title: Center(
                        child: Text(
                          "Join a Community",
                          style: TextStyle(
                              color: Color(0xff630000),
                              fontSize: 30,
                              fontFamily: 'Satisfy',
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAComm()),
              );
            },
            child: const SizedBox(
              height: 130,
              width: double.infinity,
              child: Card(
                color: Color(0xffd8b6a4),
                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 5.0),
                child: ListTile(
                    title: Center(
                      child: Text(
                        "Create a Community",
                        style: TextStyle(
                            color: Color(0xff630000),
                            fontSize: 30,
                            fontFamily: 'Satisfy',
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
          ),
          const Text(
            "Your Communities:",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}

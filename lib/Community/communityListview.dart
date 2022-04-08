import 'package:flutter/material.dart';

import 'communityPage.dart';
class CommunityListview extends StatefulWidget {
  const CommunityListview({Key? key}) : super(key: key);

  @override
  _CommunityListviewState createState() => _CommunityListviewState();
}

class _CommunityListviewState extends State<CommunityListview> {
  final String commName="Classical Music";
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child:  ListTile(
          leading:const CircleAvatar(
            backgroundImage: AssetImage('images/classicalMusic.png'),
          ),
          title:Text(
            commName,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24 ,
                fontFamily: 'Caveat',
                fontWeight: FontWeight.bold
            ),

          )
      ),
      onPressed: (){
      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  CommunityPage(commN: commName)),);
    },
    );
  }
}

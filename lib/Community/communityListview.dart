import 'package:flutter/material.dart';

import 'communityPage.dart';
class CommunityListview extends StatefulWidget {
  const CommunityListview({Key? key}) : super(key: key);

  @override
  _CommunityListviewState createState() => _CommunityListviewState();
}

class _CommunityListviewState extends State<CommunityListview> {
  final String commName="Classical Music";
  final String commAbout="Classical music is a very general term which normally refers to the standard music of countries in the western world. It is music that has been composed by musicians who are trained in the art of writing music (composing) and written down in music notation so that other musicians can play it.";
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child:  ListTile(
          leading:const CircleAvatar(
            //backgroundImage: AssetImage('images/classicalMusic.png'),
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
        MaterialPageRoute(builder: (context) =>  CommunityPage(commN: commName, commA: commAbout)),);
    },
    );
  }
}

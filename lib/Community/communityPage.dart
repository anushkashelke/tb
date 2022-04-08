import 'package:flutter/material.dart';
import '';
import '../widgets/joinButton.dart';
class CommunityPage extends StatefulWidget {
  final String commN;

  const CommunityPage({Key? key, required this.commN}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: Colors.pink,
      appBar: AppBar(
        title:  Text("   "+widget.commN,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),),
        backgroundColor: const Color(0xff630000),
        automaticallyImplyLeading: false,
        // leading: const Icon(
        //     MdiIcons.arrowLeft
        // ),
      ),
      body:Container(
        color: const Color(0xffd8b6a4),
        child: ListView(
          children:[
            // Image(image:AssetImage('images/cover.jpg'),)
            Stack(
              // alignment: Alignment.center,
              children:[
                  // const Image(image:AssetImage('images/cover.jpg')
                  Image.asset(
                      "images/cover.jpg",
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,

                  ),
                const Positioned(
                    bottom: -10,
                    left: 20,
                    // right: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/profile.jpg',
                      ),
                      radius: 45,
                    )
                )
            ]
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(
                  widget.commN,
                  style: const TextStyle(
                    fontSize: 26,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold
                  ),
                ),
                  const JoinButton(
                      backgroundColor: Color(0xffd12828),
                      borderColor: Colors.black,
                      text: 'Join',
                      textColor: Colors.white)
              ]
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10,left: 10),
              child: Text(
                "Classical music is a very general term which normally refers to the standard music of countries in the western world. It is music that has been composed by musicians who are trained in the art of writing music (composing) and written down in music notation so that other musicians can play it.",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NotoSans',
                )
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 10,left: 10),
                child:Text(
                  "Posts",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold
                  ),
                )
            )
          ],

        ),
      ) ,
    );
  }
}

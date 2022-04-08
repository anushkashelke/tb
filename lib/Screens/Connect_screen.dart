import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:timbrebells/Profile/My_Profile.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(labelText: 'Search for a user'),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
            },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  //print("Seeeee");
                  return const Center(
                    child: const CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic)
                      .docs
                      .length, //to obtain total number of relevant ids
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileScreen(uid:(snapshot.data! as dynamic).docs[index]['uid'],),),),
                      child: ListTile(
                      leading: CircleAvatar(
                          //TO DO PART
                          /*backgroundImage: NetworkImage(
                      //(snapshot.data! as dynamic).docs[index]['photoUrl']
                  ), */
                          ),
                      title: Text(
                        (snapshot.data! as dynamic).docs[index]['username'],
                      ),
                    ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
             future: FirebaseFirestore.instance.collection('posts').get(),
             builder: (context,snapshot){
               if(!snapshot.hasData){
                 return const Center(
                     child:const CircularProgressIndicator(),
                 );
               }
               return StaggeredGridView.countBuilder(
                   crossAxisCount:3,
                   itemCount: (snapshot.data! as dynamic).docs.length,
                   itemBuilder: (context,index)=> Image.network(
                       (snapshot.data! as dynamic).docs[index]['PostUrl']
                   ),
                 staggeredTileBuilder: (index) => StaggeredTile.count(
                     (index % 7 == 0)? 2:1,    //crossAxisCellCount,
                     (index % 7 == 0)? 2:1,   // mainAxisCellCount
                  ),
                 mainAxisSpacing: 9,
                 crossAxisSpacing: 9,
               );
      },),
    );
  }
}

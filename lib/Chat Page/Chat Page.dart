import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timbrebells/text_field_input.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 5),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search_outlined),
                ),
                onFieldSubmitted: (String _) {
                  setState(() {
                    isShowUsers = true;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

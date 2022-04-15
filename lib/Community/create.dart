import 'package:flutter/material.dart';
import 'package:timbrebells/resources/auth_method.dart';


import 'community_pageMain.dart';
class CreateAComm extends StatefulWidget {
  const CreateAComm({Key? key}) : super(key: key);

  @override
  _CreateACommState createState() => _CreateACommState();
}

class _CreateACommState extends State<CreateAComm> {
  final _commName = TextEditingController();
  final _commAbout = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Public';

  // List of items in our dropdown menu
  var items = [
    'Public',
    'Restricted',
    'Private',
  ];
  void dispose() {
    super.dispose();
    _commName.dispose();
    _commAbout.dispose();
  }
  void createComm() async{
    String res=await auth_methods().createComm(
      commName:_commName.text,
      commAbout:_commAbout.text,
    );
    if(res=="success"){

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timbrebells"),
        backgroundColor: Color(0xff630000),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 20),
            child: Text(
              "Community Name:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
            child: TextField(
                 controller: _commName,
              style: const TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 20),
            child: Text(
              "Community Type:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 40),
            child: DropdownButton(
                value: dropdownvalue,
                icon: const Icon(Icons.arrow_drop_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                }),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 20),
            child: Text(
              "About:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
            child: TextField(
              controller: _commAbout,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 20),
            child: Text(
              "Profile Photo:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 120, height: 50),
              child: ElevatedButton.icon(
                label:Text("UPLOAD"),
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  primary:Colors.black,
                  // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  // fixedSize: const Size(240, 80)
                ),
                icon: const Icon(
                Icons.upload
              ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 20),
            child: Text(
              "Cover Photo:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 120, height: 50),
              child: ElevatedButton.icon(
                label:Text("UPLOAD"),
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  primary:Colors.black,
                  // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  // fixedSize: const Size(240, 80)
                ),
                icon: const Icon(
                  Icons.upload,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:timbrebells/Utils/Image_picker.dart';
import 'package:timbrebells/models/users.dart';
import 'package:timbrebells/providers/Userprovider.dart';
import 'package:timbrebells/resources/Confirm_Post.dart';
import 'package:timbrebells/resources/FireStoreMethods.dart';

class Add_post extends StatefulWidget {
  const Add_post({Key? key}) : super(key: key);

  @override
  _Add_postState createState() => _Add_postState();
}

class _Add_postState extends State<Add_post> {
  @override
  bool _isLoading=false;
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  void postContent(
      String uid,
      String username,
      )async{
    setState(() {
      _isLoading=false;
    });
      try{
        String result= await FireStoreMethods().uploadPost(_descriptionController.text, uid,username, _file!);
        if (result=="success"){
             setState(() {
               _isLoading=false;
             });
             showSnackBar(
                context,
                "Posted!",
             );
        }
        clearImage();
     }
     catch(e){
      }
  }
  void clearImage(){
    setState(() {
      _file=null;
    });
  }
  _selectTypeOfItem(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Images'),
              //onPressed: () => _selectImageFromFolder(context), //function call where image can be uploaded from gallery or camera
              onPressed: () {
                Navigator.of(context).pop();
                _selectImageFromFolder(context);
            }
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Videos'),
              //onPressed: () => _selectVideoFromFolder(context), //function call where video can be uploaded from gallery or camera
                onPressed: () {
                  Navigator.of(context).pop();
                  _selectVideoFromFolder(context);
                }
            ),
          ]);
        });
  }

  _selectImageFromFolder(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Choose From Gallery'),
              onPressed: () async {
                //async is used where we need to await the file that can be returned
                Navigator.of(context).pop();
                Uint8List ImageFromGallery = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _file = ImageFromGallery;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List Image = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  _file = Image;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]);
        });
  }
  /*pickVideo(ImageSource src,BuildContext context) async{
    final video = await ImagePicker().pickVideo(source: src);
        if(video!=null){
         /* Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => PostConfirmation(),
          ),
          ); */
        }
  } */

  _selectVideoFromFolder(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Choose From Gallery'),
              onPressed: () {
                Navigator.of(context).pop();
                //pickVideo(ImageSource.gallery,context);
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Take a Video'),
              onPressed: () {
                Navigator.of(context).pop();
                //pickVideo(ImageSource.camera, context);
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(25.0),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]);
        });
  }

  _selectItems(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                  padding: const EdgeInsets.all(25.0),
                  child: const Text('Single Item'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _selectTypeOfItem(context);
                  }
                  //onPressed: () => _selectTypeOfItem(context),
                  ),
              SimpleDialogOption(
                  padding: const EdgeInsets.all(25.0),
                  child: const Text('Multiple Items'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _selectTypeOfItem(context);
                  }
                  //onPressed: () => _selectTypeOfItem(context),
                  ),
            ],
          );
        });
    //Navigator.of(context,rootNavigator:true).pop(result);
  }
  void dispose(){
    super.dispose();  //to dispose our controllers
    _descriptionController.dispose();
  }

  Widget build(BuildContext context) {
    final User_details user = Provider.of<UserProvider>(context).getUser;
    return _file == null //checking if our file is null
        //if null return Center else return MaterialApp
        ? Center(
            //if image/video upload icon is not selected show this widget
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectItems(context),
            ),
          )
        : MaterialApp(
            //if upload icon is selected
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    clearImage();
                  },
                ),
                title: const Text("Post to"),
                centerTitle: false,
                actions: [
                  TextButton(
                    onPressed: () => postContent(user.uid,user.username),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 25.0,
                        backgroundImage: NetworkImage(
                            'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F1103663452402946907%2F&psig=AOvVaw3uQSgzSK8PyFYnEsBu2OQF&ust=1646026052603000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJCVu4uTn_YCFQAAAAAdAAAAABAD'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Write a caption..',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(
                                    _file!), //our image is stored in uint8list format which is present in_file
                                //Exclamation mark is added so that as we don't want our file to be null
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

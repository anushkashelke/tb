import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';

class Storagetypes{
     final FirebaseStorage _storage= FirebaseStorage.instance;
     final FirebaseAuth userid=FirebaseAuth.instance;

     Future<String> UploadImageToStorage(String childName,Uint8List UploadFile,bool CheckIfPost) async{
       Reference ref_path= _storage.ref().child(childName).child(userid.currentUser!.uid);  //creating folder of child name
       //                   Post folder                  Uid Folder of each user
       if(CheckIfPost){   //since there can be multiple posts of same user
            String id = const Uuid().v1();  //generate a unique id
            ref_path=ref_path.child(id);   //assign this id to the child (within firebase)
       }
      UploadTask uploadTask =ref_path.putData(UploadFile);  //this provides ua a way on how our file will be uploaded on firebase
      TaskSnapshot snap= await uploadTask;
      String DownloadUrl = await snap.ref.getDownloadURL() ;  //url of the path where file will be stored
      return DownloadUrl;
     }
}
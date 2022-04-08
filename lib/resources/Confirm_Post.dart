import 'package:flutter/material.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';

class PostConfirmation extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const PostConfirmation(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key); //constructor

  @override
  _PostConfirmationState createState() => _PostConfirmationState();
}

class _PostConfirmationState extends State<PostConfirmation> {

  @override
  late VideoPlayerController  controller;//to play the videos
  void initState(){
    super.initState();
    setState(()  //this method is used to dynamically change the UI
    {
      controller=VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1); //volume can be from 0 to 1 with 1 as max volume
    controller.setLooping(true);

  }
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

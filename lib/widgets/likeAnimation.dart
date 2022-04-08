import 'package:flutter/material.dart';

class Like_animation extends StatefulWidget{
   final Widget child;  //to make like animation the parent widget
   final bool isAnimating;
   final Duration duration;  //how long like animation should continue
   final VoidCallback? onEnd; //to end the like animation
   final bool smallLike; //to check if like button was clicked or not
   const Like_animation({
     Key? key,
     required this.child,
     required this.isAnimating,
     this.duration = const Duration(milliseconds: 150),
     this.onEnd,
     this.smallLike = false,
   }) : super(key: key);
   _Like_animationState createState() => _Like_animationState();
}
class _Like_animationState extends State<Like_animation> with SingleTickerProviderStateMixin{
  //class inherited with singleticker.... to provide animation features
  late AnimationController controller;  //AnimationController is a built in class
  late Animation<double> scale;

  void initState(){
    super.initState();
    controller= AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2,
    //divides millisec.. by 2 and converts into 'int'
    ),
    );
    scale = Tween<double>(begin: 1,end: 1.2).animate(controller);  //animation time
   }
   @override
  void didUpdateWidget(covariant Like_animation oldWidget) {  //built in function
    super.didUpdateWidget(oldWidget);  //this will be called if current widget is
     //replaced by another widget
     if(widget.isAnimating != oldWidget.isAnimating){
       startAnimation();
     }
  }
  startAnimation() async{
    if(widget.isAnimating || widget.smallLike){
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200,),);
      if(widget.onEnd !=null){
        widget.onEnd!();
      }
    }
  }
  Widget build(BuildContext context){
     return ScaleTransition(
       scale: scale,
       child: widget.child,
     );
   }
}
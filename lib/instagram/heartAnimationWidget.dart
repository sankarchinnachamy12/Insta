

import 'package:flutter/material.dart';

class HeartAnimationWidget extends StatefulWidget {
  final bool isAnimating;
  final Widget child;
  final bool  alwaysAnimate;
  final Duration duration;
 final VoidCallback? onEnd;
   HeartAnimationWidget( {
    Key ?key,
   required this.child,
   required this.isAnimating,
   this.duration= const Duration(milliseconds:150) ,
   this.onEnd,
    this.alwaysAnimate=false

  
  }):super(key:key);

  @override
  State<HeartAnimationWidget> createState() => _HeartAnimationWidgetState();
}

class _HeartAnimationWidgetState extends State<HeartAnimationWidget> with SingleTickerProviderStateMixin {
    late   AnimationController controller;
    late Animation<double> scale;
    @override
      void initState(){
        super.initState();
        final halfduration=widget.duration.inMilliseconds;
        controller=AnimationController(vsync:this,value: 0.4, 
        duration: Duration(milliseconds: halfduration)
        );
        scale=Tween<double>(begin:1,end:1.2).animate(controller);
      }
    @override
      void didUpdateWidget (HeartAnimationWidget oldWidget) {
        super.didUpdateWidget(oldWidget);
         if(widget.isAnimating != oldWidget.alwaysAnimate){
        doAnimation();
      }
        
      }
     Future doAnimation()async{
      await controller.forward();
      await controller.reverse();
      Future .delayed(Duration(milliseconds: 400));
      if(widget.onEnd !=null){
        widget.onEnd!();
      }
     }


      @override
        void dispose () {
          controller.dispose();
          super.dispose();
        }
        
  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: scale,
    child: widget.child,);
    
  }

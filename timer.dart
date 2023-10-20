import 'dart:async';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimerView extends StatelessWidget{
  TimerView(this.isTurn, this.delay, this.time, this.onTap, this.subtract, this.isTop, {super.key});

  bool isTop;
  int delay;
  int time;
  bool isTurn;
  bool lose = false;
  void Function() onTap;
  void Function() subtract;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isTurn ? onTap : (){},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          color: isTurn ? (lose ? Colors.pink : Colors.blue) : Colors.blue.withOpacity(0.5),
        ),
        child: Time(delay, time, isTurn, isTop, (){lose = true; onTap();}, subtract),
      )
    );
  }
}

// ignore: must_be_immutable
class Time extends StatefulWidget{
  Time(this.delay, this.time, this.isTurn, this.isTop, this.lose, this.subtract, {super.key});

  int delay;
  int time;
  bool isTurn;
  bool isTop;
  void Function() lose;
  void Function() subtract;

  @override
  State<StatefulWidget> createState() {
    return TimeState();
  }
}

class TimeState extends State<Time>{
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(widget.isTurn){
        setState(() {
          if(widget.delay > 0){
            widget.delay--;
          }
          else if(widget.time > 0){
            widget.time--;
            widget.subtract();
          }
          else{
            widget.lose();
            return;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: widget.isTop ? const AlwaysStoppedAnimation(180 / 360) : const AlwaysStoppedAnimation(0 / 360),
        child: Text(
          "${widget.delay} - ${widget.time}",
          style: const TextStyle(
            fontSize: 100,
          ),
        ),
      ),
    );
  }
}
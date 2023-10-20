import 'package:chess_clock/timer.dart';
import 'package:flutter/material.dart';

void main() => 
runApp(
  const MaterialApp(
    home: Scaffold(
      body: 
      ChessClock()
    ),
  )
);

class ChessClock extends StatefulWidget{
  const ChessClock({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChessClockState();
  }
}

class _ChessClockState extends State<ChessClock>{
  void turnChanged(){
    setState(() {
      timeInfo[1] = 30;
      timeInfo[3] = 30;
      isTopSide = !isTopSide!;
    });
  }

  void subtract(bool isTop){
    if(isTop){
      timeInfo[2]--;
    }
    else{
      timeInfo[4]--;
    }
  }

  bool? isTopSide;
  List <int> timeInfo = [0, 30, 60, 30, 60];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: 
      ((isTopSide != null) ?
      ([
        TimerView(isTopSide!, timeInfo[1], timeInfo[2], turnChanged, (){subtract(true);}, true),
        TimerView(!isTopSide!, timeInfo[3], timeInfo[4], turnChanged, (){subtract(false);}, false),
      ])
      :
      ([
        Spacer(),
        Center(
          child: ElevatedButton(
            onPressed: (){
              setState(() {
                isTopSide = false;
              });
            }, 
            child: const Text("Play"),
          ),
        ),
        Spacer(),
      ]))
    );
  }
}



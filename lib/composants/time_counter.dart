import 'dart:async';

import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeCounter extends StatefulWidget {
  const TimeCounter({Key? key}) : super(key: key);

  @override
  TimeCounterState createState() => TimeCounterState();
}

class TimeCounterState extends State<TimeCounter> {

  Timer? _timer;
  int _secondCount = 0;
  int _minuteCount = 0;
  int _hourCount = 0;


  void initTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondCount += 1;
      });
      if (_secondCount == 60){
        setState(() {
          _secondCount = 0;
          _minuteCount += 1;
        });
        if (_minuteCount == 60){
          setState(() {
            _minuteCount = 0;
            _hourCount += 1;
          });
        }
      }

    });
  }

  void stopTimer(){
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    NumberFormat formatter = NumberFormat("00");
    return Text(
      "${formatter.format(_hourCount)}:${formatter.format(_minuteCount)}:${formatter.format(_secondCount)}",
      style: const TextStyle(
          fontSize: 10,
          fontFamily: 'Poppins Regular',
          color: principalColor
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}

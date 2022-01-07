import 'dart:async';

import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/provider/app_bar_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeCounter extends StatefulWidget {
  const TimeCounter({Key? key}) : super(key: key);

  @override
  TimeCounterState createState() => TimeCounterState();
}

class TimeCounterState extends State<TimeCounter> {


  @override
  Widget build(BuildContext context) {

    NumberFormat formatter = NumberFormat("00");
    TimeCount timeCounter = Provider.of<AppBarModel>(context).timeCount;

    return Text(
        "${formatter.format(timeCounter.hourCount)}:${formatter.format(timeCounter.minuteCount)}:${formatter.format(timeCounter.secondCount)}",
        style: const TextStyle(
            fontSize: 10,
            fontFamily: 'Poppins Regular',
            color: principalColor
        ),
    );
  }

}

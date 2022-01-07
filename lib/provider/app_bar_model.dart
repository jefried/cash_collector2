import 'dart:async';

import 'package:flutter/material.dart';

class AppBarModel extends ChangeNotifier{

  int _notifsNumber = 1;
  TimeCount _timeCount = TimeCount();
  bool _startedActivity = false;
  Timer? _timer;

  void addNotifsNumber(){
    _notifsNumber += 1;
    notifyListeners();
  }

  int get notifsNumber => _notifsNumber;

  void setStartedActivity(bool started){
    _startedActivity = started;
    initTimer();
    notifyListeners();
  }

  bool get startedActivity => _startedActivity;

  void initTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeCount.secondCount += 1;
      if (_timeCount.secondCount == 60){
        _timeCount.secondCount = 0;
        _timeCount.minuteCount += 1;
        if (_timeCount.minuteCount == 60){
          _timeCount.minuteCount = 0;
          _timeCount.hourCount += 1;
        }
      }
      notifyListeners();
    });
  }

  void stopTimer(){
    _startedActivity = false;
    _timer?.cancel();
    notifyListeners();
  }

  TimeCount get timeCount => _timeCount;

}

class TimeCount {
  int secondCount;
  int minuteCount;
  int hourCount;

  TimeCount({
    this.hourCount = 0,
    this.minuteCount = 0,
    this.secondCount = 0
  });

}
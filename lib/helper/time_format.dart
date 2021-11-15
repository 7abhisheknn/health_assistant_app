import 'package:flutter/material.dart';

String TimeFormat(String time) {
  int hour = int.parse(time.substring(10, 12));
  String meridien = (hour < 12) ? 'AM' : 'PM';
  hour = hour % 12;
  if (hour == 0) hour = 12;
  String s;
  s = hour.toString() + ' : ' + time.substring(13, 15) + ' ' + meridien;
  return s;
}

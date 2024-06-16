import 'package:flutter/material.dart';

class ConvertTimeToString {
  static String timeToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }
}

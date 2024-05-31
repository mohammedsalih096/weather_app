import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDay extends StatelessWidget {
  const CurrentDay();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formatedDay = DateFormat('EEEE').format(now);
    return Text(
      '$formatedDay',
    );
  }
}

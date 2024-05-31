import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentTime extends StatelessWidget {
  final TextStyle? style;

  const CurrentTime({super.key, this.style});
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH.MM').format(now);
    return Text(
      '$formattedTime' + "AM",
      style: style,
    );
  }
}

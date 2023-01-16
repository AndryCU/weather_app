import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CurrentWeatherColumns extends StatelessWidget {
  const CurrentWeatherColumns(
      {super.key, required this.icon, required this.value, required this.cat});
  final IconData icon;
  final String value, cat;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          cat,
          style: TextStyle(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

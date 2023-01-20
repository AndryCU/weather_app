import 'package:flutter/material.dart';

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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          cat,
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

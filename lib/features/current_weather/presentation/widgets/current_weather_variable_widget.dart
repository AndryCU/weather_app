import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
          size: 8.w,
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        ),
        Text(
          cat,
          style: TextStyle(
            color: Colors.white60,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}

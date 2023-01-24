import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/const/colors.dart';

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
          color: iconColor,
          size: 8.w,
        ),
        Text(
          value,
          style: TextStyle(
              color: textTitleColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        ),
        Text(
          cat,
          style: TextStyle(
            color: cardSubtitleColor, //Colors.white60,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}

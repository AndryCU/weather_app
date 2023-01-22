import 'dart:async';
import 'dart:io';

import 'package:weather_app/core/exeptions.dart';

class CheckInternetConnection {
  static Future<bool> checkIfHaveInternet() async {
    try {
      //https://use.opendns.com/
      final result = await InternetAddress.lookup('example.com').timeout(
          const Duration(seconds: 20),
          onTimeout: () => throw NoInternetException());
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }
}

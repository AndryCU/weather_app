import 'dart:async';
import 'dart:io';

class CheckInternetConnection {
  static Future<bool> checkIfHaveInternet() async {
    try {
      //https://use.opendns.com/
      final result = await InternetAddress.lookup('example.com').timeout(
          const Duration(seconds: 10),
          onTimeout: () =>
              throw TimeoutException('Can\'t connect in 10 seconds.'));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }
}

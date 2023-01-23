import 'package:intl/intl.dart';

class SunDataConverter {
  static String fromMillisecondsToString(int dt) {
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return DateFormat().add_jm().format(date);
  }
}

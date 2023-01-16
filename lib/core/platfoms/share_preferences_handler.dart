import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/injection/locator.dart';

//final localto = GetIt.instance;

class SharedPreferencesManager {
  final _unit = 'units_value';
  final SharedPreferences sharedPreferences;

  SharedPreferencesManager(this.sharedPreferences);
  Future<void> setUnitValue(bool value) async {
    await sharedPreferences.setBool(_unit, value);
  }

  Future<bool> getUnitValue() async {
    final value = sharedPreferences.getBool(_unit);

    return value ?? false;
  }
}

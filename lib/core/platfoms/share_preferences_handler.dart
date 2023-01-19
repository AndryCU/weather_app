import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  final _unit = 'units_value';
  final SharedPreferences sharedPreferences;
  final _order_days = 'order_days';
  SharedPreferencesManager(this.sharedPreferences);
  Future<void> setUnitValue(bool value) async {
    await sharedPreferences.setBool(_unit, value);
  }

  Future<bool> getUnitValue() async {
    final value = sharedPreferences.getBool(_unit);
    return value ?? false;
  }

  Future<void> setOrderValue(bool value) async {
    await sharedPreferences.setBool(_order_days, value);
  }

  Future<bool> getOrderValue() async {
    final value = sharedPreferences.getBool(_order_days);
    return value ?? false;
  }
}

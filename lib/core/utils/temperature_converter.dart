class TemperatureHelper {
  static String convertTemperatureToCelsius(double temp) {
    return '${(temp - 273.15).toStringAsFixed(1)}°C';
  }

  static convertTemperatureToFahrenheit(double temp) {
    return '${((temp - 273.15) * 1.8 + 32).toStringAsFixed(1)}°F';
  }
}

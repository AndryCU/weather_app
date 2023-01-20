class TemperatureHelper {
  static String convertTemperatureToCelsius(double temp) {
    return '${(temp - 273.15).round()}°C';
  }

  static convertTemperatureToFahrenheit(double temp) {
    return '${((temp - 273.15) * 1.8 + 32).round()}°F';
  }
}

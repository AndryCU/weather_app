String convertTemperatureToCelsius(double temp) {
  return '${(temp - 273.15).round()}°C';
}

String convertTemperatureToFahrenheit(double temp) {
  return '${((temp - 273.15) * 1.8 + 32).toStringAsFixed(0)}°F';
}

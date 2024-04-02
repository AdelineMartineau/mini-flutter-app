class WeatherData {
  WeatherData({
    required this.city,
    required this.temperature,
    required this.weather,
    required this.humidity,
    required this.wind,
    required this.feel,
  });

  final String city;
  final double temperature;
  final String weather;
  final double humidity;
  final double wind;
  final double feel;

  WeatherData copyWith({
    required double temperature,
  }) {
    return WeatherData(
      city: city,
      temperature: temperature,
      weather: weather,
      humidity: humidity,
      wind: wind,
      feel: feel,
    );
  }
}

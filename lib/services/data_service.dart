import 'package:myproject/models/weather_data.dart';

class WeatherService {
  static const _latencyEmulation = Duration(seconds: 2);

  Future<List<WeatherData>> fetchWeatherData() async {
    // attente de 2 sec avant de récupérer la requête
    await Future.delayed(_latencyEmulation);

    List<WeatherData> weatherData = [
      WeatherData(
        city: 'Paris',
        temperature: 18,
        weather: 'Ensoleillé',
        humidity: 76,
        wind: 13,
        feel: 17,
      ),
      WeatherData(
        city: 'New York',
        temperature: 12,
        weather: 'Nuageux',
        humidity: 50,
        wind: 9,
        feel: 10,
      ),
      WeatherData(
        city: 'Tokyo',
        temperature: 22,
        weather: 'Pluvieux',
        humidity: 10,
        wind: 5,
        feel: 23,
      ),
    ];
    return weatherData;
  }
}

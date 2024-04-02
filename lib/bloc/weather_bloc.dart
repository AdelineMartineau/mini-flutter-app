import 'package:bloc/bloc.dart';
import 'package:myproject/models/weather_data.dart';
import 'package:myproject/services/data_service.dart';

class WeatherCubit extends Cubit<List<WeatherData>> {
  final WeatherService _service;

  // constructeur
  // état initialisé avec le service et status initial du cubit
  // WeatherCubit(this.weatherDataFuture) : super(weatherDataFuture);
  WeatherCubit(this._service) : super([]);

  // appel du service
  Future<void> fetchWeatherData() async {
    final data = await _service.fetchWeatherData();
    final updatedData = data.map((e) => e.copyWith(temperature: e.temperature + 1)).toList();
    emit(updatedData);
  }
}

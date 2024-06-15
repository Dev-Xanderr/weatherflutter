import 'package:openweather_mvvm/model/lib/weather.dart';
import 'package:openweather_mvvm/model/services/base_service.dart';
import 'package:openweather_mvvm/model/services/weather_service.dart';

class WeatherRepository {
  final BaseService _weatherService = WeatherService();

  Future<Weather> fetchWeatherData(String city) async {
    dynamic response = await _weatherService.getResponse(city);
    return Weather.fromJson(response);
  }

  Future<Weather> fetchWeatherDataByLocation(double lat, double lon) async {
    dynamic response = await _weatherService.getResponseByLocation(lat, lon);
    return Weather.fromJson(response);
  }
}

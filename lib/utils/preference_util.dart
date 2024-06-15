import 'package:openweather_mvvm/model/lib/weather.dart';
import 'package:openweather_mvvm/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setWeather(Weather? weather) async {
    await _preferences.setString(Constants.city,
        weather != null ? weather.city! : Constants.defaultCity);
    await _preferences.setString(Constants.updatedAt,
        weather != null ? weather.updatedAt! : "00.00");
    await _preferences.setString(Constants.description,
        weather != null ? weather.description! : "cloudy");
    await _preferences.setString(Constants.temperature,
        weather != null ? weather.temperature! : "0.0");
    await _preferences.setString(Constants.minTemperature,
        weather != null ? weather.minTemperature! : "0.0");
    await _preferences.setString(Constants.maxTemperature,
        weather != null ? weather.maxTemperature! : "0.0");
    await _preferences.setString(Constants.sunrise,
        weather != null ? weather.sunrise! : "00.00");
    await _preferences.setString(Constants.sunset,
        weather != null ? weather.sunset! : "00.00");
    await _preferences.setString(Constants.windSpeed,
        weather != null ? weather.windSpeed! : "0.0");
    await _preferences.setString(Constants.pressure,
        weather != null ? weather.pressure! : "0.0");
    await _preferences.setString(Constants.humidity,
        weather != null ? weather.humidity! : "0.0");
  }

  static Weather? getWeather(){
    return Weather(
      city: _preferences.getString(Constants.city),
      updatedAt: _preferences.getString(Constants.updatedAt),
      description: _preferences.getString(Constants.description),
      temperature: _preferences.getString(Constants.temperature),
      minTemperature: _preferences.getString(Constants.minTemperature),
      maxTemperature: _preferences.getString(Constants.maxTemperature),
      sunrise: _preferences.getString(Constants.sunrise),
      sunset: _preferences.getString(Constants.sunset),
      windSpeed: _preferences.getString(Constants.windSpeed),
      pressure: _preferences.getString(Constants.pressure),
      humidity: _preferences.getString(Constants.humidity),
    );
  }

  static Future<void> remove(String key) async{
    await _preferences.remove(key);
  }

  static Future<void> clear() async{
    await _preferences.clear();
  }
}

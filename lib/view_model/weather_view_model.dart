import 'package:flutter/cupertino.dart';
import 'package:openweather_mvvm/model/api/api_response.dart';
import 'package:openweather_mvvm/model/lib/weather.dart';
import 'package:openweather_mvvm/model/repository/weather_repository.dart';
import 'package:openweather_mvvm/utils/preference_util.dart';

class WeatherViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial("Empty data"); // Estado inicial do ApiResponse

  Weather? _weather; // Informações meteorológicas obtidas

  ApiResponse get response {
    return _apiResponse; // Getter para acessar o ApiResponse atual
  }

  Weather? get weather {
    return _weather; // Getter para acessar as informações meteorológicas atuais
  }

  Future<void> fetchWeatherData(String city) async {
    _apiResponse = ApiResponse.loading('Fetching weather data'); // Indica que está carregando os dados
    notifyListeners(); // Notifica os listeners que o estado mudou

    try {
      Weather weather = await WeatherRepository().fetchWeatherData(city); // Obtém os dados meteorológicos do repositório
      _apiResponse = ApiResponse.completed(weather); // Atualiza o estado com os dados obtidos
      _weather = weather; // Atualiza as informações meteorológicas
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString()); // Atualiza o estado com erro, se ocorrer
      print(e); // Imprime o erro no console
    }

    notifyListeners(); // Notifica os listeners que o estado mudou novamente
  }

  Future<void> fetchWeatherDataByLocation(double lat, double lon) async {
    _apiResponse = ApiResponse.loading('Fetching weather data'); // Indica que está carregando os dados
    notifyListeners(); // Notifica os listeners que o estado mudou

    try {
      Weather weather = await WeatherRepository().fetchWeatherDataByLocation(lat, lon); // Obtém os dados meteorológicos por localização
      _apiResponse = ApiResponse.completed(weather); // Atualiza o estado com os dados obtidos
      _weather = weather; // Atualiza as informações meteorológicas
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString()); // Atualiza o estado com erro, se ocorrer
      print(e); // Imprime o erro no console
    }

    notifyListeners(); // Notifica os listeners que o estado mudou novamente
  }
}

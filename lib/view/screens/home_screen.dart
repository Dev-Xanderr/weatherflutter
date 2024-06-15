import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:openweather_mvvm/model/api/api_response.dart';
import 'package:openweather_mvvm/model/lib/weather.dart';
import 'package:openweather_mvvm/model/services/location_service.dart';
import 'package:openweather_mvvm/utils/constants.dart';
import 'package:openweather_mvvm/utils/helper.dart';
import 'package:openweather_mvvm/utils/preference_util.dart';
import 'package:openweather_mvvm/view/screens/list_city_screen.dart';
import 'package:openweather_mvvm/view/widgets/button_section.dart';
import 'package:openweather_mvvm/view/widgets/header_section.dart';
import 'package:openweather_mvvm/view/widgets/information_card_section.dart';
import 'package:openweather_mvvm/view/widgets/main_section.dart';
import 'package:openweather_mvvm/view_model/weather_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Weather? savedWeather;
  Helper helper = Helper();

  @override
  void initState() {
    super.initState();
    checkInternetAndFetchWeatherData();
  }

  void checkInternetAndFetchWeatherData() async {
    bool hasInternet = await checkInternetConnection();
    if (hasInternet) {
      fetchWeatherData();
    } else {
      fetchSavedWeatherData();
      _buildSnackBar("No internet connection");
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> fetchSavedWeatherData() async {
    Weather? weather = PreferenceUtil.getWeather();
    if (weather != null) {
      setState(() {
        savedWeather = weather;
      });
    } else {
      fetchWeatherData();
    }
  }

  void fetchWeatherData() async {
    LocationService locationService = LocationService();
    try {
      Position position = await locationService.getCurrentLocation();
      await Provider.of<WeatherViewModel>(context, listen: false)
          .fetchWeatherDataByLocation(position.latitude, position.longitude);
      Weather? newWeather =
          Provider.of<WeatherViewModel>(context, listen: false).weather;
      if (newWeather != null) {
        await PreferenceUtil.setWeather(newWeather);
        setState(() {
          savedWeather = newWeather;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<WeatherViewModel>(context).response;
    bool isLoading = apiResponse.status == Status.LOADING;
    String? message = apiResponse.message;
    Weather? weather = savedWeather;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            color: Constants.skyBlue,
            child: SafeArea(
              child: Center(
                child: _buildMainContent(weather),
              ),
            ),
          ),
          if (isLoading) _buildLoadingContent(message)
        ],
      ),
    );
  }

  Widget _buildLoadingContent(String? message) {
    return Container(
      color: Colors.black.withOpacity(0.6), // Semi-transparent overlay
      child: Center(
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Constants.cardBackground,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextSection(text: message!, size: 14),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.blue,
                      strokeWidth: 2)),
            ],
          ),
        ),
      ),
    );
  }

  void _buildSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextSection(
      text: message,
      size: 14,
    )));
  }

  Widget _buildMainContent(Weather? weather) {
    return Column(
      children: <Widget>[
        HeaderSection(
          city: weather != null ? weather.city.toString() : "Your Location",
          updatedTime: weather != null ? weather.updatedAt.toString() : "00.00",
        ),
        const SizedBox(height: 64),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 32),
              MainSection(
                mainTemp: weather != null
                    ? helper.kelvinToCelcius(weather.temperature)
                    : "0.0",
                minTemp: weather != null
                    ? helper.kelvinToCelcius(weather.minTemperature)
                    : "0.0",
                maxTemp: weather != null
                    ? helper.kelvinToCelcius(weather.maxTemperature)
                    : "0.0",
                status:
                    weather != null ? weather.description.toString() : "0.0",
              ),
              const SizedBox(height: 100),
              InformationCardSection(
                sunrise: weather != null
                    ? helper.unixTimeToAmPm(weather.sunrise)
                    : "00.00",
                sunset: weather != null
                    ? helper.unixTimeToAmPm(weather.sunset)
                    : "00.00",
                wind: weather != null ? weather.windSpeed.toString() : "0.0",
                pressure: weather != null ? weather.pressure.toString() : "0.0",
                humidity: weather != null ? weather.humidity.toString() : "0.0",
                info: 'Data',
                update: fetchWeatherData,
              ),
            ],
          ),
        ),
        ButtonSection(onTap: moveToListCityScreen, text: "Show 6 more cities"),
      ],
    );
  }

  void moveToListCityScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListCityScreen();
    }));
  }
}

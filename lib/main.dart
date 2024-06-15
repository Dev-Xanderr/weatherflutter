import 'package:flutter/material.dart';
import 'package:openweather_mvvm/utils/constants.dart';
import 'package:openweather_mvvm/utils/preference_util.dart';
import 'package:openweather_mvvm/view/screens/home_screen.dart';
import 'package:openweather_mvvm/view/screens/list_city_screen.dart';
import 'package:openweather_mvvm/view/screens/splash_screen.dart';
import 'package:openweather_mvvm/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que os widgets estejam inicializados corretamente
  await initializePreference(); // Inicializa as preferências do aplicativo de forma assíncrona
  runApp(const MyApp()); // Inicia a aplicação Flutter
}

Future<void> initializePreference() async {
  await PreferenceUtil.init(); // Inicializa as preferências do aplicativo usando a classe PreferenceUtil
}

// Classe principal que define o aplicativo Flutter
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retorna um MultiProvider que envolve toda a aplicação para gerenciar estados com Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherViewModel()), // Provider para o WeatherViewModel
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove a faixa de debug no canto superior direito
        title: 'Weather App', // Título do aplicativo
        theme: ThemeData(
          primarySwatch: Colors.blue, // Define a cor primária do tema
          scaffoldBackgroundColor: Constants.skyBlue, // Define a cor de fundo padrão do esquema
        ),
        initialRoute: '/', // Define a rota inicial do aplicativo
        routes: {
          '/': (context) => const SplashScreen(), // Rota para a SplashScreen
          '/home': (context) => const HomeScreen(), // Rota para a HomeScreen
          '/list-city': (context) => ListCityScreen(), // Rota para a ListCityScreen
        },
      ),
    );
  }
}

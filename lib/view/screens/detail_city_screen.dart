import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:openweather_mvvm/model/api/api_response.dart';
import 'package:openweather_mvvm/model/lib/weather.dart';
import 'package:openweather_mvvm/utils/constants.dart';
import 'package:openweather_mvvm/utils/helper.dart';
import 'package:openweather_mvvm/view/widgets/button_section.dart';
import 'package:openweather_mvvm/view/widgets/header_section.dart';
import 'package:openweather_mvvm/view/widgets/information_card_section.dart';
import 'package:openweather_mvvm/view/widgets/main_section.dart';
import 'package:openweather_mvvm/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class DetailCityScreen extends StatefulWidget {
  const DetailCityScreen({super.key, required this.cityName});
  final String cityName;

  @override
  State<DetailCityScreen> createState() => _DetailCityScreenState();
}

class _DetailCityScreenState extends State<DetailCityScreen> {
  @override
  void initState() {
    super.initState();
    checkInternetConnection(); // Verifica a conexão com a internet ao inicializar a tela
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      fetchWeatherData(); // Se não houver conexão, busca os dados meteorológicos locais
      _buildSnackBar("No internet connection"); // Exibe um snackbar informando a falta de conexão
    } else {
      fetchWeatherData(); // Se houver conexão, busca os dados meteorológicos da cidade selecionada
    }
  }

  void fetchWeatherData() {
    Provider.of<WeatherViewModel>(context, listen: false)
        .fetchWeatherData(widget.cityName); // Utiliza o ViewModel para buscar os dados meteorológicos
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<WeatherViewModel>(context).response;
    bool isLoading = apiResponse.status == Status.LOADING;
    Weather? weather = apiResponse.data as Weather?;
    String? message = apiResponse.message;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            color: Constants.skyBlue, // Cor de fundo da tela
            child: SafeArea(
              child: Center(
                child: _buildMainContent(weather), // Conteúdo principal da tela
              ),
            ),
          ),
          if (isLoading)
            _buildLoadingContent(message), // Exibe conteúdo de carregamento se estiver carregando
        ],
      ),
    );
  }

  Widget _buildMainContent(Weather? weather) {
    Helper helper = Helper(); // Instância do helper para conversões de dados

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        HeaderSection(
          city: widget.cityName, // Nome da cidade exibido no cabeçalho
          updatedTime: weather != null
              ? weather.updatedAt.toString()
              : "00.00"), // Última atualização dos dados meteorológicos
        const SizedBox(
          height: 64,
        ),
        MainSection(
          mainTemp: weather != null
              ? helper.kelvinToCelcius(weather.temperature)
              : "0.0", // Temperatura principal convertida de Kelvin para Celsius
          minTemp: weather != null
              ? helper.kelvinToCelcius(weather.minTemperature)
              : "0.0", // Temperatura mínima convertida de Kelvin para Celsius
          maxTemp: weather != null
              ? helper.kelvinToCelcius(weather.maxTemperature)
              : "0.0", // Temperatura máxima convertida de Kelvin para Celsius
          status: weather != null ? weather.description.toString() : "0.0", // Descrição do clima
        ),
        const SizedBox(height: 100),
        InformationCardSection(
          sunrise: weather != null
              ? helper.unixTimeToAmPm(weather.sunrise)
              : "00.00", // Horário do nascer do sol convertido para AM/PM
          sunset: weather != null
              ? helper.unixTimeToAmPm(weather.sunset)
              : "00.00", // Horário do pôr do sol convertido para AM/PM
          wind: weather != null ? weather.windSpeed.toString() : "0.0", // Velocidade do vento
          pressure: weather != null ? weather.pressure.toString() : "0.0", // Pressão atmosférica
          humidity: weather != null ? weather.humidity.toString() : "0.0", // Umidade do ar
          info: 'Data', // Informações adicionais (pode ser alterado conforme necessário)
          update: fetchWeatherData, // Função para atualizar os dados meteorológicos
        ),
        const SizedBox(height: 32),
        ButtonSection(
          onTap: () {
            Navigator.pop(context); // Botão para voltar para a lista de cidades
          },
          text: "Back to List", // Texto exibido no botão de retorno
        ),
      ],
    );
  }

  Widget _buildLoadingContent(String? message) {
    return Container(
      color: Colors.black.withOpacity(0.6), // Overlay semitransparente
      child: Center(
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Constants.cardBackground, // Cor de fundo do cartão de carregamento
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextSection(
                text: message!, // Mensagem de carregamento ou erro exibida
                size: 14,
              ),
              const SizedBox(height: 8,),
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: Colors.white, // Cor do indicador de progresso
                  backgroundColor: Colors.blue, // Cor de fundo do indicador de progresso
                  strokeWidth: 2, // Espessura do indicador de progresso
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextSection(
          text: message,
          size: 14,
        ), // Exibe um snackbar com uma mensagem de texto
      ),
    );
  }
}

import 'package:intl/intl.dart';
import 'dart:developer' as developer;

// Enumeração para representar o status de uma operação
enum Status { INITIAL, LOADING, COMPLETED, ERROR }

class Helper {
  // Converte temperatura de Kelvin para Celsius
  String kelvinToCelcius(String? temperature) {
    double celsius = double.parse(temperature!) - 273.15;
    return celsius.toStringAsFixed(1); // Retorna a temperatura com uma casa decimal
  }

  // Converte tempo Unix para formato AM/PM (12 horas)
  String unixTimeToAmPm(String? unixTime) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(unixTime!) * 1000);
    return DateFormat('h:mm a').format(date); // Formata a data e hora
  }

  // Converte tempo Unix para formato AM/PM com dia, mês e ano
  String unixTimeToAmPmSs(String? milliseconds) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds!) * 1000);
    return DateFormat('dd MMM yyyy \'|\' hh:mm a').format(dateTime);
  }

  // Converte o offset do fuso horário para data e hora local
  String timezoneOffsetToDate(String? timezoneOffset) {
    DateTime utcTime = DateTime.now().toUtc(); // Tempo UTC atual
    DateTime localTime =
        utcTime.add(Duration(seconds: int.parse(timezoneOffset!))); // Tempo local ajustado
    return DateFormat('dd MMM yyyy \'|\' hh:mm:ss').format(localTime); // Formata a data e hora local
  }

  // Método para log de mensagens com o uso da classe developer.log
  void log(String message, {String name = 'helper_log'}) {
    developer.log(message, name: name); // Log da mensagem com um nome opcional
  }

  // Capitaliza a primeira letra de cada palavra na string de entrada
  String capitalize(String input) {
    if (input.isEmpty) {
      return input; // Retorna a string vazia se não houver entrada
    }
    List<String> words = input.split(' '); // Divide a entrada em palavras
    String capitalizedString = words.map((word) {
      if (word.isEmpty) {
        return ''; // Retorna uma string vazia se a palavra for vazia
      }
      // Capitaliza a primeira letra da palavra e converte o restante para minúsculas
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' '); // Junta as palavras capitalizadas de volta em uma única string
    return capitalizedString; // Retorna a string final com todas as palavras capitalizadas
  }
}

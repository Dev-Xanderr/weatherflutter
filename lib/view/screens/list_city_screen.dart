import 'package:flutter/material.dart';
import 'package:openweather_mvvm/model/lib/city.dart';
import 'package:openweather_mvvm/view/screens/detail_city_screen.dart';
import 'package:openweather_mvvm/view/widgets/button_section.dart';

class ListCityScreen extends StatelessWidget {
  ListCityScreen({super.key});

  // Lista de cidades com seus nomes e caminhos para as imagens
  final List<City> cityList = [
    City("New York", "images/new_york_city.png"),
    City("Singapore", "images/singapore_city.png"),
    City("Mumbai", "images/mumbai_city.png"),
    City("Delhi", "images/delhi_city.png"),
    City("Sydney", "images/sydney_city.png"),
    City("Melbourne", "images/melbourne_city.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              // Lista de cidades usando ListView.builder
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cityList.length,
                itemBuilder: (context, index) {
                  final city = cityList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CityCardItem(
                      imagePath: city.imagePath,
                      cityName: city.name,
                      onTap: () {
                        // Navega para a tela de detalhes da cidade quando um card é pressionado
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailCityScreen(cityName: city.name)));
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 4,
              ),
              // Botão para voltar à tela anterior
              ButtonSection(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Back to My City",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CityCardItem extends StatelessWidget {
  const CityCardItem({
    super.key,
    required this.imagePath,
    required this.cityName,
    required this.onTap,
  });

  final String imagePath;
  final String cityName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Ao clicar no card, executa a função fornecida
      splashColor: Colors.blue[100], // Cor do splash ao tocar no card
      borderRadius: BorderRadius.circular(10), // Borda arredondada do card
      child: SizedBox(
        width: double.infinity,
        height: 135,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Texto da cidade à esquerda
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(
                    cityName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Imagem da cidade à direita
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

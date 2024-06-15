import 'package:flutter/material.dart';
import 'package:openweather_mvvm/utils/constants.dart';
import 'package:openweather_mvvm/view/widgets/main_section.dart';

class InformationCardSection extends StatelessWidget {
  const InformationCardSection(
      {super.key,
      required this.sunrise,
      required this.sunset,
      required this.wind,
      required this.pressure,
      required this.humidity,
      required this.info, required this.update});

  final String sunrise;
  final String sunset;
  final String wind;
  final String pressure;
  final String humidity;
  final String info;
  final VoidCallback update;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //CrossAxisAlignment.stretch to ensure that CardItem widgets occupy the full width of their parent Column.
      children: [
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                //Expanded widget. This ensures that each widget takes an equal portion of the available space horizontally.
                child: CardItem(
                  imagePath: "images/sunrise.png",
                  label: "Sunrise",
                  value: sunrise,
                  onTap: () {},
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: CardItem(
                  imagePath: "images/sunset.png",
                  label: "Sunset",
                  value: sunset,
                  onTap: () {},
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: CardItem(
                  imagePath: "images/wind.png",
                  label: "Wind",
                  value: "$wind km/h",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CardItem(
                  imagePath: "images/pressure.png",
                  label: "Pressure",
                  value: "$pressure %",
                  onTap: () {},
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: CardItem(
                  imagePath: "images/humidity.png",
                  label: "Humidity",
                  value: "$humidity hPa",
                  onTap: () {},
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: CardItem(
                  imagePath: "images/refresh.png",
                  label: "Update",
                  value: info,
                  onTap: update,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.value,
      required this.onTap});

  final String imagePath;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Constants.cardBackground,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: 25, // Adjust width as needed
                height: 25, // Adjust height as needed
                color: Colors.white, // Apply white tint
              ),
              const SizedBox(height: 2),
              TextSection(text: label, size: 12),
              const SizedBox(height: 4),
              TextSection(text: value, size: 12),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
// ignore: must_be_immutable
class MainSection extends StatelessWidget {
   MainSection(
      {super.key,
      required this.mainTemp,
      required this.minTemp,
      required this.maxTemp,
      required this.status});

  final String mainTemp;
  final String minTemp;
  final String maxTemp;
  final String status;

  @override
  Widget build(BuildContext context) {
    ReCase capStatus = ReCase(status);
    return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 48,),
              SizedBox(
                height: 108,
                child: TextSection(
                  text: mainTemp,
                  size: 90,
                ),
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: TextSection(text: "°C", size: 40)),
            ],
          ),
          TextSection(text: capStatus.titleCase, size: 20),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextSection(text: "Min Temp: $minTemp°C", size: 16),
              const SizedBox(width: 16,),
              TextSection(text: "Max Temp: $maxTemp°C", size: 16),
            ],
          )
        ],
      );
  }
}


class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.text, required this.size});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'poppins',
        color: Colors.white,
        fontSize: size,
      ),
    );
  }
}

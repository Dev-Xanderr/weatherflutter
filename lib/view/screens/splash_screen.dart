import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openweather_mvvm/utils/constants.dart';
import 'package:openweather_mvvm/view/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Inicia a animação ao construir o estado
    _startAnimation();
  }

  void _startAnimation() {
    // Primeira animação: Fade in do conteúdo da tela
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Segunda animação: Navega para a tela inicial após um atraso
    Timer(const Duration(seconds: 2), _navigateToHome);
  }

  void _navigateToHome() {
    // Navega para a tela inicial substituindo a splash screen
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Definição da animação de transição (slide + fade)
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(CurveTween(curve: Curves.easeIn));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.skyBlue,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: Container(
          color: Constants.skyBlue,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Ícone de vento com animação de fade in
                Icon(CupertinoIcons.wind, color: Colors.white, size: 100,),
                SizedBox(height: 16,),
                // Texto "Weather App" com estilo específico
                Text("Weather App",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "poppins",
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

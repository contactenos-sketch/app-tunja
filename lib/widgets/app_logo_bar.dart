import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  const AppLogo({Key? key, this.height = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_4.png', // Asegúrate de la ruta y nombre del logo
      height: height,
      fit: BoxFit.contain,
    );
  }
}

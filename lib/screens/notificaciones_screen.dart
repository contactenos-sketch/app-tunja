import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo_2.png', // Cambia aquí el logo especial para notificaciones
          height: 36,
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "No tienes notificaciones por ahora.",
          style: TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ),
    );
  }
}

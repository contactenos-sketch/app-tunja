import 'package:flutter/material.dart';

class SieduScreen extends StatelessWidget {
  const SieduScreen({super.key});

  static const _bg = Color(0xFF1C2427); // fondo app oscuro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('SIEDU'),
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          // Imagen superior
          Image.asset(
            'assets/images/siedu_mesa_de_trabajo_150.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 16),

          // Descripción
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'Sistema Único de Información Educativa Municipal de Tunja – SIEDUTUNJA.\n\n'
              'Es una plataforma como único sistema de información educativa del municipio de Tunja, '
              'para el reporte, consolidación y administración de la información institucional de la '
              'Secretaría de Educación Territorial, así como de la información institucional y académica '
              'de las Instituciones Educativas y Establecimientos Educativos Oficiales de Tunja.',
              style: TextStyle(fontSize: 16, color: Colors.white, height: 1.35),
              textAlign: TextAlign.justify,
            ),
          ),

          const SizedBox(height: 14),

          // Botón / tarjeta de acceso
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.open_in_browser, color: Color(0xFF183137)),
                title: const Text('Ir a SIEDU', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: const Text('siedutunja.gov.co'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detalle_webview',
                    arguments: {
                      'titulo': 'SIEDU',
                      'url': 'https://siedutunja.gov.co/home/',
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

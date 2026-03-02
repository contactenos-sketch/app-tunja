import 'package:flutter/material.dart';

class TurismoScreen extends StatelessWidget {
  const TurismoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> sitios = [
      {
        'nombre': 'Guías de Turismo',
        'url':
            'https://www.tunjaculturayturismo.gov.co/agentesdeturismo/guiasdeturismo/get',
      },
      {
        'nombre': 'Hoteles',
        'url': 'https://www.tunjaculturayturismo.gov.co/hoteles/get',
      },
      {
        'nombre': 'Restaurantes',
        'url':
            'https://www.tunjaculturayturismo.gov.co/agentesdeturismo/restaurantes/get',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1C2427), // fondo general
      appBar: AppBar(
        title: const Text("Turismo"),
        backgroundColor: const Color(0xFF1C2427),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Cabecera con imagen
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/turismo_mesa_de_trabajo_150_.png',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                // degradado para que el texto se lea si pones alguno encima
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha:0.05),
                          Colors.black.withValues(alpha:0.25),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Descripción
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Explora Tunja: encuentra aquí hoteles, restaurantes y guías oficiales "
              "que harán tu experiencia inolvidable.",
              style: TextStyle(
                fontSize: 16,
                height: 1.35,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
          ),

          const SizedBox(height: 18),

          // Enlaces como tarjetas claras sobre fondo oscuro
          ...sitios.map(
            (sitio) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
              child: Card(
                color: Colors.white.withValues(alpha: 0.96),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.link,
                    color: Color(0xFF417A89), // acento institucional
                    size: 28,
                  ),
                  title: Text(
                    sitio['nombre']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF183137),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detalle_webview',
                      arguments: {
                        'titulo': sitio['nombre'],
                        'url': sitio['url'],
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PicoYPlacaScreen extends StatelessWidget {
  const PicoYPlacaScreen({super.key});

  Future<void> _abrirLink(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1C2427);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Pico y Placa'),
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Imagen principal (portada)
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/Pico_y_Placa_App_FOTO_PRINCIPAL_1.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 20),

          /// Imagen informativa interna
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/Pico_y_Placa_App_FOTO_PRINCIPAL_2.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 24),

          /// Texto descriptivo
          const Text(
            'Consulta la información oficial sobre la medida de pico y placa para '
            'vehículos particulares en la ciudad de Tunja.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 28),

          /// Link información general
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(Icons.traffic, color: Color(0xFF183137)),
              title: const Text(
                'Consulte información sobre pico y placa',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Secretaría de Movilidad de Tunja'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => _abrirLink(
                'https://secretariademovilidad-tunja.gov.co',
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// Link excepciones
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF183137)),
              title: const Text(
                'Excepciones de pico y placa',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Consulta excepciones vigentes'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => _abrirLink(
                'http://picoyplaca.tunja.gov.co',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

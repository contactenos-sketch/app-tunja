import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanDeDesarrolloScreen extends StatelessWidget {
  const PlanDeDesarrolloScreen({super.key});

  static const _bg = Color(0xFF1C2427);
  static const _titleColor = Colors.white;
  static const _btnColor = Color(0xFF4AB39B); // verde agua del mock
  static const _url =
      'https://www.tunja-boyaca.gov.co/planes/plan-de-desarrollo-del-municipio-de-tunja-conectemos';

  Future<void> _openExternal(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) throw Exception('No se pudo abrir $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: _titleColor,
        elevation: 0,
        title: const Text('Plan de desarrollo'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
        children: [
          // Botón principal (abre fuera de la app)
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () => _openExternal(_url),
              icon: const Icon(Icons.cloud_download_rounded),
              label: const Text(
                'Descárgalo aquí',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _btnColor,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Imagen ilustrativa
          Image.asset(
            // Cambia el nombre si tu archivo difiere
            'assets/images/plan_de_desarrollo_mesa_de_trabajo_97.png',
            height: 220,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 18),

          // Acceso alterno (tarjeta con abrir en navegador)
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.open_in_browser, color: Color(0xFF183137)),
              title: const Text('Ver en el sitio oficial',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('tunja-boyaca.gov.co'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () => _openExternal(_url),
            ),
          ),
        ],
      ),
    );
  }
}

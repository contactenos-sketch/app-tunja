import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DepartamentoCatastroScreen extends StatelessWidget {
  const DepartamentoCatastroScreen({super.key});

  static const _bg = Color(0xFF1C2427);
  static const _geoportal = 'https://catastro.tunja.gov.co/geoportal/';

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
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Departamento de Catastro'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
        children: [
          // Imagen superior (cámbiala si tu asset tiene otro nombre)
          Image.asset(
            'assets/images/departamento_de_catastro.png',
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 14),

          const Text(
            'Realiza tus trámites catastrales sin salir de casa desde el Geoportal de Catastro Tunja. '
            'Consulta, descarga certificados y accede a información actualizada.',
            style: TextStyle(color: Colors.white, fontSize: 16, height: 1.35),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 16),

          // Botón principal
          SizedBox(
            height: 46,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4AB39B),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                elevation: 0,
                textStyle: const TextStyle(fontWeight: FontWeight.w800),
              ),
              onPressed: () => _openExternal(_geoportal),
              icon: const Icon(Icons.open_in_browser_rounded),
              label: const Text('Abrir Geoportal'),
            ),
          ),

          const SizedBox(height: 18),

          // Acciones rápidas (todas abren el Geoportal)
          _ActionTile(
            icon: Icons.description_rounded,
            title: 'Expedir certificado de estratificación',
            onTap: () => _openExternal(_geoportal),
          ),
          _ActionTile(
            icon: Icons.map_rounded,
            title: 'Certificado de uso del suelo / norma',
            onTap: () => _openExternal(_geoportal),
          ),
          _ActionTile(
            icon: Icons.file_download_rounded,
            title: 'Descarga de certificados catastrales',
            onTap: () => _openExternal(_geoportal),
          ),
          _ActionTile(
            icon: Icons.info_outline_rounded,
            title: 'Consultar información catastral',
            onTap: () => _openExternal(_geoportal),
          ),
          _ActionTile(
            icon: Icons.verified_rounded,
            title: 'Certificado de existencia territorial',
            onTap: () => _openExternal(_geoportal),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF183137)),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF183137),
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: const Icon(Icons.open_in_new_rounded, size: 18),
        onTap: onTap,
      ),
    );
  }
}

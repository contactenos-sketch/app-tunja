import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ParticipacionCiudadanaScreen extends StatelessWidget {
  const ParticipacionCiudadanaScreen({super.key});

  static const Color _bg = Color(0xFF1C2427);
  static const Color _brand = Color(0xFF183137);
  static const Color _accent = Color(0xFF417A89);

  static const String _formUrl = 'https://forms.gle/8QWpgRSe4dER3CrG8';

  Future<void> _abrirExterno(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text('Participación ciudadana'),
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          // Banner (sin recorte)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/images/participacion_ciudadana.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Texto principal (jerarquía)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Participación ciudadana",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Participa en los foros y encuestas disponibles y comparte tu opinión "
              "sobre temas de interés para la ciudad.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.45,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Tu voz contribuye a la construcción de convocatorias, normas, jornadas, "
              "espacios de rendición de cuentas, políticas públicas y escenarios de participación ciudadana.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.45,
              ),
              textAlign: TextAlign.left,
            ),
          ),

          const SizedBox(height: 18),

          // CTA Card (profesional)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: _accent,
                          child: Icon(Icons.article_rounded, color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Proyecto de Resolución – Calendario Tributario 2026",
                            style: TextStyle(
                              color: _brand,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Déjanos tus opiniones, sugerencias y recomendaciones en el formulario oficial.",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _abrirExterno(context, _formUrl),
                        icon: const Icon(Icons.open_in_new_rounded),
                        label: const Text(
                          "Ingresar al enlace",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _brand,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Se abrirá en el navegador (fuera de la app).",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

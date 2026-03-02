import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RendicionDeCuentasScreen extends StatelessWidget {
  const RendicionDeCuentasScreen({super.key});

  // Lista oficial de documentos / links
  final List<Map<String, String>> _documentos = const [
    {
      "titulo": "Estrategia de participación 2025",
      "url":
          "https://www.tunja-boyaca.gov.co/instancias-de-participacion-851568/estrategia-de-participacion-ciudadana-rendicion-de-cuentas"
    },
    {
      "titulo": "Informe de Avance en la Gestión – Corte Octubre",
      "url":
          "https://www.tunja-boyaca.gov.co/rendicion-de-cuentas/informe-de-gestion-corte-31-de-octubre-plan-de-desarrollo"
    },
    {
      "titulo": "Informe de Gestión 2024",
      "url":
          "https://www.tunja-boyaca.gov.co/rendicion-de-cuentas/informe-de-rendicion-de-cuentas-2024"
    },
  ];

  Future<void> _abrirLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("No se pudo abrir el enlace $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2427),
      appBar: AppBar(
        title: const Text("Rendición de cuentas"),
        backgroundColor: const Color(0xFF183137),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // DESCRIPCIÓN
          const Text(
            "En este espacio encuentras el calendario de los espacios de rendición "
            "de cuentas para cada vigencia, conoce nuestra estrategia de participación "
            "y los informes de avance en nuestra gestión. ¡Agéndate y participa!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.4,
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 20),

          // LISTA DE DOCUMENTOS
          for (var doc in _documentos)
            Card(
              color: const Color(0xFFE6F4F1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.description,
                    color: Color(0xFF417A89), size: 36),
                title: Text(
                  doc["titulo"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(Icons.open_in_new, size: 20),
                onTap: () => _abrirLink(doc["url"]!),
              ),
            ),
        ],
      ),
    );
  }
}

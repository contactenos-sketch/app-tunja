import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RutasDeAtencionScreen extends StatelessWidget {
  const RutasDeAtencionScreen({super.key});

  Future<void> _launchTel(String numero) async {
    final uri = Uri(scheme: 'tel', path: numero);
    if (!await launchUrl(uri)) throw 'No se pudo abrir $numero';
  }

  Future<void> _launchMail(String correo) async {
    final uri = Uri(scheme: 'mailto', path: correo);
    if (!await launchUrl(uri)) throw 'No se pudo enviar a $correo';
  }

  Widget _buildCard({
    required String titulo,
    required String detalle,
    String? telefono,
    String? correo,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text(detalle, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              children: [
                if (telefono != null)
                  ElevatedButton.icon(
                    onPressed: () => _launchTel(telefono),
                    icon: const Icon(Icons.phone, size: 18),
                    label: const Text("Llamar"),
                  ),
                const SizedBox(width: 10),
                if (correo != null)
                  ElevatedButton.icon(
                    onPressed: () => _launchMail(correo),
                    icon: const Icon(Icons.email, size: 18),
                    label: const Text("Correo"),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1C2427);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Rutas de Atención"),
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildCard(
            titulo: "Comisaría Primera de Familia",
            detalle:
                "Transversal 15 No. 20-65 Salida vía a Villa de Leyva",
            telefono: "3168190269",
            correo: "comisaria.primera@tunja.gov.co",
          ),
          _buildCard(
            titulo: "Comisaría Segunda de Familia",
            detalle: "Cra 11 No. 6-25 Barrio Libertador",
            telefono: "3182547577",
            correo: "comisaria.segunda@tunja.gov.co",
          ),
          _buildCard(
            titulo: "Comisaría Tercera de Familia",
            detalle: "Cra 2b No. 4a-35 Barrio Cooservicios",
            telefono: "3184654182",
            correo: "comisaria.tercera@tunja.gov.co",
          ),
          _buildCard(
            titulo: "Comisaría Cuarta de Familia",
            detalle: "Cra 6 No. 47-29 Frente a Centro Norte",
            telefono: "3156014896",
            correo: "comisaria.cuarta@tunja.gov.co",
          ),
          _buildCard(
            titulo: "Comisaría Quinta de Familia",
            detalle: "Transversal 2a No. 65-36 Barrio Los Muiscas",
            telefono: "3153682446",
            correo: "comisaria.quinta@tunja.gov.co",
          ),
          _buildCard(
            titulo: "Comisaría Sexta de Familia",
            detalle: "Cra 9 No. 17-96, 2do piso Centro",
            telefono: "3182843260",
            correo: "comisaria.sexta@tunja.gov.co",
          ),

          // LÍNEAS NACIONALES
          _buildCard(
            titulo: "Líneas Nacionales",
            detalle:
                "123: Emergencias\n155: Orientación a mujeres\n122: Fiscalía\n141: Bienestar Familiar",
          ),

          // 40 SEGUNDOS
          _buildCard(
            titulo: "40 Segundos",
            detalle: "En 40 segundos podemos salvar una vida.\nLínea 24h.",
            telefono: "3184653854",
          ),

          // Secretaría de la Mujer
          _buildCard(
            titulo: "Secretaría de la Mujer",
            detalle:
                "Lunes a viernes: 8:00 a.m. - 6:00 p.m.\nCarrera 9 No. 14b-61 Segundo piso",
            telefono: "3153059261",
            correo: "mujergeneroinclusion@tunja.gov.co",
          ),

          // Patrulla Púrpura
          _buildCard(
            titulo: "Patrulla Púrpura",
            detalle:
                "Policía Metropolitana de Tunja\nAtención a violencia de género e intrafamiliar",
            telefono: "3178169927",
          ),

          // Casa de la Mujer Empoderada
          _buildCard(
            titulo: "Casa de la Mujer Empoderada",
            detalle:
                "Lunes a viernes 8:00 a.m. - 12:00 m y 2:00 p.m. - 6:00 p.m.\nCalle 5 # 9-08 Barrio Obrero",
            correo: "equidaddegenero@tunja.gov.co",
          ),
        ],
      ),
    );
  }
}

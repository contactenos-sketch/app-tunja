import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PortalTributarioScreen extends StatelessWidget {
  const PortalTributarioScreen({super.key});

  Future<void> _abrirLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1C2427);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Portal Tributario"),
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Imagen ilustrativa
          Image.asset(
            'assets/images/portal_tributario.png',
            height: 180,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),

          // Texto explicativo
          const Text(
            "Botón Portal Tributario\n\n"
            "Incluye el pago del Impuesto Predial con descuentos del 20%, 10% y 5% respectivamente "
            "iniciando año. Además, también puedes realizar el pago de Industria y Comercio.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.4,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 30),

          // Botón de acceso directo
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4AB39B),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            icon: const Icon(Icons.account_balance_wallet_rounded),
            label: const Text(
              "Ir al Portal Tributario",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onPressed: () => _abrirLink(
              "https://portal-tunja-boyaca-govco.softwaretributario.com/",
            ),
          ),
          const SizedBox(height: 20),

          // Nota aclaratoria
          const Text(
            "Serás redirigido al sitio oficial del Portal Tributario de Tunja.",
            style: TextStyle(color: Colors.white54, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

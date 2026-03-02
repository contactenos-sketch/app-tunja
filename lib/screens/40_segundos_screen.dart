import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// ====== PANTALLA DETALLE WEBVIEW ======
class DetalleWebviewScreen extends StatefulWidget {
  final String titulo;
  final String url;

  const DetalleWebviewScreen({
    super.key,
    required this.titulo,
    required this.url,
  });

  @override
  State<DetalleWebviewScreen> createState() => _DetalleWebviewScreenState();
}

class _DetalleWebviewScreenState extends State<DetalleWebviewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            final uri = Uri.parse(request.url);

            if (uri.scheme == 'http' || uri.scheme == 'https') {
              return NavigationDecision.navigate;
            }

            try {
              final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
              if (!ok && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se pudo abrir: ${uri.scheme}')),
                );
              }
            } catch (_) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No se pudo abrir el enlace externo')),
                );
              }
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: WebViewWidget(controller: _controller),
    );
  }
}

/// ====== PANTALLA PRINCIPAL 40 SEGUNDOS ======
class CuarentaSegundosScreen extends StatelessWidget {
  const CuarentaSegundosScreen({super.key});

  static const String _waUrl =
      'https://api.whatsapp.com/send/?phone=573184653854&text&app_absent=0';

  Future<void> _abrirWhatsApp() async {
    final uri = Uri.parse(_waUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2427),
      appBar: AppBar(
        title: const Text("40 Segundos"),
        backgroundColor: const Color(0xFF1C2427),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen principal
            Image.asset(
              'assets/images/40_segundos_mesa_de_trabajo_55.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 18),

            // Texto principal (como en la foto)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "La línea 40 Segundos te abre un espacio donde tu voz importa, "
                "tu historia vale y tu silencio también habla. Aquí estamos para "
                "orientarte y escucharte.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 22),

            // “Línea de atención” + link + número (como en la foto)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Línea de atención",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: _abrirWhatsApp,
                    child: const Text(
                      _waUrl,
                      style: TextStyle(
                        color: Color(0xFF5BC0EB),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "WhatsApp: 3184653854",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Botón de WhatsApp (abre afuera)
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                  size: 30,
                ),
                title: const Text(
                  "Línea de atención WhatsApp",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: const Text("Abrir conversación"),
                trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                onTap: _abrirWhatsApp,
              ),
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

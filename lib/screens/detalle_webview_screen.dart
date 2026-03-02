import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetalleWebViewScreen extends StatelessWidget {
  final String? titulo;
  final String? url;

  const DetalleWebViewScreen({Key? key, this.titulo, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Recupera los argumentos si vienen por ruta
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final _titulo = args != null && args['titulo'] != null
        ? args['titulo'] as String
        : (titulo ?? '');
    final _url = args != null && args['url'] != null
        ? args['url'] as String
        : (url ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo, style: const TextStyle(fontSize: 16)),
      ),
      body: _url.isNotEmpty
          ? WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse(_url)),
            )
          : const Center(child: Text('No hay URL para mostrar')),
    );
  }
}

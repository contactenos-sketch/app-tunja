import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoticiasScreen extends StatefulWidget {
  final void Function(String titulo, String url) agregarAFavoritos;
  const NoticiasScreen({Key? key, required this.agregarAFavoritos}) : super(key: key);

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  late final WebViewController _controller;
  String _currentUrl = 'https://www.tunja-boyaca.gov.co/tema/noticias';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            String? newUrl = await _controller.currentUrl();
            setState(() {
              _currentUrl = newUrl ?? _currentUrl;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(_currentUrl));
  }

  void _onAddFavorite() async {
    String? url = await _controller.currentUrl();
    url ??= _currentUrl;

    // Pide al usuario el título personalizado
    String? titulo = await showDialog<String>(
      context: context,
      builder: (context) {
        String tempTitulo = '';
        return AlertDialog(
          title: const Text('Guardar en favoritos'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Título de la noticia'),
            onChanged: (value) => tempTitulo = value,
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context, null),
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () => Navigator.pop(context, tempTitulo.trim()),
            ),
          ],
        );
      },
    );

    if (titulo != null && titulo.isNotEmpty) {
      widget.agregarAFavoritos(titulo, url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Agregado a favoritos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: _onAddFavorite,
            tooltip: 'Agregar a favoritos',
          )
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

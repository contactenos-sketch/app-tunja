import 'package:flutter/material.dart';
import 'package:somos_tunja_app/models/favorito.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Favorito> favoritos;
  final void Function(Favorito) quitarDeFavoritos;

  const FavoritosScreen({
    Key? key,
    required this.favoritos,
    required this.quitarDeFavoritos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoritos.isEmpty) {
      return Center(child: Text('¡Aún no tienes favoritos!', style: TextStyle(color: Colors.white)));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: favoritos.length,
      itemBuilder: (ctx, i) {
        final f = favoritos[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: (f.imagenAsset != null && f.imagenAsset!.isNotEmpty)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(f.imagenAsset!, width: 64, height: 64, fit: BoxFit.cover),
                  )
                : Icon(Icons.article_outlined, size: 48, color: Colors.blueGrey),
            title: Text(f.titulo, style: TextStyle(fontWeight: FontWeight.bold)),
            // Si tiene ruta, NO mostramos url, solo el nombre; si es noticia, tampoco mostramos url aquí (así como lo quieres)
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => quitarDeFavoritos(f),
            ),
            onTap: () {
              if (f.ruta != null && f.ruta!.startsWith('/')) {
                Navigator.pushNamed(context, f.ruta!);
              } else if (f.url.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  '/detalle_webview',
                  arguments: {'titulo': f.titulo, 'url': f.url},
                );
              }
            },
          ),
        );
      },
    );
  }
}

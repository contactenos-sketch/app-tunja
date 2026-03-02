class Favorito {
  final String titulo;
  final String url;        // Solo para noticias
  final String? ruta;      // Solo para módulos internos
  final String? imagenAsset;
  Favorito(this.titulo, this.url, {this.ruta, this.imagenAsset});
}

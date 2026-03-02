import 'package:flutter/material.dart';
import 'package:somos_tunja_app/screens/busqueda_screen.dart';
import 'package:somos_tunja_app/screens/noticias_screens.dart';
import 'package:somos_tunja_app/screens/mi_cuenta_screen.dart';
import 'package:somos_tunja_app/screens/favoritos_screen.dart';
import 'package:somos_tunja_app/models/favorito.dart';

// COLORES PRINCIPALES
const kColorFondo = Color.fromARGB(255, 28, 36, 39); // Fondo app
const kColorPrincipal = Color.fromARGB(255, 0, 111, 202); // Botones, barra

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Favorito> _favoritos = [];

  // FUNCIONES FAVORITOS: para módulos
  void _agregarAFavoritos(_OpcionHome opcion) {
    if (!_favoritos.any((f) => f.ruta == opcion.ruta)) {
      setState(() {
        _favoritos.add(Favorito(
          opcion.titulo,
          '', // url vacío, no es noticia
          ruta: opcion.ruta,
          imagenAsset: opcion.assetPath,
        ));
      });
    }
  }

  // FAVORITOS: para noticias (solo nombre/url)
  void _agregarNoticiaAFavoritos(String titulo, String url) {
    if (!_favoritos.any((f) => f.url == url)) {
      setState(() {
        _favoritos.add(Favorito(
          titulo,
          url,
          ruta: null,
          imagenAsset: null,
        ));
      });
    }
  }

  void _quitarDeFavoritos(Favorito fav) {
    setState(() {
      _favoritos.remove(fav);
    });
  }

  static const List<String> _titles = [
    'Inicio',
    'Favoritos',
    'Buscar',
    'Noticias',
    'Mi Cuenta',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      _HomeGrid(agregarAFavoritos: _agregarAFavoritos),
      FavoritosScreen(
        favoritos: _favoritos,
        quitarDeFavoritos: _quitarDeFavoritos,
      ),
      const BusquedaScreen(),
      NoticiasScreen(agregarAFavoritos: _agregarNoticiaAFavoritos),
      const MiCuentaScreen(),
    ];

    return Scaffold(
      backgroundColor: kColorFondo,
      appBar: AppBar(
        backgroundColor: kColorFondo,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_4.png',
              height: 34,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              _titles[_selectedIndex],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/notificaciones');
              },
            )
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kColorFondo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Noticias'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mi Cuenta'),
        ],
      ),
    );
  }
}

// ---- HOME GRID (con estrellita para favoritos) ----

class _HomeGrid extends StatelessWidget {
  final void Function(_OpcionHome) agregarAFavoritos;
  const _HomeGrid({required this.agregarAFavoritos});

  @override
  Widget build(BuildContext context) {
final List<_OpcionHome> opciones = [
  _OpcionHome("40 Segundos",             'assets/images/40_segundos.png',              '/40-segundos'),
  _OpcionHome("Activa-T",                'assets/images/activa_t.png',                 '/activa-t'),
  _OpcionHome("Alertas",                 'assets/images/alarmas.png',                  '/alertas'),
  _OpcionHome("Bienestar Animal",        'assets/images/bienestar_animal.png',         '/bienestar-animal'),
  _OpcionHome("Departamento de Catastro",'assets/images/departamento_de_catastro.png',    '/departamento-catastro'),
  _OpcionHome("Participación Ciudadana", 'assets/images/participacion_ciudadana.png',  '/participacion-ciudadana'),
  _OpcionHome("Pico y Placa",            'assets/images/Pico_y_Placa_App_FOTO_PRINCIPAL_1.png',             '/pico_y_placa'),
  _OpcionHome("Plan de Desarrollo",      'assets/images/plan_de_desarrollo.png',       '/plan-de-desarrollo'),
  _OpcionHome("Portal Tributario",       'assets/images/portal_tributario.png',        '/portal-tributario'),
  _OpcionHome("PQRS",                    'assets/images/pqrs.png',                     '/pqrs'),
  _OpcionHome("Rendición de Cuentas",    'assets/images/rendicion_de_cuentas.png',     '/rendicion-de-cuentas'),
  _OpcionHome("Rutas de Atención",       'assets/images/rutas_de_atencion.png',        '/rutas-de-atencion'),
  _OpcionHome("Seguridad",               'assets/images/seguridad.png',                '/seguridad'),
  _OpcionHome("SIEDU",                   'assets/images/siedu.png',                    '/siedu'),
  _OpcionHome("Turismo",                 'assets/images/turismo.png',                  '/turismo'),
];

    return Container(
      color: kColorFondo,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: opciones.map((opcion) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, opcion.ruta);
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        opcion.assetPath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                // Estrellita para agregar a favoritos
                Positioned(
                  top: 12,
                  right: 12,
                  child: IconButton(
                    icon: const Icon(Icons.star_border, color: Colors.white, size: 30),
                    onPressed: () {
                      agregarAFavoritos(opcion);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${opcion.titulo} agregado a favoritos')),
                      );
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _OpcionHome {
  final String titulo;
  final String assetPath;
  final String ruta;
  _OpcionHome(this.titulo, this.assetPath, this.ruta);
}

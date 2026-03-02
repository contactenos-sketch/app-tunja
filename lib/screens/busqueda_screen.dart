import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Tipos de elemento que el buscador puede resolver.
enum SearchType { route, url, phone, email, other }

/// Modelo de ítem indexable en la búsqueda.
class SearchItem {
  final String title;          // Lo que ves en la lista
  final String description;    // Subtítulo / ayuda
  final String? assetPath;     // Icono/imagen opcional (en assets)
  final SearchType type;       // route | url | phone | email | other
  final String target;         // ruta '/...' | 'https://...' | '350...' | 'correo@...'
  final List<String> tags;     // sinónimos / palabras clave
  final IconData? icon;        // icono para la lista (si no hay asset)

  const SearchItem({
    required this.title,
    required this.description,
    required this.type,
    required this.target,
    this.assetPath,
    this.tags = const [],
    this.icon,
  });
}

/// =================== ÍNDICE DE BÚSQUEDA ===================
/// Agrega aquí TODO lo que quieras que aparezca en resultados.
/// Puedes mezclar rutas internas, teléfonos, correos y URLs externas.
/// Tip: agrega sinónimos en [tags] para mejorar recall.
final List<SearchItem> SEARCH_INDEX = <SearchItem>[
  // --------- Pantallas / Rutas internas ----------
  SearchItem(
    title: 'Pico y Placa',
    description: 'Consulta de restricción vehicular: particular y público.',
    type: SearchType.route,
    target: '/pico_y_placa',
    assetPath: 'assets/images/pico_y_placa_mesa_de_trabajo_94.png',
    tags: ['movilidad', 'placa', 'tránsito', 'vehículos', 'tunja'],
    icon: Icons.directions_car_rounded,
  ),
  SearchItem(
    title: 'Turismo',
    description: 'Hoteles, restaurantes y guías oficiales.',
    type: SearchType.route,
    target: '/turismo',
    assetPath: 'assets/images/1_turismo_categorias(11)(1).png',
    tags: ['viajes', 'hospedaje', 'comida', 'cultura'],
    icon: Icons.map_rounded,
  ),
  SearchItem(
    title: 'Plan de Desarrollo',
    description: 'Documento y detalles del plan municipal.',
    type: SearchType.route,
    target: '/plan_de_desarrollo',
    assetPath: 'assets/images/plan_de_desarrollo_mesa_de_trabajo_76.png',
    tags: ['plan', 'desarrollo', 'gobierno', 'documento'],
    icon: Icons.description_rounded,
  ),
  SearchItem(
    title: 'Seguridad — Cuadrantes',
    description: 'Directorio por cuadrantes, llamar o copiar teléfono.',
    type: SearchType.route,
    target: '/seguridad',
    assetPath: 'assets/images/Seguridad_PNG_Normal.png',
    tags: ['policía', 'cuadrantes', 'seguridad', 'emergencias'],
    icon: Icons.shield_moon_rounded,
  ),
  SearchItem(
    title: 'PQR',
    description: 'Peticiones, quejas y reclamos — versión demo local.',
    type: SearchType.route,
    target: '/pqr',
    assetPath: 'assets/images/pqr_mesa_de_trabajo_91.png',
    tags: ['peticiones', 'quejas', 'reclamos', 'contacto', 'servicio'],
    icon: Icons.feedback_rounded,
  ),
  SearchItem(
    title: 'SIEDU',
    description: 'Sistema de información (datos/educación/ud.).',
    type: SearchType.route,
    target: '/siedu',
    assetPath: 'assets/images/siedu_mesa_de_trabajo_92.png',
    tags: ['datos', 'educación', 'información'],
    icon: Icons.school_rounded,
  ),
  SearchItem(
    title: 'Actívate Tunja',
    description: 'Canales y redes de la estrategia Actívate.',
    type: SearchType.route,
    target: '/activa_t',
    assetPath: 'assets/images/activa-t_mesa_de_trabajo_70.png',
    tags: ['actívate', 'deporte', 'salud', 'bienestar', 'redes'],
    icon: Icons.bolt_rounded,
  ),
  SearchItem(
    title: '40 Segundos',
    description: 'Estrategia Secretaría de Medio Ambiente.',
    type: SearchType.route,
    target: '/40_segundos',
    assetPath: 'assets/images/40_segundosMesa_de_trabajo_55.png',
    tags: ['salud mental', 'prevención', 'ayuda', 'whatsapp'],
    icon: Icons.timer_rounded,
  ),
  SearchItem(
    title: 'Bienestar Animal',
    description: 'Adopciones, esterilizaciones y protección animal.',
    type: SearchType.route,
    target: '/bienestar_animal',
    assetPath: 'assets/images/bienestar_animal_mesa_de_trabajo_72.png',
    tags: ['mascotas', 'perros', 'gatos', 'esterilización', 'adopción'],
    icon: Icons.pets_rounded,
  ),
  SearchItem(
    title: 'Portal Tributario',
    description: 'Impuesto Predial, ICA y descuentos.',
    type: SearchType.route,
    target: '/portal_tributario',
    assetPath: 'assets/images/portal_tributario_mesa_de_trabajo_71.png',
    tags: ['impuestos', 'predial', 'ica', 'tributario'],
    icon: Icons.account_balance_wallet_rounded,
  ),
  SearchItem(
    title: 'Catastro — Geoportal',
    description: 'Mapa y servicios catastrales.',
    type: SearchType.route,
    target: '/catastro_geoportal',
    assetPath: 'assets/images/catastro_geoportal_mesa_de_trabajo_90.png',
    tags: ['mapa', 'catastro', 'geoportal'],
    icon: Icons.public_rounded,
  ),

  // --------- Enlaces externos (URLs) ----------
  SearchItem(
    title: 'Canal WhatsApp — 40 Segundos',
    description: 'Atención y orientación (abre fuera de la app).',
    type: SearchType.url,
    target: 'https://wa.me/c/573184653854',
    tags: ['whatsapp', 'medio ambiente', 'ayuda', 'chat'],
    icon: Icons.open_in_new_rounded,
  ),
  SearchItem(
    title: 'Plan de Desarrollo — Sitio Oficial',
    description: 'Conéctate al documento oficial en la web.',
    type: SearchType.url,
    target: 'https://www.tunja-boyaca.gov.co/planes/plan-de-desarrollo-del-municipio-de-tunja-conectemos',
    tags: ['plan', 'oficial', 'documento'],
    icon: Icons.link_rounded,
  ),
  SearchItem(
    title: 'Portal Tributario — Pagos',
    description: 'Predial / Industria y Comercio (web externa).',
    type: SearchType.url,
    target: 'https://portal-tunja-boyaca-govco.softwaretributario.com/',
    tags: ['pago', 'predial', 'ica', 'tributario', 'impuestos'],
    icon: Icons.link_rounded,
  ),
  SearchItem(
    title: 'Catastro — Geoportal Web',
    description: 'Visita el geoportal oficial del municipio.',
    type: SearchType.url,
    target: 'https://catastro.tunja.gov.co/geoportal/',
    tags: ['catastro', 'mapa', 'geoportal'],
    icon: Icons.link_rounded,
  ),

  // --------- Teléfonos (Seguridad / Cuadrantes y líneas) ----------
  SearchItem(
    title: 'CTE C-01 (Seguridad)',
    description: 'Ciudad Jardín, Pinos de Oriente, La Cabaña, etc.',
    type: SearchType.phone,
    target: '3507291864',
    tags: ['seguridad', 'cuadrante', 'policía', 'c-01'],
    icon: Icons.phone_in_talk_rounded,
  ),
  SearchItem(
    title: 'Emergencias 123',
    description: 'Línea única nacional de emergencias.',
    type: SearchType.phone,
    target: '123',
    tags: ['emergencias', 'policía', 'ambulancia'],
    icon: Icons.phone_rounded,
  ),

  // --------- Correo (ejemplo) ----------
  SearchItem(
    title: 'Comisaría Primera — Correo',
    description: 'comisaria.primera@tunja.gov.co',
    type: SearchType.email,
    target: 'comisaria.primera@tunja.gov.co',
    tags: ['comisaría', 'familia', 'atención', 'correo'],
    icon: Icons.email_rounded,
  ),

  // --------- Otros (Noticias / texto libre) ----------
  SearchItem(
    title: 'Noticia — Pico y Placa hoy',
    description: 'Actualización diaria sobre restricción vehicular (demo).',
    type: SearchType.other,
    target: 'noticia:pico_y_placa_hoy',
    tags: ['noticias', 'movilidad', 'hoy', 'placa'],
    icon: Icons.article_rounded,
  ),
];

/// Normaliza texto para hacer la búsqueda robusta (sin acentos, sin mayúsculas).
String _norm(String s) {
  final lower = s.toLowerCase();
  // Quita diacríticos básicos (rápido y suficiente para ES)
  const withDiacritics = 'áàäâãéèëêíìïîóòöôõúùüûñ';
  const without        = 'aaaaaeeeeiiiiooooouuuun';
  var out = lower;
  for (var i = 0; i < withDiacritics.length; i++) {
    out = out.replaceAll(withDiacritics[i], without[i]);
  }
  return out;
}

/// Coincide si q aparece en title/description/tags/target.
bool _matches(SearchItem item, String q) {
  if (q.isEmpty) return true;
  final nq = _norm(q);
  if (_norm(item.title).contains(nq)) return true;
  if (_norm(item.description).contains(nq)) return true;
  if (_norm(item.target).contains(nq)) return true;
  for (final t in item.tags) {
    if (_norm(t).contains(nq)) return true;
  }
  return false;
}

/// Ejecuta la acción correspondiente al tipo.
Future<void> _launchItem(BuildContext context, SearchItem it) async {
  switch (it.type) {
    case SearchType.route:
      Navigator.pushNamed(context, it.target);
      return;
    case SearchType.url:
      final uri = Uri.parse(it.target);
      // Abrir SIEMPRE FUERA de la app
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    case SearchType.phone:
      final uri = Uri(scheme: 'tel', path: it.target);
      await launchUrl(uri);
      return;
    case SearchType.email:
      final uri = Uri(scheme: 'mailto', path: it.target);
      await launchUrl(uri);
      return;
    case SearchType.other:
      // Si luego quieres manejar "otros" con lógica específica, hazlo aquí.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Elemento informativo (demo).')),
      );
      return;
  }
}

/// =================== PANTALLA ===================
class BusquedaScreen extends StatefulWidget {
  const BusquedaScreen({super.key});

  @override
  State<BusquedaScreen> createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreen> {
  String _query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<SearchItem> get _resultados {
    final base = SEARCH_INDEX.where((e) => _matches(e, _query)).toList();

    // Opcional: ordenar resultados por "score" simple (título primero, luego tags)
    base.sort((a, b) {
      final qa = _norm(_query);
      int score(SearchItem it) {
        int s = 0;
        if (_norm(it.title).contains(qa)) s += 3;
        if (_norm(it.description).contains(qa)) s += 2;
        if (it.tags.any((t) => _norm(t).contains(qa))) s += 1;
        return -s; // menor = primero (sort asc)
      }
      return score(a).compareTo(score(b));
    });
    return base;
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1C2427);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Buscar'),
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _controller,
              onChanged: (val) => setState(() => _query = val),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Busca: pico y placa, turismo, portal tributario, 123…',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF2A3438),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: (_query.isEmpty)
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () => setState(() {
                          _controller.clear();
                          _query = '';
                        }),
                      ),
              ),
            ),
          ),
          Expanded(
            child: _resultados.isEmpty
                ? const _EmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                    itemCount: _resultados.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (ctx, i) {
                      final it = _resultados[i];
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: _LeadingIconOrAsset(item: it),
                          title: Text(it.title,
                              style: const TextStyle(
                                  color: Color(0xFF183137),
                                  fontWeight: FontWeight.w700)),
                          subtitle: Text(it.description,
                              style: const TextStyle(color: Colors.black87)),
                          trailing: Icon(
                            _trailingIcon(it.type),
                            color: const Color(0xFF417A89),
                          ),
                          onTap: () => _launchItem(context, it),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  IconData _trailingIcon(SearchType t) {
    switch (t) {
      case SearchType.route:
        return Icons.arrow_forward_ios_rounded;
      case SearchType.url:
        return Icons.open_in_new_rounded;
      case SearchType.phone:
        return Icons.phone_rounded;
      case SearchType.email:
        return Icons.email_rounded;
      case SearchType.other:
        return Icons.info_outline_rounded;
    }
  }
}

class _LeadingIconOrAsset extends StatelessWidget {
  final SearchItem item;
  const _LeadingIconOrAsset({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.assetPath != null && item.assetPath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          item.assetPath!,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(item.icon ?? Icons.search, color: const Color(0xFF417A89)),
        ),
      );
    }
    return Icon(item.icon ?? Icons.search, color: const Color(0xFF417A89), size: 28);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.search_off_rounded, color: Colors.white54, size: 48),
            SizedBox(height: 10),
            Text('Sin resultados',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            SizedBox(height: 6),
            Text('Prueba con otras palabras o sin acentos.',
                style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertasScreen extends StatefulWidget {
  const AlertasScreen({super.key});

  @override
  State<AlertasScreen> createState() => _AlertasScreenState();
}

enum AlertaTipo { simulacro, festivo, evento, transito, salud, educacion }

class Alerta {
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final AlertaTipo tipo;
  final String? link;

  const Alerta({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.tipo,
    this.link,
  });
}

class _AlertasScreenState extends State<AlertasScreen> {
  static const kBg = Color(0xFF1C2427);
  static const kCard = Colors.white;

  final TextEditingController _searchCtrl = TextEditingController();
  final Set<AlertaTipo> _filtros = {};

  // DEMO de alertas
// ✅ Bien: lista normal sin const
final List<Alerta> _todas = [
  Alerta(
    titulo: 'Simulacro Municipal de Evacuación',
    descripcion: 'Ejercicio de gestión del riesgo. Puntos de encuentro en parques principales.',
    fecha: _Fake.nowPlus(days: 3),
    tipo: AlertaTipo.simulacro,
    link: 'https://www.tunja-boyaca.gov.co/',
  ),
  Alerta(
    titulo: 'Festivo: Día de la Independencia',
    descripcion: 'No hay atención al público en dependencias administrativas.',
    fecha: _Fake.fixed(month: 7, day: 20),
    tipo: AlertaTipo.festivo,
  ),
  Alerta(
    titulo: 'Cierre vial en el Centro Histórico',
    descripcion: 'Trabajos nocturnos entre 9:00 p.m. y 4:00 a.m.',
    fecha: _Fake.nowPlus(days: 1),
    tipo: AlertaTipo.transito,
  ),
  Alerta(
    titulo: 'Jornada de Vacunación contra la Influenza',
    descripcion: 'Puestos móviles en IPS y plazas de mercado. Llevar carné.',
    fecha: _Fake.nowPlus(days: 5),
    tipo: AlertaTipo.salud,
    link: 'https://www.minsalud.gov.co/',
  ),
  Alerta(
    titulo: 'Semana de Receso Escolar',
    descripcion: 'Actividades culturales y deportivas para estudiantes.',
    fecha: _Fake.nowPlus(days: 10),
    tipo: AlertaTipo.educacion,
  ),
  Alerta(
    titulo: 'Halloween en Familia',
    descripcion: 'Evento seguro en parques con actividades para niños.',
    fecha: _Fake.fixed(month: 10, day: 31),
    tipo: AlertaTipo.evento,
  ),
];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchCtrl.text.trim().toLowerCase();

    final visibles = _todas.where((a) {
      final okTexto = query.isEmpty ||
          a.titulo.toLowerCase().contains(query) ||
          a.descripcion.toLowerCase().contains(query);
      final okTipo = _filtros.isEmpty || _filtros.contains(a.tipo);
      return okTexto && okTipo;
    }).toList()
      ..sort((a, b) => a.fecha.compareTo(b.fecha));

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kBg,
        foregroundColor: Colors.white,
        title: const Text('Alertas DEMO'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Image.asset(
            'assets/images/alarmas.png',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Sección de alertas y avisos municipales.\n'
              'Datos ficticios para DEMO sin conexión a base de datos.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Buscar: simulacro, festivo, cierre vial…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: kCard,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _FiltrosTipos(
            activos: _filtros,
            onChanged: (tipo) {
              setState(() {
                _filtros.contains(tipo) ? _filtros.remove(tipo) : _filtros.add(tipo);
              });
            },
          ),
          ...visibles.map((a) => _AlertaCard(
                alerta: a,
                onOpenLink: a.link == null ? null : () => _open(a.link!),
              )),
          if (visibles.isEmpty)
            const Padding(
              padding: EdgeInsets.all(26),
              child: Center(
                child: Text(
                  'No hay resultados con los filtros actuales.',
                  style: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _AlertaCard extends StatelessWidget {
  final Alerta alerta;
  final VoidCallback? onOpenLink;

  const _AlertaCard({required this.alerta, this.onOpenLink});

  @override
  Widget build(BuildContext context) {
    final fecha = '${_two(alerta.fecha.day)}/${_two(alerta.fecha.month)}/${alerta.fecha.year}';
    final color = _colorPorTipo(alerta.tipo);
    final icono = _iconoPorTipo(alerta.tipo);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withAlpha(40),
            foregroundColor: color,
            child: Icon(icono),
          ),
          title: Text(alerta.titulo, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text('${alerta.descripcion}\nFecha: $fecha'),
          isThreeLine: true,
          trailing: onOpenLink != null
              ? IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: onOpenLink,
                )
              : null,
        ),
      ),
    );
  }

  static Color _colorPorTipo(AlertaTipo t) {
    switch (t) {
      case AlertaTipo.simulacro: return const Color(0xFFEF6C00);
      case AlertaTipo.festivo: return const Color(0xFF2E7D32);
      case AlertaTipo.evento: return const Color(0xFF1565C0);
      case AlertaTipo.transito: return const Color(0xFF8E24AA);
      case AlertaTipo.salud: return const Color(0xFFD81B60);
      case AlertaTipo.educacion: return const Color(0xFF6D4C41);
    }
  }

  static IconData _iconoPorTipo(AlertaTipo t) {
    switch (t) {
      case AlertaTipo.simulacro: return Icons.warning_amber;
      case AlertaTipo.festivo: return Icons.celebration;
      case AlertaTipo.evento: return Icons.event_available;
      case AlertaTipo.transito: return Icons.traffic;
      case AlertaTipo.salud: return Icons.health_and_safety;
      case AlertaTipo.educacion: return Icons.school;
    }
  }
}

class _FiltrosTipos extends StatelessWidget {
  final Set<AlertaTipo> activos;
  final void Function(AlertaTipo) onChanged;

  const _FiltrosTipos({required this.activos, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Wrap(
        spacing: 8,
        children: AlertaTipo.values.map((t) {
          final seleccionado = activos.contains(t);
          return FilterChip(
            label: Text(_label(t)),
            selected: seleccionado,
            onSelected: (_) => onChanged(t),
          );
        }).toList(),
      ),
    );
  }

  String _label(AlertaTipo t) {
    switch (t) {
      case AlertaTipo.simulacro: return 'Simulacro';
      case AlertaTipo.festivo: return 'Festivo';
      case AlertaTipo.evento: return 'Evento';
      case AlertaTipo.transito: return 'Tránsito';
      case AlertaTipo.salud: return 'Salud';
      case AlertaTipo.educacion: return 'Educación';
    }
  }
}

class _Fake {
  static DateTime nowPlus({int days = 0}) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day + days);
  }

  static DateTime fixed({required int month, required int day}) {
    final n = DateTime.now();
    return DateTime(n.year, month, day);
  }
}

String _two(int n) => n < 10 ? '0$n' : '$n';

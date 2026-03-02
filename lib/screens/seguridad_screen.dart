import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SeguridadScreen extends StatefulWidget {
  const SeguridadScreen({super.key});

  @override
  State<SeguridadScreen> createState() => _SeguridadScreenState();
}

class _SeguridadScreenState extends State<SeguridadScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _zonaSeleccionada = 'Todas'; // Todas | Zona 1 | Zona 2 | Zona 3
  late List<_Quadrante> _data;
  late List<_Quadrante> _filtered;

  @override
  void initState() {
    super.initState();
    _data = _quadrantes;
    _filtered = List.from(_data);
    _searchCtrl.addListener(_aplicarFiltros);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _aplicarFiltros() {
    final q = _searchCtrl.text.toLowerCase().trim();
    setState(() {
      _filtered = _data.where((e) {
        // Filtro por zona (organizativo por rangos de CTE)
        final enZona = _zonaSeleccionada == 'Todas' || e.zona == _zonaSeleccionada;

        // Filtro por texto
        final hayCte = e.cte.toLowerCase().contains(q);
        final hayTel = e.telefono.contains(q);
        final hayBarrio = e.barrios.toLowerCase().contains(q);

        return enZona && (q.isEmpty || hayCte || hayTel || hayBarrio);
      }).toList();
    });
  }

  Future<void> _llamar(String numero) async {
    final uri = Uri(scheme: 'tel', path: numero);
    final ok = await launchUrl(uri);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo llamar al $numero')),
      );
    }
  }

  Future<void> _copiar(String numero) async {
    await Clipboard.setData(ClipboardData(text: numero));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teléfono copiado al portapapeles')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1C2427);
    const chipBg = Color(0xFF2A3438);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Seguridad — Cuadrantes'),
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // CABECERA (imagen)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/seguridad_mesa_de_trabajo.png',
                height: 160,
                width: double.infinity,
                fit: BoxFit.contain, // si prefieres llenar horizontal: BoxFit.cover
              ),
            ),
          ),

          // BUSCADOR
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
            child: TextField(
              controller: _searchCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar por CTE, teléfono o barrio…',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: chipBg,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // FILTRO POR ZONA (chips)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            child: Wrap(
              spacing: 8,
              children: [
                for (final z in const ['Todas', 'Zona 1', 'Zona 2', 'Zona 3'])
                  ChoiceChip(
                    label: Text(z),
                    selected: _zonaSeleccionada == z,
                    onSelected: (_) {
                      setState(() => _zonaSeleccionada = z);
                      _aplicarFiltros();
                    },
                    selectedColor: const Color(0xFF4AB39B),
                    backgroundColor: chipBg,
                    labelStyle: TextStyle(
                      color: _zonaSeleccionada == z ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),

          // LISTA
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) => _QuadranteCard(
                data: _filtered[i],
                onCall: _llamar,
                onCopy: _copiar,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuadranteCard extends StatelessWidget {
  final _Quadrante data;
  final Future<void> Function(String) onCall;
  final Future<void> Function(String) onCopy;
  const _QuadranteCard({required this.data, required this.onCall, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF417A89),
                  child: Text(
                    data.cte.split('-').last,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'CTE ${data.cte}',
                    style: const TextStyle(
                      color: Color(0xFF183137),
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    data.zona,
                    style: const TextStyle(color: Color(0xFF0E7A87), fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),
            Text('Teléfono: ${data.telefono}', style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 6),
            Text(
              data.barrios,
              style: const TextStyle(color: Color(0xFF183137)),
            ),

            const SizedBox(height: 10),

            // Botones separados
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => onCall(data.telefono),
                    icon: const Icon(Icons.phone_in_talk_rounded),
                    label: const Text('LLAMAR'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0C8D57),
                      side: const BorderSide(color: Color(0xFF0C8D57)),
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => onCopy(data.telefono),
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('COPIAR'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF183137),
                      side: const BorderSide(color: Color(0xFF183137)),
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Quadrante {
  final String cte;
  final String telefono;
  final String barrios;
  final String zona; // Zona 1: C-01–C-10 | Zona 2: C-11–C-20 | Zona 3: C-21–C-30
  const _Quadrante(this.cte, this.telefono, this.barrios, this.zona);
}

/// ================== DATOS (30 cuadrantes) ==================
/// Nota: La segmentación por "Zona" aquí es organizativa por rangos de CTE.
///       Si luego te entregan zonas oficiales, solo cambia el cuarto campo.
const List<_Quadrante> _quadrantes = [
  // Zona 1: C-01 a C-10
  _Quadrante('C-01','3507291864','Ciudad Jardín, Pinos de Oriente, Sector La Cabaña, Sector Villa del Rosario, Parque Industrial.','Zona 1'),
  _Quadrante('C-02','3507291863','San Francisco, Urb. La Granja Sur, Vereda Runta.','Zona 1'),
  _Quadrante('C-03','3507291862','San Carlos, Urbanización La Perla, Urbanización La Perla.','Zona 1'),
  _Quadrante('C-04','3507291856','La Florida, Urbanización La Florida, Multifamiliar La Florida, Sagrado Corazón, Antonia Santos, Ciudadela Sol de Oriente, Tunjuelito.','Zona 1'),
  _Quadrante('C-05','3507291855','Bochica, Cooservicios, Altos de Cooservicios, Portal de Otoño, Urbanización Sol de Oriente, Villa Bachué, San Antonio, Las Peñitas, Xativilla, Patriotas.','Zona 1'),
  _Quadrante('C-06','3507291858','Doña Eva, Nazareth, Tunjuelito, Santiago de Tunja, Jordán, Hunza, Castillos de Oriente.','Zona 1'),
  _Quadrante('C-07','3507291861','Prados de San Luis, El Curubal, Patriotas, Manzanares, El Rodeo.','Zona 1'),
  _Quadrante('C-08','3507291844','Triunfo, Trinidad, Bolívar, Surinama, Siberia.','Zona 1'),
  _Quadrante('C-09','3507291841','Libertador, Urbanización Balcón de la Villa, Urbanización Balcón Villa María.','Zona 1'),
  _Quadrante('C-10','3507291831','Obrero, Suárez Rendón, Aquimín.','Zona 1'),

  // Zona 2: C-11 a C-20
  _Quadrante('C-11','3507291837','El Bosque, Nueva Santa Bárbara, Santa Bárbara, El Consuelo, Banderas, San Laureano.','Zona 2'),
  _Quadrante('C-12','3507291828','Mirador Escandinavo, Paraíso, Ricaurte, Colinas de San Fernando, Cortijo, Centenario, Urazandy, Las Américas, Los Andes.','Zona 2'),
  _Quadrante('C-13','3507291822','Concepción, Milagro, Kennedy, Topo.','Zona 2'),
  _Quadrante('C-14','3507291823','Topo, Centro, Santa Bárbara, Popular.','Zona 2'),
  _Quadrante('C-15','3507291829','Centro, Santa Bárbara, Lidueña.','Zona 2'),
  _Quadrante('C-16','3507291830','Centro San Ignacio, Parque Pinzón, Ludueña.','Zona 2'),
  _Quadrante('C-17','3507291857','La Esmeralda, Mirador del Norte, Rincón de la Pradera, Casa del Gobernador, Lombardía, Orquídea Real, El Dorado, Monseñor Baracaldo.','Zona 2'),
  _Quadrante('C-18','3507291827','Belalcázar, Maldonado, San Juan, Villa Cecilia, Las Nieves, Villa Olímpica, Conjunto Militar, Los Lanceros, Remonta, La Glorieta Norte.','Zona 2'),
  _Quadrante('C-19','3507291834','Santa Lucía, Popular, 20 de Julio.','Zona 2'),
  _Quadrante('C-20','3507291853','Bello Horizonte, La Esperanza, El Carmen, Torres del Parque.','Zona 2'),

  // Zona 3: C-21 a C-30
  _Quadrante('C-21','3507291854','San Lázaro, Cojines, Altamira.','Zona 3'),
  _Quadrante('C-22','3167588935','La Calleja, Altos de La María, La Fuente de la I a la IV Etapa, Trigales, San Diego.','Zona 3'),
  _Quadrante('C-23','3154843980','Jorge Eliécer Gaitán, Veinte de Julio, Parque La Biblioteca.','Zona 3'),
  _Quadrante('C-24','3167528428','Altos de San Diego, José Joaquín Camacho, Canapro, Los Cristales, Colinas del Norte, San Rafael, Los Rosales, Altos de Canapro, La María, Estancia del Roble, Los Urapanes, Villa Universitaria, UPTC, Altos de San Rafael, Pozo Donato.','Zona 3'),
  _Quadrante('C-25','3188664662','Terraza de Santa Inés, Quince Mayo, Santa Inés, Remansos de Santa Inés, La Pradera, Mesopotamia, Rincón de Mesopotamia, Urbanización Santa Inés.','Zona 3'),
  _Quadrante('C-26','3154204429','Huzahua, Villa Helena, Reserva Campestre, Las Quintas, Alta Gracia, Altos de Alejandría, El Portal de Las Quintas, Estancia de Aranjuez, Remansos de La Sabana, Casa Quinta Altagracia, Santo Tomás.','Zona 3'),
  _Quadrante('C-27','3176794859','Rincón del Seminario, Bavaria, Santa Ana.','Zona 3'),
  _Quadrante('C-28','3167502290','José Antonio Galán, Montecarlo, Villa Toledo, Villa Luz, Soaquirá, Club Comercio, Santa Rita, Poblado.','Zona 3'),
  _Quadrante('C-29','3167501998','Los Corrales, Urbanización Los Héroes, Manantial del Norte, Santa Catalina, Asís Boyacense, Buena Vista, Prados del Norte, Cabañas del Norte, Villa del Norte, Portales del Norte.','Zona 3'),
  _Quadrante('C-30','3167478800','Suamox, Coeducadores, Caminitos de Oicatá, Alcalá Real, La Arboleda, Los Muiscas, Palos Verdes, La Colorada II y III, Colinas del Zue, Barrio Torres del Este, Alameda del Norte, Balcones de Terranova.','Zona 3'),
];

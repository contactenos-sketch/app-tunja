// lib/screens/modulos_v3.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:somos_tunja_app/screens/detalle_webview_screen.dart';

// =================== ESTILOS / COLORES ===================
const kBg = Color(0xFF1C2427);          // Fondo app (de tu app existente)
const kPrimary = Color(0xFF006FCA);     // Botones/acentos (usado en la app)
const kTextOnDark = Colors.white;
const kCard = Colors.white;
const kCardText = Color(0xFF183137);

const _pad = EdgeInsets.all(18);

TextStyle get _h1 => const TextStyle(
  // Equivalente a "Titulos: bold (pt:34 aprox)" del doc
  fontSize: 22, fontWeight: FontWeight.w700, color: kTextOnDark);
TextStyle get _h2 => const TextStyle(
  // Equivalente a (pt:29 aprox)
  fontSize: 18, fontWeight: FontWeight.w600, color: kTextOnDark);
TextStyle get _body => const TextStyle(
  // Equivalente a (pt:24 aprox)
  fontSize: 16, fontWeight: FontWeight.w400, color: kTextOnDark, height: 1.35);
TextStyle get _cardTitle => const TextStyle(
  fontSize: 16, fontWeight: FontWeight.w700, color: kCardText);
TextStyle get _cardSub => const TextStyle(
  fontSize: 14, fontWeight: FontWeight.w400, color: kCardText);

// =================== HELPERS ===================
Widget banner(String bannerPath, String fallbackIconPath) {
  return Image.asset(
    bannerPath,
    fit: BoxFit.contain,
    width: double.infinity,
    errorBuilder: (_, __, ___) => Image.asset(fallbackIconPath, fit: BoxFit.contain),
  );
}

void _pushWeb(BuildContext ctx, String title, String url) {
  Navigator.push(ctx, MaterialPageRoute(
    builder: (_) => DetalleWebViewScreen(titulo: title, url: url),
  ));
}

Future<void> _call(String phone) async {
  final uri = Uri.parse('tel:$phone');
  await launchUrl(uri);
}

Future<void> _mail(String email, {String subject = ''}) async {
  final uri = Uri.parse('mailto:$email?subject=${Uri.encodeComponent(subject)}');
  await launchUrl(uri);
}

Card _card({
  required Widget leading,
  required String title,
  String? subtitle,
  VoidCallback? onTap,
  Widget? trailing,
}) {
  return Card(
    color: kCard,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 3,
    child: ListTile(
      leading: leading,
      title: Text(title, style: _cardTitle),
      subtitle: subtitle == null ? null : Text(subtitle, style: _cardSub),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: kCardText),
      onTap: onTap,
    ),
  );
}

// =================== 1) 40 SEGUNDOS ===================
// Fuente y copy: WhatsApp canal y línea 24/7, descripción estrategia. :contentReference[oaicite:2]{index=2}
class CuarentaSegundosScreen extends StatelessWidget {
  const CuarentaSegundosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('40 Segundos'), backgroundColor: kBg, foregroundColor: kTextOnDark, elevation: 0),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/40_segundos_mesa_de_trabajo_55.png', 'assets/images/40_segundos.png'),
          const SizedBox(height: 12),
          Text(
            'Somos una estrategia digital de apoyo emocional enfocada en la promoción del bienestar y la salud mental de la población tunjana. '
            'Haz clic para llamar o escribir por WhatsApp. Atención de emergencias 24/7.',
            style: _body, textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _card(
            leading: const Icon(Icons.chat, color: Colors.green, size: 28),
            title: 'Canal de WhatsApp',
            subtitle: 'Secretaría de Salud',
            onTap: () => _pushWeb(context, 'WhatsApp 40 Segundos', 'https://wa.me/c/573184653854'),
          ),
          _card(
            leading: const Icon(Icons.call, color: kCardText, size: 28),
            title: 'Línea 24 horas',
            subtitle: '318 465 3854',
            onTap: () => _call('3184653854'),
          ),
        ],
      ),
    );
  }
}

// =================== 2) ACTIVA-T ===================
// Texto y enlaces (WhatsApp, X, Facebook, Instagram). :contentReference[oaicite:3]{index=3} :contentReference[oaicite:4]{index=4}
class ActivaTScreen extends StatelessWidget {
  const ActivaTScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Activa-T'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/activa_t_mesa_de_trabajo_70.png', 'assets/images/activa_t.png'),
          const SizedBox(height: 12),
          Text(
            'Activa-T impulsa el desarrollo empresarial y el emprendimiento: asesoría, capacitación y espacios de promoción para fortalecer ideas, mejorar procesos y acceder a oportunidades de crecimiento.',
            style: _body, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          _card(
            leading: const Icon(Icons.chat, color: Colors.green),
            title: 'Canal de WhatsApp',
            onTap: () => _pushWeb(context, 'WhatsApp Activa-T', 'https://bit.ly/ActivaTunja'),
          ),
          _card(
            leading: const Icon(Icons.link),
            title: 'X (Twitter)',
            onTap: () => _pushWeb(context, 'X Activa-T', 'https://x.com/activattunja?s=11&t=o0mOpsw13EVJwC4QUKWHTA'),
          ),
          _card(
            leading: const Icon(Icons.facebook),
            title: 'Facebook',
            onTap: () => _pushWeb(context, 'Facebook Activa-T', 'https://www.facebook.com/share/1AnakHnaWt/?mibextid=wwXIfr'),
          ),
          _card(
            leading: const Icon(Icons.camera_alt_outlined),
            title: 'Instagram',
            onTap: () => _pushWeb(context, 'Instagram Activa-T', 'https://www.instagram.com/activattunja?igsh=N2Q5aGVkYjk1bmQx'),
          ),
          _card(
            leading: const Icon(Icons.info_outline),
            title: 'Más información aquí',
            onTap: () => _pushWeb(context, 'Activa-T', 'https://bit.ly/ActivaTunja'),
          ),
        ],
      ),
    );
  }
}

// =================== 3) ALERTAS ===================
// Notificaciones en tiempo real a la comunidad. :contentReference[oaicite:5]{index=5}
class AlertasScreen extends StatelessWidget {
  const AlertasScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Alertas'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/alarmas.png', 'assets/images/alarmas.png'),
          const SizedBox(height: 12),
          Text('Notificaciones en tiempo real de interés a la comunidad.', style: _body, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// =================== 4) BIENESTAR ANIMAL ===================
// Requisitos y preinscripción (texto del doc). :contentReference[oaicite:6]{index=6} :contentReference[oaicite:7]{index=7}
class BienestarAnimalScreen extends StatelessWidget {
  const BienestarAnimalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final requisitos = [
      'SISBÉN IV: Grupos A, B o C.',
      'Residencia en barrios de influencia del punto de esterilización.',
      'Perro o gato de raza criolla.',
      'Edad entre 4 meses y 8 años.',
      'Hembras.',
    ];
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Bienestar Animal'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/bienestar_animal_mesa_de_trabajo_72.png', 'assets/images/bienestar_animal.png'),
          const SizedBox(height: 12),
          Text(
            'Jornadas de esterilización masivas para perros y gatos de propietarios en SISBÉN. '
            'Los procedimientos se realizan previo cumplimiento de requisitos:',
            style: _body, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          ...requisitos.map((r) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  ', style: TextStyle(color: kTextOnDark, fontSize: 16)),
                    Expanded(child: Text(r, style: _body)),
                  ],
                ),
              )),
          const SizedBox(height: 12),
          _card(
            leading: const Icon(Icons.assignment, color: kCardText),
            title: 'Formulario de Preinscripción',
            onTap: () {
              // No viene URL exacta en el documento; abre una ruta cuando la tengas
              // _pushWeb(context, 'Preinscripción', 'https://...');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Agrega el enlace del formulario cuando esté disponible')),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =================== 5) DEPARTAMENTO DE CATASTRO ===================
// Trámites en línea / Geoportal. :contentReference[oaicite:8]{index=8}
class DepartamentoCatastroScreen extends StatelessWidget {
  const DepartamentoCatastroScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Departamento de Catastro'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/catastro_mesa_de_trabajo_76.png', 'assets/images/departamento_de_catastro.png'),
          const SizedBox(height: 12),
          _card(
            leading: const Icon(Icons.public, color: kCardText),
            title: 'Trámites en línea (Geoportal)',
            onTap: () => _pushWeb(context, 'Geoportal Catastro', 'https://catastro.tunja.gov.co/geoportal/'),
          ),
        ],
      ),
    );
  }
}

// =================== 6) PARTICIPACIÓN CIUDADANA ===================
// Campo para iniciar un foro enlazado al canal de WhatsApp. :contentReference[oaicite:9]{index=9}
class ParticipacionCiudadanaScreen extends StatelessWidget {
  const ParticipacionCiudadanaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Participación Ciudadana'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/participacion_ciudadana.png', 'assets/images/participacion_ciudadana.png'),
          const SizedBox(height: 12),
          Text('Inicia un foro y participa. Se enlaza al canal de WhatsApp de la Alcaldía.', style: _body, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          _card(
            leading: const Icon(Icons.chat, color: Colors.green),
            title: 'Abrir canal de WhatsApp',
            onTap: () => _pushWeb(context, 'WhatsApp Alcaldía', 'https://wa.me/c/573184653854'),
          ),
        ],
      ),
    );
  }
}

// =================== 7) PICO Y PLACA ===================
class PicoYPlacaScreen extends StatelessWidget {
  const PicoYPlacaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Pico y Placa'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/pico_y_placa_mesa_de_trabajo_94.png', 'assets/images/pico_y_placa.png'),
          const SizedBox(height: 12),
          _card(
            leading: const Icon(Icons.directions_car, color: kCardText),
            title: 'Consulta Particular',
            onTap: () => _pushWeb(context, 'Pico y Placa Particular', 'https://www.picoyplacatunja.com/particular.php'),
          ),
          _card(
            leading: const Icon(Icons.local_taxi, color: kCardText),
            title: 'Consulta Público',
            onTap: () => _pushWeb(context, 'Pico y Placa Público', 'https://www.picoyplacatunja.com/publico.php'),
          ),
        ],
      ),
    );
  }
}

// =================== 8) PLAN DE DESARROLLO ===================
// Botón de descarga. :contentReference[oaicite:10]{index=10}
class PlanDeDesarrolloScreen extends StatelessWidget {
  const PlanDeDesarrolloScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Plan de Desarrollo'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/plan_de_desarrollo_mesa_de_trabajo_97.png', 'assets/images/plan_de_desarrollo.png'),
          const SizedBox(height: 12),
          _card(
            leading: const Icon(Icons.download, color: kCardText),
            title: 'Descárgalo aquí',
            onTap: () => _pushWeb(context, 'Plan de Desarrollo',
              'https://www.tunja-boyaca.gov.co/planes/plan-de-desarrollo-del-municipio-de-tunja-conectemos'),
          ),
        ],
      ),
    );
  }
}

// =================== 9) PORTAL TRIBUTARIO ===================
// Predial (descuentos) e Industria & Comercio. :contentReference[oaicite:11]{index=11}
class PortalTributarioScreen extends StatelessWidget {
  const PortalTributarioScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Portal Tributario'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/portal_tributario.png', 'assets/images/portal_tributario.png'),
          const SizedBox(height: 8),
          Text(
            'Pago de Impuesto Predial con descuentos del 20%, 10% y 5% según fecha de pago al inicio del año. '
            'También puedes pagar Industria y Comercio.',
            style: _body, textAlign: TextAlign.center),
          _card(
            leading: const Icon(Icons.account_balance_wallet_outlined, color: kCardText),
            title: 'Ir al Portal Tributario',
            onTap: () => _pushWeb(context, 'Portal Tributario',
              'https://portal-tunja-boyaca-govco.softwaretributario.com/'),
          ),
        ],
      ),
    );
  }
}

// =================== 10) PQRS ===================
// Correo de Atención al Ciudadano + formulario simple. :contentReference[oaicite:12]{index=12}
class PqrsScreen extends StatefulWidget {
  const PqrsScreen({super.key});
  @override
  State<PqrsScreen> createState() => _PqrsScreenState();
}
class _PqrsScreenState extends State<PqrsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correoCtrl = TextEditingController();
  final _asuntoCtrl = TextEditingController();
  final _mensajeCtrl = TextEditingController();
  @override
  void dispose() {
    _correoCtrl.dispose(); _asuntoCtrl.dispose(); _mensajeCtrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('PQRS'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/pqrs.png', 'assets/images/pqrs.png'),
          const SizedBox(height: 8),
          Text('Este espacio está diseñado para reportar situaciones o enviar peticiones, quejas, reclamos o sugerencias.',
              style: _body, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Card(
            color: kCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _correoCtrl,
                      decoration: const InputDecoration(labelText: 'Correo para respuesta'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => (v==null || v.isEmpty) ? 'Ingresa un correo' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _asuntoCtrl,
                      decoration: const InputDecoration(labelText: 'Asunto'),
                      validator: (v) => (v==null || v.isEmpty) ? 'Ingresa un asunto' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _mensajeCtrl,
                      decoration: const InputDecoration(labelText: 'Mensaje'),
                      maxLines: 5,
                      validator: (v) => (v==null || v.isEmpty) ? 'Escribe tu mensaje' : null,
                    ),
                    const SizedBox(height: 12),
                    // Para evidencia (foto/archivo) se puede integrar image_picker más adelante.
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.send),
                        label: const Text('Enviar'),
                        style: ElevatedButton.styleFrom(backgroundColor: kPrimary, foregroundColor: Colors.white),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final correo = 'atencionalciudadano@tunja.gov.co';
                            final subject = '[PQRS App] ${_asuntoCtrl.text}';
                            final body = 'Correo de respuesta: ${_correoCtrl.text}\n\n${_mensajeCtrl.text}';
                            _mail(correo, subject: subject);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Abriendo correo…')),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================== 11) RENDICIÓN DE CUENTAS ===================
// Listado + enlace a YouTube (el doc indica YouTube, sin URL específica). :contentReference[oaicite:13]{index=13}
class RendicionDeCuentasScreen extends StatelessWidget {
  const RendicionDeCuentasScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = List<String>.filled(8, 'Vigencia 2020–2023 – Informe de gestión – Plan de desarrollo Tunja en equipo');
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Rendición de Cuentas'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/rendicion_de_cuentas.png', 'assets/images/rendicion_de_cuentas.png'),
          const SizedBox(height: 8),
          Text('Informes de gestión, estrategia de rendición de cuentas y notificaciones de espacios de rendición.',
              style: _body, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          ...items.map((t) => _card(
                leading: const Icon(Icons.picture_as_pdf, color: kCardText),
                title: t,
                onTap: () {
                  // Cuando tengas los PDFs/links, agrégalos aquí
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Agrega la URL del informe cuando esté disponible')),
                  );
                },
              )),
          _card(
            leading: const Icon(Icons.ondemand_video_outlined, color: kCardText),
            title: 'Ver en YouTube',
            onTap: () => _pushWeb(context, 'Rendición de Cuentas', 'https://www.youtube.com/'),
          ),
        ],
      ),
    );
  }
}

// =================== 12) RUTAS DE ATENCIÓN (Mujer / Comisarías / Líneas) ===================
// Toda la tabla de teléfonos y correos, más líneas nacionales y otros. :contentReference[oaicite:14]{index=14}
class RutasDeAtencionScreen extends StatelessWidget {
  const RutasDeAtencionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final comisarias = [
      ('Comisaría Primera de Familia','316 819 0269','comisaria.primera@tunja.gov.co'),
      ('Comisaría Segunda de Familia','318 254 7577','comisaria.segunda@tunja.gov.co'),
      ('Comisaría Tercera de Familia','318 465 4182','comisaira.tercera@tunja.gov.co'),
      ('Comisaría Cuarta de Familia','315 601 4896','comisaria.cuarta@tunja.gov.co'),
      ('Comisaría Quinta de Familia','315 368 2446','comisaria.quinta@tunja.gov.co'),
      ('Comisaría Sexta de Familia','318 284 3260','comisaria.sexta@tunja.gov.co'),
    ];
    final lineasNacionales = [
      ('123','Línea única de emergencias'),
      ('155','Orientación a mujeres'),
      ('122','Fiscalía General'),
      ('141','Bienestar Familiar (NNA)'),
    ];
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Rutas de Atención'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/rutas_de_atencion.png', 'assets/images/rutas_de_atencion.png'),
          const SizedBox(height: 8),
          Text('Contactos directos – Teléfono y correo.', style: _body, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text('Comisarías de Familia', style: _h2),
          const SizedBox(height: 8),
          ...comisarias.map((c) => _card(
                leading: const Icon(Icons.local_police_outlined, color: kCardText),
                title: c.$1,
                subtitle: '${c.$2} • ${c.$3}',
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(icon: const Icon(Icons.call, color: kCardText), onPressed: () => _call(c.$2.replaceAll(' ', ''))),
                  IconButton(icon: const Icon(Icons.email_outlined, color: kCardText), onPressed: () => _mail(c.$3)),
                ]),
              )),
          const SizedBox(height: 12),
          Text('Líneas Nacionales', style: _h2),
          const SizedBox(height: 8),
          ...lineasNacionales.map((l) => _card(
                leading: const Icon(Icons.phone_in_talk_outlined, color: kCardText),
                title: l.$1,
                subtitle: l.$2,
                onTap: () => _call(l.$1),
              )),
          const SizedBox(height: 12),
          Text('Apoyos adicionales', style: _h2),
          const SizedBox(height: 8),
          _card(
            leading: const Icon(Icons.phone, color: kCardText),
            title: 'Línea Secretaría de la Mujer',
            subtitle: '315 305 9261 • mujergeneroinclusion@tunja.gov.co',
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.call, color: kCardText), onPressed: () => _call('3153059261')),
              IconButton(icon: const Icon(Icons.email_outlined, color: kCardText), onPressed: () => _mail('mujergeneroinclusion@tunja.gov.co')),
            ]),
          ),
          _card(
            leading: const Icon(Icons.shield_moon_outlined, color: kCardText),
            title: 'Patrulla Púrpura',
            subtitle: '317 816 9927',
            onTap: () => _call('3178169927'),
          ),
          _card(
            leading: const Icon(Icons.home_work_outlined, color: kCardText),
            title: 'Casa de la Mujer Empoderada',
            subtitle: 'equidaddegenero@tunja.gov.co',
            onTap: () => _mail('equidaddegenero@tunja.gov.CO'),
          ),
        ],
      ),
    );
  }
}

// =================== 13) SEGURIDAD (30 cuadrantes) ===================
// Lista completa de cuadrantes con teléfono y barrios. :contentReference[oaicite:15]{index=15}
class SeguridadScreen extends StatelessWidget {
  const SeguridadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cuad = <Map<String, String>>[
      {'cte':'C-01','tel':'3507291864','barrios':'Ciudad Jardín, Pinos De Oriente, Sector La Cabaña, Sector Villa Del Rosario, Parque Industrial.'},
      {'cte':'C-02','tel':'3507291863','barrios':'San Francisco, Urb. La Granja Sur, Vereda Runta.'},
      {'cte':'C-03','tel':'3507291862','barrios':'San Carlos, Urbanización La Perla, Urbanización La Perla.'},
      {'cte':'C-04','tel':'3507291856','barrios':'La Florida, Urbanización La Florida, Multifamiliar La Florida, Sagrado Corazón, Antonia Santos, Ciudadela Sol De Oriente, Tunjuelito.'},
      {'cte':'C-05','tel':'3507291855','barrios':'Bochica, Cooservicios, Altos De Cooservicios, Portal De Otoño, Urbanización Sol De Oriente, Villa Bachué, San Antonio, Las Peñitas, Xativilla, Patriotas.'},
      {'cte':'C-06','tel':'3507291858','barrios':'Doña Eva, Nazareth, Tunjuelito, Santiago De Tunja, Jordán, Hunza, Castillos De Oriente.'},
      {'cte':'C-07','tel':'3507291861','barrios':'Prados de San Luis, El Curubal, Patriotas, Manzanares, El Rodeo.'},
      {'cte':'C-08','tel':'3507291844','barrios':'Triunfo, Trinidad, Bolívar, Surinama, Siberia.'},
      {'cte':'C-09','tel':'3507291841','barrios':'Libertador, Urbanización Balcón De La Villa, Urbanización Balcón Villa María.'},
      {'cte':'C-10','tel':'3507291831','barrios':'Obrero, Suárez Rendon, Aquimín.'},
      {'cte':'C-11','tel':'3507291837','barrios':'El Bosque, Nueva Santa Barbara, Santa Barbara, El Consuelo, Banderas, San Laureano.'},
      {'cte':'C-12','tel':'3507291828','barrios':'Mirador Escandinavo, Paraíso, Ricaurte, Colinas De San Fernando, Cortijo, Centenario, Urazandy, Las Américas, Los Andes.'},
      {'cte':'C-13','tel':'3507291822','barrios':'Concepción, Milagro, Kennedy, Topo.'},
      {'cte':'C-14','tel':'3507291823','barrios':'Topo, Centro, Santa Barbara, Popular.'},
      {'cte':'C-15','tel':'3507291829','barrios':'Centro, Santa Barbara, Lidueña.'},
      {'cte':'C-16','tel':'3507291830','barrios':'Centro San Ignacio Parque Pinzón, Ludueña.'},
      {'cte':'C-17','tel':'3507291857','barrios':'La Esmeralda, Mirador Del Norte, Rincón De La Pradera, Casa Del Gobernador, Lombardía, Orquídea Real, El Dorado, Monseñor Baracaldo.'},
      {'cte':'C-18','tel':'3507291827','barrios':'Belalcázar, Maldonado, San Juan, Villa Cecilia, Las Nieves, Villa Olímpica, Conjunto Militar, Los Lanceros, Remonta, La Glorieta Norte.'},
      {'cte':'C-19','tel':'3507291834','barrios':'Santa Lucia, Popular, 20 De Julio.'},
      {'cte':'C-20','tel':'3507291853','barrios':'Bello Horizonte, La Esperanza, El Carmen, Torres Del Parque.'},
      {'cte':'C-21','tel':'3507291854','barrios':'San Lázaro, Cojines, Altamira.'},
      {'cte':'C-22','tel':'3167588935','barrios':'La Calleja, Altos De La María, La Fuente De La I A La IV Etapa, Trigales, San Diego.'},
      {'cte':'C-23','tel':'3154843980','barrios':'Jorge Eliecer Gaitán, Veinte De Julio, Parque La Biblioteca.'},
      {'cte':'C-24','tel':'3167528428','barrios':'Altos De San Diego, José Joaquín Camacho, Canapro, Los Cristales, Colinas Del Norte, San Rafael, Los Rosales, Altos De Canapro, La María, Estancia Del Roble, Los Urapanes, Villa Universitaria, UPTC, Altos De San Rafael, Pozo Donato.'},
      {'cte':'C-25','tel':'3188664662','barrios':'Terraza de Santa Inés, Quince Mayo, Santa Inés, Remansos De Santa Inés, La Pradera, Mesopotamia, Rincón De Mesopotamia, Urbanización Santa Inés.'},
      {'cte':'C-26','tel':'3154204429','barrios':'Huzahua, Villa Helena, Reserva Campestre, Las Quintas, Alta Gracia, Altos De Alejandría, El Portal De Las Quintas, Estancia De Aranjuez, Remansos De La Sabana, Casa Quinta Altagracia, Santo Tomas.'},
      {'cte':'C-27','tel':'3176794859','barrios':'Rincón Del Seminario, Bavaria, Santa Ana.'},
      {'cte':'C-28','tel':'3167502290','barrios':'José Antonio Galán, Montecarlo, Villa Toledo, Villa Luz, Soaquirá, Club Comercio, Santa Rita, Poblado.'},
      {'cte':'C-29','tel':'3167501998','barrios':'Los Corrales, Urbanización Los Héroes, Manantial Del Norte, Santa Catalina, Asís Boyacense, Buena Vista, Prados Del Norte, Cabañas Del Norte, Villa Del Norte, Portales Del Norte.'},
      {'cte':'C-30','tel':'3167478800','barrios':'Suamox, Coeducadores, Caminitos De Oicatá, Alcalá Real, La Arboleda, Los Muiscas, Palos Verdes, La Colorada II Y III, Colinas Del Zue, Barrio Torres del Este, Alameda del Norte, Balcones de Terranova.'},
    ];

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Seguridad – Cuadrantes'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView.builder(
        padding: _pad,
        itemCount: cuad.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                banner('assets/images/seguridad.png', 'assets/images/seguridad.png'),
                const SizedBox(height: 8),
                Text('Haz clic para llamar al cuadrante de tu sector.', style: _body, textAlign: TextAlign.center),
                const SizedBox(height: 8),
              ],
            );
          }
          final q = cuad[i - 1];
          return Card(
            color: kCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text('${q['cte']}  •  ${q['tel']}', style: _cardTitle),
              subtitle: Text(q['barrios']!, style: _cardSub),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: kCardText),
                onPressed: () => _call(q['tel']!.replaceAll(' ', '')),
              ),
              children: const [SizedBox(height: 4)],
            ),
          );
        },
      ),
    );
  }
}

// =================== 14) SIEDU ===================
// Descripción y enlaces (www.siedutunja.gov.co / home). :contentReference[oaicite:16]{index=16}
class SieduScreen extends StatelessWidget {
  const SieduScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('SIEDU'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/siedu_mesa_de_trabajo_150.png', 'assets/images/siedu.png'),
          const SizedBox(height: 8),
          Text(
            'SISTEMA ÚNICO DE INFORMACIÓN EDUCATIVA MUNICIPAL DE TUNJA – SIEDUTUNJA. '
            'Plataforma única para el reporte, consolidación y administración de información educativa municipal.',
            style: _body, textAlign: TextAlign.center),
          _card(
            leading: const Icon(Icons.open_in_browser, color: kCardText),
            title: 'Ir a siedutunja.gov.co',
            onTap: () => _pushWeb(context, 'SIEDU', 'https://siedutunja.gov.co/home/'),
          ),
        ],
      ),
    );
  }
}

// =================== 15) TURISMO ===================
// Mapa interactivo de sitios turísticos (pendiente URL del mapa). :contentReference[oaicite:17]{index=17}
class TurismoScreen extends StatelessWidget {
  const TurismoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(title: const Text('Turismo'), backgroundColor: kBg, foregroundColor: kTextOnDark),
      body: ListView(
        padding: _pad,
        children: [
          banner('assets/images/turismo_mesa_de_trabajo_150.png', 'assets/images/turismo.png'),
          const SizedBox(height: 8),
          _card(
            leading: const Icon(Icons.map_outlined, color: kCardText),
            title: 'Mapa interactivo de sitios turísticos',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Agrega el enlace del mapa cuando esté disponible')),
              );
            },
          ),
        ],
      ),
    );
  }
}

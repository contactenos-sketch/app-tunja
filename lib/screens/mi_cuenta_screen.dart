import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

const kColorFondo = Color(0xFFFF8D046); // Amarillo institucional (nota: este valor parece tener 9 dígitos)
const kColorNegro = Color(0xFF102427);  // Negro institucional

class MiCuentaScreen extends StatefulWidget {
  const MiCuentaScreen({super.key});

  @override
  State<MiCuentaScreen> createState() => _MiCuentaScreenState();
}

class _MiCuentaScreenState extends State<MiCuentaScreen> {
  // ✅ Link oficial política
  static const String privacyUrl =
      "https://tours.interralab.co/PoliticasPrivacidadSomosTunja.html";

  File? _imagenPerfil;
  String _nombre = "Nombre";
  final TextEditingController _nombreController = TextEditingController();

  final Map<String, String> urls = const {
    "Instagram": "https://www.instagram.com/alcaldiadetunja",
    "Facebook": "https://www.facebook.com/AlcaldiaTunja",
    "Twitter": "https://twitter.com/AlcaldiaTunja",
    "YouTube": "https://www.youtube.com/@PrensaAlcaldiaTunja",
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nombre = prefs.getString('nombre') ?? "Nombre";
      _nombreController.text = _nombre;
      final fotoPath = prefs.getString('foto_perfil');
      if (fotoPath != null && File(fotoPath).existsSync()) {
        _imagenPerfil = File(fotoPath);
      }
    });
  }

  Future<void> _guardarNombre() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nombre = _nombreController.text.trim();
    });
    await prefs.setString('nombre', _nombre);
  }

  Future<void> _cambiarImagen() async {
    final picker = ImagePicker();
    final fuente = await showDialog<ImageSource>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Selecciona una fuente"),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.photo),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            label: const Text("Galería"),
          ),
          TextButton.icon(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            label: const Text("Cámara"),
          ),
        ],
      ),
    );

    if (fuente == null) return;

    final imagen = await picker.pickImage(source: fuente);
    if (imagen != null) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _imagenPerfil = File(imagen.path);
      });
      await prefs.setString('foto_perfil', imagen.path);
    }
  }

  Future<void> _abrirUrl(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el enlace")),
      );
    }
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _itemAccion({
    required IconData icon,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey.shade700),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitulo),
        trailing: const Icon(Icons.open_in_new_rounded, size: 18),
        onTap: onTap,
      ),
    );
  }

  Widget _infoCard(String title, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...items,
        ],
      ),
    );
  }

  Widget _redesSocialesRow() {
    final iconos = {
      "Instagram": FontAwesomeIcons.instagram,
      "Facebook": FontAwesomeIcons.facebookF,
      "Twitter": FontAwesomeIcons.twitter,
      "YouTube": FontAwesomeIcons.youtube,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: urls.entries.map((entry) {
        return IconButton(
          icon: FaIcon(iconos[entry.key], color: Colors.blueGrey, size: 28),
          onPressed: () => _abrirUrl(entry.value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Mi Cuenta", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _cambiarImagen,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imagenPerfil != null
                        ? FileImage(_imagenPerfil!)
                        : const AssetImage('assets/usuario.jpg') as ImageProvider,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: Icon(Icons.edit, size: 18),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    controller: _nombreController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tu nombre",
                    ),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _guardarNombre,
                )
              ],
            ),

            const SizedBox(height: 20),

            _infoCard("Información de contacto", [
              _infoItem("📍 Dirección", "Calle 19 #9-95 Edificio Municipal, Tunja-Boyacá"),
              _infoItem("🕒 Horario", "LUN a VIE: 8 a.m - 12 m / 2 p.m - 6 p.m"),
              _infoItem("📞 Teléfono", "+57 (8) 7405770"),
              _infoItem("📧 Correo institucional", "contactenos@tunja-boyaca.gov.co"),
              _infoItem("⚖ Correo judicial", "juricaydefensa@tunja.gov.co"),
            ]),

            _infoCard("Atención al ciudadano", [
              _infoItem("📍 Dirección", "Calle 19 No. 9 - 69 Tunja, Boyacá"),
              _infoItem("🕒 Horario", "LUN a VIE: 8 a.m - 12 m / 2 p.m - 6 p.m"),
              _infoItem("📧 Email", "atencionalciudadano@tunja.gov.co"),
              _infoItem("📞 Teléfonos", "+57 (8) 7405770 Ext. 1713"),
            ]),

            _infoCard("Redes Sociales", [_redesSocialesRow()]),

            // ✅ NUEVO: Legal / Política
            _infoCard("Legal", [
  _itemAccion(
    icon: Icons.privacy_tip_outlined,
    titulo: "Política de privacidad",
    subtitulo: "Consulta las políticas de uso de la aplicación",
    onTap: () => _abrirUrl(privacyUrl),
  ),

  const SizedBox(height: 8),

  const Text(
    "Aplicación independiente no oficial.",
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ),
  ),
]),

          ],
        ),
      ),
    );
  }
}


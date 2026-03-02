import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class PqrsScreen extends StatefulWidget {
  const PqrsScreen({super.key});
  @override
  State<PqrsScreen> createState() => _PqrsScreenState();
}

class _PqrsScreenState extends State<PqrsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _asuntoCtrl = TextEditingController();
  final _mensajeCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  File? _evidencia;

  static const Color kBg = Colors.white;
  static const Color kAqua = Color(0xFFA8DCCF);
  static const Color kTeal = Color(0xFF0E7A87);
  static const Color kText = Color(0xFF183137);

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _evidencia = File(picked.path));
    }
  }

  @override
  void dispose() {
    _asuntoCtrl.dispose();
    _mensajeCtrl.dispose();
    _correoCtrl.dispose();
    super.dispose();
  }

  InputDecoration _aquaInput(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kText, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: kAqua,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      );

  Future<void> _enviarCorreoDemo() async {
    final asunto = _asuntoCtrl.text.trim();
    final correo = _correoCtrl.text.trim();
    final mensaje = _mensajeCtrl.text.trim();

    final body = StringBuffer()
      ..writeln('Correo para respuesta: $correo')
      ..writeln()
      ..writeln(mensaje)
      ..writeln()
      ..writeln('---')
      ..writeln('(Modo DEMO: la evidencia seleccionada en la app no se adjunta)');

    final uri = Uri.parse(
      'mailto:atencionalciudadano@tunja.gov.co'
      '?subject=${Uri.encodeComponent(asunto.isEmpty ? "PQRS" : asunto)}'
      '&body=${Uri.encodeComponent(body.toString())}',
    );

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el cliente de correo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kBg,
        elevation: 0,
        foregroundColor: kText,
        title: const Text('PQRS', style: TextStyle(color: kText, fontWeight: FontWeight.w800)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
            children: [
              TextFormField(
                controller: _asuntoCtrl,
                style: const TextStyle(color: kText),
                decoration: _aquaInput('Asunto'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe un asunto' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _mensajeCtrl,
                maxLines: 6,
                style: const TextStyle(color: kText),
                decoration: _aquaInput('Mensaje'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe un mensaje' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _correoCtrl,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: kText),
                decoration: _aquaInput('Correo para respuesta'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Ingresa tu correo';
                  final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                  return ok ? null : 'Correo no válido';
                },
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Evidencia', style: TextStyle(color: kText, fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(color: kAqua, borderRadius: BorderRadius.circular(22)),
                  child: _evidencia == null
                      ? const Center(child: Icon(Icons.photo_camera, size: 64, color: kText))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.file(_evidencia!, fit: BoxFit.cover, width: double.infinity),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 180,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kTeal,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enviarCorreoDemo();
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Este espacio está diseñado especialmente para que puedas informar o reportar '
                'cualquier situación que consideres importante.\n\n'
                'Modo DEMO: esta pantalla no almacena datos ni los envía a un servidor. '
                'Al presionar “Enviar”, se abrirá tu cliente de correo con el mensaje prellenado.',
                textAlign: TextAlign.center,
                style: TextStyle(color: kText, fontSize: 12, height: 1.3),
              ),
              const SizedBox(height: 6),
              Center(
                child: InkWell(
                  onTap: () async {
                    final uri = Uri.parse('mailto:atencionalciudadano@tunja.gov.co');
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  child: const Text(
                    'atencionalciudadano@tunja.gov.co',
                    style: TextStyle(
                      color: kTeal, fontWeight: FontWeight.w800, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

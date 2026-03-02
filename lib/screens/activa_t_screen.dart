import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivaTScreen extends StatelessWidget {
  const ActivaTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1C2427); // fondo oscuro como el resto de la app
    const cardColor = Colors.white;
    const cardText = Color(0xFF183137);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Activa-T"),
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
        children: [
          // Imagen principal
          Image.asset(
            'assets/images/activa_t_mesa_de_trabajo_70.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 16),

          // Descripción
          const Text(
            "Activa-T es un programa que impulsa el desarrollo empresarial "
            "y el emprendimiento en la ciudad. Ofrece asesoría, capacitación "
            "y espacios de promoción para que emprendedores y empresarios "
            "fortalezcan sus ideas, mejoren sus procesos y accedan a nuevas "
            "oportunidades de crecimiento.",
            style: TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 22),

          // WhatsApp
          _LinkCardExternal(
            icon: Icons.chat, // usa FontAwesome si lo agregas
            title: "Canal de WhatsApp",
            subtitle: "Accede al canal oficial",
            url: "https://bit.ly/ActivaTunja",
            cardColor: cardColor,
            iconColor: Colors.green,
            titleColor: cardText,
          ),
          const SizedBox(height: 12),

          const Text(
            "Redes Sociales",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // X (Twitter)
          _LinkCardExternal(
            icon: Icons.alternate_email,
            title: "X (Twitter)",
            subtitle: "Síguenos en X",
            url: "https://x.com/activattunja?s=11&t=o0mOpsw13EVJwC4QUKWHTA",
            cardColor: cardColor,
            iconColor: Colors.lightBlue,
            titleColor: cardText,
          ),
          const SizedBox(height: 8),

          // Facebook
          _LinkCardExternal(
            icon: Icons.facebook,
            title: "Facebook",
            subtitle: "Visita nuestra página",
            url: "https://www.facebook.com/share/1AnakHnaWt/?mibextid=wwXIfr",
            cardColor: cardColor,
            iconColor: Colors.blue,
            titleColor: cardText,
          ),
          const SizedBox(height: 8),

          // Instagram
          _LinkCardExternal(
            icon: Icons.camera_alt,
            title: "Instagram",
            subtitle: "Síguenos en Instagram",
            url: "https://www.instagram.com/activattunja?igsh=N2Q5aGVkYjk1bmQx",
            cardColor: cardColor,
            iconColor: Colors.purple,
            titleColor: cardText,
          ),
        ],
      ),
    );
  }
}

class _LinkCardExternal extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String url;
  final Color cardColor;
  final Color iconColor;
  final Color titleColor;

  const _LinkCardExternal({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.cardColor,
    required this.iconColor,
    required this.titleColor,
  });

  Future<void> _openExternal(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      // feedback por si falla
      throw Exception('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 30),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Icons.open_in_new_rounded, size: 18),
        onTap: () => _openExternal(url), // 👈 abre FUERA de la app
      ),
    );
  }
}


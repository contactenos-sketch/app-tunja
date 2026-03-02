import 'package:flutter/material.dart';

class BienestarAnimalScreen extends StatelessWidget {
  const BienestarAnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bg = Color(0xFF183137);

    const requisitos = [
      'Animales de personas que se encuentren registrados dentro de los Grupos A, B y C del SISBEN IV.',
      'Propietarios que residan en los barrios de influencia del punto de esterilización dado.',
      'Que el animal (perro o gato) sea un animal criollo.',
      'Edad entre 4 meses a 8 años.',
      'Animales hembras.',
    ];

    const String facebookUrl =
        'https://www.facebook.com/share/1EiRrBU4JnE/?mibextid=wwXIfr';

    return Scaffold(
      backgroundColor: const Color(0xFF1C2427),
      appBar: AppBar(
        title: const Text('Bienestar Animal'),
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // Banner principal
          Image.asset(
            'assets/images/bienestar_animal_mesa_de_trabajo_72.png',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 20),

          // ====== BLOQUE: “Cuidamos a quienes no tienen voz” ======
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'Cuidamos a quienes no tienen voz',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'El Programa de Bienestar Animal de la Alcaldía de Tunja desarrolla '
              'jornadas de esterilización, vitaminización y desparasitación dirigidas '
              'a animales con tutor, promoviendo la tenencia responsable en la ciudad.\n\n'
              'También ofrece atención médico-veterinaria a los animales en condición '
              'de calle, aportando a su bienestar y a la salud pública.\n\n'
              'Estas acciones aportan a una ciudad más consciente, solidaria y '
              'comprometida con el cuidado de todos los seres vivos.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1.4,
              ),
              textAlign: TextAlign.justify,
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.white24, indent: 18, endIndent: 18),
          const SizedBox(height: 12),

          // ====== BLOQUE: Requisitos de esterilización ======
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'Jornadas de esterilización masivas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'Los procedimientos se realizan previo cumplimiento de los siguientes requisitos:',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.4,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: requisitos.map((r) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '•  ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          r,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 18),

          // Card: Formulario de preinscripción
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.assignment, color: bg),
                title: const Text(
                  'Formulario de Preinscripción',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Inscripción de beneficiarios de jornada de esterilización',
                ),
                trailing:
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detalle_webview',
                    arguments: {
                      'titulo': 'Preinscripción – Esterilización',
                      'url':
                          'https://survey123.arcgis.com/share/00ae2b3e1adb465da432b6d89c2c373f',
                    },
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Card: Más información (Facebook)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.facebook, color: Color(0xFF1877F2)),
                title: const Text(
                  'Más información en Facebook',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Programa de Bienestar Animal – Alcaldía de Tunja',
                ),
                trailing:
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detalle_webview',
                    arguments: {
                      'titulo': 'Bienestar Animal – Facebook',
                      'url': facebookUrl,
                    },
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Nota final
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'Nota: recuerda llevar tu documento y cumplir con todos los requisitos al punto de esterilización.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
                height: 1.4,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

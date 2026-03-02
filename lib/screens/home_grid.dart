import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  final Function(String, String)? onFavoritoTap;

  const HomeGrid({Key? key, this.onFavoritoTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_OpcionHome> opciones = [
      _OpcionHome("40 Segundos", 'assets/images/40_segundos.png', '/40-segundos'),
      _OpcionHome("Activa-T", 'assets/images/activa_t.png', '/activa-t'),
      _OpcionHome("Alertas", 'assets/images/alarmas.png', '/alertas'),
      _OpcionHome("Bienestar Animal", 'assets/images/bienestar_animal.png', '/bienestar-animal'),
      _OpcionHome("Departamento Catastro", 'assets/images/departamento_de_catastro.png', '/departamento-catastro'),
      _OpcionHome("Participación Ciudadana", 'assets/images/participacion_ciudadana.png', '/participacion-ciudadana'),
      _OpcionHome("Pico y Placa", 'assets/images/pico_y_placa.png', '/pico_y_placa'),
      _OpcionHome("Plan de Desarrollo", 'assets/images/plan_de_desarrollo.png', '/plan-de-desarrollo'),
      _OpcionHome("Portal Tributario", 'assets/images/portal_tributario.png', '/portal-tributario'),
      _OpcionHome("PQRS", 'assets/images/pqrs.png', '/pqrs'),
      _OpcionHome("Rendición de Cuentas", 'assets/images/rendicion_de_cuentas.png', '/rendicion-de-cuentas'),
      _OpcionHome("Rutas de Atención", 'assets/images/rutas_de_atencion.png', '/rutas-de-atencion'),
      _OpcionHome("Seguridad", 'assets/images/seguridad.png', '/seguridad'),
      _OpcionHome("SIEDU", 'assets/images/siedu.png', '/siedu'),
      _OpcionHome("Turismo", 'assets/images/turismo.png', '/turismo'),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: opciones.map((opcion) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, opcion.ruta);
            },
            child: Stack(
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.asset(
                    opcion.assetPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Estrella favoritos
                Positioned(
                  right: 12,
                  top: 12,
                  child: GestureDetector(
                    onTap: () {
                      if (onFavoritoTap != null) {
                        onFavoritoTap!(opcion.titulo, opcion.ruta);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star_border, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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

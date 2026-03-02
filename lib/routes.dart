import 'package:flutter/material.dart';

// ===== NO CAMBIAR =====
import 'package:somos_tunja_app/screens/busqueda_screen.dart';
import 'package:somos_tunja_app/screens/home_screen.dart';
import 'package:somos_tunja_app/screens/login_screen.dart';
import 'package:somos_tunja_app/screens/mi_cuenta_screen.dart';
import 'package:somos_tunja_app/screens/register_screen.dart';
import 'package:somos_tunja_app/screens/detalle_webview_screen.dart';
import 'package:somos_tunja_app/screens/noticias_screens.dart';
import 'package:somos_tunja_app/screens/notificaciones_screen.dart';

// ===== NUEVOS MÓDULOS =====
import 'package:somos_tunja_app/screens/40_segundos_screen.dart';
import 'package:somos_tunja_app/screens/activa_t_screen.dart';
import 'package:somos_tunja_app/screens/alertas_screen.dart';
import 'package:somos_tunja_app/screens/bienestar_animal_screen.dart';
import 'package:somos_tunja_app/screens/departamento_catastro_screen.dart';
import 'package:somos_tunja_app/screens/participacion_ciudadana_screen.dart';
import 'package:somos_tunja_app/screens/pico_y_placa_screen.dart';
import 'package:somos_tunja_app/screens/plan_de_desarrollo_screen.dart';
import 'package:somos_tunja_app/screens/portal_tributario_screen.dart';
import 'package:somos_tunja_app/screens/pqrs_screen.dart';
import 'package:somos_tunja_app/screens/rendicion_de_cuentas_screen.dart';
import 'package:somos_tunja_app/screens/rutas_de_atencion_screen.dart';
import 'package:somos_tunja_app/screens/seguridad_screen.dart';
import 'package:somos_tunja_app/screens/siedu_screen.dart';
import 'package:somos_tunja_app/screens/turismo_screen.dart';

// ===== RUTAS =====
final Map<String, WidgetBuilder> appRoutes = {
  // No se cambian
  '/home':            (ctx) => const HomeScreen(),
  '/login':           (ctx) => const LoginScreen(),
  '/register':        (ctx) => const RegisterScreen(),
  '/mi_cuenta':       (ctx) => const MiCuentaScreen(),
  '/buscar':          (ctx) => const BusquedaScreen(),
  '/detalle_webview': (ctx) => DetalleWebViewScreen(titulo: '', url: ''),
  '/noticias':        (ctx) => NoticiasScreen(agregarAFavoritos: (titulo, url) {}),
  '/notificaciones':  (ctx) => const NotificacionesScreen(),

  // Nuevos módulos
  '/40-segundos':             (ctx) => const CuarentaSegundosScreen(),
  '/activa-t':                (ctx) => const ActivaTScreen(),
  '/alertas':                 (ctx) => const AlertasScreen(),
  '/bienestar-animal':        (ctx) => const BienestarAnimalScreen(),
  '/departamento-catastro':   (ctx) => const DepartamentoCatastroScreen(),
  '/participacion-ciudadana': (ctx) => const ParticipacionCiudadanaScreen(),
  '/pico_y_placa':            (ctx) => const PicoYPlacaScreen(),
  '/plan-de-desarrollo':      (ctx) => const PlanDeDesarrolloScreen(),
  '/portal-tributario':       (ctx) => const PortalTributarioScreen(),
  '/pqrs':                    (ctx) => const PqrsScreen(),
  '/rendicion-de-cuentas':    (ctx) => const RendicionDeCuentasScreen(),
  '/rutas-de-atencion':       (ctx) => const RutasDeAtencionScreen(),
  '/seguridad':               (ctx) => const SeguridadScreen(),
  '/siedu':                   (ctx) => const SieduScreen(),
  '/turismo':                 (ctx) => const TurismoScreen(),
};

import 'package:app_osteoartrite/modules/usuario/usuario_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuarioModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => UsuarioPage());
  }
}

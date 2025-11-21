import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_osteoartrite/modules/home/tela_principal_page.dart';

class TelaPrincipalModule extends Module{
   @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const TelaPrincipalPage());
  }
}
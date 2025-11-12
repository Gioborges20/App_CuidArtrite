import 'package:app_osteoartrite/modules/cadastro/cadastro_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroModule extends Module{
  @override
  void routes(RouteManager r) {
    r.child('/cadastro', child: (context) => CadastroPage());
  }
}
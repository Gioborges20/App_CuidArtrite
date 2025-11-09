import 'package:app_osteoartrite/modules/login/login_module.dart';
import 'package:app_osteoartrite/modules/login/cadastro_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    // Definindo as rotas do app
    r.module('/', module: LoginModule()); // Rota inicial para a página de login
    r.module('/cadastro', module: CadastroModule()); // Rota para a página de cadastro
  }
}

import 'package:app_osteoartrite/modules/login/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    // Colocar as rotas do app aqui
    // Coloque o / da rota e o seu module
    r.module('/', module: LoginModule());
  }
}

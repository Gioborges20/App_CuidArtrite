import 'package:app_osteoartrite/modules/home/login_module.dart';
import 'package:app_osteoartrite/modules/home/cadastro_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: LoginModule());
    r.module('/Login', module: LoginModule());
    r.module('/cadastro', module: CadastroModule());
  }
}

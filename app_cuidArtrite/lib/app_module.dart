import 'package:app_osteoartrite/modules/home/tela_principal_module.dart';
import 'package:app_osteoartrite/modules/login/login_module.dart';
import 'package:app_osteoartrite/modules/cadastro/cadastro_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: TelaPrincipalModule());
    r.module('/Login', module: LoginModule());
    r.module('/cadastro', module: CadastroModule());
  }
}

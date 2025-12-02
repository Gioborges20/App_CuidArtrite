import 'package:app_osteoartrite/modules/home/tela_principal_module.dart';
import 'package:app_osteoartrite/modules/login/login_module.dart';
import 'package:app_osteoartrite/modules/cadastro/cadastro_module.dart';
import 'package:app_osteoartrite/modules/relato_resultado/relato_resultado_module.dart';
import 'package:app_osteoartrite/modules/usuario/usuario_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: LoginModule());
    r.module('/Login', module: LoginModule());
    r.module('/cadastro', module: CadastroModule());
    r.module('/tela_principal', module: TelaPrincipalModule());
    r.module('/relato_resultado', module: RelatoResultadoModule());
    r.module('/usuario', module: UsuarioModule());
  }
}

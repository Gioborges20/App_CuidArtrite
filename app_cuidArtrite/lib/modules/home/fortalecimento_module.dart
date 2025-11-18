import 'package:app_osteoartrite/modules/Fortalecimento.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FortalecimentoModule extends Module{
  @override
  void routes(RouteManager r) {
    r.child('/home', child: (context) => FortalecimentoJoelho());
  }
}

import 'package:app_osteoartrite/modules/relato_resultado/relato_resultado_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RelatoResultadoModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => RelatoResultadoPage());
  }
}

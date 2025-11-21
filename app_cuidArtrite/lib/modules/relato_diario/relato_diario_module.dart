
import 'package:app_osteoartrite/modules/relato_diario/relato_diario_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RelatoDiarioModule extends Module{
  @override
  void routes(RouteManager r){
    r.child('/', child: (context) => const RelatoDiaPage());
  }
}
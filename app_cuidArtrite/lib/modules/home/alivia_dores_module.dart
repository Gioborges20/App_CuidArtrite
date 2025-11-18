import 'package:app_osteoartrite/modules/alivia_dores_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AliviaDorModule extends Module{
  @override
  void routes(RouteManager r) {
    r.child('/home', child: (context) => AliviaDor());
  }
}
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_osteoartrite/modules/login/login_page.dart';

class LoginModule extends Module{
   @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginPage());
  }
}
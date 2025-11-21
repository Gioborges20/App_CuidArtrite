import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';
import 'app_widget.dart';
import 'package:firebase_core/firebase_core.dart'; //firebase
import 'shared/services/firebase_options.dart'; //firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp( // Add inicialização do Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}

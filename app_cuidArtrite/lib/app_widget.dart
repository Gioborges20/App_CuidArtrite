import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  
  @override
  void initState() {
    super.initState();
    _setupFirebaseForegroundListener();
  }

  void _setupFirebaseForegroundListener() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permissão concedida pelo usuário');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          print('Notificação recebida no AppWidget: ${message.notification!.title}');
          
          final context = Modular.routerDelegate.navigatorKey.currentContext;

          if (context != null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(message.notification!.title ?? 'Aviso'),
                content: Text(message.notification!.body ?? ''),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      });
    } else {
      print('Usuário recusou ou não aceitou as permissões');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Meu App Flutter',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    );
  }
}
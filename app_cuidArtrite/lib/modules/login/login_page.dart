import 'package:app_osteoartrite/modules/cadastro/cadastro_page.dart';
import 'package:app_osteoartrite/modules/home/tela_principal_page.dart' show TelaPrincipalPage;
import 'package:flutter/material.dart';
import 'package:app_osteoartrite/shared/services/auth_service.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CuidArtrite',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF13574C),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 450.0,
              height: 160.0,
              child: Image(image: AssetImage('assets/logo.png')),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Faça o login ou crie uma conta para acessar o aplicativo',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 22),

          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(24, 0, 0, 0),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 330,
            padding: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(5),
                    child: Text('E-mail', style: TextStyle(fontSize: 18)),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Digite seu e-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsetsGeometry.all(5),
                    child: Text('Senha', style: TextStyle(fontSize: 18)),
                  ),
                  ShowHidePassword(
                    passwordField: (bool hidePassword) {
                      return TextField(
                        controller: senhaController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: 'Digite sua senha',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (emailController.text.isEmpty) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('E-mail não pode ser vazio')),
                          );
                          return; // interrompe fluxo
                        }
                        if (senhaController.text.isEmpty) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Senha não pode ser vazio')),
                          );
                          return; // interrompe fluxo
                        }

                        try {
                          await AuthService.instance.login(
                            emailController.text.trim(),
                            senhaController.text.trim(),
                          );

                          bool verificado = await AuthService.instance.emailFoiVerificado();

                          if (!verificado) {
                            await AuthService.instance.logout();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Por favor, verifique seu e-mail antes de fazer login.')),
                            );
                            return;
                          }

                          if (!mounted) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TelaPrincipalPage()),
                          );

                        } on FirebaseAuthException catch (e) {
                          if (!mounted) return;

                          if (e.code == 'user-not-found' || e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Usuário não encontrado ou senha incorreta')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erro ao fazer login: ${e.code}')),
                            );
                            return;
                          }
                        }
                      } catch (e, stackTrace) {
                        log("Erro ao fazer login: $e", name: "LoginPage", error: e, stackTrace: stackTrace);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF13574C), // Cor verde do AppBar
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CadastroPage()),
                      );},
                      child: const Text(
                      'Cadastre-se',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                      decoration: TextDecoration.underline,
                      )),
                    ),
                  TextButton(
                    onPressed: () async {
                      try {
                        if (emailController.text.isEmpty) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Por favor, insira seu e-mail para redefinir a senha.')),
                          );
                          return; // interrompe fluxo
                        }

                        await AuthService.instance.esqueciSenha(emailController.text.trim());

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('E-mail de redefinição de senha enviado. Não esqueça de verificar a caixa de spam.')),
                        );
                      } catch (e) {
                        log("Erro ao solicitar redefinição de senha: $e", name: "LoginPage", error: e);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao solicitar redefinição de senha. Tente novamente.')),
                        );
                      }
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                      decoration: TextDecoration.underline,
                      )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

}

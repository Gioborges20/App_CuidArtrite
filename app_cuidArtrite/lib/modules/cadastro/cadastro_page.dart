import 'package:app_osteoartrite/modules/login/login_page.dart';
import 'package:flutter/material.dart'; 
import 'package:show_hide_password/show_hide_password.dart'; 
import 'package:app_osteoartrite/shared/services/user_service.dart';
import 'package:app_osteoartrite/shared/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

const List<String>  tipoSexo = <String>['Masculino', 'Feminino', 'Outro'];

class _CadastroPageState extends State<CadastroPage>{
  String? _sexoSelecionado;
  final nomeController = TextEditingController();
  final dataNascController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final celularController = TextEditingController();
  final prefAcesController = TextEditingController();

  @override
  Widget build(BuildContext context){
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
        child: Center(
          child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 25, 16, 10),
              child: Text(
                'Cadastro',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              ),
          const SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(23, 236, 0, 0),
                width: 1.0,),
            borderRadius: BorderRadius.circular(8.0),
            ),
            width: 330,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Importante para scroll funcionar

                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Nome Completo', style: TextStyle(fontSize: 18))
                  ),
                  TextField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      hintText: 'Digite seu nome completo',
                      border: OutlineInputBorder()
                       ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Data de Nascimento', style: TextStyle(fontSize: 18))
                  ),
                  TextField(
                    controller: dataNascController,
                    decoration: InputDecoration(
                      hintText: 'DD/MM/AAAA',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
                    child: Text('Sexo', style: TextStyle(fontSize: 18))
                  ), 
                  DropdownButtonFormField<String>(  // Colocar validação
                    initialValue: _sexoSelecionado,
                    decoration: InputDecoration(hintText:'Selecione seu sexo', border: OutlineInputBorder()),
                    items: tipoSexo.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState((){
                        _sexoSelecionado = newValue;
                      });
                    }
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Telefone', style: TextStyle(fontSize: 18))
                  ),
                  TextFormField(
                    controller: celularController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                    hintText: '(99) 99999-9999',
                    border: OutlineInputBorder()),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Insira um número de telefone.';
                      }
                      if(value.length < 15){
                        return 'Número de telefone incompleto.';
                      }
                      return null;              
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Email', style: TextStyle(fontSize: 18)),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Exemplo: aaaabbb@hotmail.com',
                      border: OutlineInputBorder(),
                    )
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Senha para cadastro', style: TextStyle(fontSize: 18))
                  
                  ),
                  ShowHidePassword(
                    passwordField: (bool hidePassword) {
                      return TextField(
                        controller: senhaController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: 'Exemplo: SeNh!a513',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Confirmação de senha', style: TextStyle(fontSize: 18))
                  
                  ),
                  ShowHidePassword(
                    passwordField: (bool hidePassword) {
                      return TextField(
                        controller: confirmarSenhaController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: 'Confirme sua senha',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Preferências de acessibilidade', style: TextStyle(fontSize: 18),)
                  ),
                  TextField(
                    controller: prefAcesController,
                    decoration: InputDecoration(
                      hintText: 'Descreva suas preferências de acessibilidade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async{
                      if(nomeController.text.isEmpty ||
                         dataNascController.text.isEmpty ||
                         emailController.text.isEmpty ||
                         senhaController.text.isEmpty ||
                         confirmarSenhaController.text.isEmpty ||
                         celularController.text.isEmpty ||
                         _sexoSelecionado == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Por favor, preencha todos os campos!')),
                        );
                        return;
                      }

                      // Verificação das senhas
                      if (senhaController.text.trim() != confirmarSenhaController.text.trim()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('As senhas não coincidem!')),
                        );
                        return;
                      }

                      try {
                        await AuthService.instance.registrar(
                          emailController.text.trim(),
                          senhaController.text.trim(),
                        );

                        final uid = FirebaseAuth.instance.currentUser!.uid;

                        await UserService().saveDadosUsuario(
                          uid: uid,
                          nome: nomeController.text.trim(),
                          dataNasc: dataNascController.text.trim(),
                          email: emailController.text.trim(),
                          celular: celularController.text.trim(),
                          sexo: _sexoSelecionado!,
                          prefAces: prefAcesController.text.trim(),
                        );


                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } catch (e, stackTrace) {
                        log("Erro ao cadastrar: $e", name: "CadastroPage", error: e, stackTrace: stackTrace);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF13574C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ],
            ),
          ),
          ),
        ]
      ),
    ),)
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    dataNascController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    celularController.dispose();
    prefAcesController.dispose();
    super.dispose();
  }

}

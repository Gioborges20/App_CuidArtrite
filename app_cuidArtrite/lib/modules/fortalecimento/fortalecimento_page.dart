import 'package:flutter/material.dart';

class FortalecimentoJoelho extends StatefulWidget{
  const FortalecimentoJoelho ({super.key});

  @override
  State<FortalecimentoJoelho> createState() => _FortaleceJoelho();
}

class _FortaleceJoelho extends State<FortalecimentoJoelho>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
       title: const Text('CuidArtrite',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
      ),
      centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Image(
            image: AssetImage('assets/logo.png'),
            width: 30,
          ),
        ),
        backgroundColor: Color(0xFF13574C),
    ),
    body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
          ]
        )
        )
    )
    );
  }
}
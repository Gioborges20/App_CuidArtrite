import 'package:flutter/material.dart';

class TelaPrincipalPage extends StatefulWidget {
  const TelaPrincipalPage({super.key});

  @override
  State<TelaPrincipalPage> createState() => _telaPrincipal();
}

class _telaPrincipal extends State<TelaPrincipalPage> {
  @override
  Widget build(BuildContext context) {
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
            width: 40,
          ),
        ),
        backgroundColor: Color(0xFF13574C),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24), // Margem superior
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 110, 196, 218),
                    border: Border.all(
                      color: const Color.fromARGB(23, 100, 100, 100),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 200,
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.all(15),
                          child: Text(
                            'Relato Diário', 
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),)),
                        ),
                        Center(
                          child: SizedBox(
                              width:60,
                              height:60,
                              child: Image(image: AssetImage(
                              'assets/ImageRelatoDiario.png'
                              ),),
                            ),
                            ),
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          'Perguntas sobre\nsua dor e intensidade.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
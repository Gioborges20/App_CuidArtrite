import 'package:app_osteoartrite/modules/aliviaDores_page.dart';
import 'package:flutter/material.dart';

class TelaPrincipalPage extends StatefulWidget {
  const TelaPrincipalPage({super.key});

  @override
  State<TelaPrincipalPage> createState() => _TelaPrincipal();
}

class _TelaPrincipal extends State<TelaPrincipalPage> {
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
            width: 30,
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
                    color: Color.fromARGB(255, 122, 181, 196),
                    border: Border.all(
                      color: const Color.fromARGB(23, 100, 100, 100),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            'Relato Diário',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/ImageRelatoDiario.png'),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Perguntas sobre sua dor e intensidade.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Text(
                              'Iniciar Relato',
                              style: TextStyle(
                                color: Color(0xFF13574C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             Padding(
                padding: EdgeInsets.only(top: 24), 
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 221, 220, 220),
                    border: Border.all(
                      color: const Color.fromARGB(23, 100, 100, 100),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(197, 170, 169, 169),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Center(
                          child: Text(
                            'Exerça Práticas Físicas!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 49, 49, 49),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('A prática de exercícios físicos pode ser numa grande aliada contra a osteoartrite.'
                              '\nAo executá-las, fortalecemos nossas articulações e criamos uma “barreira” contra lesões.',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 18)
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(73, 155, 154, 154),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                          Text(
                            'Aliviando as dores',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 49, 49, 49),
                            ),
                          ),

                          SizedBox(height: 4),

                          Text('Assita aos vídeos!',
                          style: TextStyle(
                            fontSize: 15, 
                            color: Color.fromARGB(255, 117, 117, 117))
                          ),

                          SizedBox(height: 12),

                          ElevatedButton(
                            onPressed: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AliviaDor()),
                        );
                            }, 
                             style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Text(
                              'Iniciar',
                              style: TextStyle(
                                color: Color(0xFF13574C),
                              ),
                            ),
                            ),
                  ],
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
import 'package:app_osteoartrite/modules/fortalecimento/fortalecimento_page.dart';
import 'package:app_osteoartrite/modules/alivia_dores/alivia_dores_page.dart';
import 'package:app_osteoartrite/modules/relato_diario/relato_diario_page.dart';
import 'package:app_osteoartrite/modules/relato_diario/relato_diario_service.dart';
import 'package:app_osteoartrite/shared/services/auth_service.dart';
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
        title: const Text(
          'CuidArtrite',
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
                    color: Color.fromARGB(159, 249, 252, 73),
                    border: Border.all(
                      color: const Color.fromARGB(23, 100, 100, 100),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 71, 71, 71),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 71, 71, 71),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final usuarioId = AuthService.instance.usuarioAtual!.uid;
                              final relatoService = RelatoDiarioService();

                              // Verifica se já enviou hoje
                              final jaEnviado = await relatoService.relatoEnviadoHoje(usuarioId);

                              if (jaEnviado) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Você já enviou um relato hoje."),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return; // bloqueia navegação
                              }

                              if (!mounted) return;

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RelatoDiaPage())
                                );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:  Color(0xFF13574C),
                            ),
                            child: Text(
                              'Iniciar Relato',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
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
                    color: Color.fromARGB(121, 181, 243, 214),
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
                          color: Color.fromARGB(197, 33, 129, 100),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                    'A prática de exercícios físicos pode ser numa grande aliada contra a osteoartrite.'
                                    '\nAo executá-las, fortalecemos nossas articulações e criamos uma “barreira” contra lesões.',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 18))),
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
                    color: Color.fromARGB(121, 181, 243, 214),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/iconHappy.png'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
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
                                  color: Color.fromARGB(255, 117, 117, 117))),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AliviaDor()),
                              );
                            },
                             style: ElevatedButton.styleFrom(
                              backgroundColor:
                                 Color(0xFF13574C)            ),
                            child: Text(
                              'Iniciar',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
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
                    color: Color.fromARGB(121, 181, 243, 214),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/iconFortalecimentoJoelho.png'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        children: [
                          Text(
                            'Fortalecendo a articulação',
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
                                  color: Color.fromARGB(255, 117, 117, 117))),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FortalecimentoJoelho()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                 Color(0xFF13574C)            ),
                            child: Text(
                              'Iniciar',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
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
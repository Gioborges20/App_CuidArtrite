import 'package:flutter/material.dart';
import 'package:app_osteoartrite/modules/widgets/youtube_player.dart';

class RelatoResultadoPage extends StatelessWidget {
  const RelatoResultadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Relato Diário',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF13574C),

        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/tela_principal'); 
            },
            child: Image.asset('assets/logo.png', width: 30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(71, 0, 0, 0),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'O que posso fazer para\n aliviar essa situação?...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF13574C),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Container(
                        width: 323,
                        height: 111,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(172, 19, 87, 76),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              'Que tal um alongamento,\n como o que está no vídeo\n abaixo?',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      YoutubeThumbAndPlayer(
                  youtubeUrl: "https://www.youtube.com/watch?v=t9sTQLJHMVk"
                ),

                SizedBox(height: 25),

                YoutubeThumbAndPlayer(
                  youtubeUrl: "https://www.youtube.com/watch?v=0cKfH7XSAEo"
                ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

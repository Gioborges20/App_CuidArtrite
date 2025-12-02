import 'package:app_osteoartrite/modules/widgets/youtube_player.dart';
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
       title: const Text('Fortalecimento',
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
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black26),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const Text(
                  "Fortalecer sua articulação é o primeiro\n"
                  "passo para quebrar o ciclo da dor e da\n"
                  "rigidez causada pela osteoartrite.\n"
                  "Vamos começar?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 50, 165, 180),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: const Text(
                    "Que tal um alongamento,\n"
                    "como os que estão nos vídeos abaixo?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                YoutubeThumbAndPlayer(
                  youtubeUrl: "https://youtu.be/i3dNhtvTJQ4?si=G5qRzMj8HFZ8XNdP"
                ),

                SizedBox(height: 16),

                YoutubeThumbAndPlayer(
                  youtubeUrl: "https://youtu.be/GF6TPjQMHJA?si=5HKwQbeffa93vqnm"
                ),

                SizedBox(height: 16),

                YoutubeThumbAndPlayer(
                  youtubeUrl: "https://youtu.be/vA3oj3mzGRs?si=HPB-CCU21SWnVlJO"
                ),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xC7FFC72D),
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: const Text(
                    "ATENÇÃO!\n"
                    "A prática dos exercícios errado pode piorar suas dores!\n"
                    "Veja o que NÃO fazer com suas articulaçoes no vídeo abaixo:\n\n"
                    "Dica: Não esqueça de consultar seu médico ou fisioterapeuta.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE397),
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: YoutubeThumbAndPlayer(
                    youtubeUrl: "https://youtu.be/m0DMYFve9u8?si=NVg7YtnTivU5jOqL"
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:app_osteoartrite/modules/home/tela_principal_page.dart';
import 'package:flutter/material.dart';
/*import 'package:http/http.dart' as http; // Pacote para acessar a internet
import 'package:app_osteoartrite/modules/video_card.dart';*/
import 'package:app_osteoartrite/modules/widgets/youtube_player.dart';

class AliviaDor extends StatefulWidget {
  const AliviaDor({super.key});

  @override
  State<AliviaDor> createState() => _TelaAliviaDor();
}

class _TelaAliviaDor extends State<AliviaDor> {
  Widget buildVideoCard(String title, String url) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.play_circle_fill),
        onTap: () {
          // Ação ao clicar no card (ex: abrir o vídeo)
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aliviando as dores',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF13574C),
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: IconButton(
            iconSize: 40,
            padding: EdgeInsets.zero,
            icon: Image.asset('assets/logo.png'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaPrincipalPage()),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Esses vídeos podem te ajudar a aliviar suas dores! '
                        'Sempre que precisar, acesse essa aba e acesse o vídeo que mais lhe agradar!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 50, 165, 180),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'Que tal um alongamento, como os que estão nos vídeos abaixo?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            YoutubeThumbAndPlayer(
                              youtubeUrl:
                                  'https://www.youtube.com/watch?v=vB4koF8uElY',
                            ),
                            const SizedBox(height: 16),
                            YoutubeThumbAndPlayer(
                              youtubeUrl:
                                  'https://www.youtube.com/watch?v=zuoHttAIv9o',
                            ),
                            const SizedBox(height: 16),
                            YoutubeThumbAndPlayer(
                              youtubeUrl:
                                  'https://www.youtube.com/watch?v=C5Al9dJ-bQU',
                            ),
                            const SizedBox(height: 16),
                            YoutubeThumbAndPlayer(
                              youtubeUrl:
                                  'https://www.youtube.com/watch?v=o7jK8tBGNVQ',
                            ),
                            const SizedBox(height: 16),
                            YoutubeThumbAndPlayer(
                              youtubeUrl:
                                  'https://www.youtube.com/watch?v=7ZQB9Smmu9E',
                            ),
                          ],
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

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeThumbAndPlayer extends StatefulWidget {
  final String youtubeUrl;

  const YoutubeThumbAndPlayer({super.key, required this.youtubeUrl});

  @override
  State<YoutubeThumbAndPlayer> createState() => _YoutubeThumbAndPlayerState();
}

class _YoutubeThumbAndPlayerState extends State<YoutubeThumbAndPlayer> {
  late String videoId;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Extrai ID do vídeo
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl)!;

    // Inicializa player
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  bool showPlayer = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!showPlayer)
          GestureDetector(
            onTap: () {
              setState(() {
                showPlayer = true;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://img.youtube.com/vi/$videoId/maxresdefault.jpg",
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),

        // Player aparece após clicar
        if (showPlayer)
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoWidget extends StatefulWidget {
  final String name;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;

  VideoWidget({
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.name.toUpperCase(),
              style: const TextStyle(
                color: Color.fromRGBO(139, 143, 153, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: widget.thumbnailUrl,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              IconButton(
                icon: const Icon(
                  Icons.play_circle_fill,
                  size: 50.0,
                  color: Colors.white,
                ),
                onPressed: () async{
                 await _chewieController.play();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              widget.description,
              style: const TextStyle(
                color: Color.fromRGBO(134, 138, 148, 1),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                shareVideo(context, widget.videoUrl, widget.name);
              },
              icon: const Icon(Icons.share, color: Color.fromRGBO(81, 83, 87, 2)),
              label: const Text(
                'Compartilhar',
                style: TextStyle(
                  color: Color.fromRGBO(81, 83, 87, 2),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(236, 236, 236, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }

  void shareVideo(BuildContext context, String videoUrl, String videoName) {
    final String text = 'Confira esse vídeo incrível: $videoName\n$videoUrl';
  
  }
}
